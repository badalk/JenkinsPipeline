pipeline {
    agent any
    
    parameters{
        string(name: 'Repository', defaultValue: 'git@github.com:badalk/AzureResourceGroup.git', description: 'Source Control Branch to build from')        
        string(name: 'Branch', defaultValue: 'master', description: 'Source Control Branch to build from') 
        // file(name: "ParameterFile", description: "Choose a file to upload")
    }

    environment {
        BUILD_DISPLAY_NAME = "test"
        JOB_NAME = "CI Build for Cloud Automation"
   }
    stages {
        
        stage ('Build'){
            steps{
                    // script{
                    //     env.currentBuild.displayname = "test"
                    //     env.currentBuild.description = "test description"
                    // }

                    echo "Getting source code from Repository: ${params.Repository} and Branch: ${params.Branch}"

                    // checkout([$class: 'GitSCM', branches: [[name: "*/${params.Branch}"]], 
                    //     doGenerateSubmoduleConfigurations: false, 
                    //     extensions: [[$class: 'CleanBeforeCheckout']], 
                    //     submoduleCfg: [], 
                    //     userRemoteConfigs: [[credentialsId: 'BadalGit', 
                    //     url: "${params.Repository}"]]])

                    checkout([$class: 'GitSCM', branches: [[name: "*/${params.Branch}"]], 
                        doGenerateSubmoduleConfigurations: false, 
                        extensions: [], 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[credentialsId: 'github-jenkins-ssh-key', 
                                            url: "${params.Repository}"]]])
                    
                    echo "Source code pulled from repository"

            }
         }

        stage ("Test"){
            //when {not {branch 'Production'}}

            steps {
                echo "In test"

                // powershell '''$TemplateParams = @{ registryName= "aksacrregistry"; sku= "Premium"; acrAdminUserEnabled=$true; location="eastus2"; replicatedregistrylocation="westus2"; isReplicationEnabled=$true } 
                // $parameters = @{ ResourceGroupName = "rg-aks"; TemplateFile = ".\\AzureResourceGroup1\\rg-AKS\\azuredeploy-acr.json"; PassedParameters = $TemplateParams } 
                // $script = @{ Path = ".\\*"; Parameters = $parameters } 
                // Invoke-Pester -Script $script -EnableExit -OutputFile ".\\TestResults.xml" -OutputFormat NUnitXml'''

                powershell '''$parameters = @{ ResourceGroupName = "rg-aks"; accountName ="http://azure-cli-2018-08-09-15-12-39"; password = "f1c35295-8e9a-4f7c-a753-57b9d15dc70e"; tenantId = "b25fcb44-9c49-413c-9fdc-b59b39447b84" } 
                $script = @{ Path = ".\\*"; Parameters = $parameters } 
                Invoke-Pester -Script $script -EnableExit -OutputFile ".\\TestResults.xml" -OutputFormat NUnitXml'''

            }

            post {
                always {
                    nunit testResultsPattern: 'TestResults.xml'
                }
            }
            
        }

        stage ("Deploy"){
            steps {
                echo "In Deploy"
            }
        }
    }
}