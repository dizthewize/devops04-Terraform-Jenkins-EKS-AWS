#!/usr/bin/env groovy

library identifier: '', retriever: modernSCM(
  [$class: 'Github',
    remote: 'https://github.com/dizthewize/devops04-Terraform-Jenkins-EKS-AWS.git'
    credentialsId: 'gh-credentials'
  ]
)

pipeline {
    agent any
    tools {
      terraform 'terraform'
    }
    stages {
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