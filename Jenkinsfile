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
        testImage.push("https://registry.hub.docker.com" ,"8a7286c4-7547-4928-a6bd-0313adf9ae76")
    }
    stage('Build Production') {
        echo 'Build Production'
    }
    stage('Publish') {
        echo 'Building..'
    }
}
