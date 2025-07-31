pipeline {
    agent {
        docker {
            image 'python:3.9'
            args '-u root:root' // jalankan sebagai root agar bebas permission
        }
    }

    environment {
        VENV_PATH = "${WORKSPACE}/venv"
    }

    stages {
        stage('Checkout') {
            steps {
                git credentialsId: 'github-ssh-key', url: 'git@github.com:danijuntak27/devops-hari10-unitlint.git', branch: 'main'
            }
        }

        stage('Install Dependencies') {
            steps {
                sh '''
                    python -m venv venv
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
                    flake8 .
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
                sh '''
                    docker build -t myapp .
                    docker run -d --name myapp_container -p 5000:5000 myapp
                '''
            }
        }
    }

    post {
        always {
            echo 'Pipeline Selesai.'
        }
    }
}
