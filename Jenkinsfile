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

        // Optional: you can remove this if Dockerfile handles Angular build
        stage('Install Dependencies') {
            steps {
                bat 'npm install'
            }
        }

        // Optional: remove if Dockerfile builds Angular
        stage('Build Angular App') {
            steps {
                bat 'npm run build -- --configuration production'
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
                docker run -d -p 8080:80 --name %APP_NAME% %IMAGE_NAME%:%IMAGE_TAG%
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
