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
                                # Create a new React app using Vite
                                npx create-vite@latest ${reactAppName} --template react

                                # Navigate to the project directory
                                cd ${reactAppName}

                                # Install dependencies
                                npm install

                                # Build the React app
                                npm run build

                                # Create artifact directory and copy build output
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
                                # Create a new ASP.NET Core web application
                                dotnet new webapp -o ${dotnetAppName}

                                # Navigate to the project directory
                                cd ${dotnetAppName}

                                # Build and publish the .NET app
                                dotnet publish -c Release -o publish

                                # Create artifact directory and copy publish output
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
        echo 'Run Ansible playbook to back up existing website for rollback and deploy new versions'
        sh 'ansible-playbook -i /tmp/ansible/hosts.yaml /tmp/ansible/playbook.yaml'
      }
        }
    }
}
