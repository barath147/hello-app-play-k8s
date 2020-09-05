node {
	stage('Initialize Pipeline') {
		deleteDir()
		properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '10')), disableConcurrentBuilds(), pipelineTriggers([githubPush(), pollSCM('')])])
    	}

    stage('Code Checkout & Build') {
        	git branch: "${env.BRANCH_NAME}", credentialsId: 'GITHUB-CREDS', url: 'https://github.com/barath147/hello-app-play-k8s.git'
		sh 'mvn clean install'
    }
}
