# Making an R Shiny Electron App using macOS via npx

A setup guide by L. Abigail Walter
Instructions adapted from Travis Hinkelman: https://www.travishinkelman.com/post/deploy-shiny-electron/

## Getting started

### Steps to get your computer ready:

1. Install Node (https://nodejs.org/en/)
2. Install Electron and Electron Forge using npm (which comes with Node) using the command line:
```install -g electron-forge```
  b. if that didn't work, try: npm i -g @electron-forge/cli
  c. if there's a permission error, run: sudo npm i -g @electron-forge/cli
4. Install program 'n'. This program will let us downgrade node if there is an issue running it at the most up-to-date version.
  a. sudo npm install -g n
  b. sudo n stable (this upgrades to the latest version of n)
5. Have an R project open that you're ready to turn into an R
  a. shiny electron app
6. Open the Terminal and make sure your directory is in the package/project folder. Run:
  a. pwd
  b. if you're not in the right folder, change it with 'cd'
  
## Advanced steps
  
### You can start here if you already have the required software and a package to turn into an app. If you've already finished steps 1-6 before, you can start at 7.

7. In your project directory, install electron locally/create the app by running:
```npx create-electron-app colorbands```


 
