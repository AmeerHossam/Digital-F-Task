pipeline{
    agent any
    stages{
        stage("Build stage"){
            steps{
                withCredentials([usernamePassword(credentialsId :'DockerHubCred',usernameVariable :'USER',passwordVariable :'PASSWORD')]){

                sh 'docker build -t sudo1amir/springcode:v1 .'
                sh 'echo $PASSWORD | docker login -u $USER --password-stdin'
                sh 'docker push sudo1amir/springcode:v1'
                }
            }
        }

        stage("Deployment stage"){
            steps{
                script {
                    kubernetesDeploy(configs: "deployment.yaml", kubeconfigId: "kubernetes")
                    kubernetesDeploy(configs: "service.yaml", kubeconfigId: "kubernetes")
                }
            }
        }
    }
}