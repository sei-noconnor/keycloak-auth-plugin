# Keycloak Crucible Auth Plugin
This auth plugin enables DoD CAC authentication in keycloak and is based off the Platform One keycloak auth plugin. This plugin is provided by the SEI to work with SEI applications requiring CAC authentication.

## Building the plugin. 
To build a docker image of the plugin run the command at the root of the repo 
```
docker buildx build -t <YOUR REGISTRY>/<IMAGE>:<TAG> .
```
```
docker push <YOUR REGISTRY>/<IMAGE>:<TAG> .
```

## Quickstart - DevSpace
### Requirements
- `Docker Desktop` Docker Engine should suffice

its best to install [brew](https://brew.sh) on your os and install the dependencies through brew. 
- `kubectl`
- `kind`
- `yq`
- `devspace-cli`
- `openssl`

### Bootstrap 
1. `devspace run prep` - Creates SSL certificates
1. `devspace run bootstrap` - initializes the Kind cluster

This will bootstrap a kind cluster named `crucible (kind-crucible)` with an nginx ingress.

> **_Note:_** you may need to create a dummy kind cluster to run the initial commands `kind create cluster -n dummy` devspace needs an existing kubectl context in order to run the `prep` and `bootstrap` commands. Cleanup the cluster with `kind delete cluster -n dummy` once you've run the `prep` and `bootstrap` commands



### Import the SSL root-ca 
you will need to find instructions on how to import certificates based on your OS, on linux certificates are managed by the browsers. When you run the prep script above. an `ssl` folder is created at the root of this repository import the `root-ca.pem` into your certificate store 

### Development
currently this repo is only supporting theme development and not java development

1. symlink the crucible folder to theme-live-dev `ln -s $PWD/p1-keycloak-plugin/src/main/resources/theme/crucible $PWD/development/theme-live-dev/theme/p1-sso-live-dev` 
1. `devspace dev`
1. start editing files in the `./development/plugin/live-theme-dev/theme/p1-sso-live-dev`
1. saving the files will automatically sync the theme, changes can be seen in realtime with a refresh

### Building plugin image
1. `devspace build`
2. `docker push <registry>/<image>:<tag>`

### Cleanup 
To destroy the cluster and your development environment run 
`devspace run crucible-common.clean`


## Quickstart - Docker
First we need to build the plugin from source. 
```
docker run -it --rm -v $(pwd):/app gradle:7.4.2-jdk11 bash
cd /app
./gradlew clean --build-cache assemble
```
once the build is done you'll have a JAR file in `./build/libs` directory and we'll want to copy this file into our `development/plugin` folder 
```
ln -s ${PWD}/build/libs/* ./development/plugin
```
you'll want to symlink the theme your developing. within the `p1-keycloak-plugin/src/main/resources/theme` directory for example if you want to develop the crucible theme you would create a symlink as follows
```
ln -s ${PWD}/p1-keycloak-plugin/src/main/resources/theme/crucible development/theme-live-dev 
```
Once you've created the symlink you can launch the docker-compose environment 
```
cd development
docker compose up -d 
docker logs -f keycloak
```

Any changes made to the theme will be updated in real time

## Deployment - Usage
to use this plugin in a production keycloak instance. add an initContainer to the helm values 
file this plugin is compatible with the bitnami/keycloak helm chart

```yaml
  - name: plugin
    image: cmusei/keycloak-auth-plugin:<tag>
    imagePullPolicy: Always
    command:
    - sh
    - -c
    - |
      cp /app/p1-keycloak-plugin.jar /init
      ls -l /init
    volumeMounts:
    - name: plugin
      mountPath: "/init"
```
and add extra volumes and volume mounts 
```yaml
extraVolumes: |-
  - name: plugin
    emptyDir: {}
```
```yaml
extraVolumeMounts: |-
  - name: plugin
    mountPath: /opt/bitnami/keycloak/providers/p1-keycloak-plugin.jar
    subPath: p1-keycloak-plugin.jar
```




# Keycloak P1 Auth Plugin
Repository for the Platform One Keycloak Plugin. This plugin has passed scans in the Party Bus IL2 MissionDevOps pipeline. The Keycloak plugin has custom themes and authentication flows. The project also contains a custom quarkus extension for routing. This code is specific to the Platform One SSO deployment because it has some hard-coded email and web links in the theme that point to *.dsop.mil and *.dso.mil among other P1 branding. Keycloak is configurable to use your own theme. See the [Big Bang Keycloak repo documentation](https://repo1.dso.mil/big-bang/product/packages/keycloak/-/blob/main/development/README.md) for guidance on how to build and use your own custom theme with Keycloak.
The plugin is now available for public consumption in [Iron Bank](https://ironbank.dso.mil/repomap/details;registry1Path=big-bang%252Fp1-keycloak-plugin). The image registry path is `registry1.dso.mil/ironbank/big-bang/p1-keycloak-plugin:X.X.X`

# Credits
Commit history could not be preserved. Credit goes to Jeff McCoy who developed the original plugin. The plugin is now maintained by Platform One.

# Additional Information
See more [docs](docs/). Be sure to review the [docs/compatibility-matrix.md](docs/compatibility-matrix.md) to choose the most appropriate version.