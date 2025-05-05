`timescale 1ns/1ps

module asROM (
    input  [7:0] addr1, addr2,  // 2 địa chỉ truy xuất (2 byte song song)
    output reg [7:0] data1, data2 // đầu ra 2 byte sau khi tra cứu S-box
);

    always @(*) begin
        // -------------------
        // Tra cứu S-box cho addr1
        // -------------------
        case (addr1)
            8'h00: data1 = 8'h63;  8'h01: data1 = 8'h7c;  8'h02: data1 = 8'h77;  8'h03: data1 = 8'h7b;
            8'h04: data1 = 8'hf2;  8'h05: data1 = 8'h6b;  8'h06: data1 = 8'h6f;  8'h07: data1 = 8'hc5;
            8'h08: data1 = 8'h30;  8'h09: data1 = 8'h01;  8'h0a: data1 = 8'h67;  8'h0b: data1 = 8'h2b;
            8'h0c: data1 = 8'hfe;  8'h0d: data1 = 8'hd7;  8'h0e: data1 = 8'hab;  8'h0f: data1 = 8'h76;
            8'h10: data1 = 8'hca;  8'h11: data1 = 8'h82;  8'h12: data1 = 8'hc9;  8'h13: data1 = 8'h7d;
            8'h14: data1 = 8'hfa;  8'h15: data1 = 8'h59;  8'h16: data1 = 8'h47;  8'h17: data1 = 8'hf0;
            8'h18: data1 = 8'had;  8'h19: data1 = 8'hd4;  8'h1a: data1 = 8'ha2;  8'h1b: data1 = 8'haf;
            8'h1c: data1 = 8'h9c;  8'h1d: data1 = 8'ha4;  8'h1e: data1 = 8'h72;  8'h1f: data1 = 8'hc0;
            8'h20: data1 = 8'hb7;  8'h21: data1 = 8'hfd;  8'h22: data1 = 8'h93;  8'h23: data1 = 8'h26;
            8'h24: data1 = 8'h36;  8'h25: data1 = 8'h3f;  8'h26: data1 = 8'hf7;  8'h27: data1 = 8'hcc;
            8'h28: data1 = 8'h34;  8'h29: data1 = 8'ha5;  8'h2a: data1 = 8'he5;  8'h2b: data1 = 8'hf1;
            8'h2c: data1 = 8'h71;  8'h2d: data1 = 8'hd8;  8'h2e: data1 = 8'h31;  8'h2f: data1 = 8'h15;
            8'h30: data1 = 8'h04;  8'h31: data1 = 8'hc7;  8'h32: data1 = 8'h23;  8'h33: data1 = 8'hc3;
            8'h34: data1 = 8'h18;  8'h35: data1 = 8'h96;  8'h36: data1 = 8'h05;  8'h37: data1 = 8'h9a;
            8'h38: data1 = 8'h07;  8'h39: data1 = 8'h12;  8'h3a: data1 = 8'h80;  8'h3b: data1 = 8'he2;
            8'h3c: data1 = 8'heb;  8'h3d: data1 = 8'h27;  8'h3e: data1 = 8'hb2;  8'h3f: data1 = 8'h75;
            8'h40: data1 = 8'h09;  8'h41: data1 = 8'h83;  8'h42: data1 = 8'h2c;  8'h43: data1 = 8'h1a;
            8'h44: data1 = 8'h1b;  8'h45: data1 = 8'h6e;  8'h46: data1 = 8'h5a;  8'h47: data1 = 8'ha0;
            8'h48: data1 = 8'h52;  8'h49: data1 = 8'h3b;  8'h4a: data1 = 8'hd6;  8'h4b: data1 = 8'hb3;
            8'h4c: data1 = 8'h29;  8'h4d: data1 = 8'he3;  8'h4e: data1 = 8'h2f;  8'h4f: data1 = 8'h84;
            8'h50: data1 = 8'h53;  8'h51: data1 = 8'hd1;  8'h52: data1 = 8'h00;  8'h53: data1 = 8'hed;
            8'h54: data1 = 8'h20;  8'h55: data1 = 8'hfc;  8'h56: data1 = 8'hb1;  8'h57: data1 = 8'h5b;
            8'h58: data1 = 8'h6a;  8'h59: data1 = 8'hcb;  8'h5a: data1 = 8'hbe;  8'h5b: data1 = 8'h39;
            8'h5c: data1 = 8'h4a;  8'h5d: data1 = 8'h4c;  8'h5e: data1 = 8'h58;  8'h5f: data1 = 8'hcf;
            8'h60: data1 = 8'hd0;  8'h61: data1 = 8'hef;  8'h62: data1 = 8'haa;  8'h63: data1 = 8'hfb;
            8'h64: data1 = 8'h43;  8'h65: data1 = 8'h4d;  8'h66: data1 = 8'h33;  8'h67: data1 = 8'h85;
            8'h68: data1 = 8'h45;  8'h69: data1 = 8'hf9;  8'h6a: data1 = 8'h02;  8'h6b: data1 = 8'h7f;
            8'h6c: data1 = 8'h50;  8'h6d: data1 = 8'h3c;  8'h6e: data1 = 8'h9f;  8'h6f: data1 = 8'ha8;
            8'h70: data1 = 8'h51;  8'h71: data1 = 8'ha3;  8'h72: data1 = 8'h40;  8'h73: data1 = 8'h8f;
            8'h74: data1 = 8'h92;  8'h75: data1 = 8'h9d;  8'h76: data1 = 8'h38;  8'h77: data1 = 8'hf5;
            8'h78: data1 = 8'hbc;  8'h79: data1 = 8'hb6;  8'h7a: data1 = 8'hda;  8'h7b: data1 = 8'h21;
            8'h7c: data1 = 8'h10;  8'h7d: data1 = 8'hff;  8'h7e: data1 = 8'hf3;  8'h7f: data1 = 8'hd2;
            8'h80: data1 = 8'hcd;  8'h81: data1 = 8'h0c;  8'h82: data1 = 8'h13;  8'h83: data1 = 8'hec;
            8'h84: data1 = 8'h5f;  8'h85: data1 = 8'h97;  8'h86: data1 = 8'h44;  8'h87: data1 = 8'h17;
            8'h88: data1 = 8'hc4;  8'h89: data1 = 8'ha7;  8'h8a: data1 = 8'h7e;  8'h8b: data1 = 8'h3d;
            8'h8c: data1 = 8'h64;  8'h8d: data1 = 8'h5d;  8'h8e: data1 = 8'h19;  8'h8f: data1 = 8'h73;
            8'h90: data1 = 8'h60;  8'h91: data1 = 8'h81;  8'h92: data1 = 8'h4f;  8'h93: data1 = 8'hdc;
            8'h94: data1 = 8'h22;  8'h95: data1 = 8'h2a;  8'h96: data1 = 8'h90;  8'h97: data1 = 8'h88;
            8'h98: data1 = 8'h46;  8'h99: data1 = 8'hee;  8'h9a: data1 = 8'hb8;  8'h9b: data1 = 8'h14;
            8'h9c: data1 = 8'hde;  8'h9d: data1 = 8'h5e;  8'h9e: data1 = 8'h0b;  8'h9f: data1 = 8'hdb;
            8'ha0: data1 = 8'he0;  8'ha1: data1 = 8'h32;  8'ha2: data1 = 8'h3a;  8'ha3: data1 = 8'h0a;
            8'ha4: data1 = 8'h49;  8'ha5: data1 = 8'h06;  8'ha6: data1 = 8'h24;  8'ha7: data1 = 8'h5c;
            8'ha8: data1 = 8'hc2;  8'ha9: data1 = 8'hd3;  8'haa: data1 = 8'hac;  8'hab: data1 = 8'h62;
            8'hac: data1 = 8'h91;  8'had: data1 = 8'h95;  8'hae: data1 = 8'he4;  8'haf: data1 = 8'h79;
            8'hb0: data1 = 8'he7;  8'hb1: data1 = 8'hc8;  8'hb2: data1 = 8'h37;  8'hb3: data1 = 8'h6d;
            8'hb4: data1 = 8'h8d;  8'hb5: data1 = 8'hd5;  8'hb6: data1 = 8'h4e;  8'hb7: data1 = 8'ha9;
            8'hb8: data1 = 8'h6c;  8'hb9: data1 = 8'h56;  8'hba: data1 = 8'hf4;  8'hbb: data1 = 8'hea;
            8'hbc: data1 = 8'h65;  8'hbd: data1 = 8'h7a;  8'hbe: data1 = 8'hae;  8'hbf: data1 = 8'h08;
            8'hc0: data1 = 8'hba;  8'hc1: data1 = 8'h78;  8'hc2: data1 = 8'h25;  8'hc3: data1 = 8'h2e;
            8'hc4: data1 = 8'h1c;  8'hc5: data1 = 8'ha6;  8'hc6: data1 = 8'hb4;  8'hc7: data1 = 8'hc6;
            8'hc8: data1 = 8'he8;  8'hc9: data1 = 8'hdd;  8'hca: data1 = 8'h74;  8'hcb: data1 = 8'h1f;
            8'hcc: data1 = 8'h4b;  8'hcd: data1 = 8'hbd;  8'hce: data1 = 8'h8b;  8'hcf: data1 = 8'h8a;
            8'hd0: data1 = 8'h70;  8'hd1: data1 = 8'h3e;  8'hd2: data1 = 8'hb5;  8'hd3: data1 = 8'h66;
            8'hd4: data1 = 8'h48;  8'hd5: data1 = 8'h03;  8'hd6: data1 = 8'hf6;  8'hd7: data1 = 8'h0e;
            8'hd8: data1 = 8'h61;  8'hd9: data1 = 8'h35;  8'hda: data1 = 8'h57;  8'hdb: data1 = 8'hb9;
            8'hdc: data1 = 8'h86;  8'hdd: data1 = 8'hc1;  8'hde: data1 = 8'h1d;  8'hdf: data1 = 8'h9e;
            8'he0: data1 = 8'he1;  8'he1: data1 = 8'hf8;  8'he2: data1 = 8'h98;  8'he3: data1 = 8'h11;
            8'he4: data1 = 8'h69;  8'he5: data1 = 8'hd9;  8'he6: data1 = 8'h8e;  8'he7: data1 = 8'h94;
            8'he8: data1 = 8'h9b;  8'he9: data1 = 8'h1e;  8'hea: data1 = 8'h87;  8'heb: data1 = 8'he9;
            8'hec: data1 = 8'hce;  8'hed: data1 = 8'h55;  8'hee: data1 = 8'h28;  8'hef: data1 = 8'hdf;
            8'hf0: data1 = 8'h8c;  8'hf1: data1 = 8'ha1;  8'hf2: data1 = 8'h89;  8'hf3: data1 = 8'h0d;
            8'hf4: data1 = 8'hbf;  8'hf5: data1 = 8'he6;  8'hf6: data1 = 8'h42;  8'hf7: data1 = 8'h68;
            8'hf8: data1 = 8'h41;  8'hf9: data1 = 8'h99;  8'hfa: data1 = 8'h2d;  8'hfb: data1 = 8'h0f;
            8'hfc: data1 = 8'hb0;  8'hfd: data1 = 8'h54;  8'hfe: data1 = 8'hbb;  8'hff: data1 = 8'h16;
            default: data1 = 8'h00; // trường hợp chưa khai báo
        endcase

        // -------------------
        // Tra cứu S-box cho addr2
        // -------------------
        case (addr2)
            8'h00: data2 = 8'h63;  8'h01: data2 = 8'h7c;  8'h02: data2 = 8'h77;  8'h03: data2 = 8'h7b;
            8'h04: data2 = 8'hf2;  8'h05: data2 = 8'h6b;  8'h06: data2 = 8'h6f;  8'h07: data2 = 8'hc5;
            8'h08: data2 = 8'h30;  8'h09: data2 = 8'h01;  8'h0a: data2 = 8'h67;  8'h0b: data2 = 8'h2b;
            8'h0c: data2 = 8'hfe;  8'h0d: data2 = 8'hd7;  8'h0e: data2 = 8'hab;  8'h0f: data2 = 8'h76;
            8'h10: data2 = 8'hca;  8'h11: data2 = 8'h82;  8'h12: data2 = 8'hc9;  8'h13: data2 = 8'h7d;
            8'h14: data2 = 8'hfa;  8'h15: data2 = 8'h59;  8'h16: data2 = 8'h47;  8'h17: data2 = 8'hf0;
            8'h18: data2 = 8'had;  8'h19: data2 = 8'hd4;  8'h1a: data2 = 8'ha2;  8'h1b: data2 = 8'haf;
            8'h1c: data2 = 8'h9c;  8'h1d: data2 = 8'ha4;  8'h1e: data2 = 8'h72;  8'h1f: data2 = 8'hc0;
            8'h20: data2 = 8'hb7;  8'h21: data2 = 8'hfd;  8'h22: data2 = 8'h93;  8'h23: data2 = 8'h26;
            8'h24: data2 = 8'h36;  8'h25: data2 = 8'h3f;  8'h26: data2 = 8'hf7;  8'h27: data2 = 8'hcc;
            8'h28: data2 = 8'h34;  8'h29: data2 = 8'ha5;  8'h2a: data2 = 8'he5;  8'h2b: data2 = 8'hf1;
            8'h2c: data2 = 8'h71;  8'h2d: data2 = 8'hd8;  8'h2e: data2 = 8'h31;  8'h2f: data2 = 8'h15;
            8'h30: data2 = 8'h04;  8'h31: data2 = 8'hc7;  8'h32: data2 = 8'h23;  8'h33: data2 = 8'hc3;
            8'h34: data2 = 8'h18;  8'h35: data2 = 8'h96;  8'h36: data2 = 8'h05;  8'h37: data2 = 8'h9a;
            8'h38: data2 = 8'h07;  8'h39: data2 = 8'h12;  8'h3a: data2 = 8'h80;  8'h3b: data2 = 8'he2;
            8'h3c: data2 = 8'heb;  8'h3d: data2 = 8'h27;  8'h3e: data2 = 8'hb2;  8'h3f: data2 = 8'h75;
            8'h40: data2 = 8'h09;  8'h41: data2 = 8'h83;  8'h42: data2 = 8'h2c;  8'h43: data2 = 8'h1a;
            8'h44: data2 = 8'h1b;  8'h45: data2 = 8'h6e;  8'h46: data2 = 8'h5a;  8'h47: data2 = 8'ha0;
            8'h48: data2 = 8'h52;  8'h49: data2 = 8'h3b;  8'h4a: data2 = 8'hd6;  8'h4b: data2 = 8'hb3;
            8'h4c: data2 = 8'h29;  8'h4d: data2 = 8'he3;  8'h4e: data2 = 8'h2f;  8'h4f: data2 = 8'h84;
            8'h50: data2 = 8'h53;  8'h51: data2 = 8'hd1;  8'h52: data2 = 8'h00;  8'h53: data2 = 8'hed;
            8'h54: data2 = 8'h20;  8'h55: data2 = 8'hfc;  8'h56: data2 = 8'hb1;  8'h57: data2 = 8'h5b;
            8'h58: data2 = 8'h6a;  8'h59: data2 = 8'hcb;  8'h5a: data2 = 8'hbe;  8'h5b: data2 = 8'h39;
            8'h5c: data2 = 8'h4a;  8'h5d: data2 = 8'h4c;  8'h5e: data2 = 8'h58;  8'h5f: data2 = 8'hcf;
            8'h60: data2 = 8'hd0;  8'h61: data2 = 8'hef;  8'h62: data2 = 8'haa;  8'h63: data2 = 8'hfb;
            8'h64: data2 = 8'h43;  8'h65: data2 = 8'h4d;  8'h66: data2 = 8'h33;  8'h67: data2 = 8'h85;
            8'h68: data2 = 8'h45;  8'h69: data2 = 8'hf9;  8'h6a: data2 = 8'h02;  8'h6b: data2 = 8'h7f;
            8'h6c: data2 = 8'h50;  8'h6d: data2 = 8'h3c;  8'h6e: data2 = 8'h9f;  8'h6f: data2 = 8'ha8;
            8'h70: data2 = 8'h51;  8'h71: data2 = 8'ha3;  8'h72: data2 = 8'h40;  8'h73: data2 = 8'h8f;
            8'h74: data2 = 8'h92;  8'h75: data2 = 8'h9d;  8'h76: data2 = 8'h38;  8'h77: data2 = 8'hf5;
            8'h78: data2 = 8'hbc;  8'h79: data2 = 8'hb6;  8'h7a: data2 = 8'hda;  8'h7b: data2 = 8'h21;
            8'h7c: data2 = 8'h10;  8'h7d: data2 = 8'hff;  8'h7e: data2 = 8'hf3;  8'h7f: data2 = 8'hd2;
            8'h80: data2 = 8'hcd;  8'h81: data2 = 8'h0c;  8'h82: data2 = 8'h13;  8'h83: data2 = 8'hec;
            8'h84: data2 = 8'h5f;  8'h85: data2 = 8'h97;  8'h86: data2 = 8'h44;  8'h87: data2 = 8'h17;
            8'h88: data2 = 8'hc4;  8'h89: data2 = 8'ha7;  8'h8a: data2 = 8'h7e;  8'h8b: data2 = 8'h3d;
            8'h8c: data2 = 8'h64;  8'h8d: data2 = 8'h5d;  8'h8e: data2 = 8'h19;  8'h8f: data2 = 8'h73;
            8'h90: data2 = 8'h60;  8'h91: data2 = 8'h81;  8'h92: data2 = 8'h4f;  8'h93: data2 = 8'hdc;
            8'h94: data2 = 8'h22;  8'h95: data2 = 8'h2a;  8'h96: data2 = 8'h90;  8'h97: data2 = 8'h88;
            8'h98: data2 = 8'h46;  8'h99: data2 = 8'hee;  8'h9a: data2 = 8'hb8;  8'h9b: data2 = 8'h14;
            8'h9c: data2 = 8'hde;  8'h9d: data2 = 8'h5e;  8'h9e: data2 = 8'h0b;  8'h9f: data2 = 8'hdb;
            8'ha0: data2 = 8'he0;  8'ha1: data2 = 8'h32;  8'ha2: data2 = 8'h3a;  8'ha3: data2 = 8'h0a;
            8'ha4: data2 = 8'h49;  8'ha5: data2 = 8'h06;  8'ha6: data2 = 8'h24;  8'ha7: data2 = 8'h5c;
            8'ha8: data2 = 8'hc2;  8'ha9: data2 = 8'hd3;  8'haa: data2 = 8'hac;  8'hab: data2 = 8'h62;
            8'hac: data2 = 8'h91;  8'had: data2 = 8'h95;  8'hae: data2 = 8'he4;  8'haf: data2 = 8'h79;
            8'hb0: data2 = 8'he7;  8'hb1: data2 = 8'hc8;  8'hb2: data2 = 8'h37;  8'hb3: data2 = 8'h6d;
            8'hb4: data2 = 8'h8d;  8'hb5: data2 = 8'hd5;  8'hb6: data2 = 8'h4e;  8'hb7: data2 = 8'ha9;
            8'hb8: data2 = 8'h6c;  8'hb9: data2 = 8'h56;  8'hba: data2 = 8'hf4;  8'hbb: data2 = 8'hea;
            8'hbc: data2 = 8'h65;  8'hbd: data2 = 8'h7a;  8'hbe: data2 = 8'hae;  8'hbf: data2 = 8'h08;
            8'hc0: data2 = 8'hba;  8'hc1: data2 = 8'h78;  8'hc2: data2 = 8'h25;  8'hc3: data2 = 8'h2e;
            8'hc4: data2 = 8'h1c;  8'hc5: data2 = 8'ha6;  8'hc6: data2 = 8'hb4;  8'hc7: data2 = 8'hc6;
            8'hc8: data2 = 8'he8;  8'hc9: data2 = 8'hdd;  8'hca: data2 = 8'h74;  8'hcb: data2 = 8'h1f;
            8'hcc: data2 = 8'h4b;  8'hcd: data2 = 8'hbd;  8'hce: data2 = 8'h8b;  8'hcf: data2 = 8'h8a;
            8'hd0: data2 = 8'h70;  8'hd1: data2 = 8'h3e;  8'hd2: data2 = 8'hb5;  8'hd3: data2 = 8'h66;
            8'hd4: data2 = 8'h48;  8'hd5: data2 = 8'h03;  8'hd6: data2 = 8'hf6;  8'hd7: data2 = 8'h0e;
            8'hd8: data2 = 8'h61;  8'hd9: data2 = 8'h35;  8'hda: data2 = 8'h57;  8'hdb: data2 = 8'hb9;
            8'hdc: data2 = 8'h86;  8'hdd: data2 = 8'hc1;  8'hde: data2 = 8'h1d;  8'hdf: data2 = 8'h9e;
            8'he0: data2 = 8'he1;  8'he1: data2 = 8'hf8;  8'he2: data2 = 8'h98;  8'he3: data2 = 8'h11;
            8'he4: data2 = 8'h69;  8'he5: data2 = 8'hd9;  8'he6: data2 = 8'h8e;  8'he7: data2 = 8'h94;
            8'he8: data2 = 8'h9b;  8'he9: data2 = 8'h1e;  8'hea: data2 = 8'h87;  8'heb: data2 = 8'he9;
            8'hec: data2 = 8'hce;  8'hed: data2 = 8'h55;  8'hee: data2 = 8'h28;  8'hef: data2 = 8'hdf;
            8'hf0: data2 = 8'h8c;  8'hf1: data2 = 8'ha1;  8'hf2: data2 = 8'h89;  8'hf3: data2 = 8'h0d;
            8'hf4: data2 = 8'hbf;  8'hf5: data2 = 8'he6;  8'hf6: data2 = 8'h42;  8'hf7: data2 = 8'h68;
            8'hf8: data2 = 8'h41;  8'hf9: data2 = 8'h99;  8'hfa: data2 = 8'h2d;  8'hfb: data2 = 8'h0f;
            8'hfc: data2 = 8'hb0;  8'hfd: data2 = 8'h54;  8'hfe: data2 = 8'hbb;  8'hff: data2 = 8'h16;
            default: data2 = 8'h00; // trường hợp chưa khai báo
        endcase
    end

endmodule
