# How to Make an R Shiny Electron App 

A setup guide by L. Abigail Walter
<br>Instructions adapted from <a href="https://www.travishinkelman.com/post/deploy-shiny-electron/">Travis Hinkelman</a> 
<br>R Shiny Electron template created by <a href="https://github.com/dirkschumacher/r-shiny-electron">Dirk Shumacher</a>

### Introduction

<b>Motivation:</b> In February 2020, I was unable to create a standalone desktop app using an R Shiny Electron template via Dirk Shumaker's <a href="https://github.com/dirkschumacher/r-shiny-electron">original repo</a> or Travis Hinkelman's <a href="https://github.com/hinkelman/r-shiny-electron">fork</a>. I avoided the warnings created with their methods by using <b>npx</b> instead of <b>npm</b>, and by adding file main.js, and wanted to share this information with other users.

<b>Objective:</b> Write a comprehensive guide for anyone interested in creating an R Shiny Electron app. This guide assumes the user has intermediate R coding skills, intermediate ability to use the terminal, and little to no experience with JavaScript. 

<b>Note:</b> I recommend building your app using macOS if possible; it is _much_ simpler than Windows. 

### Navigation

- [Setup guide: macOS](#getting-started-on-macos) - complete!
- [Setup guide: Windows](#getting-started-on-windows) - complete!
- [Setup guide: Linux](#getting-started-on-linux) - in progress
- [Troubleshooting](#troubleshooting)
- [Acknowledgements](#acknowledgements)

---

## Getting started on macOS
All of the following steps can be run exclusively in the RStudio terminal

### Steps to get your computer ready:

1. Install Node.js: https://nodejs.org/en/
2. Install Electron Forge using npm (npm is installed with Node.js)
    - In the R terminal, run ```npm i -g @electron-forge/cli``` 
    - If there's a permission error, run ```sudo npm i -g @electron-forge/cli```
3. Check your versions of node ```node -v``` and npm ```npm -v```. For this guide, I will be using <b>node v13.9.0</b> and <b>npm v6.13.7</b>. If your installations do not match mine and you experience problems with these steps, try downgrading or upgrading (see [Troubleshooting](#troubleshooting) section below).
4. Open an existing R project, create a new one, or initialize a project by cloning a git repo.
  
## Advanced macOS steps
  
### Start here if you have all of the dependencies installed:

5. Make sure your directory is in R project folder you're ready to turn into an app. 
    - Run ```pwd``` on the command line to check what directory you are in. 
    - If you're not in the right folder, change your directory using ```cd example/file/path``` with the example path replaced with the appropriate path to your project. 
6. In your project directory, install Electron locally by running ```npx create-electron-app appNameHere```. Replace appNameHere with whatever you want to name your app. 
    - <b>Note:</b> Your app cannot be titled "app".
7. In your appNameHere folder, delete folder <b>src</b>. 
8. Move files (I typically use the R file pane gui) to your new app folder, including:
- get-r-mac.sh 
- add-cran-binary-pkgs.R
- start-shiny.R
- Folder <b>shiny</b> from this repo, containing: 
    - shiny/app.R 
- Folder <b>src</b> from this repo, containing:
    - src/failed.html
    - src/helpers.js
    - src/index.css
    - src/index.js
    - src/loading.css
    - src/loading.html
    - src/main.js
- <b>Note:</b> File app.R is whatever R Shiny script you want to launch in your application. You can use the example provided in this repo or use your own.
9. Change your directory to your new app folder ```cd appNameHere```
10. Install R locally:
    - First, check the version of R on your machine. In the R console, run ```version``` 
    - Edit get-r-mac.sh, replacing version numbers in the link ```https://cloud.r-project.org/bin/macosx/R-3.6.2.pkg``` with the version you are running. 
        - <b>Important:</b> The R version used to make the shiny app and the version installed locally must match. The app included in this repo was created in R v3.6.2.
    - Once you save the file, run the shell script in the terminal ```sh ./get-r-mac.sh``` 
11. If you don't have the automagic package installed, run ```install.packages("automagic")``` in the R console. 
12. In the R terminal, run ```Rscript add-cran-binary-pkgs.R``` to get packages for R. 
13. Add additional dependencies to package.json. Replace the dependencies listed at the end of the script with the following. Take care not to paste over the final ending bracket ```}``` of the .json file.
```      
    "dependencies": {
      "axios": "^0.19.2",
      "electron-squirrel-startup": "^1.0.0",
      "esm": "^3.2.25",
      "execa": "^4.0.0"
    },
    "devDependencies": {
      "@babel/core": "^7.8.4",
      "@babel/plugin-transform-async-to-generator": "^7.8.3",
      "@babel/preset-env": "^7.8.4",
      "@babel/preset-react": "^7.8.3",
      "@electron-forge/cli": "^6.0.0-beta.50",
      "@electron-forge/maker-deb": "^6.0.0-beta.50",
      "@electron-forge/maker-rpm": "^6.0.0-beta.50",
      "@electron-forge/maker-squirrel": "^6.0.0-beta.50",
      "@electron-forge/maker-zip": "^6.0.0-beta.50",
      "electron": "8.0.2",
      "eslint": "^6.8.0",
      "eslint-config-airbnb": "^18.0.1",
      "eslint-plugin-import": "^2.20.1",
      "eslint-plugin-jsx-a11y": "^6.2.3",
      "eslint-plugin-react": "^7.18.3",
      "eslint-plugin-react-hooks": "^1.7.0",
      "fs-extra": "^8.1.0"
      }
```
<b>Note:</b> Modules are updated frequently and as such are subject to changing version numbers. It is important to double-check that these dependencies are up-to-date by replacing their version numbers with any newer version numbers. You can accomplish this by manually searching the module names at https://www.npmjs.com/

<b>Note:</b> We are using ```"eslint-plugin-react-hooks": "^1.7.0"``` because using the latest v2.4.0 throws a warning.

<b>Optional</b>: If you have not added a field in the package.json for repository information, you will see a warning when running ```npm install```. This is not a serious warning, but it is good practice to edit the .json with your git repo if you have the time. To do this, insert the following to your package.json:
```
 "repository": {
  "type": "git",
  "url": "git://github.com/username/repo.git"
  },
```

14. Replace the ```"lint": "echo \"No linting configured\""``` line in package.json with ```"lint": "eslint src --color"```
15. Run ```npm install``` to add new dependencies you listed in package.json to the node_modules folder.
16. Test to see if your app works by running ```electron-forge start```
17. If the app runs successfully, congratulations! Package and create the .exe on the command line with ```electron-forge make```. Your app can be found in the /out folder.

---

## Getting started on Windows
Unlike the macOS setup, Windows will require the use of multiple terminals, which are specified at each step

### Steps to get your computer ready:

1. Install Node.js: https://nodejs.org/en/
    - Check the box option during the node.js install to also install chocolatey
2. Skip this step if chocolatey is installed. If chocolatey has <b>not</b> been installed:
    - Open Windows PowerShell with right-click option "Run as Administrator" 
    - Follow the installation steps on the <a href="https://chocolatey.org/install">chocolatey</a> website
3. Using chocolatey, install innoextract v1.8 or greater:
    - Re-open Windows PowerShell with right-click option "Run as Administrator" 
        - <b>Note:</b> If you just installed chocolatey in Windows PowerShell, you need to close and re-launch the admin shell
    - Run ```choco install innoextract``` 
        - If innoextract is already installed at a version less than v1.8, run ```choco upgrade innoextract```
4. In the same Administrator Windows PowerShell, install Electron Forge globally
    - Run ```npm install -g electron-forge```
5. Install <a href="https://cygwin.com/">Cygwin</a>
    - During Cygwin install, <a href="https://superuser.com/questions/693284/wget-command-not-working-in-cygwin">select wget packages</a> at the 'packages' screen by clicking the arrow in the 'new' clolumn to select the newest version.
6. Check your versions of node ```node -v``` and npm ```npm -v``` using any terminal. For this guide, I will be running <b>node v13.9.0</b> and <b>npm v6.13.7</b>. If your installations do not match mine and you experience problems with these steps, try downgrading or upgrading (see [Troubleshooting](#troubleshooting) section below).
7. Open an existing R project, create a new one, or initialize a project by cloning a git repo.
  
## Advanced Windows steps
  
### Start here if you have all of the dependencies installed:

8. Make sure your directory is in R project folder you're ready to turn into an app. 
    - In Windows PowerShell, run ```pwd``` on the command line to check what directory you are in. 
    - If you're not in the right folder, change your directory using ```cd C:\Users\Name\Desktop\gitFolderName``` with the example path replaced with the appropriate path to your project. 
9. In your project directory, install Electron locally:
    - Using Windows PowerShell, run ```npx create-electron-app appNameHere```
    - Replace appNameHere with whatever you want to name your app. 
        - <b>Note:</b> Your app cannot be titled "app".
10. In your appNameHere folder, delete folder <b>src</b>. 
11. Move files (I typically use the R file pane gui) to your new app folder, including:
- get-r-win.sh
- add-cran-binary-pkgs.R
- start-shiny.R
- Folder <b>shiny</b> from this repo, containing:  
    - shiny/app.R 
- Folder <b>src</b> from this repo, containing:
    - src/failed.html
    - src/helpers.js
    - src/index.css
    - src/index.js
    - src/loading.css
    - src/loading.html
    - src/main.js
12. In Windows PowerShell, change your directory to your new app folder ```cd appNameHere```
13. Install R locally:
    - First, check the version of R on your machine. In the R console, run ```version``` 
    - Edit get-r-win.sh, replacing version numbers in the link ```https://cloud.r-project.org/bin/windows/base/R-3.6.2-win.exe``` with the version you are running if you made the app.R, or the version of R that was used to make the app.
        - <b>Important:</b> The R version used to make the shiny app and the version installed locally must match. The app included in this repo was created in R v3.6.2.
    - Open the Cygwin terminal. Change your directory by 1) typing ```cd```, 2) opening File Explorer and navigating to your app folder, then 3 ) dragging the app folder itself to the Cygwin terminal window to paste the file path. Run the command.
        - <b>Example:</b> ```cd /cygdrive/c/Users/Abby/Desktop/git/r-shiny-electron-app/appNameHere```
    - In Cygwin, run ```sh ./get-r-win.sh```
        - <b>If you got an error:</b> you will likely need to convert get-r-win.sh to Unix 
        - To fix error ```./get-r-win.sh: line 5 --output-document: command not found```
            - Download <a href="https://notepad-plus-plus.org/">Notepad++</a> if you don't already have it
            - Open get-r-win.sh in Notepad++
            - Go to Edit -> EOL Conversion -> Unix (LF)
            - Save the script
            - In Cygwin, re-run ```sh ./get-r-win.sh``` 
14. In the R console, ```install.packages("automagic")``` if this package is not already installed.
15. Switch to the RStudio terminal and make sure your directory is in the appNameHere folder. Get packages for R by running ```Rscript add-cran-binary-pkgs.R```
16. Using R, edit package.json to add additional dependencies. Replace the dependencies listed at the end of the script with the following. Take care not to paste over the final ending bracket ```}``` of the .json file.
```      
    "dependencies": {
      "axios": "^0.19.2",
      "electron-squirrel-startup": "^1.0.0",
      "esm": "^3.2.25",
      "execa": "^4.0.0"
    },
    "devDependencies": {
      "@babel/core": "^7.8.4",
      "@babel/plugin-transform-async-to-generator": "^7.8.3",
      "@babel/preset-env": "^7.8.4",
      "@babel/preset-react": "^7.8.3",
      "@electron-forge/cli": "^6.0.0-beta.50",
      "@electron-forge/maker-deb": "^6.0.0-beta.50",
      "@electron-forge/maker-rpm": "^6.0.0-beta.50",
      "@electron-forge/maker-squirrel": "^6.0.0-beta.50",
      "@electron-forge/maker-zip": "^6.0.0-beta.50",
      "electron": "8.0.2",
      "eslint": "^6.8.0",
      "eslint-config-airbnb": "^18.0.1",
      "eslint-plugin-import": "^2.20.1",
      "eslint-plugin-jsx-a11y": "^6.2.3",
      "eslint-plugin-react": "^7.18.3",
      "eslint-plugin-react-hooks": "^1.7.0",
      "fs-extra": "^8.1.0"
      }
```
<b>Note:</b> Modules are updated frequently and as such are subject to changing version numbers. It is important to double-check that these dependencies are up-to-date by replacing their version numbers with any newer version numbers by manually searching the module names at https://www.npmjs.com/

<b>Note:</b> We are using ```"eslint-plugin-react-hooks": "^1.7.0"``` because using the latest v2.4.0 throws a warning.

<b>Optional</b>: If you have not added a field in the package.json for repository information, you will see a warning when running ```npm install```. This is not a serious warning, but it is good practice to edit the .json with your git repo if you have the time. To do this, insert the following to your package.json:
```
 "repository": {
  "type": "git",
  "url": "git://github.com/username/repo.git"
  },
```

17. Replace the ```"lint": "echo \"No linting configured\""``` line in package.json with ```"lint": "eslint src --color"```
18. In Cygwin, run ```npm install``` to add new dependencies you listed in package.json to the node_modules folder.
19. Test to see if your app works by running ```electron-forge start``` in the Cygwin terminal.
    - To stop running the app, press ```Ctrl+C```
20. If the app runs successfully, congratulations! Package and create the .exe on the command line with ```electron-forge make```. Your app can be found in the /out folder.

---

## Getting started on Linux
These steps were created on and for Linux Mint 18, but should work with any Ubuntu edition

### Steps to get your computer ready:

1. Install Node.js using the terminal ```sudo apt install nodejs-legacy```
2. Your Node.js version is probably behind, so next install a version manager ```sudo npm install -g n```
    - Upgrade Node.js 
        - To the most recent version, which at present is v13.9.0, by running ```sudo n 13.9.0```
        - Or to the most recent stable version using ```sudo n stable```
3. Install Electron Forge
    - Run ```npm i -g @electron-forge/cli``` 
    - If there's a permission error, run ```sudo npm i -g @electron-forge/cli```
4. Check your versions of node ```node -v``` and npm ```npm -v```. For this guide, I will be using <b>node v13.9.0</b> and <b>npm v6.13.7</b>. If your installations do not match mine and you experience problems with these steps, try downgrading or upgrading (see [Troubleshooting](#troubleshooting) section below).
5. Open an existing R project, create a new one, or initialize a project by cloning a git repo.
  
## Advanced Linux steps
  
### Start here if you have all of the dependencies installed:

6. Make sure your directory is in R project folder you're ready to turn into an app. 
    - Run ```pwd``` on the command line to check what directory you are in. 
    - If you're not in the right folder, change your directory using ```cd example/file/path``` with the example path replaced with the appropriate path to your project. 
7. In your project directory, install Electron locally by running ```npx create-electron-app appNameHere```. Replace appNameHere with whatever you want to name your app. 
    - <b>Note:</b> Your app cannot be titled "app".
8. In your appNameHere folder, delete folder <b>src</b>. 
9. Move files (I typically use the R file pane gui) to your new app folder, including:
- get-r-linux.sh -- shell script adapted from <a href="https://docs.rstudio.com/resources/install-r-source/">RStudio Documentation</a> by me
- add-cran-binary-pkgs.R
- start-shiny.R
- Folder <b>shiny</b> from this repo, containing:  
    - shiny/app.R 
- Folder <b>src</b> from this repo, containing:
    - src/failed.html
    - src/helpers.js
    - src/index.css
    - src/index.js
    - src/loading.css
    - src/loading.html
    - src/main.js
- <b>Note:</b> File app.R is whatever R Shiny script you want to launch in your application. You can use the example provided in this repo or use your own.
10. Change your directory to your new app folder ```cd appNameHere```
11. Install R locally:
    - First, check the version of R on your machine. In the R console, run ```version``` 
    - Open get-r-linux.sh and edit the line ```export R_VERSION=3.6.2``` with the version you are running if you made the app.R, or the version of R that was used to make the app.
        - <b>Important:</b> The R version used to make the shiny app and the version installed locally must match. The app included in this repo was created in R v3.6.2.
        - <b>Note:</b> I only cover installing R locally on Ubuntu and Ubuntu-based editions. To install R locally on another Linux distribution, cheeck out the <a href="https://cran.r-project.org/doc/manuals/r-release/R-admin.html#Installing-R-under-Unix_002dalikes">R Installation and Administration Manual</a> and readme files in the <a href="https://cloud.r-project.org/bin/linux/ubuntu/">R directories</a>. Good luck!
    - Save your edit(s) in get-r-linux.sh and then run the shell script in the terminal ```sh ./get-r-linux.sh``` 
        - <b>Note:</b> This step may take a while (5-15 mins).
12. If you don't have the automagic package installed, run ```install.packages("automagic")``` in the R console. 
13. In the R terminal, run ```Rscript add-cran-binary-pkgs.R``` to get packages for R. 
14. Add additional dependencies to package.json. Replace the dependencies listed at the end of the script with the following. Take care not to paste over the final ending bracket ```}``` of the .json file.
```      
    "dependencies": {
      "axios": "^0.19.2",
      "electron-squirrel-startup": "^1.0.0",
      "esm": "^3.2.25",
      "execa": "^4.0.0"
    },
    "devDependencies": {
      "@babel/core": "^7.8.4",
      "@babel/plugin-transform-async-to-generator": "^7.8.3",
      "@babel/preset-env": "^7.8.4",
      "@babel/preset-react": "^7.8.3",
      "@electron-forge/cli": "^6.0.0-beta.50",
      "@electron-forge/maker-deb": "^6.0.0-beta.50",
      "@electron-forge/maker-rpm": "^6.0.0-beta.50",
      "@electron-forge/maker-squirrel": "^6.0.0-beta.50",
      "@electron-forge/maker-zip": "^6.0.0-beta.50",
      "electron": "8.0.2",
      "eslint": "^6.8.0",
      "eslint-config-airbnb": "^18.0.1",
      "eslint-plugin-import": "^2.20.1",
      "eslint-plugin-jsx-a11y": "^6.2.3",
      "eslint-plugin-react": "^7.18.3",
      "eslint-plugin-react-hooks": "^1.7.0",
      "fs-extra": "^8.1.0"
      }
```
<b>Note:</b> Modules are updated frequently and as such are subject to changing version numbers. It is important to double-check that these dependencies are up-to-date by replacing their version numbers with any newer version numbers. You can accomplish this by manually searching the module names at https://www.npmjs.com/

<b>Note:</b> We are using ```"eslint-plugin-react-hooks": "^1.7.0"``` because using the latest v2.4.0 throws a warning.

<b>Optional</b>: If you have not added a field in the package.json for repository information, you will see a warning when running ```npm install```. This is not a serious warning, but it is good practice to edit the .json with your git repo if you have the time. To do this, insert the following to your package.json:
```
 "repository": {
  "type": "git",
  "url": "git://github.com/username/repo.git"
  },
```

15. Replace the ```"lint": "echo \"No linting configured\""``` line in package.json with ```"lint": "eslint src --color"```
16. Run ```npm install``` to add new dependencies you listed in package.json to the node_modules folder.
17. Test to see if your app works by running ```electron-forge start```
18. If the app runs successfully, congratulations! Package and create the .exe on the command line with ```electron-forge make```. Your app can be found in the /out folder.

## Troubleshooting 
Steps for macOS, Windows, and Linux

- To change your version of Node.js, install <b>n</b> with npm. This module will enable you downgrade or upgrade Node.js if there is an issue running it at your current version. In the terminal, run ```sudo npm install -g n``` to install.
    - <b>Example:</b> To change to Node v10.16.3 run ```sudo n 13.9.0```

## Acknowledgements

I credit <a href="https://github.com/dirkschumacher/r-shiny-electron">Dirk Shumacher</a> for writing most scripts in this repo, only some of which I edited with only minor changes. In addition, <a href="https://www.travishinkelman.com/post/deploy-shiny-electron/">Travis Hinkelman</a> created the groundwork for this guide, which I made changes to in order to avoid warnings and reports of vulnerabilities and to ultimately allow the app to launch.

[Back to top](#how-to-make-an-r-shiny-electron-app)

