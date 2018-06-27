node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Test Code') {
        def testImage = docker.build("zonex/test:${env.BUILD_ID}")
        testImage.inside {
            sh 'pip install pep8'
            sh 'pip install pylint'
        }
        testImage.inside {
            sh 'python --version'
        }
        testImage.push()
    }
    stage('Build Production') {
        echo 'Build Production'
    }
    stage('Publish') {
        echo 'Building..'
    }
}
