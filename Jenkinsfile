pipeline {
    agent any
    parameters{
        string(name: 'scmBranch', defaultValue: 'master', description: 'Source Control Branch to build from') 
        string(name: 'scmRepository', defaultValue: 'https://github.com/badalk/AzureResourceGroup.git', description: 'Source Control Branch to build from')        
        file(name: "FILE", description: "Choose a file to upload")
    }
    stages {
        stage ('Checkout Code'){
            steps{
                //node{ //use node to execute steps on an agent rather than master
                    echo "Getting source code"

                    checkout([$class: 'GitSCM', branches: [[name: '*/master']], 
                        doGenerateSubmoduleConfigurations: false, 
                        extensions: [[$class: 'CleanBeforeCheckout']], 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[credentialsId: 'BadalsGithub', 
                            url: 'https://github.com/badalk/AzureResourceGroup.git']]])

                    echo "Checking Powershell Version"

                    powershell returnStdout: true, script: '''$PSVersionTable.PSVersion'''

                //}
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