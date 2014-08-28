# Maker V1.2
# Made By: Scott Walker
# github.com/Blaaaaarg

programname="executable"

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

for v in $@
do
    if [ "$v" = "-v" ]
    then
         verbose="true" 
    fi
done

for g in $@
do
    if [ "$g" = "-g" ]
    then
        debug="true"
    fi
done

for m in $@
do
    if [ "$m" = "-m" ]
    then
        minimal="true"
    fi
done

for n in $@
do
    if [ "$n" = "-n" ]
    then
	for name in $@
	do
	    if [ "$name" != "-n" ] 
	    then
	 	if [ "$name" != "-v" ]
	        then
	            programname="$name"
		fi
	    fi
	done
    fi
done

if [ "$verbose" = "true" ]
then
    echo "Building the makefile..."
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

if [ "$minimal" != "true" ]
then
    echo -e "\n"clean : >> makefile
    echo -n -e "\t"rm -f *.o *.x "\n" >> makefile

    if [ "$debug" = "true" ]
    then
        echo debug : >> makefile
        echo -e "\t"gdb $programname.x >> makefile
    fi

    echo run : >> makefile
    echo -e -n "\t"./$programname.x"\n" >> makefile
fi

if [ "$verbose" = "true" ]
then
    echo -e ".\nFinished!"
fi
