import mysql.connector

mydb = None
mycursor = None
dba = False
out_log = []

#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Functions ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
def handle_user_level():
    print("Please select your user level.")
    print("1. General User")
    print("2. Database Administrator")
    userLevel = int(input("Enter a number: "))
    return userLevel

def handle_dba(): # : boolean
    global dba
    password = "password" # secret
    for i in range(5):
        print("Enter Admin Password")
        ans = input()
        if(ans != password):
            print("You have ", 4-i, " tries left.")
        else:
            print ("Authenticated")
            dba = True
            return True
            break
    return False

def make_connection():
    global mydb, mycursor
    mydb = mysql.connector.connect(
        host="localhost",
        user="root",
        password="Password123!",
        database="internet_traffic"
    )
    mycursor = mydb.cursor()

def run_query(q):
    mycursor.execute(q)
    r = mycursor.fetchall()
    global out_log
    out_log.append(r)
    out_log = out_log[-10:]
    print(r)
    mydb.commit()
    return r

def add_data():
    if not dba:
        print("Please select what type of data you would like to add:")
        print("1. Host")
        print("2. Webservice")
        print("3. Protocol")

        tableChoice = int(input("Enter a number: "))
        tables = ["Host","Webservice","Protocol"]
        colnames = ['(IPAddress, portNumber)', '', '']

        input1=None
        input2=None

        if (tableChoice == 1):
            input1 = input("Enter an IP Address: ")
            input2 = int(input("Enter a Port Number: "))
            
        elif (tableChoice == 2):
            input1 = int(input("Enter a L7 Protocol Number: "))
            input2 = input("Enter a WebService Name: ")

        elif (tableChoice == 3):
            input1 = int(input("Enter a Protocol Number: "))
            input2 = input("Enter a Protocol Name: ")

        query = f'''INSERT INTO {tables[tableChoice-1]} {colnames[tableChoice-1]}
                    VALUES (\'{input1}\', {input2});'''
                    
        return run_query(query)

    else:
        print("Please select what type of data you would like to add:")
        print("1. Host")
        print("2. Webservice")
        print("3. Protocol")
        print("4. Connection")
        print("5. Overall Flow")
        print("6. Extra Flow")

        tableChoice = int(input("Enter a number: "))
        
        if (tableChoice < 5):
            tables = ["Host","Webservice","Protocol","Involves"]
            colnames = ['(IPAddress, portNumber)', '', '', '(sourceID, destinationID)']
            input1=None
            input2=None

            if (tableChoice == 1):
                input1 = input("Enter an IP Address: ")
                input2 = int(input("Enter a Port Number: "))
                
            elif (tableChoice == 2):
                input1 = int(input("Enter a L7 Protocol Number: "))
                input2 = input("Enter a WebService Name: ")

            elif (tableChoice == 3):
                input1 = int(input("Enter a Protocol Number: "))
                input2 = input("Enter a Protocol Name: ")

            elif (tableChoice == 4):
                #inputConnectionID = int(input("Enter a ConnectionID: "))
                input1 = int(input("Enter a sourceID: "))
                input2 = int(input("Enter a destinationID: "))

            query = f'''INSERT INTO {tables[tableChoice-1]} {colnames[tableChoice-1]}
                        VALUES (\'{input1}\', {input2});'''
                        
            return run_query(query)

        elif (tableChoice == 5):
            flowStatsInfo = input("Enter Flow Stats info in CSV format: ")
            flowInfo = input("Enter flowID, connectionID, L7ProtocolNumber, Protocol Number, and Label: ")
            query1 = f'''INSERT INTO flowStats
                        VALUES ({','.join([s.strip() for s in flowStatsInfo.split(',')])});'''
            
            query2 = f'''INSERT INTO flow
                        VALUES ({','.join([s.strip() for s in flowInfo.split(',')])});'''
            
            return (run_query(query1), run_query(query2))

        elif (tableChoice == 6):
            print("Select a table to add data to:")
            print ("1. ForwardStats")
            print ("2. BackwardStats")
            print ("3. directionalFlagCounts")
            print ("4. totalFlagCounts")

            tables = ["ForwardStats","BackwardStats","DirectionalFlagCounts","TotalFlagCounts"]

            tableChoice = int(input("Enter a number: "))
            flowInfo = input("Enter flowID and data in csv format:")
            query = f'''INSERT INTO {tables[tableChoice-1]}
                        VALUES ({flowInfo});'''
                        
            return run_query(query)

