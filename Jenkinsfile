pipeline {
    agent any
    parameters{
        repositoryBranch
    }
    stages {
        stage ('Checkout Code'){
            steps{
                
                checkout([$class: 'GitSCM', branches: [[name: '*/master']], 
                    doGenerateSubmoduleConfigurations: false, 
                    extensions: [[$class: 'CleanBeforeCheckout']], 
                    submoduleCfg: [], 
                    userRemoteConfigs: [[credentialsId: 'BadalsGithub', 
                        url: 'https://github.com/badalk/sitecoreazure.git']]])
            }
         }
        // stage('Checkout'){
        //   checkout scm
        // }
        // stage('build') {
        //     steps {
                
        //         sh 'npm --version'

        //         // node {
        //         //     def status = powershell(returnStatus: true, script: 'ipconfig')
        //         //      if (status == 0) {
        //         //     // Success!
        //         //     }
        //         // }
        //     }
            
        // }

        stage ("Build"){
            steps {
                echo "Hello World !!"
                bat 'npm install'
                bat 'Invoke-Pester '
            }
            
        }
    }
}