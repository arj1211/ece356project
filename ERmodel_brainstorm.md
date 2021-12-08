# Entities

## Notes
- using ISCX data combined (~2M records)
- *Forward* and *Backward* are specializations of *Packet*

## Todo
- primary keys for each entity
- foreign keys for each entity
- discriminators
- relations and cardinalities

---

### Flow

- <u>Timestamp
- Flow ID</u>
  - Source IP
  - Source Port
  - Destination IP
  - Destination Port
- Protocol
- Flow Bytes/s
- Flow Duration
- Flow IAT Max
- Flow IAT Mean
- Flow IAT Min
- Flow IAT Std
- Flow Packets/s
<!-- - Subflow Fwd Packets
- Subflow Bwd Bytes
- Subflow Bwd Packets
- Subflow Fwd Bytes -->

---

### ForwardFlows
- Flow ID
- Fwd ID
- Fwd Avg Bytes/Bulk
- Fwd IAT Total
- Fwd Packets/s
- Fwd PSH Flags
- act_data_pkt_fwd
- Avg Fwd Segment Size
- Fwd Avg Bulk Rate
- Fwd Avg Packets/Bulk
- Fwd Header Length
- Fwd Header Length.1
- Fwd IAT Max
- Fwd IAT Mean
- Fwd IAT Min
- Fwd IAT Std
- Fwd Packet Length Max
- Fwd Packet Length Mean
- Fwd Packet Length Min
- Fwd Packet Length Std
- Fwd URG Flags
- Total Fwd Packets
- Total Length of Fwd Packets
- Init_Win_bytes_forward
- min_seg_size_forward

---

### BackwardFlows
- Bwd Avg Bulk Rate
- Bwd IAT Total
- Avg Bwd Segment Size
- Bwd Avg Bytes/Bulk
- Bwd Avg Packets/Bulk
- Bwd Header Length
- Bwd IAT Max
- Bwd IAT Mean
- Bwd IAT Min
- Bwd IAT Std
- Bwd Packet Length Max
- Bwd Packet Length Mean
- Bwd Packet Length Min
- Bwd Packet Length Std
- Bwd Packets/s
- Bwd PSH Flags
- Bwd URG Flags
- Total Length of Bwd Packets
- Init_Win_bytes_backward
- Total Backward Packets

---

### Flags
- ACK Flag Count
- CWE Flag Count
- ECE Flag Count
- FIN Flag Count
- PSH Flag Count
- RST Flag Count
- SYN Flag Count
- URG Flag Count

---

### Activity
- Active Mean
- Active Max
- Active Min
- Active Std
- Idle Mean
- Idle Max
- Idle Min
- Idle Std
- Down/Up Ratio

---

### Packets
- Average Packet Size
- Max Packet Length
- Min Packet Length
- Packet Length Mean
- Packet Length Std
- Packet Length Variance

---

### Security
- Label
