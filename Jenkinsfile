pipeline {
    agent any
    
    environment {
        // Tên image trên Docker Hub của bạn
        DOCKER_IMAGE = "tuananh2010/22120011-web" 
        // URL repository GitHub của bạn
        GIT_REPO = "https://github.com/TuanAnh20-10/22120011-mmtlab03.git"
    }

    stages {
        stage('Checkout') {
            steps {
                // Kéo code từ nhánh main
                git branch: 'main', 
                    url: "${GIT_REPO}", 
                    credentialsId: 'github-creds' // ID bạn đã tạo ở bước trước
            }
        }

        stage('Build & Push') {
            steps {
                script {
                    // Sử dụng ID Credential Docker Hub đã tạo
                    docker.withRegistry('', 'docker-hub-creds') {
                        def customImage = docker.build("${DOCKER_IMAGE}:${env.BUILD_ID}")
                        customImage.push()
                        customImage.push('latest')
                    }
                }
            }
        }

        stage('Deploy') {
            steps {
                script {
                    // Dọn dẹp container cũ nếu có và chạy bản mới nhất
                    sh "docker stop my-web-app || true"
                    sh "docker rm my-web-app || true"
                    sh "docker run -d -p 8082:80 --name my-web-app ${DOCKER_IMAGE}:latest"
                }
            }
        }
    }
}
