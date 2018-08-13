pipeline {
    agent any
    stages {
        stage('build') {
            steps {
                sh 'npm --version'

                node {
                    def status = powershell(returnStatus: true, script: 'ipconfig')
                     if (status == 0) {
                    // Success!
                    }
                }
            }
            
        }
    }
}