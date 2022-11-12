pipeline{
    agent any
    stages{
        stage('Unit Tests'){ 
            steps{
                sh "java -jar ./src/test/java/com/example/demo/DemoApplicationTests.java" 
            }
        }

        stage("SonarQube Stage"){
            steps {
            
                script {
                    scannerHome = tool 'SonarQube'
                }
                    withSonarQubeEnv('SonarQube Scanner') {
                        sh "${scannerHome}/bin/sonar-scanner"
                    }  
                }
            }
        stage("Build Stage"){
            steps{
                withCredentials([usernamePassword(credentialsId :'DockerHubCred',usernameVariable :'USER',passwordVariable :'PASSWORD')]){

                sh 'docker build -t sudo1amir/gradle:v1 -f ./dockerfile'
                sh 'echo $PASSWORD | docker login -u $USER --password-stdin'
                sh 'docker push sudo1amir/gradle:v1'
                }
        }
        }

        stage("Deployment"){
                steps{
                    sh 'kubectl apply -Rf ./depl-files'

            }
        }
    }
}
