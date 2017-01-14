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

function insertDefaultMsg()
{
	if [ "$1x" == "x" ]; then
		echo "No file name!!"
		exit 1
	fi

	NEW_FILE=$1

	touch ${NEW_FILE}
    echo '---'                                >> ${NEW_FILE}
    echo 'layout: post'                       >> ${NEW_FILE}
    echo 'category: "example"'                >> ${NEW_FILE}
    echo 'description: ""'                    >> ${NEW_FILE}
    echo 'title:  "Blog 文章的基本模版"'      >> ${NEW_FILE}
    echo 'date: 2011-09-01'                   >> ${NEW_FILE}
    echo 'tags: [linux]'                      >> ${NEW_FILE}
    echo '---'                                >> ${NEW_FILE}
    echo 'Blog 文章的基本模版示例'            >> ${NEW_FILE}
    echo ''                                   >> ${NEW_FILE}
    echo '### 示例'                           >> ${NEW_FILE}
}

function newFile()
{
	NEW_FILE=_post/${DATA}-$1.md

	if [ "$1x" == "x" ]; then
		echo "No file name!!"
		exit 1
	fi

	echo "New file is ${NEW_FILE}"
	insertDefaultMsg ${NEW_FILE}
	run ${MD_EDITOR} ${NEW_FILE}
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
