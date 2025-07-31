pipeline {
  agent {
    docker {
      image 'python:3.9'
      args '-u root'  // untuk memastikan bisa install dan write jika perlu
    }
  }

  environment {
    PIP_CACHE_DIR = '.pip-cache'  // mencegah cache di root system
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
          pip install --no-cache-dir -r requirements.txt
        '''
      }
    }

    stage('Lint') {
      steps {
        sh 'pylint app/*.py || true'
      }
    }

    stage('Test') {
      steps {
        sh 'pytest || true'
      }
    }

    stage('Docker Build & Run') {
      steps {
        script {
          def image = "devops-unitlint:${env.BUILD_NUMBER}"
          sh "docker build -t ${image} ."
          sh "docker run -d -p 7001:7000 --rm --name devops_unitlint ${image}"
        }
      }
    }
  }

  post {
    always {
      echo "Pipeline Finished."
    }
    failure {
      echo "Pipeline Failed."
    }
  }
}
