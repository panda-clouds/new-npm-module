#!/bin/bash
if [ -z $1 ]
then
	echo 'ERROR: project not defined.'
	exit 0
fi

if [ -z $2 ]
then
	echo 'ERROR: module name not defined.'
	exit 0
fi

CURR_DIR=$(pwd)

if [[ -e ../$1 ]]
then
	echo 'copying to existing directory'
else
	echo 'creating fresh clone'

	cd ..
	git clone git@github.com:panda-clouds/$1.git

	cd $CURR_DIR
fi

rsync -a --exclude='create_project.sh' --exclude='.git' --exclude='jest_0/' --exclude='README.md' --exclude='coverage/' --exclude='gen_module.py' . ../$1

echo 
python gen_module.py $1 $2

echo 'renaming files'
mv ../$1/new_README.md ../$1/README.md
mv ../$1/src/PCModule.js ../$1/src/$2.js
mv ../$1/spec/PCModule.spec.js ../$1/spec/$2.spec.js
