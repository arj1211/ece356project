<html>
<head>
<!-- Other head stuff here, like title or meta -->

<style type="text/css">
u.dotted{
  border-bottom: 2px dashed #999;
  text-decoration: none; 
}
</style>
</head>
<!-- Body, content here -->

# Host - Entity
- <u>hostID</u>
- ip
  - part1
  - part2
  - part3
  - part4
- port
<!-- - Source.Port
- Destination.Port
- Source.IP
- Destination.IP -->

# Connection - Entity
<!-- - sourceHostID
- destinationHostID -->
- <u>connectionID</u>

# Protocol - Entity
<!-- - protocolNumber
- protocolName -->
- <u>Protocol</u>

# Flow Statistics - Entity
- <u>Flow.ID</u>
- Timestamp
- Flow.Duration
- Flow.IAT.Max
- Flow.IAT.Min
- Flow.Bytes.s
- Flow.Packets.s
- Flow.IAT.Mean
- Flow.IAT.Std
- Packet.Length.Mean
- Packet.Length.Std
- Packet.Length.Variance
- Average.Packet.Size
- Min.Packet.Length
- Max.Packet.Length
- Down.Up.Ratio
- Active.Mean
- Active.Std
- Active.Max
- Active.Min
- Idle.Mean
- Idle.Std
- Idle.Max
- Idle.Min

# Forward Statistics - Entity
<!-- - all the fwd info corresponding to a flowID -->
- <u>flowID</u>
- Total.Fwd.Packets
- Total.Length.of.Fwd.Packets
- Fwd.Packet.Length.Max
- Fwd.Packet.Length.Min
- Fwd.IAT.Total
- Fwd.IAT.Max
- Fwd.IAT.Min
- Fwd.Header.Length
- Fwd.Avg.Bytes.Bulk
- Fwd.Avg.Packets.Bulk
- Fwd.Avg.Bulk.Rate
- Subflow.Fwd.Packets
- Subflow.Fwd.Bytes
- Fwd.Packet.Length.Mean
- Fwd.Packet.Length.Std
- Fwd.IAT.Mean
- Fwd.IAT.Std
- Fwd.Packets.s
- Avg.Fwd.Segment.Size
- Init_Win_bytes_forward
- act_data_pkt_fwd
- min_seg_size_forward

# Backward Statistics - Entity
<!-- - all the bwd info corresponding to a flowID -->
- <u>flowID</u>
- Total.Backward.Packets
- Total.Length.of.Bwd.Packets
- Bwd.Packet.Length.Max
- Bwd.Packet.Length.Min
- Bwd.IAT.Total
- Bwd.IAT.Max
- Bwd.IAT.Min
- Bwd.Header.Length
- Bwd.Avg.Bytes.Bulk
- Bwd.Avg.Packets.Bulk
- Bwd.Avg.Bulk.Rate
- Subflow.Bwd.Packets
- Subflow.Bwd.Bytes
- Bwd.Packet.Length.Mean
- Bwd.Packet.Length.Std
- Bwd.IAT.Mean
- Bwd.IAT.Std
- Bwd.Packets.s
- Avg.Bwd.Segment.Size
- Init_Win_bytes_backward

# Count statistics - Entity
- <u>flowID</u>
- FIN.Flag.Count
- SYN.Flag.Count
- RST.Flag.Count
- PSH.Flag.Count
- ACK.Flag.Count
- URG.Flag.Count
- CWE.Flag.Count
- ECE.Flag.Count

# FlagInfo - Entity
<!-- - everything about flags -->
- <u>flowID</u>
- Bwd.PSH.Flags
- Bwd.URG.Flags
- Fwd.PSH.Flags
- Fwd.URG.Flags

# Web service - Entity
- <u>L7Protocol</u>
- ProtocolName


# Involves - Relation (Host, Connection)
- <u>sessionID</u>

# Flow - Relation (Connection, FWDInfo, BWDInfo)
<!-- - flowID
- time
- the "total" info corresponding to a flowID -->
- Label

# Logs - Relation (CountStats, Forward Statistics, Backward Statistics)
- <u>logID</u>

# FlagCounts - Relation (CountStats, FlagInfo)

</html>