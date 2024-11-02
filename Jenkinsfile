pipeline {
  agent any

  stages {
    stage('Test') {
      steps {
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }
  }
}
