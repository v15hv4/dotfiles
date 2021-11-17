#!/usr/bin/env bash

PARTNAME=/scratch
DIRNAME=$(whoami)
NODELIST=()
ACCOUNT=research

# help text
if [ $# -eq 0 ]
then
    echo "Usage: ./touchloop.sh -w <nodes> -p <partition> -d <directory name> -A <account>" >&2
    exit
fi

# handle options
while getopts ":w:p:d:A:" OPT
do
    case $OPT in
        w)
            NODELIST=("$OPTARG")
            until [[ $(eval "echo \${$OPTIND}") =~ ^-.* ]] || [ -z $(eval "echo \${$OPTIND}") ]
            do
                NODELIST+=($(eval "echo \${$OPTIND}"))
                OPTIND=$((OPTIND + 1))
            done
            ;;
        p)
            PARTNAME=$OPTARG
            ;;
        d)
            DIRNAME=$OPTARG
            ;;
        A)
            ACCOUNT=$OPTARG
    esac
done

# touch files in all specified nodes
for idx in ${NODELIST[@]}
do
    node="gnode$idx"

    echo "Touching $PARTNAME/$DIRNAME in $node..."
    srun -c 1 -A $ACCOUNT -w $node find $PARTNAME/$DIRNAME -exec touch {} +
    echo
done