# Questions to answer (Queries)

## WebServices

- who connected to ['fabcebf','google']? : hostID sourceIPs 
    - in a certain time period vs all time
    - `select * from host left join webserive whre webservie={userinput}`

- what protocls have been used on webserive [fb|google|etc]? protocols
    `select distinct protocolName from webservice
     join flow
     join protocol
     where L7protocolName=\'{webservice_name}\
                        `

- display stats for all flows that connected to the webservice [fb|google|etc] : **BIG** output
    - some query with bare joins

    `select distinct * from flowstats
    where flowID in (
    select distinct flowID from webservice
    join flow 
    on webservice.L7Protocol=flow.L7protocol
    join involves
    on flow.connectionID=involves.connectionID
    join host
    on sourceID=hostID or destinationID=hostID
    where L7protocolName='GMAIL'
    );`



## Host
- when was *hostIP* active? : timestamps, flowduration
    `select distinct timestamp, (flowDuration/1000000) as durationSeconds from flowstats
    join flow on flowstats.flowID=flow.flowID
    join involves on flow.connectionID=involves.connectionID
    join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
    where host.IPAddress = '10.200.7.217';`
- which other hosts has *hostIP* connected to?
    `select distinct IPAddress, portNumber from involves 
    join host on sourceID=hostID or destinationID=hostID
    where 
    (sourceID in (select distinct hostID from host where IPAddress='10.200.7.194')
    or destinationID in (select distinct hostID from host where IPAddress='10.200.7.194'))
    and IPAddress!='10.200.7.194';`
- which webservices has *hostIP* connected to?
    `select distinct L7protocolName from webservice
    join flow on webservice.L7Protocol=flow.L7protocol
    join involves on flow.connectionID=involves.connectionID
    join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
    where host.IPAddress = '10.200.7.217';`
- how much time has *hostIP* spent on the internet?
    `select host.IPAddress, sum(flowDuration/1000000) as seconds from flowstats
    join flow on flowstats.flowID=flow.flowID
    join involves on flow.connectionID=involves.connectionID
    join host on involves.sourceID=host.hostID or involves.destinationID=host.hostID
    where host.IPAddress = '10.200.7.217'
    group by host.IPAddress;`

## Protocol
- show all traffic with *protocol*
    `select distinct 
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
    where protocolName='TCP'
    `
