node {
    checkout scm
    def testImage = docker.build("test-image")
    testImage.inside {
        sh 'python --version'
    }
}
