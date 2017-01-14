#! /bin/bash

CI_MSG=.ci.msg

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
	*)
		$0 all
		;;
esac
