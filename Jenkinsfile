pipeline {
  agent {
    docker {
      image 'python:3.9'
      args '-u root'
    }
  }

  environment {
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

    stage('Install Dependencies') {
      steps {
        sh '''
          python -m pip install --upgrade pip
          pip install -r requirements.txt
        '''
      }
    }

    stage('Lint') {
      steps {
        echo "🔍 Menjalankan linting..."
        sh 'pylint app/*.py || true'
      }
    }

    stage('Test') {
      steps {
        echo "🧪 Menjalankan unit test..."
        sh 'PYTHONPATH=. pytest || true'
      }
    }

    stage('Docker Build & Run') {
      when {
        expression {
          return fileExists('Dockerfile') && sh(script: 'which docker', returnStatus: true) == 0
        }
      }
      steps {
        echo "🐳 Membuat dan menjalankan container..."
        sh "docker rm -f ${CONTAINER_NAME} || true"
        sh "docker build -t ${IMAGE_NAME} ."
        sh "docker run -d -p ${PORT} --name ${CONTAINER_NAME} ${IMAGE_NAME}"
      }
    }
  }

  post {
    always {
      echo "🧼 Pipeline selesai. Membersihkan jika perlu..."
      sh "docker rm -f ${CONTAINER_NAME} || true"
    }
  }
}
