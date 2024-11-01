pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker {
          image 'alpine/ansible'
        }

      }
      steps {
        echo 'building iis container'
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }

  }
}