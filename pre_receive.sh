#!binbash
 
mkdir_and_cp_file(){
    result=$(echo $1  grep )
    if [ $result !=  ];then
        mkdir -p $2${1%}
        echo mkdir_and_cp_file$1
    fi
 
    git show $newVersion$1  $2$1
 
}
 
while read oldVersion newVersion branch; do
    # 只对master分支做检查
    result=${branch}
    if [ $result !=  ];then
        echo 开始检查代码
        desPath=~code
        # echo -e ncp file
        gitDiff=`git diff --name-status $oldVersion $newVersion  awk '$1 == M { print $2 }'`
        
        for var in ${gitDiff}; do
            mkdir_and_cp_file ${var} $desPath
        done
        
        # echo -e nmkdir and add cp file
        gitDiff=`git diff --name-status $oldVersion $newVersion  awk '$1 == A { print $2 }'`
        for var in ${gitDiff}; do
            mkdir_and_cp_file ${var} $desPath
        done
        
        gitDiff=`git diff --name-status $oldVersion $newVersion  awk '$1 ~ R { print $3}'`
        for var in ${gitDiff}; do
            mkdir_and_cp_file ${var} $desPath
        done
        
        # echo -e ndelete file
        gitDiff=`git diff --name-status $oldVersion $newVersion  awk '$1 == D { print $2 }'`
        for var in ${gitDiff}; do
            rm $desPath${var}
        done
        
        gitDiff=`git diff --name-status $oldVersion $newVersion  awk '$1 ~ R { print $2}'`
        for var in ${gitDiff}; do
            rm $desPath${var}
        done
        
        cd $desPath
        unset GIT_DIR
        unset GIT_QUARANTINE_PATH
        #开始验证代码
        echo 检查代码成功
    fi
done