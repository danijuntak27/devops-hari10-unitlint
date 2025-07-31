pipeline {
  agent {
    docker {
      image 'python:3.9'
      args '-u 1000:1000'  // gunakan UID non-root agar --user berfungsi
    }
  }

  environment {
    IMAGE_NAME = "devops-unitlint"
    CONTAINER_NAME = "devops_unitlint"
    APP_PORT = "7000"
    HOST_PORT = "7001"
    PIP_USER_DIR = "${HOME}/.local/bin"
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
          python -m pip install --upgrade pip --user
          pip install --no-cache-dir --user -r requirements.txt
        '''
      }
    }

    stage('Lint') {
      steps {
        sh '''
          export PATH=$PIP_USER_DIR:$PATH
          ~/.local/bin/pylint app/*.py || true
        '''
      }
    }

    stage('Test') {
      steps {
        sh '''
          export PATH=$PIP_USER_DIR:$PATH
          ~/.local/bin/pytest
        '''
      }
    }

    stage('Docker Build & Run') {
      steps {
        script {
          def tag = "${IMAGE_NAME}:${env.BUILD_NUMBER}"
          sh """
            docker build -t ${tag} .
            docker rm -f ${CONTAINER_NAME} || true
            docker run -d -p ${HOST_PORT}:${APP_PORT} --name ${CONTAINER_NAME} ${tag}
          """
        }
      }
    }
  }

  post {
    always {
      echo "Pipeline finished: ${currentBuild.currentResult}"
    }
  }
}
