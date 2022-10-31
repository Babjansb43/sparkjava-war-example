pipeline{
    agent any
    stages{
        stage("image build"){
            steps{
                sh '''
                aws ecr get-login-password --region ap-southeast-1 |sudo docker login --username AWS --password-stdin 301712948359.dkr.ecr.ap-southeast-1.amazonaws.com
                sudo docker build -t 301712948359.dkr.ecr.ap-southeast-1.amazonaws.com/springjava:$BUILD_NUMBER .
                sudo docker images
                sudo docker push 301712948359.dkr.ecr.ap-southeast-1.amazonaws.com/springjava:$BUILD_NUMBER
                '''
            }
        }
        stage("image deploy"){
            steps{
                cd k8s/
                kubectl apply -f *
            }
        }
    }
}