// Dinner Philosopher
// Dylan Andersen

#include <pthread.h>
#include <stdio.h>
#include <stdlib.h>
#include <stdint.h>

//define constant PHILOSOPHERS as 7
#define PHILOSOPHERS 7
//define number of times function philosopher runs, per thread, as 20
#define NUMBEROFLOOPS 20

// mutex for grabbing forks
pthread_mutex_t lock; 
// mutex for writing to txt file
pthread_mutex_t writeLock; 
// mutex for discussing
pthread_mutex_t discussLock; 

// condition variable for discussing
pthread_cond_t discussCondition;
// condition variable for grabbing forks
pthread_cond_t grabCondition;

// variable to count the number of discussing philosophers
int numDThreads=0;

// array to represent the forks
int forks[PHILOSOPHERS] = {0};

// number of alive even threads
int numEThreads = 0;

// function headers
void * thinking(void * tid);
void * eating(void * tid);
void * take_fork(void * tid);
void * discussing(void * tid);
void * put_fork(void * tid);

void * philosophers(void * tid);


// take fork function
void * take_fork(void * tid) {
	int status;
	int philosopherID = (intptr_t)tid;
	char command[150];
    
    // assigning correct forks to philosopher 
	int leftFork = philosopherID % PHILOSOPHERS;
	int rightFork = philosopherID-1;
	int left = leftFork + 1;
    int right = rightFork +1;
    
    //grab fork lock
    // if forks are taken wait
    pthread_mutex_lock(&lock);
	while(forks[rightFork] || forks[leftFork]) {
		pthread_cond_wait(&grabCondition, &lock);
	}
	forks[rightFork] = 1;
	forks[leftFork] = 1;
	
	sprintf(command, "echo 'Philosopher %d takes fork %d and fork %d' >> philosophers_output.txt", philosopherID, left, right);
	printf("Philosopher %d takes fork %d and fork %d\n", philosopherID, left, right);
	
	// grab writing lock
	pthread_mutex_lock(&writeLock);
	status = system(command);
	pthread_mutex_unlock(&lock);
	pthread_mutex_unlock(&writeLock);
}

// putting forks away function
void * put_fork(void * tid) {
	int status;
	int philosopherID = (intptr_t)tid;
	char command[150];
	
	// assigning correct forks to philosopher 
	int leftFork = philosopherID % PHILOSOPHERS;
	int rightFork = philosopherID-1;
	int left = leftFork + 1;
    int right = rightFork +1;

    // grab fork lock
	pthread_mutex_lock(&lock);
	forks[rightFork] = 0;
	forks[leftFork] = 0;

    // broadcasts to any thread waiting to grab forks
	pthread_cond_broadcast(&grabCondition);
	sprintf(command, "echo 'Philosopher %d is putting fork %d and fork %d' >> philosophers_output.txt", philosopherID, left, right);
	printf("Philosopher %d is putting fork %d and fork %d\n", philosopherID, left, right);
    
    // grab writing lock
    pthread_mutex_lock(&writeLock);
	status = system(command);
	pthread_mutex_unlock(&lock);
	pthread_mutex_unlock(&writeLock);
}

// discussing function
void * discussing(void * tid) {
	int status;
	int philosopherID = (intptr_t)tid;
	char command[150];

    // scenerio if an even thread tries to discuss when one or more other even threads are completely done
	if (numEThreads < 3) {
		sprintf(command, "echo 'Not enough philosophers alive to discuss %d \n' >> philosophers_output.txt", philosopherID);
		printf("Not enough philosophers alive to discuss %d \n", philosopherID);
		
		// grab writing lock
		pthread_mutex_lock(&writeLock);
    	status = system(command);
    	pthread_mutex_unlock(&writeLock);
		return 0;
	}
    
	sprintf(command, "echo 'Philosopher %d joined the discussion with %d others\n' >> philosophers_output.txt", philosopherID, numDThreads);
	printf("Philosopher %d joined the discussion with %d others\n", philosopherID, numDThreads);
	
	// grab writing lock
	pthread_mutex_lock(&writeLock);
    status = system(command);
    pthread_mutex_unlock(&writeLock);
    
    // grab discuss lock
    pthread_mutex_lock(&discussLock);
	numDThreads+=1;


    // broadcasts if 3 even philosophers are able to discuss
	if (numDThreads == 3) {
		char Command[150];
		sprintf(Command, "echo 'Philosopher %d is ending the discussion' >> philosophers_output.txt", philosopherID );
		printf("Philosopher %d is ending the discussion\n", philosopherID);
		status = system(Command);

		numDThreads = 0;

		pthread_cond_broadcast(&discussCondition);
	}
	
	// wait for the broadcast, not enough even philosophers ready to discuss yet
	else {
		if (numDThreads > 0 && numDThreads<3) {
			pthread_cond_wait(&discussCondition, &discussLock);
		}
	}
	
	pthread_mutex_unlock(&discussLock);
}



// thinking function
void * thinking(void * tid) {
    int status;
	int philosopherID = (intptr_t)tid;
	
    // prints ID and status of thinking to console and txt file
	printf("Philosopher thread %d is thinking\n", philosopherID);
	char command[100];
	sprintf(command, "echo 'Philosopher %d thinking\n' >> philosophers_output.txt", philosopherID);
	
	// grab writing lock 
	pthread_mutex_lock(&writeLock);
	status = system(command);
	pthread_mutex_unlock(&writeLock);

}

// eating function
void * eating(void * tid) {
    int status;
	int philosopherID = (intptr_t)tid;
	
    // prints ID and status of eating to console and txt file
	printf("Philosopher thread %d is eating\n", philosopherID);
	char command[100];
	sprintf(command, "echo 'Philosopher %d eating\n' >> philosophers_output.txt", philosopherID);

    // grab writing lock 
	pthread_mutex_lock(&writeLock);
	status = system(command);
	pthread_mutex_unlock(&writeLock);


}


void * philosopher(void * philosopherID) {
	int philosID = (intptr_t)philosopherID;
	
	// if even increment
	if (philosID % 2 == 0) { 
		numEThreads++;
	}
    
    // loop to feed the philosophers 
	for(int i = 0; i < NUMBEROFLOOPS; i++) {
		thinking(philosopherID);
		take_fork(philosopherID);
		eating(philosopherID);
		
		// if even discuss
		if (philosID % 2 == 0) { 
			discussing(philosopherID);
		}

		put_fork(philosopherID);
	}
	
	// if even decrement when completely done
	if (philosID % 2 == 0) { 
		numEThreads--;
	}

    printf("Philosopher thread %d is full \n",philosID);

	pthread_exit(NULL);
}

int main(int argc, char * argv[])
{
	/* The main program creates 7 threads and then exits. */
	pthread_t threads[PHILOSOPHERS];
	int status, i;

	// create a mutex
	if (pthread_mutex_init(&lock, NULL) != 0)
	{
		printf("\n mutex init failed\n");
		return 1;
	}
	// creating the 7 philosophers 
	for(i=1; i < PHILOSOPHERS+1; i++) {
		// run main thread
		printf("Main here. Creating philosopher thread %d\n", i);
		// create 7 threads
		status = pthread_create(&threads[i], NULL, philosopher, (void *)(intptr_t)i);
		// check for errors with creating threads
		if (status != 0) {
			printf("Oops. pthread create returned error code %d\n", status);
			exit(-1);
		}

	}
	// forcing threads to wait for all to be created
	for (int j = 1; j < PHILOSOPHERS+1; j++)
	{
		pthread_join (threads[j], NULL);
	}
	// delete the mutex
	pthread_mutex_destroy(&lock);
	exit(0);
}