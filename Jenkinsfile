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
            withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                script {
                    sh '''
                    pwd
                    cd $PWD/docker/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 476713460067.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t flask_app:v"$BUILD_NUMBER" .
                    docker tag flask_app:v"$BUILD_NUMBER" 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo/flask_app:v"$BUILD_NUMBER"
                    docker push 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo/flask_app:v"$BUILD_NUMBER"
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo/flask_app:v"$BUILD_NUMBER"
                    '''
                }
            }
            }
        }
        // stage('Apply Kubernetes files 🚀 🎉 ') {
        //     steps{
        //     withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
        //         script {
        //             sh '''
        //             sed -i \"s|image:.*|image: 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_app:app_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/deployment_flaskapp.yml
        //             sed -i \"s|image:.*|image: 612386077301.dkr.ecr.us-east-1.amazonaws.com/python_db:db_"$BUILD_NUMBER"|g\" `pwd`/kubernetes_manifest_file/statefulSet_flaskdb.yml
        //             aws eks --region us-east-1 update-kubeconfig --name eks
        //             kubectl apply -f $PWD/kubernetes_manifest_file
        //             '''
        //         }
        //         }    
        //     }
        // }        
    }
}