pipeline {
    agent any
    stages {
        stage('Build') {
      parallel {
        stage('React App with Vite') {
          steps {
            script {
              def reactAppName = 'react-vite-app'
              sh """
                    npx create-vite@latest ${reactAppName} --template react
                    cd ${reactAppName}

                    npm install
                    npm run build

                    mkdir -p ${WORKSPACE}/ansible/files/wwwroot/${reactAppName}
                    cp -r dist/* ${WORKSPACE}/ansible/files/wwwroot/${reactAppName}/
                """
            }
          }
        }
        stage('ASP.NET Core App') {
          steps {
            script {
              def dotnetAppName = 'aspnet-core-app'
              sh """
                    dotnet new webapp -o ${dotnetAppName}
                    cd ${dotnetAppName}
                    dotnet publish -c Release -o publish

                    mkdir -p ${WORKSPACE}/ansible/files/wwwroot/${dotnetAppName}
                    cp -r publish/* ${WORKSPACE}/ansible/files/wwwroot/${dotnetAppName}/
                """
              }
            }
          }
        }
      }
        stage('Deploy') {
          steps {
            echo 'Run Ansible playbook to back up existing website for rollback and deploy new versions'
            sh 'ansible-playbook -i ansible/hosts.yaml ansible/playbook.yaml'
          }
        }
    }
    post {
      always {
        cleanWs()
      }
    }
}
