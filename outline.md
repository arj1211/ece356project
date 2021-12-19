# Host - Entity
- hostID
- ip
- port

# Session - Relation (Host, Connection)
- sessionID

# Connection - Entity (Host and Flow)
- sourceHostID
- destinationHostID

# Protocol - Entity
- protocolNumber
- protocolName

# Flow - Entity Relation (Connection, FWDInfo, BWDInfo)
- flowID
- time
- the "total" info corresponding to a flowID

# ForwardInfo - Entity
- all the fwd info corresponding to a flowID

# BackwardInfo - Entity
- all the bwd info corresponding to a flowID

# FlagInfo - Entity
- everything about flags

# Web