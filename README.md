# Azure Bicep for AOAI

This provide Azure bicep files to provision Azure OpenAI Service instance.


## Getting Started

### Provisioning AOAI Instance

Run the commands in the following order:

```bash
# Get the environment name
AZURE_ENV_NAME="bicep$RANDOM"

# Note the environment name
echo $AZURE_ENV_NAME

# Login to Azure Dev CLI
azd auth login

# Configure Azure Dev CLI
azd init -e $AZURE_ENV_NAME

# Choose as many available locations as you want for Azure OpenAI Service. Currently available regions (as of September, 2023) are:
# `australiaeast, canadaeast, eastus, eastus2, francecentral, japaneast, northcentralus, swedencentral, switzerlandnorth, uksouth, westeurope`
AOAI_LOCATIONS="northcentralus"

# Configure Azure OpenAI Service location
azd env set AZURE_OPENAI_LOCATIONS $AOAI_LOCATIONS

# Provision the AOAI instance
azd up
```

> - If you're in a GitHub Codespace instance, run `azd auth login --use-device-code=false` instead of `azd auth login`.
>   - When you see the 404 error page on your web browser, copy the URL and run the `curl` command in a new terminal session with the URL.
> - You will be asked to enter the environment name. Note this environment name for deprovisioning.


### Deprovisioning AOAI Instance

Run the commands in the following order:

```bash
# Login to Azure
az login

# Delete the model deployment for GPT 3.5 Turbo
az cognitiveservices account deployment delete -g rg-$AZURE_ENV_NAME -n aoai-$AZURE_ENV_NAME --deployment-name model-gpt35turbo

# Delete the model deployment for GPT 4
az cognitiveservices account deployment delete -g rg-$AZURE_ENV_NAME -n aoai-$AZURE_ENV_NAME --deployment-name model-gpt432k

# Deprovision the AOAI instance
azd down --force

# Purge the AOAI instance
pwsh ./infra/Purge-CognitiveServices.ps1
```

> - When you see the 404 error page on your web browser, copy the URL and run the `curl` command in a new terminal session with the URL.
> - Make sure that `$AZURE_ENV_NAME` is the value when you provision resources using `azd up`.

