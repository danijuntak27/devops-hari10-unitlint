pipeline {
  agent {
    docker {
      image 'python:3.10'
      args '-u root'  // supaya bisa install kalau perlu
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
        sh 'pip install -r requirements.txt'
      }
    }

    stage('Lint') {
      steps {
        sh 'pylint app/*.py || true'
      }
    }

    stage('Test') {
      steps {
        sh 'pytest'
      }
    }
  }
}
