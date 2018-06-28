node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Build') {
        def dockerImage = docker.build("zonex/test:${env.BUILD_ID}")
    }
    stage('Test') {
        def dockerImage = docker.image("zonex/test:${env.BUILD_ID}")
        dockerImage.inside {
            sh 'pip list --outdated'
            sh 'pip install -r /app/requirements/dev.txt'
            sh 'pylint /app'
            sh 'py.test /tests'
        }
    }
    stage('Build Production') {
        docker.withRegistry("https://registry-1.docker.io" ,"dockerhub") {
            def dockerImage = docker.image("zonex/test:${env.BUILD_ID}")
            dockerImage.push()
            dockerImage.push('latest')
        }
    }
    stage('Publish') {
        echo 'Building..'
    }
}
