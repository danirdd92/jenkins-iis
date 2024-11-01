pipeline {
  agent none
  stages {
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