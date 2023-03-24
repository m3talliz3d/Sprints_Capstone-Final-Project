pipeline {
    agent any
    stages {
        stage('Checkout external proj 🙈🙈🙈') {
            steps {
                git url: 'https://github.com/m3talliz3d/Sprints_Capstone-Final-Project.git', branch: 'main' , credentialsId: 'github_pipeline_id'
            }
        }
        stage('Build Docker image Python app and push to ecr 🚚📌') {
            steps{
                script {
                    sh '''
                    pwd
                    cd $PWD/docker/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 476713460067.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t flask_app:v"$BUILD_NUMBER" .
                    docker tag flask_app:v"$BUILD_NUMBER" 476713460067.dkr.ecr.us-east-1.amazonaws.com/flask_app:v"$BUILD_NUMBER"
                    docker push 476713460067.dkr.ecr.us-east-1.amazonaws.com/flask_app:v"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 476713460067.dkr.ecr.us-east-1.amazonaws.com/flask_app:v"$BUILD_NUMBER"
                    '''
                }
            }
        }
    }
}