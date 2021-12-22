# Host - Entity
- hostID
- IP
- port

# Connection - Entity
- connectionID

# Protocol - Entity
- protocolID
- protocolName

# FlowStats - Entity
- flowID
- timestamp
- flowDuration
- flowIATMax
- flowIATMin
- flowBytes_s
- flowPackets_s
- flowIATMean
- flowIATStd
- packetLengthMean
- packetLengthStd
- packetLengthVariance
- averagePacketSize
- minPacketLength
- maxPacketLength
- downUpRatio
- activeMean
- activeStd
- activeMax
- activeMin
- idleMean
- idleStd
- idleMax
- idleMin

# ForwardStats - Entity
- flowID
- totalFwdPackets
- totalLengthFwdPackets
- fwdPacketLengthMax
- fwdPacketLengthMin
- fwdIATTotal
- fwdIATMax
- fwdIATMin
- fwdHeaderLength
- fwdAvgBytesBulk
- fwdAvgPacketsBulk
- fwdAvgBulkRate
- subflowFwdPackets
- subflowFwdBytes
- fwdPacketLengthMean
- fwdPacketLengthStd
- fwdIATMean
- fwdIATStd
- fwdPackets_s
- avgFwdSegmentSize
- init_Win_bytes_forward
- act_data_pkt_fwd
- min_seg_size_forward


# BackwardStats - Entity
- flowID
- totalBackwardPackets
- totalLengthBwd.Packets
- bwdPacketLength.Max
- bwdPacketLength.Min
- bwdIATTotal
- bwdIATMax
- bwdIATMin
- bwdHeaderLength
- bwdAvgBytesBulk
- bwdAvgPacketsBulk
- bwdAvgBulkRate
- subflowBwdPackets
- subflowBwdBytes
- bwdPacketLengthMean
- bwdPacketLengthStd
- bwdIATMean
- bwdIATStd
- bwdPackets_s
- avgBwdSegmentSize
- init_Win_bytes_backward


# TotalFlagCounts - Entity
- flowID
- FINFlagCount
- SYNFlagCount
- RSTFlagCount
- PSHFlagCount
- ACKFlagCount
- URGFlagCount
- CWEFlagCount
- ECEFlagCount


# DirectionalFlagCounts - Entity
- flowID
- bwdPSHFlags
- bwdURGFlags
- fwdPSHFlags
- fwdURGFlags


# WebService - Entity
- L7Protocol
- protocolName


# Involves - Relation (Host, Connection)

# Flow - Relation (Connection, WebService, Protocol, FlowStats)
- Label

# Logs - Relation (FlowStats, TotalFlagCounts, DirectionalFlagCounts, ForwardStats, BackwardStats)
