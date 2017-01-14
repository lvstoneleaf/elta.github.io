#! /bin/bash

CI_MSG=.ci.msg
DATA=$(date +%Y-%m-%d)

MD_EDITOR=macdown

function run()
{
	if [ "x"$1 == "x" ]; then
		echo "Nothing to run"
		exit 1
	fi

	$*

	if [ $? != 0 ]; then
		echo "$* error"
		exit 1;
	fi
}

function newFile()
{
	NEW_FILE=${DATA}-$1.md

	if [ "$1x" == "x" ]; then
		echo "No file name!!"
		exit 1
	fi

	echo "New file is ${NEW_FILE}"
	cp utils/default.md _posts/${NEW_FILE}
	run ${MD_EDITOR} _posts/${NEW_FILE}
}


function commitAll()
{
	git st -s        > ${CI_MSG}
    cat ${CI_MSG} | awk '{ print $2 }' | xargs git add
	echo "${DATA}"  >> ${CI_MSG}
	git commit -F  ${CI_MSG}
	rm -rf ${CI_MSG}
}

function pushRepo()
{
	git push
}


case $1 in
	all)
		echo "All step"
		$0 ci
		$0 push
		;;
	ci)
		echo "Commit all"
		commitAll
		;;
	push)
		echo "Push"
		pushRepo
		;;
	new)
		if [ "$2x" == "x" ]; then
			echo "No file name!!"
			exit 1
		fi
		echo "Create New file $2"
		newFile $2
		;;
	*)
		$0 all
		;;
esac
