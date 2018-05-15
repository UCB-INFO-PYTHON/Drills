#!/bin/bash

#Thanks to Hugo Saavedra who submitted a version of  this autopusher in the W18 summer 2016 class
#
# This is a bash script that automatically pulls and pushes to a remote repo every 10 minutes
# until 8 PM. It touches two files, and overwrites one with the current weather and appends
# the current weather to the other one.
#
###### LOCATION and EXECUTION ###########

# you can put your bot in your repo or keep it out of your repo by putting it in your binaries folder along the search path
# to see your saerch path type "echo $PATH" at the CLI
# here is mine:

#Gunnars-MacBook-Pro-2:Drills GunnarK$ echo $PATH

#/Users/GunnarK/miniconda/bin:/Library/Frameworks/R.framework/Resources/bin/R:/Users/GunnarK/anaconda/envs/plotbio35/bin:/Library/Frameworks/Python.framework/Versions/2.7/bin:/Users/GunnarK/anaconda/bin:/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/opt/X11/bin:/Library/TeX/texbin:/usr/lpp/mmfs/bin:/usr/bin/java
#
# So i put the weather pusher in Users/GunnarK/miniconda/bin
# and I invoked it from inside github playground in order to push to that repo
#
# Gunnars-MBP-2:github-playground GunnarK$ bash weather_pusher.sh
#
# *** NOTE: if you want to share your code strip any APIs out and push it to the shared playground no one will be able to see your bin folder



####################### AUTHENTICATION ###########################################
#
# Runing this script requires some form of authentication there are a few ways to do this ##
# - password username cashing -- 
# - SSH authenticatication -- 
# - A personal API token --
# Note SSH and HTTP and API based authentication all work with different syntax 
#
####REFERENCES
# SSH based methods - these are very convenient and more safe.
#https://stackoverflow.com/questions/2643502/git-permission-denied-publickey
#https://help.github.com/articles/connecting-to-github-with-ssh/
#
# Password caching HTTP based methods
# https://stackoverflow.com/questions/5343068/is-there-a-way-to-skip-password-typing-when-using-https-on-github
# https://stackoverflow.com/questions/6565357/git-push-requires-username-and-password
# https://help.github.com/articles/caching-your-github-password-in-git/
#
# API TOKEN based methods 
# https://github.com/blog/1509-personal-api-tokens
# https://stackoverflow.com/questions/44342276/how-to-push-code-to-github-hiding-the-api-keys
# https://developer.github.com/v3/auth/

## if you are using API authentication *DONT SHARE API TOKEN ON GITHUB* #####################
# Save this file in ~/bin (see location notes above), not in the same repository that you will be pulling pushing from
# or gitignore it, otherwise the API info will be shared.
# or use a separate file with the credentials in it as shown
##############################################################################################

# To update a file with the weather as below, you need the weather utility
# (sudo apt-get install weather-util).

pass=1  # Set the loop counter to 1. This ensures that the first commit is commit 1.

while [ $(date "+%H") -lt 23 ] # The while condition is that the time on the 24 hour clock is less than 11 PM.

do
    curl wttr.in/austin > getWeather.txt # download the weather from wttr
    cleanWeather=$(head -7 getWeather.txt) # takes just todays weather

    git pull https://github.com/MIDS-INFO-W18/github-playground.git

        echo " text
           $cleanWeather
            This is loop number $pass.
            The local system date and time is $(date)." > weatherReport.txt

        echo " text
           $cleanWeather
            This is loop number $pass.
            The local system date and time is $(date)."  >> edit.txt

    git add edit.txt
    git commit -m "Austin WeatherPusher srikes again \(number $pass\)"

    git push --set-upstream https://github.com/MIDS-INFO-W18/github-playground.git
    pass=$[ $pass+1 ] # Adds 1 to the loop and commit number.
    sleep 0
    # Sleep for 3600 seconds (600 seconds) before looping again.
done
