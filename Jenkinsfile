pipeline {
  agent any

  stages {
    stage('Build') {
      steps {
        echo 'A matrix of workers in docker containers ready to build any kind of website and output artifacts into ansible/files'
      }
    }
    stage('Deploy') {
      steps {
        echo 'Run ansible playbook that backups existing website for rollback and deploy new versions'
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
    }
  }
}
