node {
	stage('Initialize Pipeline') {
		deleteDir()
		properties([buildDiscarder(logRotator(artifactDaysToKeepStr: '', artifactNumToKeepStr: '', daysToKeepStr: '10', numToKeepStr: '10')), disableConcurrentBuilds(), pipelineTriggers([githubPush(), pollSCM('')])])
		slackSend channel: 'dap-devops-case-study-group', failOnError: true, message: "${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) ==>> Pipeline Initialized", tokenCredentialId: 'SLACK-TOKEN'
    }

    stage('Code Checkout & Build') {
        git branch: "${env.BRANCH_NAME}", credentialsId: 'GITHUB-CREDS', url: 'https://github.com/barath147/hello-app-play-k8s.git'
		sh 'mvn clean install'
		slackSend channel: 'dap-devops-case-study-group', failOnError: true, message: "${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) ==>> GitHub Checkout and Maven Build Complete", tokenCredentialId: 'SLACK-TOKEN'
    }

    stage('Static Code Analysis') {
    	withCredentials([usernamePassword(credentialsId: 'SONAR-QUBE-CREDS', passwordVariable: 'SONAR_PASS', usernameVariable: 'SONAR_USER')]) {
    		withSonarQubeEnv('SonarQube') {
    			sh 'mvn $SONAR_MAVEN_GOAL -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_USER -Dsonar.password=$SONAR_PASS -Dsonar.sources=. -Dsonar.tests=. -Dsonar.test.inclusions=. -Dsonar.exclusions=.'
    		}
    	}
    	slackSend channel: 'dap-devops-case-study-group', failOnError: true, message: "${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) ==>> SonarQube Static Code Analysis Scan Complete", tokenCredentialId: 'SLACK-TOKEN'
   	}

   	stage('Skaffold Build') {
        /* withCredentials([usernamePassword(credentialsId: 'SONAR-QUBE-CREDS', passwordVariable: 'SONAR_PASS', usernameVariable: 'SONAR_USER')]) {
        	withSonarQubeEnv('SonarQube') {
        		sh 'mvn $SONAR_MAVEN_GOAL -Dsonar.host.url=$SONAR_HOST_URL -Dsonar.login=$SONAR_USER -Dsonar.password=$SONAR_PASS -Dsonar.sources=. -Dsonar.tests=. -Dsonar.test.inclusions=. -Dsonar.exclusions=.'
        	}
        } */
        sh "skaffold build"
        slackSend channel: 'dap-devops-case-study-group', failOnError: true, message: "${env.JOB_NAME} ${env.BUILD_NUMBER} (<${env.BUILD_URL}|Open>) ==>> Docker Image Build and Upload to Registry using Skaffold Complete", tokenCredentialId: 'SLACK-TOKEN'
    }
}

