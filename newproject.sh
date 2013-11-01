generateCppTemplate() 
{
echo "Cpp Template"
echo // $title >> main.cpp
echo // $(whoami) >> main.cpp
echo // $(date) >> main.cpp
echo // "Description: " >> main.cpp
echo
echo "#include <iostream>
using namespace std;

int main()
{
    cout << \"Hello World\";
    return 0;
}" >> main.cpp

}

generateMakefile()
{
echo "$title.x : main.o
	g++ -g main.o -o $title.x

main.o :
	g++ -g -c main.cpp

run :
	./$title.x

debug :
	gdb $title.x

clean :
	rm $title.x" > makefile
}


directory=$(pwd)
echo "What type of project do you want to create?
1) cpp 
Enter a number: "
read number
echo "You chose $number"
echo "What is the project or lab name? "
read title
mkdir $title
cd $title
if [ $number == 1 ]; then
    generateCppTemplate
    generateMakefile
else
    echo Invalid Selection
    exit 1
fi

git init #$directory$title "Initial Commit"
git add *.cpp
git add makefile
git status
echo
ls -la
