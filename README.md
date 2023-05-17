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

## Developing the plugin.
In order to provide a development environment, in which changes can be made quickly, we have updated this repo to combine docker-compose files from supporting repos [P1 keycloak](https://repo1.dso.mil/big-bang/product/packages/keycloak.git)

### Quickstart - Build the plugin 
First we need to build the plugin from source. 
```
docker run -it --rm -v $(pwd):/app gradle:7.4.2-jdk11 bash
cd /app
./gradlew clean --build-cache assemble
```
once the build is done you'll have a JAR file in `./build/libs` directory and we'll want to symlink this folder into our `development/plugin` folder 
```
ln -s ./build/libs/* ./development/plugin
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

Any changes made to the theme will be 




# Keycloak P1 Auth Plugin
Repository for the Platform One Keycloak Plugin. This plugin has passed scans in the Party Bus IL2 MissionDevOps pipeline. The Keycloak plugin has custom themes and authentication flows. The project also contains a custom quarkus extension for routing. This code is specific to the Platform One SSO deployment because it has some hard-coded email and web links in the theme that point to *.dsop.mil and *.dso.mil among other P1 branding. Keycloak is configurable to use your own theme. See the [Big Bang Keycloak repo documentation](https://repo1.dso.mil/big-bang/product/packages/keycloak/-/blob/main/development/README.md) for guidance on how to build and use your own custom theme with Keycloak.
The plugin is now available for public consumption in [Iron Bank](https://ironbank.dso.mil/repomap/details;registry1Path=big-bang%252Fp1-keycloak-plugin). The image registry path is `registry1.dso.mil/ironbank/big-bang/p1-keycloak-plugin:X.X.X`

# Credits
Commit history could not be preserved. Credit goes to Jeff McCoy who developed the original plugin. The plugin is now maintained by Platform One.

# Additional Information
See more [docs](docs/). Be sure to review the [docs/compatibility-matrix.md](docs/compatibility-matrix.md) to choose the most appropriate version.