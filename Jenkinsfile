pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'building iis container'
        sh 'docker build -t example/iis --file ./Dockerfile.iis .'
      }
    }
  }
}