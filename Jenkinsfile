pipeline {
    agent any

    environment {
        APP_NAME = "merlin-dashboard"
        IMAGE_NAME = "merlin-dashboard"
        IMAGE_TAG = "latest"
    }

    stages {
        stage('Checkout Code') {
            steps {
                git branch: 'master', url: 'https://github.com/merlinpratheesh/docker-dashboard.git'
            }
        }

        stage('Build Docker Image') {
            steps {
                bat "docker build -t %IMAGE_NAME%:%IMAGE_TAG% ."
            }
        }

        stage('Deploy Docker Container') {
            steps {
                bat """
                docker stop %APP_NAME% || exit 0
                docker rm %APP_NAME% || exit 0
                docker run -d -p 5001:80 --name %APP_NAME% %IMAGE_NAME%:%IMAGE_TAG%
                """
            }
        }
    }

    post {
        success {
            echo "✅ Docker deployment completed successfully! Access app at http://<server-ip>:5001"
        }
        failure {
            echo "❌ Deployment failed."
        }
    }
}
