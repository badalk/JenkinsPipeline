pipeline {
    agent any
    parameters{
        string(name: 'Repository', defaultValue: 'https://github.com/badalk/AzureResourceGroup.git', description: 'Source Control Branch to build from')        
        string(name: 'Branch', defaultValue: 'master', description: 'Source Control Branch to build from') 
        file(name: "ParameterFile", description: "Choose a file to upload")
    }
    stages {
        stage ('Upload Parameter File'){
            input {
                message "Upload parameters file"
                ok "Upload File"
                parameters {
                    file(name: "ParamFile", description: "Choose a file to upload")
                }
                
            }
            steps {
                echo "Hello, ${params.ParameterFile}, nice to meet you."
                echo "Hello, ${ParameterFile}, nice to meet you."
                echo "Hello Input, ${ParamFile}, nice to meet you."
                echo "Workspace: $workspace"
                script{
                    new hudson.FilePath(new File("$workspace/Template-Parameters.json")).copyFrom(new FileInputStream("${ParamFile}"))
                }
                echo "Parameters File copied to workspace at this location $workspace"
            }
        }
        
        stage ('Build'){
            steps{
                //node{ //use node to execute steps on an agent rather than master
                    echo "Getting source code"
                    echo "Branch: ${params.Branch}"
                    echo "Repository: ${params.Repository}"
                    
                    checkout([$class: 'GitSCM', branches: [[name: "*/${params.Branch}"]], 
                        doGenerateSubmoduleConfigurations: false, 
                        submoduleCfg: [], 
                        userRemoteConfigs: [[credentialsId: 'BadalGit', 
                        url: "${params.Repository}"]]])

                    echo "Source code pulled from repository"

                //}
            }
         }

        stage ("Test"){
            //when {not {branch 'Production'}}

            steps {
                echo "In test"

                powershell '''$TemplateParams = @{ registryName= "aksacrregistry"; sku= "Premium"; acrAdminUserEnabled=$true; location="eastus2"; replicatedregistrylocation="westus2"; isReplicationEnabled=$true } 
                $parameters = @{ ResourceGroupName = "rg-aks"; TemplateFile = ".\\AzureResourceGroup1\\rg-AKS\\azuredeploy-acr.json"; PassedParameters = $TemplateParams } 
                $script = @{ Path = ".\\*"; Parameters = $parameters } 
                Invoke-Pester -Script $script -EnableExit -OutputFile ".\\TestResults.xml" -OutputFormat NUnitXml'''

                echo "${workspace}\\TestResults.xml"

            }

            post {
                always {
                    retry(3) {
                        if (fileExists('TestResults.xml')) {
                            echo 'TestResults.xml: Yes'
                        } else {
                            echo 'TestResults.xml: No'
                        }
                        nunit testResultsPattern: 'TestResults.xml'
                    }
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