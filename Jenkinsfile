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
          python -m pip install --upgrade pip
          pip install --no-cache-dir -r requirements.txt
        '''
      }
    }

    stage('Lint') {
      steps {
        sh 'pylint app/*.py'
      }
    }

    stage('Test') {
      steps {
        sh 'pytest'
      }
    }

    stage('Docker Build & Run') {
      steps {
        script {
          def image = "devops-unitlint:${env.BUILD_NUMBER}"
          sh "docker build -t ${image} ."
          sh "docker run -d -p 7001:7000 --name devops_unitlint ${image}"
        }
      }
    }
  }
}
