pipeline{
    agent any
    stages{
        stage("Build stage"){
            steps{
                withCredentials([usernamePassword(credentialsId :'DockerHubCred',usernameVariable :'USER',passwordVariable :'PASSWORD')]){

                sh 'docker build -t sudo1amir/springdf:v1 .'
                sh 'echo $PASSWORD | docker login -u $USER --password-stdin'
                sh 'docker push sudo1amir/springdf:v1'
                }
            }
        }

        stage("Deployment stage"){
            kubernetes{
                yaml '''
                    apiVersion: apps/v1
                    kind: Deployment
                    metadata:
                      name: spring-app
                      labels:
                        app: spring-code
                    
                    spec:
                      replicas: 1
                      selector:
                        matchLabels:
                          app: spring-code
                    
                      template:
                        metadata:
                          labels:
                            app: spring-code
                    
                    
                        spec:
                          containers:
                          - name : spring-app
                            image : nginx
                            ports:
                            - name: app-port
                              containerPort: 80
                '''
            }
        }
    }
}