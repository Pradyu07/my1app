pipeline {
    
    agent any 
    
    environment {
        IMAGE_NAME = "pradyu07/my1app"
        IMAGE_TAG = "${BUILD_NUMBER}"
    }
    
    stages {
        
        stage('Checkout'){
           steps {
                git credentialsId: 'git-hub-creds',                
                url: 'https://github.com/Pradyu07/my1app',
                branch: 'main'
           }
        }

        stage('Build Docker'){
            steps{
                script{
                    sh '''
                    echo 'Buid Docker Image'
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} 
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-token') {
                    docker.image("${IMAGE_NAME}:${BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}
    
