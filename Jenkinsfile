#!/usr/bin/env groovy

pipeline {
    agent any
    tools {
      terraform 'terraform'
    }
    stages {
      stage('Git Checkout') {
        steps {
          git credentials: 'gh-credentials', url: 'https://github.com/dizthewize/devops04-Terraform-Jenkins-EKS-AWS.git'
        }
      }
      stage('provision server') {
        environment {
          AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key')
            AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
        }
        steps {
          script {
            dir('terraform') {
              sh 'terraform init'
              sh 'terraform apply --auto-approve'
            }
          }
        }
      }
    }
}
