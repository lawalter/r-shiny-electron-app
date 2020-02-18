# Shiny Electron for macOS using npx --------------------------------------

# A setup guide by Abby Walter
# Instructions adapted from Travis Hinkelman:
# https://www.travishinkelman.com/post/deploy-shiny-electron/

# Steps from the beginning ------------------------------------------------

# Do these to get your computer set up:

# Step 1: Install Node (https://nodejs.org/en/)
# Step 2: Install Electron and Electron Forge using npm (which comes with
      #   Node) using the command line
      # a. install -g electron-forge
      # b. if that didn't work, try: npm i -g @electron-forge/cli
      # c. if there's a permission error, run:
      #   sudo npm i -g @electron-forge/cli
# Step 3: Have an R package open that you're ready to turn into an R
      # shiny electron app, either an original package or one that has
      # been cloned/downloaded from the GitHub repo (e.g. RSE template)
# Step 4: Open the Terminal and make sure your directory is in the 
      # package/project folder.
      # a. type 'pwd' to check
      # b. if you're not in the right folder, change it with 'cd'

# Advanced steps ----------------------------------------------------------

# Start here if you are on a computer with Steps 1-4 completed:

# Step 5: Add get-r-mac.sh, add-cran-binary-pkgs.R, and start-shiny.R(?)
      # to main project folder
# Step 6: Add package.json with script/dependencies updated
# Step 7: Add folder src
# Step 8: To src, add failed.html, helpers.js, index.js, loading.css, 
      # and loading.html
# Step 9: Install R locally using: 
      # sh ./get-r-mac.sh
# Step 10: Get packages used in the shiny app by running:
      # Rscript add-cran-binary-pkgs.R
# Step 11: Install electron locally (as a development dependency) in 
# the app, by running:
     # npx create-electron-app app
# Step 12: Change wd to new folder created for the npx project
     # cd app
# Step 13: Create the executable app by running:
    # electron-forge make