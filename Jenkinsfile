pipeline {
    tools {
        terraform 'Terraform'
    }

    parameters {
        booleanParam(name: 'autoApprove', defaultValue: false, description: 'Automatically run apply after generating plan?')
    } 

    environment {
        AWS_ACCESS_KEY_ID     = credentials('AWS_ACCESS_KEY_ID')
        AWS_SECRET_ACCESS_KEY = credentials('AWS_SECRET_ACCESS_KEY')
    }

    agent {
        label 'kubeagent'
    }
    
    stages {
        stage('Checkout') {
            steps {
                script {
                    dir("terraform") {
                        git branch: 'main', url: 'https://github.com/jagruthi35/AWS_terraform_modules.git'

                    }
                }
            }
        }

        stage('Plan') {
            steps {
                script {
                    dir("terraform") {
                        sh 'terraform init'
                        sh 'terraform plan -out tfplan'
                        sh 'terraform show -no-color tfplan > tfplan.txt'
                    }
                }
            }
        }
        
        stage('Approval') {
            when {
                expression { params.autoApprove != true }
            }

            steps {
                script {
                    def plan = readFile 'terraform/tfplan.txt'
                    input message: "Do you want to apply the plan?",
                          parameters: [text(name: 'Plan', description: 'Please review the plan', defaultValue: plan)]
                }
            }
        }

        stage('Apply') {
            steps {
                script {
                    dir("terraform") {
                        sh 'terraform apply -input=false tfplan'
                    }
                }
            }
        }
    }
}
