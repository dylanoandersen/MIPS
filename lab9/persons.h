//Dylan Andersen
//lab 9

#include <string>
#include <iostream>
using namespace std;

#ifndef PERSONS_H
#define PERSONS_H

class person{
public:
    person();
    person(int);
    person(int, string);
    person(int, string, string);

    void report_person_data();
    int get_person_year() const;
    string get_person_name();
    string get_person_location();

private:
    void set_birth_year(int) ;
    void set_location(string);
    void set_person_name(string);

    int p_birth_year;
    string p_location;
    string p_name;

};


#endif 