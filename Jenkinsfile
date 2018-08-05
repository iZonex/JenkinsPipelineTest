node('master') {
    stage('Checkout') {
        checkout scm
    }
    stage('Dockerfile Check') {
        sh 'docker run --rm -i hadolint/hadolint < Dockerfile'
    }
    stage('Build Image') {
        def dockerImage = docker.build("zonex/test:${env.BUILD_ID}")
    }
    stage('Test Code and Coverage') {
        def dockerImage = docker.image("zonex/test:${env.BUILD_ID}")
        dockerImage.inside {
            sh 'pip list --outdated'
            sh 'pip install -r /app/requirements/dev.txt'
            sh 'pylint /app'
            sh 'rm -rf /app/__pycache__'
            sh 'rm -rf /test/__pycache__'
            sh 'py.test /tests'
            sh 'rm -rf /app/__pycache__'
            sh 'rm -rf /test/__pycache__'
            sh 'py.test --cov=app tests/'
        }
    }
    stage('Build Production') {
        echo 'Building..'
    }
    stage('Push to Registry') {
        docker.withRegistry("https://registry-1.docker.io" ,"dockerhub") {
            def dockerImage = docker.image("zonex/test:${env.BUILD_ID}")
            dockerImage.push()
            dockerImage.push('latest')
        }
    }
}