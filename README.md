# WooliesX-WeatherForecast
This project handles 3 different areas of work, [devops](./devops), [infrastructure](./infrastructure) and [application](./application). The end result is to deploy an image to Google Cloud Run, currently built and published to Docker Hub which can be found [here](https://hub.docker.com/r/dfranciswoolies/ciarecruitment-bestapiever). Due to restrictions within Cloud Run, only image on Google Container Registry or Google Artifact Registry can be deployed. To tackle this, within the application deployment pipeline, image is pulled from Docker Hub, retagged before subsequently making its way to Artifact Registry.

## DevOps
Consists of 2 pipeline yaml files, one for Infrastructure deployment and the other for Application. Both pipelines execute on Azure DevOps.

## Infrastructure
Within this folder consists of Terraform code required to provision Google services. To execute this, a Google project must exist with 2 Service Accounts, one for State management and the other for orchestration.

## Application
This folder contains Terraform code required to deploy image to Google Cloud Run. Two workspaces have been created to handle 2 different environments, **dev** and **prod**.
>  :information_source: Note: Infrastructure must be provisioned first before an application can be deployed.