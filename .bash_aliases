#!/bin/bash
# alias.sh

shopt -s expand_aliases

alias intellij=sudo\ /usr/local/bin/idea-IC-171.4424.56/bin/idea.sh
alias mysql=mysql\ \-\-user\=root\ \-\-password\=i0tam3ager
alias xclip='xclip -sel clip'

git config --global alias.a add
git config --global alias.c commit -m
git config --global alias.s status
git config --global alias.p push
git config --global alias.co checkout
git config --global alias.l log
git config --global alias.d diff

alias k="kubectl"
alias kgp="kubectl get pods"
alias kdp="kubectl describe po"
alias kg="kubectl get"
alias kd="kubectl describe"
alias peg="printenv | grep -i"

awsProfile() {
	profile=${1}

    unset AWS_REGION

    if [ $profile = 'us-gov-west-1' ]
    then
        export AWS_REGION=us-gov-west-1
    elif [ $profile = 'us-east-1' ]
    then
        export AWS_REGION=us-east-1
    fi
   
	export AWS_PROFILE="${profile}"
	export AWS_ACCESS_KEY_ID="$(aws configure get aws_access_key_id --profile ${profile})"
	export AWS_SECRET_ACCESS_KEY="$(aws configure get aws_secret_access_key --profile ${profile})"
  export AWS_SESSION_TOKEN="$(aws configure get aws_session_token --profile ${profile})"
	echo "Changing to profile ${profile}"
}

unsetAwsProfile() {
  unset AWS_REGION
  unset AWS_ACCESS_KEY_ID
  unset AWS_SECRET_ACCESS_KEY
  unset AWS_SESSION_TOKEN
}
