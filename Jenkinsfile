pipeline {
    agent any

    environment {
        APP_NAME = "merlin-dashboard"
        IMAGE_NAME = "merlin-dashboard"
        IMAGE_TAG = "latest"
        DOCKER_REGISTRY = "docker.io/your-dockerhub-username"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'main', url: 'https://github.com/merlinpratheesh/docker-dashboard.git'
            }
        }

        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        stage('Build Angular App') {
            steps {
                bat 'npm run build -- --configuration production'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %DOCKER_REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG% ."
            }
        }

        stage('Push Docker Image') {
            steps {
                withCredentials([usernamePassword(credentialsId: 'docker-hub-cred', usernameVariable: 'DOCKER_USER', passwordVariable: 'DOCKER_PASS')]) {
                    bat """
                    echo %DOCKER_PASS% | docker login -u %DOCKER_USER% --password-stdin
                    docker push %DOCKER_REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG%
                    """
                }
            }
        }

        stage('Deploy Docker Container') {
            steps {
                bat """
                docker stop %APP_NAME% || exit 0
                docker rm %APP_NAME% || exit 0
                docker run -d -p 8080:80 --name %APP_NAME% %DOCKER_REGISTRY%/%IMAGE_NAME%:%IMAGE_TAG%
                """
            }
        }
    }

    post {
        success {
            echo "✅ Docker deployment completed successfully!"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