def query_data():
    if not dba:
        print("Please select what attribute you would like to query based on:")
        print("1. Host IPAddress")
        print("2. Webservice")
        print("3. Protocol")
        dataType = int(input("Enter a number: "))
        if dataType == 1:
            print('Select one of the following queries:')
            print("1. which other hosts has *hostIP* connected to?")
            print("2. how much time has *hostIP* spent on the internet?")
            print("3. which webservices has *hostIP* connected to?")
            print('4. when was *hostIP* active?')
            qType = int(input("Enter a number: "))
            ip_address = input("Enter an IP Address: ")
            if qType == 1:
                query1 = f'''select distinct IPAddress, portNumber from involves 
                            join host on sourceID=hostID or destinationID=hostID
                            where 
                            (sourceID in (select distinct hostID from host where IPAddress=\'{ip_address}\')
                            or destinationID in (select distinct hostID from host where IPAddress=\'{ip_address}\'))
                            and IPAddress!=\'{ip_address}\';'''
                return run_query(query1)
            elif qType == 2:
                query2 = f'''select host.IPAddress, sum(flowDuration/1000000) as seconds from flowstats
                            join flow on flowstats.flowID=flow.flowID
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\'
                            group by host.IPAddress;'''
                return run_query(query2)
            elif qType == 3:
                query3 = f'''select distinct L7protocolName from webservice
                            join flow on webservice.L7Protocol=flow.L7protocol
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\';'''
                return run_query(query3)
            elif qType == 4:       
                query4 = f'''select distinct timestamp, (flowDuration/1000000) as durationSeconds from flowstats
                            join flow on flowstats.flowID=flow.flowID
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\';'''
                return run_query(query4)
        elif dataType == 2:
            print('Select one of the following queries:')
            print("1. who connected to ['fabcebf','google']? : hostID sourceIPs")
            print("2. what protocls have been used on webserive [fb|google|etc]?")
            print("3. display stats for all flows that connected to the webservice [fb|google|etc].")
            qType = int(input("Enter a number: "))
            webservice_name = input("Enter a WebService name: ")
            if qType == 1:
                query1 = f'''select distinct IPAddress from webservice
                            join flow join involves
                            join host
                            on sourceID=hostID or destinationID=hostID
                            where L7protocolName=\'{webservice_name}\';'''
                return run_query(query1)
            elif qType == 2:
                query2 = f'''select distinct protocolName from webservice
                            join flow
                            join protocol
                            where L7protocolName=\'{webservice_name}\';'''
                return run_query(query2)
            elif qType == 3:
                query3 = f'''select distinct * from flowstats
                            where flowID in (
                            select distinct flowID from webservice
                            join flow 
                            on webservice.L7Protocol=flow.L7protocol
                            join involves
                            on flow.connectionID=involves.connectionID
                            join host
                            on sourceID=hostID or destinationID=hostID
                            where L7protocolName=\'{webservice_name}\'
                            );'''
                return run_query(query3)     
        elif dataType == 3:
            protocol_name = input("Enter a protocol name: ")
            query1 = f'''select distinct 
                        flow.flowID, 
                        flow.connectionID, 
                        flow.protocolID, 
                        flow.L7protocol, 
                        flow.label, 
                        protocol.protocolName, 
                        webservice.L7protocolName,
                        involves.sourceID,
                        involves.destinationID,
                        host.*
                        from flow
                        join protocol 
                        on flow.protocolID=protocol.protocolID
                        join webservice
                        on flow.L7protocol=webservice.L7protocol
                        join involves
                        on flow.connectionID=involves.connectionID
                        join host
                        on sourceID=hostID or destinationID=hostID
                        where protocolName=\'{protocol_name}\';'''
            return run_query(query1)
    else:
        print("Please select what attribute you would like to query based on:")
        print("1. Host IPAddress")
        print("2. Webservice")
        print("3. Protocol")
        dataType = int(input("Enter a number: "))
        if dataType == 1:
            print('Select one of the following queries:')
            print("1. which other hosts has *hostIP* connected to?")
            print("2. how much time has *hostIP* spent on the internet?")
            print("3. which webservices has *hostIP* connected to?")
            print('4. when was *hostIP* active?')
            qType = int(input("Enter a number: "))
            ip_address = input("Enter an IP Address: ")
            if qType == 1:
                query1 = f'''select distinct IPAddress, portNumber from involves 
                            join host on sourceID=hostID or destinationID=hostID
                            where 
                            (sourceID in (select distinct hostID from host where IPAddress=\'{ip_address}\')
                            or destinationID in (select distinct hostID from host where IPAddress=\'{ip_address}\'))
                            and IPAddress!=\'{ip_address}\';'''
                return run_query(query1)
            elif qType == 2:
                query2 = f'''select host.IPAddress, sum(flowDuration/1000000) as seconds from flowstats
                            join flow on flowstats.flowID=flow.flowID
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\'
                            group by host.IPAddress;'''
                return run_query(query2)
            elif qType == 3:
                query3 = f'''select distinct L7protocolName from webservice
                            join flow on webservice.L7Protocol=flow.L7protocol
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\';'''
                return run_query(query3)
            elif qType == 4:       
                query4 = f'''select distinct timestamp, (flowDuration/1000000) as durationSeconds from flowstats
                            join flow on flowstats.flowID=flow.flowID
                            join involves on flow.connectionID=involves.connectionID
                            join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
                            where host.IPAddress = \'{ip_address}\';'''
                return run_query(query4)
        elif dataType == 2:
            print('Select one of the following queries:')
            print("1. who connected to ['fabcebf','google']? : hostID sourceIPs")
            print("2. what protocls have been used on webserive [fb|google|etc]?")
            print("3. display stats for all flows that connected to the webservice [fb|google|etc].")
            qType = int(input("Enter a number: "))
            webservice_name = input("Enter a WebService name: ")
            if qType == 1:
                query1 = f'''select distinct IPAddress from webservice
                            join flow join involves
                            join host
                            on sourceID=hostID or destinationID=hostID
                            where L7protocolName=\'{webservice_name}\';'''
                return run_query(query1)
            elif qType == 2:
                query2 = f'''select distinct protocolName from webservice
                            join flow
                            join protocol
                            where L7protocolName=\'{webservice_name}\';'''
                return run_query(query2)
            elif qType == 3:
                query3 = f'''select distinct * from flowstats
                            where flowID in (
                            select distinct flowID from webservice
                            join flow 
                            on webservice.L7Protocol=flow.L7protocol
                            join involves
                            on flow.connectionID=involves.connectionID
                            join host
                            on sourceID=hostID or destinationID=hostID
                            where L7protocolName=\'{webservice_name}\'
                            );'''
                return run_query(query3)     
        elif dataType == 3:
            protocol_name = input("Enter a protocol name: ")
            query1 = f'''select distinct 
                        flow.flowID, 
                        flow.connectionID, 
                        flow.protocolID, 
                        flow.L7protocol, 
                        flow.label, 
                        protocol.protocolName, 
                        webservice.L7protocolName,
                        involves.sourceID,
                        involves.destinationID,
                        host.*
                        from flow
                        join protocol 
                        on flow.protocolID=protocol.protocolID
                        join webservice
                        on flow.L7protocol=webservice.L7protocol
                        join involves
                        on flow.connectionID=involves.connectionID
                        join host
                        on sourceID=hostID or destinationID=hostID
                        where protocolName=\'{protocol_name}\';'''
            return run_query(query1)

