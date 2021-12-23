
def add_data(userLevel):
    if (userLevel == 1):
        print("Please select what type of data you would like to add:")
        print("1. Host")
        print("2. Webservice")
        print("3. Protocol")

        tableChoice = int(input("Enter a number: "))

        if (tableChoice == 1):
            inputIP = input("Enter an IP Address: ")
            inputPort = int(input("Enter a Port Number: "))
            
        elif (tableChoice == 2):
            inputProtocolID = int(input("Enter a L7 Protocol Number: "))
            inputProtocolName = input("Enter a WebService Name: ")

        elif (tableChoice == 3):
            inputProtocolID = int(input("Enter a Protocol Number: "))
            inputProtocolName = input("Enter a Protocol Name: ")

    else:
        print("Please select what type of data you would like to add:")
        print("1. Host")
        print("2. Webservice")
        print("3. Protocol")
        print("4. Connection")
        print("5. Overall Flow")
        print("6. Extra Flow")

        tableChoice = int(input("Enter a number: "))

        if (tableChoice == 1):
            inputIP = input("Enter an IP Address: ")
            inputPort = int(input("Enter a Port Number: "))
            
        elif (tableChoice == 2):
            inputProtocolID = int(input("Enter a L7 Protocol Number: "))
            inputProtocolName = input("Enter a WebService Name: ")

        elif (tableChoice == 3):
            inputProtocolID = int(input("Enter a Protocol Number: "))
            inputProtocolName = input("Enter a Protocol Name: ")

        elif (tableChoice == 4):
            inputConnectionID = int(input("Enter a ConnectionID: "))
            inputSourceID = input("Enter a sourceID: ")
            inputDestinationID = input("Enter a destinationID: ")

        elif (tableChoice == 5):
            flowStatsInfo = input("Enter Flow Stats info in CSV format: ")
            flowInfo = input("Enter connectionID, webService, and protocol")

        elif (tableChoice == 6):
            print("Select a table to add data to:")
            print ("1. ForwardStats")
            print ("2. BackwardStats")
            print ("3. directionalFlagCounts")
            print ("4. totalFlagCounts")

            tableChoice = int(input("Enter a number: "))

            flowInfo = input("Enter flowID and data in csv format:")

def query_data(userLevel):
    if (userLevel == 1):
        # print("Please select what type of data you would like to query:")
        # print("1. Host")
        # print("2. Webservice")
        # print("3. Protocol")
        # print("4. Flow")
        # print("5. All")

        print("Please select what attribute you would like to query based on:")
        print("1. Host IPAddress")
        print("2. Webservice")
        print("3. Protocol")

        dataType = int(input("Enter a number: "))

        if dataType == 1:
            pass
        elif dataType == 2:
            webservice_name = 'GMAIL'
            query = f'''select distinct IPAddress from webservice
                        join flow join involves
                        join host
                        on sourceID=hostID or destinationID=hostID
                        where L7protocolName=\'{webservice_name}\''''
            
        elif dataType == 3:
            pass

        
    


def delete_data(userLevel):
    print("SHANE delete!")
    
def update_data(userLevel):
    print("SHANE update!")

running = True
loggedIn = False
while (running):
    print("Please select your user level.")
    print("1. General User")
    print("2. Database Administrator")

    userLevel = int(input("Enter a number: "))

    if(userLevel == 1):
        loggedIn = True
    else:
        password = "password"
        for i in range(5):
            print("Enter Admin Password")
            ans = input()
            if(ans != password):
                print("You have ", 4-i, " tries left.")
            else:
                print ("true")
                loggedIn = True
                break
        
    while(loggedIn):
        
        if(userLevel == 1):
            print("Select one of the following actions:")
            print("1. Add Data")
            print("2. Query Data")

            userAction = int(input("Enter a number: "))

            if (userAction == 1):
                add_data(userLevel)
            else:
                query_data(userLevel)

        else:
            print("Select one of the following actions:")
            print("1. Add Data")
            print("2. Query Data")
            print("3. Delete Data")
            print("4. Update Data")
            
            userAction = int(input("Enter a number: "))

            if (userAction == 1):
                add_data(userLevel)
            elif (userAction == 2):
                query_data(userLevel)
            elif (userAction == 3):
                delete_data(userLevel)
            else:
                update_data(userLevel)