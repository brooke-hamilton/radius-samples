import radius as radius

param appId string
param location string

resource seq 'Applications.Core/containers@2022-03-15-privatepreview' = {
  name: 'seq'
  location: location
  properties: {
    application: appId
    container: {
      image: 'datalust/seq:latest'
      env: {
        ACCEPT_EULA: 'Y'
      }
      ports: {
        http: {
          containerPort: 80
          provides: seqRoute.id
        }
      }
    }
  }
}

resource seqRoute 'Applications.Core/httproutes@2022-03-15-privatepreview' = {
  name: 'seq-route'
  location: location
  properties: {
    application: appId
  }
}

output seqRouteName string = seqRoute.name