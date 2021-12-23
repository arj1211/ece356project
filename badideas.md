# Questions to answer (Queries)

## WebServices

- who connected to ['fabcebf','google']? : hostID sourceIPs 
    - in a certain time period vs all time
    - `select * from host left join webserive whre webservie={userinput}`

- what protocls have been used on webserive [fb|google|etc]? protocols

- display stats for all flows that connected to the webservice [fb|google|etc] : **BIG** output
    - some query with bare joins


## Host
- when was *hostIP* active? : timestamps, flowduration
- which other hosts has *hostIP* connected to?
- which webservices has *hostIP* connected to?
- how much time has *hostIP* spent on the internet?

## Protocol
- show all traffic with *protocol*
