node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Test Code') {
        def testImage = docker.build("test-image:${env.BUILD_ID}")
        testImage.inside {
            sh 'python --version'
        }
        testImage.inside {
            sh 'python --version'
        }
    }
    stage('Build Production') {
        echo 'Build Production'
    }
    stage('Publish') {
        echo 'Building..'
    }
}
