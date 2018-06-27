node('master') {
    stage 'Checkout'
        checkout scm
    stage 'Build'
        def testImage = docker.build("test-image:${env.BUILD_ID}")
        testImage.inside {
            sh 'python --version'
        }
    stage 'Test'
        testImage.inside {
            sh 'python --version'
        }
    stage 'Publish'
        testImage.push()
}
