#!/bin/bash
cd /var/opt/gitlab/gitlab_check/code;
mvn dependency:copy-dependencies;
/var/opt/gitlab/dependency-check/bin/dependency-check.sh -s /var/opt/gitlab/gitlab_check/code -o /var/opt/gitlab/gitlab_check
result=$(python3 /var/opt/gitlab/gitlab_check/result.py /var/opt/gitlab/gitlab_check/dependency-check-report.html 2>&1)
if [[ $result == "ok" ]]
then
  echo "dependency-check ok"
  exit 0
else
  echo $result
  exit 1
fi
