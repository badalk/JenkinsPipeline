pipeline {
    agent any
        options {
        // Nightwatch.js supports color ouput, so wrap add his option
        ansiColor colorMapName: 'XTerm'
    }
    stages {
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
                sh 'npm install'
            }
            
        }
    }
}