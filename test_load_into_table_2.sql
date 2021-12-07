create table TestTableNetwork (
    source_ip varchar(255),
    source_port int,
    destination_ip varchar(255),
    destination_port int,
    protocol int
);

LOAD DATA INFILE
'/var/lib/mysql-files/21-Network-Traffic/Unicauca-dataset-April-June-2019-Network-flows.csv'
into table TestTableNetwork 
FIELDS TERMINATED BY ','
LINES TERMINATED BY '\n'
IGNORE 2704000 LINES (
    @dummy,
    @dummy,
    source_ip,
    source_port,
    destination_ip,
    destination_port,
    protocol,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
    @dummy,
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