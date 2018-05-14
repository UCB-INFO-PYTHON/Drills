x=int(input("please enter an integer "))
row=x

# row loop 
while row >-1:
    row=row-1
    #column loop
    col=x
    while col >-1:
        if col%2==0: 
            print ('__', end="")
        else:
            print ("$$", end="")
        col=col-1   
    print ("")
    print ("")