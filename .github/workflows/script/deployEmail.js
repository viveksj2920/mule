const fs = require('fs');
const path = require('path');

function getEmailBody() {
  const deploySuccess = process.env.DEPLOY_STATUS_SUCCESS === "true";
  const codeCoverageGate = 80;
  const longRunningApexTestMethodGate = 10000;

  const usStoryList = getUserStoryList();
  const branchUrl = `${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}/tree/${process.env.CURRENT_BRANCH_NAME}`;
  const appName = `${process.env.APP_NAME}`;
  const gitTagUrl = `${process.env.GITHUB_SERVER_URL}/${process.env.GITHUB_REPOSITORY}/releases/tag/${process.env.TAG_OR_VERSION_NAME}`;
  const deploymentStatusURL = `https://anypoint.mulesoft.com/cloudhub/#/console/home/applications`;

  const { dryrun_deployment, dryrun_deployment_css, dryrun_deployment_icon, dryrun_deployment_image } = getDryRunDetails();
  const { env_css, env_icon, env_image } = getEnvironmentDetails();
  const { status_css, status_text, status_icon, status_image } = getStatusDetails(deploySuccess);

  const emailSubject = `MIRA Integration ${process.env.ENVIRONMENT}${env_image} ${dryrun_deployment}${dryrun_deployment_image} has ${deploySuccess ? "Successfully Completed" : "Failed"}${status_image}`;



  const replacements = createReplacements({
    env_icon,
    dryrun_deployment,
    dryrun_deployment_icon,
    status_icon,
    status_text,
    branchUrl,
	appName,
    gitTagUrl,
    deploymentStatusURL
  });

  console.log('replacements',replacements);

  const emailbody_content = generateEmailBodyContent(replacements);
  //console.log('emailbody_content',emailbody_content);

  fs.appendFileSync(process.env.GITHUB_ENV, `EMAIL_SUBJECT=${emailSubject}\n`);
  fs.appendFileSync(process.env.GITHUB_ENV, `EMAIL_BODY=${emailbody_content.replace(/\n/g, '')}\n`);
  
}

function getUserStoryList() {
  if (process.env.USERSTORY_LIST) {
    try {
      return JSON.parse(process.env.USERSTORY_LIST);
    } catch (ex) {
      console.log('Error parsing USERSTORY_LIST:', ex);
    }
  } else {
    console.log("USERSTORY_LIST is null");
  }
  return [];
}

function getDeploymentStatusURL() {
  if (process.env.DEPLOYMENT_ID) {
    return `https://anypoint.mulesoft.com/cloudhub/#/console/home/applications`;
  }
  return process.env.SALESFORCE_ENVIRONMENT_URL;
}

function getDryRunDetails() {
  if (process.env.IS_DRY_RUN === 'true') {
    return {
      dryrun_deployment: 'Validation',
      dryrun_deployment_css: 'background-color:#ffde21;',
      dryrun_deployment_icon: '&#x2714;',
      dryrun_deployment_image: '✔'
    };
  }
  return {
    dryrun_deployment: 'Deployment',
    dryrun_deployment_css: 'background-color:#7E54D9;color:white;',
    dryrun_deployment_icon: '&#x1F680;',
    dryrun_deployment_image: '🚀'
  };
}

function getEnvironmentDetails() {
  if (process.env.ENVIRONMENT === 'PROD') {
    return {
      env_css: 'background-color:#7E54D9;color:white;',
      env_icon: '&#x1F3ED;',
      env_image: '🏭'
    };
  }
  return {
    env_css: 'background-color:#ffde21;',
    env_icon: '&#x1F9EA;',
    env_image: '🧪'
  };
}

function getStatusDetails(deploySuccess) {
  if (deploySuccess) {
    return {
      status_css: 'background-color:green;color:white;',
      status_text: 'successfully completed',
      status_icon: '&#x1F389;',
      status_image: '🎉'
    };
  }
  return {
    status_css: 'background-color:red;color:white;',
    status_text: 'failed',
    status_icon: '&#x274C;',
    status_image: '❌'
  };
}



function createReplacements({ env_icon, dryrun_deployment, dryrun_deployment_icon, status_icon, status_text, branchUrl, appName, gitTagUrl, deploymentStatusURL }) {
  return {
    'var_env_icon': env_icon,
    'var_env_name': process.env.ENVIRONMENT,
    'var_deployment_type_text': dryrun_deployment,
    'var_deployment_type_icon': dryrun_deployment_icon,
    'var_deployment_status_icon': status_icon,
    'var_deployment_message': status_text,
    'var_deployment_status_header_text': process.env.DEPLOY_STATUS_SUCCESS === 'true' ? 'Successful' : 'Failed',
    'var_branch_url': branchUrl,
	'var_app_name': appName,
    'var_branch_name': process.env.CURRENT_BRANCH_NAME,
    'var_mule_deploy_status_url': deploymentStatusURL,
    'var_ghactions_output_url': process.env.GITHUB_RUN_URL
  };
}

function generateEmailBodyContent(replacements) {
  const filePath = path.join(__dirname, 'deployeMailTemplate.html');
  let emailbody_content = '';

  try {
    const data = fs.readFileSync(filePath, 'utf8');
    console.log('File read successfully.');

    let modifiedContent = data;
    for (const [placeholder, value] of Object.entries(replacements)) {
      const regex = new RegExp(placeholder, 'g');
      modifiedContent = modifiedContent.replace(regex, value);
      console.log(`Replaced ${placeholder} with ${value}`);
    }

    emailbody_content = modifiedContent;
  } catch (err) {
    console.error('Error reading the file:', err);
  }

  return emailbody_content;
}

getEmailBody();
