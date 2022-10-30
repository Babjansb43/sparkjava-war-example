pipeline{
    agent any
    stages{
        stage("image build"){
            steps{
                sh '''
                aws ecr get-login-password --region ap-southeast-1 |sudo docker login --username AWS --password-stdin 301712948359.dkr.ecr.ap-southeast-1.amazonaws.com
                sudo docker build -t dockerimage:$BUILD_NUMBER .
                sudo docker images
                sudo docker run -d -p 10000:8080 dockerimage:$BUILD_NUMBER
                '''
            }
        }
    }
}