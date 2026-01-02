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
                    docker build -t ${IMAGE_NAME}:${BUILD_NUMBER} .
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
        stage('Deploy to Kubernetes') {
            steps {
                // Uses the Kubeconfig to apply the manifests to your local cluster
                withKubeConfig([credentialsId: 'k8s-config']) {
                    sh "sed -i 's|IMAGE_PLACEHOLDER|${IMAGE_NAME}:${IMAGE_TAG}|g' deploy/deployment.yaml"
					sh "kubectl cluster-info" // If this works, your ID is correct!
                // Apply everything inside the 'deploy' directory
                    sh "kubectl apply -f deploy/"
					}
                }
            }
        }
    
	post {
        success {
            echo "🎉 Deployment successful! Happy New Year!"
        }
    }
}

