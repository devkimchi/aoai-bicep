targetScope = 'subscription'

param name string
param location string = 'Korea Central'

resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'rg-${name}'
  location: location
}

module aoai './openAi.bicep' = {
  name: 'OpenAI'
  scope: rg
  params: {
    name: name
    location: 'southcentralus'
  }
}
