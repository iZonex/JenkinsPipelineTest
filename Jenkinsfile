node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Build') {
        def testImage = docker.build("zonex/test:${env.BUILD_ID}")
    }
    stage('Test') {
        def productionImage = docker.image("zonex/test:${env.BUILD_ID}")
        testImage.inside {
            sh 'pip list --outdated'
            sh 'pip install -r /app/requirements/dev.txt'
            sh 'pylint /app'
            sh 'py.test /tests'
        }
    }
    stage('Build Production') {
        docker.withRegistry("https://registry-1.docker.io" ,"dockerhub") {
            def productionImage = docker.image("zonex/test:${env.BUILD_ID}")
            productionImage.push()
            productionImage.push('latest')
        }
    }
    stage('Publish') {
        echo 'Building..'
    }
}
