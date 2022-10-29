pipeline{
    agent any
    stages{
        stage("image build"){
            steps{
                sh '''
                docker build -t tomcat:1 .
                docker images
                '''
            }
        }
    }
}