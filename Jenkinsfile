#!/usr/bin/env groovy

pipeline {
    agent any
    stages {
        stage("build app") {
            steps {
                script {
                    echo "building application"
                }
            }
        }
        stage("build image") {
            steps {
                script {
                    echo "building image the docker image"
                }
            }
        }
        stage("deploy") {
            environment {
              AWS_ACCESS_KEY_ID = credentials('jenkins_aws_access_key')
              AWS_SECRET_ACCESS_KEY = credentials('jenkins_aws_secret_access_key')
            }
            steps {
                script {
                    echo "deploying"
                    sh "kubectl create deployment node-deployment --image=dizthewize/express-api"
                }
            }
        }
    }
}
