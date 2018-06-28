node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Build image') {
        docker.withRegistry("https://registry-1.docker.io" ,"dockerhub") {
            def testImage = docker.build("zonex/test:${env.BUILD_ID}")
            testImage.inside {
                sh 'pip install -r /requirements/dev.txt'
            }
            testImage.inside {
                sh 'python --version'
            }
            // testImage.push()
            // testImage.push('latest')
        }
    }
    stage('Build Production') {
        echo 'Build Production'
    }
    stage('Publish') {
        echo 'Building..'
    }
}
