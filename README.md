# Making an R Shiny Electron App using macOS via npx

*In progress*

A setup guide by L. Abigail Walter
<br>Instructions adapted from Travis Hinkelman: https://www.travishinkelman.com/post/deploy-shiny-electron/

## Getting started

### Steps to get your computer ready:

1. Install Node (https://nodejs.org/en/)
2. Install Electron and Electron Forge using npm (which comes with Node). In the terminal, type ```install -g electron-forge```. If that didn't work, try ```npm i -g @electron-forge/cli```. If there's a permission error, run ```sudo npm i -g @electron-forge/cli```.
4. Install program 'n'. This program will let us downgrade node if there is an issue running it at the most up-to-date version. In the terminal, run ```sudo npm install -g n``` to install and then ```sudo n stable``` to upgrade to the latest version of n.
5. Open an existing R project or create a new one.
6. Open the Terminal again and make sure your directory is in the package or project folder you're ready to turn into an app. Run ```pwd``` on the command line to check what directory you are in. If you're not in the right folder, change your directory using ```cd```.
  
## Advanced steps
  
### You can start here if you already have the required software and a package to turn into an app. If you've already finished steps 1-6 before, you can start at 7.

7. In your project directory, install electron locally/create the app by running: ```npx create-electron-app appNameHere```. Replace appNameHere with whatever you want to name your app.
8. Move or add files to your new app folder, including:
- get-r-mac.sh
- add-cran-binary-pkgs.R
- start-shiny.R
- shiny/app.R
- src/main.js
- src/index.js
- src/index.css
- src/loading.css
- src/loading.html
- src/failed.html
- src/helpers.js
9. Install R locally: ```sh ./get-r-mac.sh```
10. Get packages for R that are used in the shiny app by running: ```Rscript add-cran-binary-pkgs.R```
11. Add additional dependencies to the package.json:
```      "dependencies": {
        "axios": "^0.19.2",
        "electron-squirrel-startup": "^1.0.0",
        "execa": "^4.0.0"
      },
      "devDependencies": {
        "@babel/core": "^7.8.4",
        "@babel/plugin-transform-async-to-generator": "^7.8.3",
        "@babel/preset-env": "^7.8.4",
        "@babel/preset-react": "^7.8.3",
        "@electron-forge/cli": "^6.0.0-beta.49",
        "@electron-forge/maker-deb": "^6.0.0-beta.49",
        "@electron-forge/maker-rpm": "^6.0.0-beta.49",
        "@electron-forge/maker-squirrel": "^6.0.0-beta.49",
        "@electron-forge/maker-zip": "^6.0.0-beta.49",
        "electron": "8.0.1",
        "eslint": "^6.8.0",
        "eslint-config-airbnb": "^18.0.1",
        "eslint-plugin-import": "^2.20.1",
        "eslint-plugin-jsx-a11y": "^6.2.3",
        "eslint-plugin-react": "^7.18.3",
        "eslint-plugin-react-hooks": "^2.4.0",
        "fs-extra": "^8.1.0"
      }
```
12. Test to see if your app works by running: ```electron-forge start```
13. If it runs, package and create the .exe by running: ```electron-forge make```. Your app can be found in the /out folder.




 
