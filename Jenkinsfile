pipeline {
    agent any

    environment {
        DOCKERHUB_REPO = 'raghunandanservice'
        DOCKER_CREDENTIALS = 'docker-hub'
    }

    stages {

        stage('Initialize') {
            steps {
                script {

                    echo "Branch: ${env.BRANCH_NAME}"

                    if (env.BRANCH_NAME == 'linux-java-gui-lab') {

                        env.IMAGE_NAME = 'linux-java-gui-lab'

                    } else if (env.BRANCH_NAME == 'linux-devops-cicd-gui-lab') {

                        env.IMAGE_NAME = 'linux-devops-cicd-gui-lab'

                    } else if (env.BRANCH_NAME == 'linux-devops-k8s-gui-lab') {

                        env.IMAGE_NAME = 'linux-devops-k8s-gui-lab'

                    } else {

                        error("Unsupported branch: ${env.BRANCH_NAME}")
                    }

                    env.TIMESTAMP = new Date().format(
                        'ddMMSShhmmss',
                        TimeZone.getTimeZone('Asia/Kolkata')
                    )

                    env.IMAGE =
                        "${DOCKERHUB_REPO}/${IMAGE_NAME}"

                    env.VERSIONED_IMAGE =
                        "${IMAGE}:${TIMESTAMP}"

                    env.LATEST_IMAGE =
                        "${IMAGE}:latest"

                    echo "================================"
                    echo "Image      : ${IMAGE}"
                    echo "Version    : ${VERSIONED_IMAGE}"
                    echo "Latest     : ${LATEST_IMAGE}"
                    echo "================================"
                }
            }
        }

        stage('Docker Build') {
            steps {
                sh '''
                    echo "Building Docker image..."

                    docker build \
                        -t ${VERSIONED_IMAGE} \
                        -t ${LATEST_IMAGE} \
                        .
                '''
            }
        }

        stage('Docker Login') {
            steps {

                withCredentials([
                    usernamePassword(
                        credentialsId: "${DOCKER_CREDENTIALS}",
                        usernameVariable: 'DOCKER_USERNAME',
                        passwordVariable: 'DOCKER_PASSWORD'
                    )
                ]) {

                    sh '''
                        echo "$DOCKER_PASSWORD" | docker login \
                            --username "$DOCKER_USERNAME" \
                            --password-stdin
                    '''
                }
            }
        }

        stage('Docker Push') {
            steps {
                sh '''
                    docker push ${VERSIONED_IMAGE}
                    docker push ${LATEST_IMAGE}
                '''
            }
        }

        stage('Verify') {
            steps {
                sh '''
                    echo "Docker images pushed successfully:"
                    echo "${VERSIONED_IMAGE}"
                    echo "${LATEST_IMAGE}"
                '''
            }
        }
    }

    post {

        success {
            echo """
            ==========================================
            BUILD SUCCESS
            ==========================================

            Branch:
            ${BRANCH_NAME}

            Docker Image:
            ${VERSIONED_IMAGE}

            Latest:
            ${LATEST_IMAGE}

            ==========================================
            """
        }

        failure {
            echo "BUILD FAILED"
        }
    }
}
