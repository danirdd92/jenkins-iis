pipeline {
  agent none
  stages {
    stage('Build') {
      post {
        always {
          echo '========always========'
        }

        success {
          echo '========A executed successfully========'
        }

        failure {
          echo '========A execution failed========'
        }

      }
      steps {
        echo 'building iis container'
        sh 'docker build -t example/iis "Dockerfile.iis"'
      }
    }

  }
  post {
    always {
      echo '========always========'
    }

    success {
      echo '========pipeline executed successfully ========'
    }

    failure {
      echo '========pipeline execution failed========'
    }

  }
}