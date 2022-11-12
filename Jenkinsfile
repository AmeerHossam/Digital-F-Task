pipeline{
    agent any
    stages{
        stage("CI"){
            steps{
                withCredentials([usernamePassword(credentialsId :'DockerHubCred',usernameVariable :'USER',passwordVariable :'PASSWORD')]){

                sh 'docker build -t sudo1amir/springcode:v1 .'
                sh 'echo $PASSWORD | docker login -u $USER --password-stdin'
                sh 'docker push sudo1amir/springcode:v1'
                }
            }
        }
    }
}