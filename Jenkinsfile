pipeline {
  agent {
    docker {
      image 'python:3.9'
    }
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
          export PATH=$PATH:$HOME/.local/bin
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
          sh "docker run -d --rm -p 7001:7000 --name devops_unitlint ${image}"
        }
      }
    }
  }

  post {
    always {
      echo "Pipeline Selesai."
    }
  }
}
