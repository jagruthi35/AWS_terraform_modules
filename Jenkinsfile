pipeline {
    tools {
        // Use the configured Terraform installation
        terraform 'Terraform'
    }
    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 
    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

   agent  any
    stages {
        stage('checkout') {
            steps {
                 script{
                        dir("tfcon")
                        {
                            git "https://github.com/jagruthi35/AWS_terraform_modules.git"
                        }
                    }
                }
            }

        stage('Plan') {
            steps {
                sh 'pwd;cd tfcon/ ; terraform init'
                // #sh "pwd;cd terraform/ ; terraform plan -out tfplan1"
                // #sh 'pwd;cd terraform/ ; terraform show -no-color tfplan1 >> tfplan1.txt'
            }
        }
       //  stage('Approval') {
       //     when {
       //         not {
       //             equals expected: true, actual: params.autoApprove
       //         }
       //     }

       //     steps {
       //         script {
       //              def plan = readFile 'tfcon/tfplan1.txt'
       //              input message: "Do you want to apply the plan?",
       //              parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
       //         }
       //     }
       // }

        stage('Apply') {
            steps {
                // #sh "pwd;cd tfcon/ ; terraform apply -input=false tfplan1"
                sh "pwd;cd tfcon/ ; terraform apply -auto-approve"
            }
        }
    }

  }
