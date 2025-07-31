pipeline {
  agent any

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
        catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
          sh 'pylint app/*.py'
        }
      }
    }

    stage('Test') {
      steps {
        catchError(buildResult: 'UNSTABLE', stageResult: 'FAILURE') {
          sh 'pytest'
        }
      }
    }

    stage('Docker Build & Run') {
      steps {
        script {
          def image = "devops-unitlint:${env.BUILD_NUMBER}"
          sh "docker rm -f devops_unitlint || true"
          sh "docker build -t ${image} ."
          sh "docker run -d -p 7001:7000 --name devops_unitlint ${image}"
        }
      }
    }
  }
}
