pipeline {
  agent none
  stages {
    stage('Build') {
      agent {
        docker {
          image 'alpine/ansible'
          args '-v $WORKSPACE/ansible:/tmp/ansible -e HOME=/tmp'
        }
      }
      steps {
        echo 'building iis container'
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }
  }
}
