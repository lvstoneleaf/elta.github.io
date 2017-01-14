#! /bin/bash

CI_MSG=.ci.msg

function commitAll()
{
	git st -s        > ${CI_MSG}
	sed -i "1,${DATA}" ${CI_MSG}
    git st -s | awk '{ print $2 }' | xargs git add
	git commit -F  ${CI_MSG}
	rm -rf ${CI_MSG}
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
