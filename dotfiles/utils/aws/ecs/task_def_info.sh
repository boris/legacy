#!/bin/bash

tmp_file="/tmp/aws-task-def-list.txt"

function get_list(){
    get_tasks=$(aws ecs list-task-definitions --output json | sed -e 's/\// /g' | awk '{print $2}' | sed -e 's/:/ /g' | awk '{print $1}' |uniq)
    
    rm $tmp_file

    for task in $get_tasks
    do
        hostPort=$(aws ecs describe-task-definition --task-definition $task --output json | grep hostPort)
        if [ ! -z "$hostPort" ]
        then
    	echo $task $hostPort >> $tmp_file
        fi

    done
}

function get_last_port(){
    last=`cat $tmp_file | sed -e 's/,//g' | awk '{print $NF}' | sort -n | tail -n2 |head -n1`
    echo "Last port used is: $last"
}

case "$1"  in
    ""|--help|-h)
	echo -e "Usage: 
	./task_def_info.sh --<option>

Options:
	find:\tfind a task by name
	last:\tget last port used
	update:\tget or refresh the list of tasks"
	;;

    --find | -f)
	cat $tmp_file | grep -i $2
	;;

    --last | -l)
	get_last_port
	;;

    --update | -u)
	get_list
	;;

esac
