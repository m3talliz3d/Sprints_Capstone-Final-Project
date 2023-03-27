pipeline {
    agent any
    stages {
        stage('Checkout Github Repo') {
            steps {
                git url: 'https://github.com/m3talliz3d/Sprints_Capstone-Final-Project.git', branch: 'main' , credentialsId: 'github_pipeline_id'
            }
        }
        stage('Build and push Flask app') {
            steps{
            withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                script {
                    sh '''
                    pwd
                    cd $PWD/docker/FlaskApp/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 476713460067.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t ecr_repo:flask .
                    docker tag ecr_repo:flask 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:flask
                    docker push 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:flask
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:flask
                    '''
                }
            }
            }
        }
        stage('Build and push MySQL app') {
            steps{
            withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                script {
                    sh '''
                    pwd
                    cd $PWD/docker/db/
                    aws ecr get-login-password --region us-east-1 | docker login --username AWS --password-stdin 476713460067.dkr.ecr.us-east-1.amazonaws.com
                    docker build -t ecr_repo:sql .
                    docker tag ecr_repo:sql 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:sql
                    docker push 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:sql
                    echo "Docker Cleaning up 🗑️"
                    docker rmi 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:sql
                    '''
                }
            }
            }
        }
        stage('K8s Deployment ') {
            steps{
            withCredentials([string(credentialsId: 'AWS_SECRET_ACCESS_KEY', variable: 'AWS_SECRET_ACCESS_KEY'), string(credentialsId: 'AWS_ACCESS_KEY_ID', variable: 'AWS_ACCESS_KEY_ID')]) {
                script {
                        sh '''
                        sed -i \"s|image:.*|image: 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:flask |g\" `pwd`/kube/pod_dep_flask.yaml
                        sed -i \"s|image:.*|image: 476713460067.dkr.ecr.us-east-1.amazonaws.com/ecr_repo:sql |g\" `pwd`/kube/pod_stateful_db.yml
                        aws eks --region us-east-1 update-kubeconfig --name sprint_eks_cluster
                        kubectl apply -f $PWD/kube
                        '''
                }
                }    
            }
        }        
    }
}