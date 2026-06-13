pipeline {
    agent any
    environment {
        DOCKER_CREDS = 'dockerhub-creds'
        DOCKER_USER  = 'shouravawasthi'
    }

    stages {

        stage('Checkout') {
            steps {
                checkout scm
            }
        }

        stage('Build Docker Image') {
            steps {
                script {

                    if (env.BRANCH_NAME == 'dev') {

                        sh """
                        docker build -t ${DOCKER_USER}/dev:latest .
                        """

                    } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {

                        sh """
                        docker build -t ${DOCKER_USER}/prod:latest .
                        """
                    }
                }
            }
        }

        stage('Docker Hub Login') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDS}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh """
                    echo \$DOCKER_PASSWORD | docker login -u \$DOCKER_USERNAME --password-stdin
                    """
                }
            }
        }

        stage('Push Docker Image') {
            steps {

                script {

                    if (env.BRANCH_NAME == 'dev') {

                        sh """
                        docker push ${DOCKER_USER}/dev:latest
                        """

                    } else if (env.BRANCH_NAME == 'main' || env.BRANCH_NAME == 'master') {

                        sh """
                        docker push ${DOCKER_USER}/prod:latest
                        """
                    }
                }
            }
        }
    }

    post {

        success {
            echo 'Docker image successfully pushed to Docker Hub.'
        }

        failure {
            echo 'Pipeline failed.'
        }

        always {
            sh 'docker logout || true'
        }
    }
}