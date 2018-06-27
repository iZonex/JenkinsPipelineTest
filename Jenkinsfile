node('master') {
    stage 'Checkout'
        checkout scm
    stage 'Build'
        def testImage = docker.build("test-image")
        testImage.inside {
            sh 'python --version'
        }
}
