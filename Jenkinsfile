pipeline {
    agent any
    parameters{
        string(name: 'Repository', defaultValue: 'https://github.com/badalk/AzureResourceGroup.git', description: 'Source Control Branch to build from')        
        string(name: 'Branch', defaultValue: 'master', description: 'Source Control Branch to build from') 
        file(name: "ParameterFile", description: "Choose a file to upload")
    }
    stages {
        stage ('Upload Parameter File'){
            def inputFile = input message: 'Upload file', parameters: [file(name: 'azuredelpoy-acr.parameters.json')]
            new hudson.FilePath(new File("$workspace/azuredelpoy-acr.parameters.json")).copyFrom(inputFile)
            inputFile.delete()
        }
        stage ('Build'){
            steps{
                //node{ //use node to execute steps on an agent rather than master
                    echo "Getting source code"

                    checkout([$class: 'GitSCM', branches: [[name: '*/${params.Branch}']], 
                        doGenerateSubmoduleConfigurations: false, 
                        extensions: [[$class: 'CleanBeforeCheckout']], 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[credentialsId: 'BadalsGithub', 
                            url: '${params.Repository}']]])

                    echo "Source code pulled from repository"

                //}
            }
         }

        stage ("Test"){
            steps {
                echo fileExists('input.json').toString()
                def props = readJSON file: '$workspace/azuredelpoy-acr.parameters.json' // Read the json file
                echo props

                // powershell '''$TemplateParams = @{ registryName= "aksacrregistry"; sku= "Premium"; acrAdminUserEnabled=true; location="eastus2"; replicatedregistrylocation="westus2"; isReplicationEnabled=true } 
                // $parameters = @{ ResourceGroupName = "my-resource-group"; TemplateFile = ".\\appdeploy-acr.json"; Parameters = $TemplateParams } 
                // $script = @{ Path = ".\\*"; Parameters = $parameters } 
                // Invoke-Pester -Script $script -EnableExit -OutputFile ".\\artifacts\\TestResults.xml" -OutputFormat NUnitXml'''

            }
            
        }

        stage ("Deploy"){

        }
    }
}