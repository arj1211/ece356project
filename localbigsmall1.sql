alter table backwardstats drop foreign key backwardstats_ibfk_1;
alter table directionalflagcounts drop foreign key directionalflagcounts_ibfk_1;
alter table flow drop foreign key flow_ibfk_1;
alter table flow drop foreign key flow_ibfk_2;
alter table flow drop foreign key flow_ibfk_3;
alter table flow drop foreign key flow_ibfk_4;
alter table forwardstats drop foreign key forwardstats_ibfk_1;
alter table totalflagcounts drop foreign key totalflagcounts_ibfk_1;
alter table involves drop foreign key involves_ibfk_1;
alter table involves drop foreign key involves_ibfk_2;

DROP TABLE IF EXISTS Host;
DROP TABLE IF EXISTS Involves;
DROP TABLE IF EXISTS WebService;
DROP TABLE IF EXISTS Protocol;
DROP TABLE IF EXISTS FlowStats;
DROP TABLE IF EXISTS Flow;
DROP TABLE IF EXISTS DirectionalFlagCounts;
DROP TABLE IF EXISTS TotalFlagCounts;
DROP TABLE IF EXISTS ForwardStats;
DROP TABLE IF EXISTS BackwardStats;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

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

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

SET GLOBAL local_infile=1;

SET GLOBAL innodb_buffer_pool_size=402653184;

delete from Host where 1=1;
ALTER TABLE Host ADD UNIQUE unique_index(IPAddress, portNumber);
ALTER TABLE Host AUTO_INCREMENT=1;

delete from Involves where 1=1;
ALTER TABLE Involves ADD UNIQUE unique_index(sourceID, destinationID);
ALTER TABLE Involves AUTO_INCREMENT=1;

delete from WebService where 1=1;

delete from Protocol where 1=1;
ALTER TABLE Protocol AUTO_INCREMENT=1;

delete from FlowStats where 1=1;
ALTER TABLE FlowStats AUTO_INCREMENT=1;

delete from Flow where 1=1;
ALTER TABLE Flow AUTO_INCREMENT=1;

delete from DirectionalFlagCounts where 1=1;
ALTER TABLE DirectionalFlagCounts AUTO_INCREMENT=1;

delete from TotalFlagCounts where 1=1;
ALTER TABLE TotalFlagCounts AUTO_INCREMENT=1;

delete from ForwardStats where 1=1;
ALTER TABLE ForwardStats AUTO_INCREMENT=1;

delete from BackwardStats where 1=1;
ALTER TABLE BackwardStats AUTO_INCREMENT=1;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table Host 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    IPAddress,
    portNumber,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table Host 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    IPAddress,
    portNumber,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table Involves 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @S_IP,
    @S_Port,
    @D_IP,
    @D_Port,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
)
set 
    sourceID = (select hostID from Host where IPAddress = @S_IP and portNumber = @S_Port),
    destinationID = (select hostID from Host where IPAddress = @D_IP and portNumber = @D_Port);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table WebService 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    L7Protocol,
    L7protocolName
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table Protocol 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    protocolID,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
)
set protocolName = (select 'TCP');

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table FlowStats 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @TIMEVAR_timestamp,
    flowDuration,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    flowBytesS,
    flowPacketsS,
    flowIATMean,
    flowIATStd,
    flowIATMax,
    flowIATMin,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    minPacketLength,
    maxPacketLength,
    packetLengthMean,
    packetLengthStd,
    packetLengthVariance,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    downUpRatio,
    averagePacketSize,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    activeMean,
    activeStd,
    activeMax,
    activeMin,
    idleMean,
    idleStd,
    idleMax,
    idleMin,
    @dummy,
    @dummy,
    @dummy
)
set timestamp = STR_TO_DATE(@TIMEVAR_timestamp, "%d/%m/%Y%T");

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table Flow 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @S_IP,
    @S_Port,
    @D_IP,
    @D_Port,
    protocolID,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    label,
    L7Protocol,
    @dummy
)

set 
    connectionID = (
        select connectionID from Involves 
        where sourceID = (
            select hostID from Host 
            where IPAddress=@S_IP 
            and portNumber=@S_Port
        ) 
        and destinationID = (
            select hostID from Host 
            where IPAddress=@D_IP 
            and portNumber=@D_Port
        )
    )
;

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table DirectionalFlagCounts 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    fwdPSHFlags,
    bwdPSHFlags,
    fwdURGFlags,
    bwdURGFlags,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table TotalFlagCounts 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    FINFlagCount,
    SYNFlagCount,
    RSTFlagCount,
    PSHFlagCount,
    ACKFlagCount,
    URGFlagCount,
    CWEFlagCount,
    ECEFlagCount,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table ForwardStats 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    totalFwdPackets,
    @dummy,
    totalLengthFwdPackets,
    @dummy,
    fwdPacketLengthMax,
    fwdPacketLengthMin,
    fwdPacketLengthMean,
    fwdPacketLengthStd,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    fwdIATTotal,
    fwdIATMean,
    fwdIATStd,
    fwdIATMax,
    fwdIATMin,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    fwdHeaderLength,
    @dummy,
    fwdPackets_s,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    avgFwdSegmentSize,
    @dummy,
    @dummy,
    fwdAvgBytesBulk,
    fwdAvgPacketsBulk,
    fwdAvgBulkRate,
    @dummy,
    @dummy,
    @dummy,
    subflowFwdPackets,
    subflowFwdBytes,
    @dummy,
    @dummy,
    init_Win_bytes_forward,
    @dummy,
    act_data_pkt_fwd,
    min_seg_size_forward,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

LOAD DATA LOCAL INFILE
"C:/1. Main Work/6.Term_3B/ECE356/Project/archive/Dataset-Unicauca-Version2-87Atts.csv"
ignore into table BackwardStats 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 3576297 LINES (
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    totalBackwardPackets,
    @dummy,
    totalLengthBwdPackets,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    bwdPacketLengthMax,
    bwdPacketLengthMin,
    bwdPacketLengthMean,
    bwdPacketLengthStd,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    bwdIATTotal,
    bwdIATMean,
    bwdIATStd,
    bwdIATMax,
    bwdIATMin,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    bwdHeaderLength,
    @dummy,
    bwdPackets_s,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    avgBwdSegmentSize,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    bwdAvgBytesBulk,
    bwdAvgPacketsBulk,
    bwdAvgBulkRate,
    @dummy,
    @dummy,
    subflowBwdPackets,
    subflowBwdBytes,
    @dummy,
    init_Win_bytes_backward,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy
);

-- ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~