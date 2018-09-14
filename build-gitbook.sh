#!/bin/sh

COMPILE_DIR="_book"

#遍历目录
function loopDir(){
        #1st param, the dir name
        #2nd param, the aligning space
        for file in `ls $1`;
        do
			if [ -d "$2$file" -a -f "$2$file/SUMMARY.md" ]; then
				#echo "$2$file"
				excu_compile "$2$file"
				#break
			fi
        done
}

function excu_compile(){
	
	CURR=`pwd`
	rm -rf $CURR/$1/$COMPILE_DIR 
	cd $CURR/$1
	gitbook build
	del_origin_files $CURR/$1
	if test -d $CURR/$1/$COMPILE_DIR ; then 
		cp -r $CURR/$1/$COMPILE_DIR/*  $CURR/$1/
	fi
	cd ..

}

function del_origin_files(){
	for file in `ls $1`;
	do
		if test $file != $COMPILE_DIR
		then 
			echo "$file"
			rm -rf $file			
		fi
	done
}



echo 'compile dubbo document'

#切换分支到gh-pages
git checkout gh-pages

#遍历目录
loopDir $1 ""

git add .

git commit -m "构建文档,,,"

git push origin/gh-pages  gh-pages




