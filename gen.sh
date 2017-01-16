#! /bin/bash

CI_MSG=.ci.msg
POSTDATE=$(date +"%Y-%m-%d %H:%M:%S+00:00")
CDATE=$(date +%Y-%m-%d)
# DATE=$(date +%Y-%m-%d-%H-%M-%S)

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
    echo 'category: "Default"'                >> ${NEW_FILE}
    echo 'description: ""'                    >> ${NEW_FILE}
    echo 'title:  "标题"'                     >> ${NEW_FILE}
    echo "date: ${POSTDATE}"                  >> ${NEW_FILE}
    echo 'tags: [Default]'                    >> ${NEW_FILE}
    echo '---'                                >> ${NEW_FILE}
    echo ''                                   >> ${NEW_FILE}
}

function newFile()
{
	NEW_FILE=_posts/${CDATE}-$1.md

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
	echo "Update repos"
	git pull

	echo "Commit local changes"
	echo ""          > ${CI_MSG}
	git st -s       >> ${CI_MSG}
    cat ${CI_MSG} | awk '{ print $2 }' | xargs git add

	run cp ${CI_MSG} ${CI_MSG}.tmp
	echo ${POSTDATE}  > ${CI_MSG}
	echo ""          >> ${CI_MSG}
	cat ${CI_MSG}.tmp >> ${CI_MSG}
	rm -rf ${CI_MSG}.tmp

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
	edit)
		if [ "$2x" == "x" ]; then
			echo "No file name!!"
			exit 1
		fi
		${MD_EDITOR} $2
		;;
	test)
		echo "${POSTDATE}"
		;;
	*)
		$0 all
		;;
esac
