pipeline {
    stages {
        stage('Build') {
            steps {
                echo 'Building..'
                def customImage = docker.build("test")

    		customImage.inside {
        		sh 'python --version'
    		}
            }
        }
        stage('Test') {
            steps {
                sh 'python --version'
            }
        }
        stage('Deploy') {
            steps {
                echo 'Deploying....'
            }
        }
    }
}
