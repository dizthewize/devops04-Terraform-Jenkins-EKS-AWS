#!/usr/bin/env groovy

pipeline {
    agent any
    tools {
      terraform 'terraform'
    }
    stages {
      stage('Git Checkout') {
        steps {
          git branch: 'main', credentialsId: 'gh-credentials', url: 'https://github.com/dizthewize/devops04-Terraform-Jenkins-EKS-AWS.git'
        }
      }
      stage('Terraform Init') {
        steps {
          script {
            dir('terraform') {
              sh 'terraform init'
            }
          }
        }
      }
      stage('Terraform Plan') {
          steps {
            script {
              dir('terraform') {
                sh 'terraform plan'
              }
            }
          }
      }
      stage('Terraform Apply') {
          steps {
            script {
              dir('terraform') {
                sh 'terraform apply --auto-approve'
              }
            }
          }
      }
    }
}
