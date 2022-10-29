pipeline{
    agent any
    stages{
        stage("image build"){
            steps{
                sh '''
                sudo docker build -t tomcat:1 .
                sudo docker images
                '''
            }
        }
    }
}