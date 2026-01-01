pipeline {
    
    agent any 
    
    environment {
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
                    docker build -t pradyu07/my1app:${BUILD_NUMBER} .
                    '''
                }
            }
        }

        stage('Push the artifacts'){
           steps{
                script{
                    docker.withRegistry('https://index.docker.io/v1/', 'docker-hub-token') {
                    docker.image("pradyu07/my1app:${BUILD_NUMBER}").push()
                    }
                }
            }
        }
    }
}
    
