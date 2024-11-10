pipeline {
    agent any
    stages {
        stage('Build') {
      parallel {
        stage('React App with Vite') {
          steps {
            script {
              def reactAppName = 'react-vite-app'
              def reactArtifactDir = "ansible/files/wwwroot/${reactAppName}"
              sh """
                    npx create-vite@latest ${reactAppName} --template react
                    cd ${reactAppName}

                    npm install
                    npm run build

                    mkdir -p ../${reactArtifactDir}
                    cp -r dist/* ../${reactArtifactDir}/
                """
            }
          }
        }
        stage('ASP.NET Core App') {
          steps {
            script {
              def dotnetAppName = 'aspnet-core-app'
              def dotnetArtifactDir = "ansible/files/wwwroot/${dotnetAppName}"
              sh """
                    dotnet new webapp -o ${dotnetAppName}
                    cd ${dotnetAppName}

                    dotnet publish -c Release -o publish

                    mkdir -p ../${dotnetArtifactDir}
                    cp -r publish/* ../${dotnetArtifactDir}/
                """
            }
          }
        }
      }
        }
        post {
        success {
        echo "Both React and ASP.NET Core applications were built and artifacts are stored in 'ansible/files/'."
        }
        failure {
        echo 'Pipeline failed. Check the logs for details.'
        }
        }
      stage('Deploy') {
        steps {
          echo 'Run ansible playbook that backups existing website for rollback and deploy new versions'
          sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml '
        }
      }
    }
}
