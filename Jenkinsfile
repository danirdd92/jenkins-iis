pipeline {
  agent none
  stages {
    stage('Debug') {
      agent any
      steps {
        sh 'ls -la'
      }
    }
    stage('Test') {
      agent {
        dockerfile {
          filename 'Dockerfile.ansible'
        }
      }
      steps {
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }
  }
}
