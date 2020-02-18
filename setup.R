# Shiny Electron for macOS using npx --------------------------------------

# A setup guide by L. Abigail Walter
# Last updated Feb 2020

# Instructions adapted from Travis Hinkelman:
# https://www.travishinkelman.com/post/deploy-shiny-electron/

# Steps from the beginning ------------------------------------------------

# Do these to get your computer set up:

# Step 1: Install Node (https://nodejs.org/en/)
# Step 2: Install Electron and Electron Forge using npm (which comes with
      # Node) using the command line:
      #   a. install -g electron-forge
      #   b. if that didn't work, try: npm i -g @electron-forge/cli
      #   c. if there's a permission error, run:
      #      sudo npm i -g @electron-forge/cli
# Step 3: Have an R package open that you're ready to turn into an R
      # shiny electron app, either an original package or one that has
      # been cloned/downloaded from the GitHub repo (e.g. RSE template)
# Step 4: Open the Terminal and make sure your directory is in the 
      # package/project folder.
      # a. type 'pwd' to check
      # b. if you're not in the right folder, change it with 'cd'

# Advanced steps ----------------------------------------------------------

# Start here if you are on a computer with Steps 1-4 completed:

# Step 5: Install electron locally/create the app by running:
      # npx create-electron-app colorbands
# Step 6: Change directory to your new app folder:
      # cd colorbands
# Step 7: Move get-r-mac.sh and add-cran-binary-pkgs.R to app folder
# Step 8: Install R locally using: 
      # sh ./get-r-mac.sh
# Step 9: Get packages used in the shiny app by running:
      # Rscript add-cran-binary-pkgs.R

# Step _: Create the executable app by running:
      # electron-forge make