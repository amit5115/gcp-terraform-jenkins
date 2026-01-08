pipeline {
  agent any

  parameters {
    choice(name: 'TF_ACTION', choices: ['plan', 'apply'])
    string(name: 'PROJECT_ID')
    string(name: 'REGION', defaultValue: 'us-central1')
    string(name: 'VM_NAME', defaultValue: 'demo-vm')
    string(name: 'MACHINE_TYPE', defaultValue: 'e2-medium')
    string(name: 'ZONE', defaultValue: 'us-central1-a')
  }

  environment {
    GOOGLE_APPLICATION_CREDENTIALS = credentials('gcp-sa-key')
  }

  stages {

    stage('Checkout') {
      steps {
        git 'https://github.com/amit5115/gcp-terraform-jenkins.git'
      }
    }

    stage('Terraform Init') {
      steps {
        sh 'terraform init'
      }
    }

    stage('Terraform Plan') {
      steps {
        sh """
        terraform plan \
          -var="project_id=${params.PROJECT_ID}" \
          -var="region=${params.REGION}" \
          -var="vm_name=${params.VM_NAME}" \
          -var="machine_type=${params.MACHINE_TYPE}" \
          -var="zone=${params.ZONE}"
        """
      }
    }

    stage('Terraform Apply') {
      when {
        expression { params.TF_ACTION == 'apply' }
      }
      steps {
        sh """
        terraform apply -auto-approve \
          -var="project_id=${params.PROJECT_ID}" \
          -var="region=${params.REGION}" \
          -var="vm_name=${params.VM_NAME}" \
          -var="machine_type=${params.MACHINE_TYPE}" \
          -var="zone=${params.ZONE}"
        """
      }
    }
  }
}