def delete_data():
    print("Please select which table you would like to delete data from:")
    print("1. FlowStats")
    print("2. ForwardStats")
    print("3. BackwardStats")
    print("4. DirectionalFlagCounts")
    print("5. TotalFlagCounts")
    print("6. Flow")

    userTable = int(input("Enter a number: "))

    tables = ["ForwardStats","BackwardStats","DirectionalFlagCounts","TotalFlagCounts","Flow"]

    if (userTable == 1):
        print("\nWarning: corresponding flow information in other tables will be removes as well")
        inputFlowID = int(input("\nEnter ID of flow to delete: "))
        r = []
        for t in tables:
            query = f'''DELETE FROM {t} WHERE flowID={inputFlowID};'''
            r.append(run_query(query))

        query = f'''DELETE FROM flowStats WHERE flowID={inputFlowID};'''
        r.append(run_query(query))
        return r

    else:
        inputFlowID = int(input("Enter ID of flow data to delete: "))

        query = f'''DELETE FROM {tables[userTable-2]} WHERE flowID={inputFlowID};'''
        return run_query(query)


#~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~ Beginning ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

running = True
loggedIn = False

make_connection()

while (running):
    if handle_user_level() == 1:
        loggedIn = True
    else:
        loggedIn = handle_dba()
        if not loggedIn: print('Cannot authenticate, goodbye.')
    
    while loggedIn:
        print("Select one of the following actions:")
        print('0. Show recent output history')
        print("1. Add Data")
        print("2. Query Data")
        if dba: print("3. Delete Data")
        userAction = int(input("Enter a number: "))
        if userAction == 0:
            print(out_log)
        elif userAction == 1:
            add_data()
        elif userAction == 2:
            query_data()
        elif dba:
            delete_data()
        