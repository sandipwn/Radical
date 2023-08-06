pipeline {

    options {
        buildDiscarder(logRotator(numToKeepStr: '5', artifactNumToKeepStr: '5'))
    }

    agent any

    tools {
        maven 'Maven3.8.8'
    }

    stages {
        stage('Code Compilation') {
            steps {
                echo 'code compilation is starting'
                sh 'mvn clean compile'
				echo 'code compilation is completed'
            }
        }

        stage('Code Package') {
            steps {
                echo 'code packing is starting'
                sh 'mvn clean package'
				echo 'code packing is completed'
            }
        }
        stage('Building & Tag Docker Image') {
                    steps {
                        echo 'Starting Building Docker Image'
                        sh 'docker build -t sandipnaikwade/radical-ms .'
                        sh 'docker build -t radical-ms .'
                        echo 'Completed  Building Docker Image'
                    }
        }
        stage('Docker Image Scanning') {
                    steps {
                        echo 'Docker Image Scanning Started'
                        sh 'java -version'
                        echo 'Docker Image Scanning Started'
                    }
        }
        stage(' Docker push to Docker Hub') {
                   steps {
                      script {
                         withCredentials([string(credentialsId: 'dockerhubCred', variable: 'dockerhubCred')]){
                         sh 'docker login docker.io -u sandipnaikwade -p ${dockerhubCred}'
                         echo "Push Docker Image to DockerHub : In Progress"
                         sh 'docker push sandipnaikwade/radical-ms:latest'
                         echo "Push Docker Image to DockerHub : In Progress"
                         sh 'whoami'
                         }
                      }
                    }
        }
        stage(' Docker Image Push to Amazon ECR') {
                   steps {
                      script {
                         withCredentials([[$class: 'AmazonWebServicesCredentialsBinding',credentialsId:'ecr-credentials', url:"https://336363707015.dkr.ecr.ap-south-1.amazonaws.com/radical-ms"]]){
                         sh """
                         echo "List the docker images present in local"
                         docker images
                         echo "Tagging the Docker Image: In Progress"
                         docker tag radical-ms:latest 336363707015.dkr.ecr.ap-south-1.amazonaws.com/radical-ms:latest
                         echo "Tagging the Docker Image: Completed"
                         echo "Push Docker Image to ECR : In Progress"
                         docker login https://336363707015.dkr.ecr.ap-south-1.amazonaws.com
                         docker push 336363707015.dkr.ecr.ap-south-1.amazonaws.com/radical-ms:latest
                         echo "Push Docker Image to ECR : Completed"
                         """
                         }
                      }
                   }
        }
    }
}

