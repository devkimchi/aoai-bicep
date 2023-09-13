targetScope = 'subscription'

param name string
param location string = 'Korea Central'
param aoaiLocations string

resource rg 'Microsoft.Resources/resourceGroups@2022-09-01' = {
  name: 'rg-${name}'
  location: location
}

var locations = split(aoaiLocations, ',')

module aoais './openAi.bicep' = [for location in locations: {
  name: 'OpenAI_${trim(location)}'
  scope: rg
  params: {
    name: name
    location: trim(location)
  }
}]
