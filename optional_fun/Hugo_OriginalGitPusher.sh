#!/bin/bash 

# This is a bash script that automatically pulls and pushes to a remote repo every 10 minutes
# until 8 PM. It touches two files, and overwrites one with the current weather and appends
# the current weather to the other one.
#
# It requires a personal API token -- see https://github.com/blog/1509-personal-api-tokens
#
# To update a file with the weather as below, you need the weather utility
# (sudo apt-get install weather-util).
#
# Save this file in ~/bin, not in the same repository that you will be pulling/pushing from
# or gitignore it, otherwise the API info will be shared.

pass=1  # Set the loop counter to 1. This ensures that the first commit is commit 1.

while [ $(date "+%H") -lt 23 ] # The while condition is that the time on the 24 hour clock is less than 11 PM.

do
    touch file1.txt
    touch file2.txt

    getWeather=$(weather KOAK) # Checks the weather at Oakland International Airport using the weather utility and captures the output in the variable getWeather.
    cleanWeather=${getWeather:227:500} # Removes the header info and date info from getWeather.

    git pull https://<API>@github.com/blabla/remote.git # Substitute repo/user info in link, and personal API token in <API>

        echo " text
           $cleanWeather
            This is loop number $pass.
            The local system date and time is $(date)." > weatherReport.txt

        echo " text
           $cleanWeather
            This is loop number $pass.
            The local system date and time is $(date)."  >> edit.txt

    git add file1.txt
    git add file2.txt
    git commit -m "Autopusher commit $pass."

    git push --set-upstream https://<API>@github.com/blabla/remote.git master

    pass=$[ $pass+1 ] # Adds 1 to the loop and commit number.

    sleep 600 # Sleep for 10 minutes (600 seconds) before looping again.

done
Status API Training Shop Blog About
© 2016 GitHub, Inc. Terms Privacy Security Contact Help
