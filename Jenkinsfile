pipeline {
    agent any

    stages {
        stage('Run') {
            steps {
                sh '''
                terraform init
                terraform validate
                terraform apply --auto-approve
                '''
            }
        }
    }
}
