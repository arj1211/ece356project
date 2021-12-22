create table Host (
    hostID int not null auto_increment, 
    IPAddress varchar(16) not null, 
    portNumber int not null,

    primary key(hostID)
);

create table Involves (
    connectionID int not null auto_increment, 
    sourceID int not null, 
    destinationID int not null,

    primary key(connectionID),
    foreign key(sourceID) references Host(hostID),
    foreign key(destinationID) references Host(hostID)
);

create table WebService (
    L7Protocol int not null, 
    L7protocolName varchar(10) not null, 

    primary key(L7Protocol)
);

create table Protocol (
    protocolID int not null, 
    protocolName varchar(10) not null, 

    primary key(protocolID)
);

create table FlowStats (
    flowID int not null auto_increment,
    timestamp datetime not null,
    flowDuration int not null,
    flowIATMax int not null,
    flowIATMin int not null,
    flowBytesS float not null,
    flowPacketsS float not null,
    flowIATMean float not null,
    flowIATStd float not null,
    packetLengthMean float not null,
    packetLengthStd float not null,
    packetLengthVariance float not null,
    averagePacketSize float not null,
    minPacketLength int not null,
    maxPacketLength int not null,
    downUpRatio float not null,
    activeMean float not null,
    activeStd float not null,
    activeMax int not null,
    activeMin int not null,
    idleMean float not null,
    idleStd float not null,
    idleMax int not null,
    idleMin int not null,

    primary key(flowID)
);

create table Flow (
    flowID int not null auto_increment,
    connectionID int not null,
    protocolID int not null,
    L7protocol int not null,
    label varchar(10),

    primary key(flowID),
    foreign key(flowID) references FlowStats(flowID),
    foreign key(connectionID) references Involves(connectionID),
    foreign key(protocolID) references Protocol(protocolID),
    foreign key(L7protocol) references WebService(L7protocol)
    
);

create table DirectionalFlagCounts (
    flowID int not null auto_increment,
    bwdPSHFlags int not null,
    bwdURGFlags int not null,
    fwdPSHFlags int not null,
    fwdURGFlags int not null,

    primary key(flowID),
    foreign key(flowID) references FlowStats(flowID)
);

create table TotalFlagCounts (
    flowID int not null auto_increment, 
    FINFlagCount int not null, 
    SYNFlagCount int not null, 
    RSTFlagCount int not null, 
    PSHFlagCount int not null, 
    ACKFlagCount int not null, 
    URGFlagCount int not null, 
    CWEFlagCount int not null, 
    ECEFlagCount int not null,

    primary key(flowID),
    foreign key(flowID) references FlowStats(flowID)
);

create table ForwardStats (
    flowID int not null auto_increment,
    totalFwdPackets int not null,
    totalLengthFwdPackets int not null,
    fwdPacketLengthMax int not null,
    fwdPacketLengthMin int not null,
    fwdIATTotal int not null,
    fwdIATMax int not null,
    fwdIATMin int not null,
    fwdHeaderLength int not null,
    fwdAvgBytesBulk float not null,
    fwdAvgPacketsBulk float not null,
    fwdAvgBulkRate float not null,
    subflowFwdPackets int not null,
    subflowFwdBytes int not null,
    fwdPacketLengthMean float not null,
    fwdPacketLengthStd float not null,
    fwdIATMean float not null,
    fwdIATStd float not null,
    fwdPackets_s float not null,
    avgFwdSegmentSize float not null,
    init_Win_bytes_forward int not null,
    act_data_pkt_fwd int not null,
    min_seg_size_forward int not null,

    primary key(flowID),
    foreign key(flowID) references FlowStats(flowID)
);

create table BackwardStats (
    flowID int not null auto_increment, 
    totalBackwardPackets int not null, 
    totalLengthBwdPackets int not null, 
    bwdPacketLengthMax int not null, 
    bwdPacketLengthMin int not null, 
    bwdIATTotal int not null, 
    bwdIATMax int not null, 
    bwdIATMin int not null, 
    bwdHeaderLength int not null, 
    bwdAvgBytesBulk float not null, 
    bwdAvgPacketsBulk float not null, 
    bwdAvgBulkRate float not null, 
    subflowBwdPackets int not null, 
    subflowBwdBytes int not null, 
    bwdPacketLengthMean float not null, 
    bwdPacketLengthStd float not null, 
    bwdIATMean float not null, 
    bwdIATStd float not null, 
    bwdPackets_s float not null, 
    avgBwdSegmentSize float not null, 
    init_Win_bytes_backward int not null,

    primary key(flowID),
    foreign key(flowID) references FlowStats(flowID)
);
