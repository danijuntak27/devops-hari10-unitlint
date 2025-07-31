pipeline {
  agent {
    docker {
      image 'python:3.9'
    }
  }

  stages {
    stage('Install Dependencies') {
      steps {
        sh 'pip install -r requirements.txt'
      }
    }

    stage('Lint') {
      steps {
        sh 'pylint app/*.py'
      }
    }

    stage('Test') {
      steps {
        sh 'pytest app/test_main.py'
      }
    }

    stage('Docker Build') {
      steps {
        sh 'docker build -t devops-unitlint .'
      }
    }
  }
}
