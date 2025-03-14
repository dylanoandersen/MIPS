/*
Author: Nnamdi Nwanze, Dylan Andersen
Purpose: This program gives an example of how threads are created and executed.
To compile: gcc -pthread threadexample.c
To run: ./a.out
*/

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//define constant NUMBERTHREADS as 10
#define NUMBERTHREADS 10
/*
    pthread_mutex_t lock;        - creates a mutex
	pthread_mutex_lock(&lock);   - locks a mutex 
	pthread_mutex_unlock(&lock); - unlocks a mutex
*/

pthread_mutex_t lock; // mutex variable
pthread_cond_t cond; // variable used for conditional locking

void * saveMyProcesses(void * tid)
{	
    
    // Thread Identifier created
	int myid = (intptr_t)tid;
	// File pointer used for opening file
	FILE* fptr;
	fptr = fopen("processesowned.txt", "a");
    // if the file is not found, close the program
	if (fptr == NULL) {
		printf("The file could not be opened. The program will now exit.");
		exit(0);
	}
	
    /*Create a UNIX bash command to list processes and filter for lines 
    where the owner name (first field) begins with "root".*/
	char command[50];
	sprintf(command, "ps aux | grep '^root' >> processesowned.txt");
	
	pthread_mutex_lock(&lock);
	printf("Thread %d is writing to file.\n", myid);
	fprintf(fptr, "Thread %d is writing to file.\n", myid);
	
	//Forces previous line out of buffer before continuing
	//Necessary to avoid the outputting of processes before the fprintf line
	fflush(fptr);

	/*run the command*/
	int status = system(command);

	/*print a farewell message*/
	fprintf(fptr, "Thread %d is done writing.\n", myid);
    
    //closes the file pointer
	fclose(fptr);
    
    //unlocks the mutex after all operations in critical region
	pthread_mutex_unlock(&lock);

    // line outside of critical region as doesn't affect file
	printf("Thread %d is done writing.\n", myid);
}

//function to count processes
void * countMyProcesses(void * tid)
{
	int myid = (intptr_t)tid;
	// File pointer used for opening file
	FILE* fptr; 
	fptr = fopen("processesowned.txt", "a");
	// if the file is not found, close the program
	if (fptr == NULL) {
		printf("The file could not be opened. The program will now exit.");
		exit(0);
	}
	
	/*create a UNIX bash command to count processes*/
	char command[100];
	
	// prints out the number of lines in the console
	sprintf(command, "echo $(cat processesowned.txt | wc -l) lines of text were read by thread %d. ",myid);

    // locks the mutex to write to file
    pthread_mutex_lock(&lock);

	fprintf(fptr, "Thread %d is reading the file.\n", myid);
	
	// gives up the lock for additional readers/writers
	pthread_mutex_unlock(&lock);

	/*run the command*/
	int status = system(command);
	
    // take the lock to write to the file
    pthread_mutex_lock(&lock);
	/*print a farewell message*/
	fprintf(fptr, "Thread %d is done reading the file.\n", myid);

    // gives up the lock for additional writers
	pthread_mutex_unlock(&lock);
	// writes to the console 
	printf("Thread %d is done reading the file.\n", myid);

	fclose(fptr);
}

//run both functions
void * runAll(void * tid)
{
    saveMyProcesses(tid);
    countMyProcesses(tid);
}

int main(int argc, char * argv[])
{
    /*The main program creates NUMBERTHREADS (10) threads and then exits.*/
	pthread_t threads[NUMBERTHREADS];
	int status, i;

	/*create a UNIX bash command to run*/
	char command[100];
	/*run the command*/
	sprintf(command, "echo 'The program is starting' > processesowned.txt");
    status = system(command);

	//count through 10 threads
	for(i=0; i < NUMBERTHREADS; i++) {
		//run main thread
		printf("Main here. Creating thread %d\n", i);
		//create 10 threads
		status = pthread_create(&threads[i], NULL, runAll, (void *)(intptr_t)i);
		//check for errors with creating threads
		if (status != 0) {
			printf("Oops. pthread create returned error code %d\n", status);
			exit(-1);
		}
	}

	for(i=0; i<NUMBERTHREADS; i++){
		pthread_join(threads[i], NULL);
	}


	return 0;
}

