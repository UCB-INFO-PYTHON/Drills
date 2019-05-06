x = int(input("Please enter an integer: "))

print("")

# assign row=x
row = x

#row loop
while row > -1:
    row -= 1
    
    #assign col=x
    col = x
    
    #column loop
    while col > -1:
        if col%2==0: 
            print ('__', end="")
        else:
            print ("$$", end="")
        col -= 1   
 
    print("") 