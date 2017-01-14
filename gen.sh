#! /bin/bash

CI_MSG=.ci.msg

function commitAll()
{
    git st -s | awk '{ print $2 }' | xargs git add
	echo ${DATA} > ${CI_MSG}
	git st -s   >> ${CI_MSG}
	git commit -F  ${CI_MSG}
}



case $1 in
	all)
		echo "All"
		;;
	ci)
		echo "Commit all"
		commitAll
		;;
	*)
		echo "Fall down"
		;;
esac
