pipeline {
  agent any
  stages {
    stage('Build') {
      agent {
        docker {
          image 'alpine/ansible'
          args '''-v /var/jenkins_home:/var/jenkins_home  -v /tmp/ansible:/tmp/ansible
'''
        }

      }
      steps {
        echo 'building iis container'
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }

  }
}