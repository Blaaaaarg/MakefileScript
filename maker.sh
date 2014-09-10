# Maker V1.4
# Made By: Scott Walker
# This program generates makefiles for c++ programs
# For directions see included .md file or go to github.com/Blaaaaarg/MakefileScript

programname="executable.x"
input=""
version="1.4"
compiler="g++"


builddeplist()
{
    for filename in *.cpp
    do
        echo $filename | sed 's/.cpp/.o/g'
    done
}
hfiles()
{
    for hfilename in *.h
    do
        found=$(grep $hfilename $filename)
        if [ "$found" != "" ]
        then
            echo $hfilename
        fi
    done
    for hppfilename in *.hpp
    do
	found=$(grep $hppfilename $filename)
        if [ "$found" != "" ]
	then
	    echo $hppfilename
	fi
    done
}


# Check for flags
for op in $@
do
    if [ "$op" = "-v" ]
    then
        verbose="true" 
        echo -e "Maker v$version"
        echo -e "========================"
    elif [ "$op" = "-g" ]
    then
        debug="true"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tEnabled debugging mode"
        fi
    elif [ "$op" = "-m" ]
    then
        minimal="true"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tEnabled minimal mode"
        fi
    elif [ "$op" = "-df" ]
    then
        compile="true"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tEnabled compile by default (forced)"
        fi
    elif [ "$op" = "-gcc" ]
    then
        compiler="gcc"

    elif [ "$op" = "-d" ]
    then
        compile="true"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tEnabled compile by default"
        fi
        if [ "$(find $programname)" = "$programname" ]
        then
            echo -e "\tWarning: $programname will be overwritten"
            echo -e "\tContinue? (y/n)"
            read input
            if [ "$input" != "y" ]
            then
                exit;
            fi
        fi
    fi
done

# Check for rename (-n) flag
for name in $@
do
    if [ "$tag" = "true" ]
    then
        programname="$name"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tWriting executable name as '$name'"
        fi
        break
    fi
    if [ "$name" = "-n" ]
    then
        tag="true"
        continue
    fi
done

if [ "$verbose" = "true" ]
then
    echo -e "Using $compiler"
    echo -e "Building the makefile"
fi

echo -e "#"Makefile created by maker v$version"\t"github.com/Blaaaaarg/MakefileScript > makefile

if [ "$verbose" = "true" ]
then
    echo -e "Building dependency list"
fi

echo $programname : $(builddeplist) >> makefile

# Create makefile commands
if [ "$debug" = "true" ]
then
    echo -n -e "\t"$compiler -g -o $programname >> makefile
else
    echo -n -e "\t"$compiler -o $programname >> makefile
fi

echo -n -e " " $(builddeplist) >> makefile
echo -n -e "\n" >> makefile

# Find dependancies for all project files
for filename in *.cpp
do
    echo -n $filename | sed 's/.cpp/.o/g' >> makefile
    echo -n -e " ": $filename >> makefile
    echo -e " " $(hfiles) >> makefile
    if [ "$debug" = "true" ]
    then
        echo -n -e "\t"$compiler -g -c $filename >> makefile
    else
        echo -n -e "\t"$compiler -c $filename >> makefile
    fi
    echo -n -e "\n" >> makefile
done

if [ "$debug" = "true" ]
then
    echo -e "\n"debug : >> makefile
    echo -e "\t"gdb $programname >> makefile
fi

if [ "$minimal" != "true" ]
then
    echo -e "\n"clean : >> makefile
    echo -n -e "\t"rm -f *.o *.x "\n" >> makefile


    echo run : >> makefile
    echo -e -n "\t"./$programname"\n" >> makefile
fi

if [ "$compile" = "true" ]
then
    if [ "$verbose" = "true" ]
    then
        echo -e "Compiling executable"
    fi
    echo -e make | sh
fi

if [ "$verbose" = "true" ]
then
    echo -e "Finished!"
fi
