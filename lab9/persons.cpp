//Dylan Andersen
//lab 9
#include "persons.h"
#include <string>
#include <iostream>
#include <utility>
using namespace std;

person::person() = default;

person::person(int b_year)
    : p_birth_year{move(b_year)}
    {}

person::person(int b_year, string b_loc)
    : p_birth_year{move(b_year)}, p_location{move(b_loc)}
    {}

person::person(int b_year, string b_loc, string b_name)
    : p_birth_year{move(b_year)}, p_location{move(b_loc)}, p_name{move(b_name)}
    {}

//_________________________________________________________________

int person::get_person_year()const{
    return this->p_birth_year;
}

string person::get_person_location(){
    return this->p_location;
}

string person::get_person_name(){
    return this->p_name;
}

void person::set_birth_year(int year){
    this->p_birth_year = year;
}

void person::set_location(string loc){
    this->p_location = loc;
}

void person::set_person_name(std::string name){
    this->p_name = std::move(name);
}

void person::report_person_data(){
    cout << "Person Name: " << get_person_name() << endl;
    cout << "Born on Date: " << get_person_year() << endl;
    cout << "Location Info: " << get_person_location() << endl;
}