pipeline {
    agent any

    environment {
        VENV_PATH = "${WORKSPACE}/venv"
        IMAGE_NAME = "devops-unitlint:${BUILD_NUMBER}"
        CONTAINER_NAME = "devops_unitlint"
        PORT = "7001:7000"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-ssh-key', url: 'git@github.com:danijuntak27/devops-hari10-unitlint.git', branch: 'main'
            }
        }

        stage('Setup Virtualenv') {
            steps {
                sh '''
                    python3 -m venv venv
                    . venv/bin/activate
                    pip install --upgrade pip
                    pip install -r requirements.txt
                '''
            }
        }

        stage('Lint') {
            steps {
                sh '''
                    . venv/bin/activate
                    flake8 app/
                '''
            }
        }

        stage('Test') {
            steps {
                sh '''
                    . venv/bin/activate
                    pytest
                '''
            }
        }

        stage('Docker Build & Run') {
            steps {
                script {
                    // Stop and remove container if already running
                    sh "docker rm -f ${CONTAINER_NAME} || true"
                    // Build image
                    sh "docker build -t ${IMAGE_NAME} ."
                    // Run container
                    sh "docker run -d -p ${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
                }
            }
        }
    }

    post {
        always {
            echo "Pipeline selesai. Gambar Docker: ${IMAGE_NAME}"
        }
    }
}
