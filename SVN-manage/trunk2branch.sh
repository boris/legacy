#!/bin/bash
SVN="/path/to/SVN"
SERVER="http://svn.example.com/svn/project"
TRUNK="web/trunk/web"
BRANCH="web/branch"

cd $SVN
echo "Hi! I'm at" `pwd`

# Define the name of the new branch
echo -n "Set name for the new branch: "
read NEWBRANCH
echo "New branch name: $NEWBRANCH"
# Creates a copy of the latest version of the trunk, to a new branch
echo -n "Are you sure you want to create the $NEWBRANCH branch? [yes/no]: "
read ANSWER

if [ $ANSWER == "yes" ]
	then
	svn copy $SERVER/$TRUNK $SERVER/$BRANCH/$NEWBRANCH
else
	echo "Aborted"
fi

# Notify the new branch by email
echo -n "Add message to notification: "
read MESSAGE
echo "New branch created on $BRANCH/$NEWBRANCH. \n$MESSAGE" | mail -s "New Branch notification" somebody@example.com