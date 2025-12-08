#!/bin/bash
clear

# filling courses.txt
bash courses.bash

courseFile="courses.txt"

function displayCoursesofInst(){

echo -n "Please Input an Instructor Full Name: "
read instName

echo ""
echo "Courses of $instName :"
cat "$courseFile" | grep "$instName" | cut -d';' -f1,2 | \
sed 's/;/ | /g'
echo ""

}

function courseCountofInsts(){

echo ""
echo "Course-Instructor Distribution"
cat "$courseFile" | cut -d';' -f7 | \
grep -v "/" | grep -v "\.\.\." | \
sort -n | uniq -c | sort -n -r 
echo ""

}

# TODO - 1
# Make a function that displays all the courses in given location
# function dislaplays course code, course name, course days, time, instructor
# Add function to the menu
# Example input: JOYC 310
# Example output: See the screenshots in canvas

function displayCourseLocation(){

    echo -n "Input desired course location:"
    read courseLoc
    echo "Courses located in $courseLoc:"
    cat "$courseFile" | grep "$courseLoc" | cut -d';' -f1,2,5,6,7,10

}

# TODO - 2
# Make a function that displays all the courses that has availability
# (seat number will be more than 0) for the given course code
# Add function to the menu
# Example input: SEC
# Example output: See the screenshots in canvas

function displayAvailableCourses(){

    echo -n "Input desired course subject:"
    read courseSub
    echo "$courseSub courses that are available:"
    grep "^$courseSub" "$courseFile" | while IFS=";" read -r f1 f2 f3 f4 f5 f6 f7 f8 f9 f10; do
        if [ "$f4" -gt 0 ]; then
            echo "$f1 | $f2 | $f3 | $f4 | $f5 | $f6 | $f7 | $f8 | $f9 | $f10"
        fi
   done

}

while :
do
	echo ""
	echo "Please select and option:"
	echo "[1] Display courses of an instructor"
	echo "[2] Display course count of instructors"
	echo "[3] Display course by location"
	echo "[4] Display available courses by subject"
	echo "[5] Exit"

	read userInput
	echo ""

	if [[ "$userInput" == "5" ]]; then
		echo "Goodbye"
		break

	elif [[ "$userInput" == "1" ]]; then
		displayCoursesofInst

	elif [[ "$userInput" == "2" ]]; then
		courseCountofInsts

    elif [[ "$userInput" == "3" ]]; then
        displayCourseLocation

    elif [[ "$userInput" == "4" ]]; then
        displayAvailableCourses

    # TODO - 3 Display a message, if an invalid input is given
    else
        echo "That is not a valid input. Please choose 1-5 from the menu"

	fi
done
