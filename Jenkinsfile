#!/usr/bin/env groovy

pipeline {
    agent any

    tools {
      terraform 'terraform'
    }

    environment {
      TF_IN_AUTOMATION = 'true'
      AWS_SHARED_CREDENTIALS_FILE='/root/.aws/credentials'
    }

    stages {
      stage('Init TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  ls -al
                  cat vpc.tf
                  terraform init
                '''
              }
          }
        }
      }

      stage('Plan TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform plan
                '''
              }
          }
        }
      }

      stage('Validate TF') {
        input {
          message "Do you want to apply this Plan?"
          ok "Apply Plan"
        }
        steps {
          echo 'Plan Accepted'
        }
      }

      stage('Apply TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform apply -auto-approve
                '''
              }
          }
        }
      }

      stage('Validate Destroy') {
        input {
          message "Do you want to destroy Terraform Infra?"
          ok "Destroy"
        }
        steps {
          echo "Destroy Accepted"
        }
      }

      stage('Destroy TF') {
        steps {
          script {
              dir('terraform') {
                sh '''
                  terraform destroy -auto-approve
                '''
              }
          }
        }
      }

  }
}
