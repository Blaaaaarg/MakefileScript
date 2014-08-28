# Maker V1.3
# Made By: Scott Walker
# This program generates makefiles for c++ programs
# For directions see included .md file or go to github.com/Blaaaaarg/MakefileScript

programname="executable"

for v in $@
do
    if [ "$v" = "-v" ]
    then
         verbose="true" 
    fi
done

if [ "$verbose" = "true" ]
then
    echo -e "Building dependency list..."
fi

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


if [ "$verbose" = "true" ]
then
    echo -e "========================"
    echo -e "User options: "
fi

for c in $@
do
    if [ "$c" = "-c" ]
    then
        compile="true"
        echo -e "\tEnabled compile by default"
        echo -e "\tWarning: this will overwrite any executable with the same name"
    fi
done

for g in $@
do
    if [ "$g" = "-g" ]
    then
        debug="true"
        echo -e "\tEnabled debugging mode"
    fi
done

for m in $@
do
    if [ "$m" = "-m" ]
    then
        minimal="true"
        echo -e "\tEnabled minimal mode"
    fi
done

for name in $@
do
    if [ "$tag" = "true" ]
    then
        programname="$name"
        if [ "$verbose" = "true" ]
        then
            echo -e "\tEnabled executable name as '$name'"
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
    echo -e "========================"
    echo -e "Building the makefile..."
fi

echo -e "#"Makefile created by maker v1.2"\t"github.com/Blaaaaarg/MakefileScript > makefile

echo $programname.x : $(builddeplist) >> makefile

if [ "$debug" = "true" ]
then
    echo -n -e "\t"g++ -g -o $programname.x >> makefile
else
    echo -n -e "\t"g++ -o $programname.x >> makefile
fi

echo -n -e " " $(builddeplist) >> makefile
echo -n -e "\n" >> makefile

if [ "$verbose" = "true" ]
then
    echo -n "."
fi

for filename in *.cpp
do
    echo -n $filename | sed 's/.cpp/.o/g' >> makefile
    echo -n -e " ": $filename >> makefile
    echo -e " " $(hfiles) >> makefile
    if [ "$debug" = "true" ]
    then
        echo -n -e "\t"g++ -g -c $filename >> makefile
    else
        echo -n -e "\t"g++ -c $filename >> makefile
    fi
    echo -n -e "\n" >> makefile
    if [ "$verbose" = "true" ]
    then
        echo -n "."
    fi
done

if [ "$debug" = "true" ]
then
    echo -e "\n"debug : >> makefile
    echo -e "\t"gdb $programname.x >> makefile
fi

if [ "$minimal" != "true" ]
then
    echo -e "\n"clean : >> makefile
    echo -n -e "\t"rm -f *.o *.x "\n" >> makefile


    echo run : >> makefile
    echo -e -n "\t"./$programname.x"\n" >> makefile
fi

if [ "$compile" = "true" ]
then
    if [ "$verbose" = "true" ]
    then
        echo -e "\nCompiling executable..."
    fi
    echo -e make | sh
fi

if [ "$verbose" = "true" ]
then
    echo -e ".\nFinished!"
fi
