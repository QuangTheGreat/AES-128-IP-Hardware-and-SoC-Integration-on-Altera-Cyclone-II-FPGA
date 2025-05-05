# AES-128-IP-Hardware-and-SoC-Integration-on-Altera-Cyclone-II-FPGA
Digital System Design Course Project  
Authors:  
Doan Dang Quang  
Gian Thanh Sang

This project delivers an RTL implementation of an area-efficient AES-128 encryption based on proposed architecture [1] and integrates it via an Avalon-MM wrapper into a NIOS II SoC on the Altera Cyclone II DE2 FPGA. The design was verified with ModelSim and synthesized in Quartus II.

## SoC Integration

The AES-128 hardware core was wrapped with a memory-mapped Avalon-MM interface to support communication with the NIOS II processor. The IP was integrated into a complete SoC system using Qsys, enabling processor-to-accelerator interaction via control and status registers. A C program was developed on the NIOS II Eclipse IDE to handle key management, data transfer, and encryption control. The full system was deployed and tested on the DE2 FPGA board.

## Reference

[1] A. Brokalakis, H. Michail, A. Kakarountas, E. Fotopoulou, A. Milidonis, G. Theodoridis, and C. Goutis, “A high-speed and area efficient hardware implementation of AES-128 encryption standard,” in *Proc. 5th WSEAS Int. Conf. on Multimedia, Internet and Video Technologies*, Corfu, Greece, Aug. 2005, pp. 125–129.
