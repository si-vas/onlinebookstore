pipeline {
    agent any
     tools {
      maven 'maven'
      }
     stages{
       stage('GetCode'){
        when {
           expression {
            env.TERRAFORM_ACTION == 'YES'
             }
           }
            steps{
                git 'https://github.com/si-vas/onlinebookstore.git'
              }
            }
         stage('SonarQube Check'){
           when {
             expression {
               env.TERRAFORM_ACTION == 'YES'
                }
             }
            steps{
            script{
                withSonarQubeEnv('sonarqube-9.7') { 
                 sh "mvn clean verify sonar:sonar -e"
                    }
                 timeout(time: 1, unit: 'HOURS') {
                 def qg = waitForQualityGate()
                 if (qg.status != 'OK') {
                 error "Pipeline aborted due to quality gate failure: ${qg.status}"
                    }
                   }
                  }
                }
          }
         stage ('Build Maven Artifact') {
          when {
             expression {
               env.TERRAFORM_ACTION == 'YES'
                }
             }
            steps {
                sh 'mvn clean install'
            }
          }  
         stage ('Deploy Artifacts') {
            when {
              expression {
               env.TERRAFORM_ACTION == 'YES'
                 }
              }
            steps {
              nexusArtifactUploader artifacts: [
                  [
                    artifactId: 'onlinebookstore', 
                    classifier: '', 
                    file: 'target/onlinebookstore.war', 
                    type: 'war'
                  ]
                ], 
              credentialsId: 'nexus', 
              groupId: 'onlinebookstore', 
              nexusUrl: '172.31.5.109:8081', 
              nexusVersion: 'nexus3', 
              protocol: 'http', 
              repository: 'onlinebookstore', 
              version: '1.0.0'
          }
        }
        stage ('Terraform init') {
          when {
            expression {
             env.TERRAFORM_ACTION == 'YES'
              }
            }
            steps {
              sh 'terraform init'
              sh 'terraform validate'
              sh 'terraform plan'
            }
        }
        stage ('Terraform Apply') {
          when {
                    expression {
                        env.TERRAFORM_ACTION == 'YES'
                    }
                }
            steps {
              sh 'terraform init'
              sh 'terraform apply --auto-approve'
            }
        }
        stage ('Terraform State Show') {
          when {
                    expression {
                        env.TERRAFORM_ACTION == 'YES'
                    }
                }
            steps {
              sh 'terraform init'
              sh 'terraform state list'
              sh 'sleep 30'
            }
        }
        stage ('Ansible Playbook Deploy Tomcat') {
              when {
                    expression {
                        env.TERRAFORM_ACTION == 'YES'
                    }
                }
            steps {
                sh 'ansible-playbook -i hosts.cfg tomcat.yml'
            }
          }
        stage ('Terraform Destroy') {
          when {
                    expression {
                        env.TERRAFORM_ACTION == 'NO'
                    }
                }
            steps {
              sh 'terraform init'
              sh 'terraform destroy --auto-approve'
          }
        }
  }
}
