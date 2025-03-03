pipeline {
    agent any
    
    environment {
        GCP_PROJECT_ID='solo-levelling-arise'
        REGION='us-central1'
    }

    stages {
        stage('Clean Workspace') {
            steps {
                cleanWs()
            }
        }
        stage('Git Checkout') {
            steps {
                git branch: 'dev', changelog: false, credentialsId: 'github-sa', poll: false, url: 'https://github.com/fastest-man-alive/hotwheels-collection.git'
            }
        }
        stage('Build Docker Image') {
            agent {
                docker {
                    image 'google/cloud-sdk'
                    reuseNode true
                }
            }
            steps {
                
                withCredentials([file(credentialsId: 'Jenkins-SA', variable: 'SA_KEY')]) {
                    sh '''
                        gcloud auth activate-service-account --key-file=$SA_KEY
                        gcloud config set project $GCP_PROJECT_ID
                        gcloud config list
                        #gcloud auth configure-docker us-central1-docker.pkg.dev
                        date=$(date '+%Y%m%d%H%M%S')
                        version_number="v$BUILD_NUMBER.$date"
                        gcloud builds submit --region=$REGION --tag us-central1-docker.pkg.dev/solo-levelling-arise/hot-wheels/hw-image:${version_number} --gcs-log-dir gs://arise-logs-bucket
                        sleep 100
                        echo "Docker image pushed successfully"

                        echo "Starting deployment to Kubernetes cluster!"
                        echo "Update deployment file with latest image"
                        sed -i "s|us-central1-docker.pkg.dev/solo-levelling-arise/hot-wheels/hw-image:latest|us-central1-docker.pkg.dev/solo-levelling-arise/hot-wheels/hw-image:${version_number}|g" /manifest/deployment.yaml
                        gcloud container clusters get-credentials my-cluster --region us-central1 --project solo-levelling-arise
                        kubectl apply -f /manifest/deployment.yaml
                        kubectl apply -f /manifest/service.yaml
                        sleep 100

                    '''
                }
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deployment Successful...'
            }
        }
    }
}