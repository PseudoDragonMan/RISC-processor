library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_unsigned.all;
use ieee.numeric_std.all;

entity CPU is 

   port(
	     clk,rst:in std_logic;
		  i1,i2,i3,i4,alu3at,alu3bt,i5,i6,dd1,dd2,dd3,i_1,ddin, alu3op,pc, r0,r1,r2,r3,r4,r5,r6,r7:out std_logic_vector(15 downto 0)	;	 
ifw1,stall: out std_logic;
	c: out std_logic_vector(0 downto 0)	;	 


selalu: out std_logic_vector(2 downto 0));
				
end entity;

architecture bhv of CPU is

component ALU1 is 
port (
      A: in std_logic_vector(15 downto 0);--PC here
		en:in std_logic;--Enable signal
		Y: out std_logic_vector(15 downto 0)); 
end component ALU1;

component inst_memory is
port(	mem_read:in std_logic;
		mem_A:in std_logic_vector(15 downto 0);
		mem_O: out std_logic_vector(15 downto 0));
end component inst_memory;

component pipeline is
	port(
    pipeout: out std_logic_vector(15 downto 0);
    pipein: in  std_logic_vector(15 downto 0);
    pipe_write,clk,rst: in  std_logic);
end component pipeline;

component rf is
    port (
        multi, rf_write, rf_read,pcwr: in std_logic;
        imm: in std_logic_vector(7 downto 0);
        rf_in0, rf_in1, rf_in2, rf_in3, rf_in4, pcin, rf_in5, rf_in6, rf_in7, rin: in std_logic_vector(15 downto 0);
        ra1, ra2,rain: in std_logic_vector(2 downto 0);
        rdata1, rdata2: out std_logic_vector(15 downto 0);
        rf_out0, rf_out1, rf_out2, rf_out3, rf_out4, rf_out5, rf_out6, rf_out7,pcout: out std_logic_vector(15 downto 0);
        clk, rst: in std_logic
		  
    );
end component rf;

component control1 is 

  port(rst:in std_logic;
		ir_write,pc_write,alu_en,pc_pipe,pc1_pipe:out std_logic);
			
end component;

component control2 is 
    port(
        rst: in std_logic;
        ir1: in std_logic_vector(15 downto 0);
        ir2_write, pc_pipe, pc1_pipe, pc_rst, pc1_rst: out std_logic
    );
end component;

    component control3
        port(
            rst,clk: in std_logic;
            ir2: in std_logic_vector(15 downto 0);
            rf_read, pr_write, pc_pipe, pc_rst, pc1_rst, pc1_pipe, p1_write, p2_write, ir3_write, multi, p7_write, p7_rst: out std_logic;
            ra, rb: out std_logic_vector(2 downto 0)
        );
    end component;

component ddblock is 
    port(
        rst,clk: in std_logic;
        ir2, ir3, ir4, ir5, rf1, rf2, pc13, pc14, pc15, s4, s5, mem_o, s6, ir2imm6, ir2imm9,p6: in std_logic_vector(15 downto 0);
        p1, p2, p7: out std_logic_vector(15 downto 0);
        ctrl1_stall, ctrl2_stall, ctrl3_stall, nop4: out std_logic
    );
end component;

component data_memory is
    port (
        multi, mem_write, mem_read: in std_logic;
        imm: in std_logic_vector(7 downto 0);
        multi_in0,multi_in1,multi_in2,multi_in3,multi_in4,multi_in5,multi_in6,multi_in7: in std_logic_vector(15 downto 0);
        mem_A: in std_logic_vector(15 downto 0);
        mem_I: in std_logic_vector(15 downto 0);
        mem_O: out std_logic_vector(15 downto 0);
        multi_out0,multi_out1,multi_out2,multi_out3,multi_out4,multi_out5,multi_out6,multi_out7: out std_logic_vector(15 downto 0);
        clk, rst: in std_logic
    );
end component;

component nop is 
      port(Clk,Rst,C_Curr,Z_curr,nop4: in std_logic;
		     ir3_in, ir2_in, ir1_in: in std_logic_vector(15 downto 0);			  
			  ir1_out,ir2_out,ir3_out: out std_logic_vector(15 downto 0)
			 );  
end component nop;


component ALU3 is 
    port (A,B: in std_logic_vector(15 downto 0);
	 C: in std_logic_vector(0 downto 0);
	 en:in std_logic;
	 sel: in std_logic_vector(2 downto 0);
	 C_flag: out std_logic;
	 Z_flag: out std_logic;
	 Y: out std_logic_vector(15 downto 0));
end component ALU3;


component Register_1bit is
    port (
        clk, reset : in std_logic;
        din,wrt : in std_logic;
        dout : out std_logic
    );
end component Register_1bit;


component SignExtended9 is
	port (inp : IN STD_LOGIC_VECTOR(8 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end component SignExtended9;

component SignExtended6 is
	port (inp : IN STD_LOGIC_VECTOR(5 downto 0);

				op : OUT STD_LOGIC_VECTOR(15 downto 0));
end component SignExtended6;

component control6 is 
    port(
	     clk: in std_logic;
        rst: in std_logic;
        ir5: in std_logic_vector(15 downto 0);
		  pc1_i:in std_logic_vector(15 downto 0);
		  C_prev,Z_prev:in std_logic;
        rf_wr,multi,mux_p56_en: out std_logic;
		  --the mux has 3 input lines p5,p6 and pc1_i pipeline register
		  --00->p5 01-->p6 10-->pc1_i
		  mux_p56_sel: out std_logic_vector(1 downto 0);
		  pipeline8_en:out std_logic;
		  rc: out std_logic_vector(2 downto 0);
	     rc_out:out std_logic_vector(7 downto 0) --for multiple case	  
    );
end component control6;

component pc_sel_blk is 
    port(rst,clk,stall:in std_logic;
	      ALU2_out,ALU3_out:in std_logic_vector(15 downto 0);
			P7:in std_logic_vector(15 downto 0);  
			PC_3,ir3:in std_logic_vector(15 downto 0);
			C_curr,Z_curr:in std_logic;
			PC1_3:IN std_logic_vector(15 downto 0); --gives PC+1
			PC_new:out std_logic_vector(15 downto 0)
			);
end component pc_sel_blk;

component c4 is 
    port(
        rst: in std_logic;
        ir3: in std_logic_vector(15 downto 0);
		  C_prev,Z_prev: in std_logic;
        ir4_wr,P3_wr,P4_wr,en_ALU2,en_ALU3,C_wr,Z_wr,P8_wr,pc1_wr: out std_logic;--pc1_wr only in JAL,JLR,
		  SEL_ALU3: out std_logic_vector(2 downto 0);
		  pipeline_wr,sign_mux: out std_logic
		 
    );
end component;

component control5 is 
    port(
        rst, clk: in std_logic;
        ir4: in std_logic_vector(15 downto 0);
        mem_read, mem_write, mema_sel, pm_write, pc1_pipe, p5_write, p6_write, ir5_write, multi, p5_rst, p6_rst: out std_logic
      );
end component control5;


component  MUX2x1 is
   port(
      S0: in std_logic;
      X0, X1: in std_logic_vector(15 downto 0);
      Y: out std_logic_vector(15 downto 0);
      mux_en: in std_logic
   );
end component MUX2x1;

component MUX3x1 is
   port(
      S: in std_logic_vector(1 downto 0);
      X0, X1, X2: in std_logic_vector(15 downto 0);
      Y: out std_logic_vector(15 downto 0);
      mux_en: in std_logic
   );
end component MUX3x1;

component pipe8 is
    port(
        pipeout0,pipeout1,pipeout2,pipeout3,pipeout4,pipeout5,pipeout6,pipeout7: out std_logic_vector(15 downto 0);
        pipein0,pipein1,pipein2,pipein3,pipein4,pipein5,pipein6,pipein7: in std_logic_vector(15 downto 0);
        pipe_write, clk, rst: in std_logic
    );
end component pipe8;

component ALU2 is 
port (
      A,IMM: in std_logic_vector(15 downto 0);--PC here
		en:in std_logic;--Enable signal
		Y: out std_logic_vector(15 downto 0)); 
end component ALU2;






type arr is array (0 to 7) of std_logic_vector(15 downto 0);


signal memi_read,  memi_o, multirf, rf_write, rf_read, pcwr, pc_rst, pc1_rst, alu1en, pcp2w, pc1p2w : std_logic;
signal ir5_o, ir1_o, ir2_o, ir3_o, ir4_o, ir5_i, ir1_i, ir2_i, ir3_i, ir4_i, pc1 : std_logic_vector(15 downto 0);
--signal pm0, pm1, pm2, pm3, pm4, pm5, pm6, pm7, pr0, pr1, pr2, pr6, pr7, pcbo : std_logic_vector(15 downto 0);
signal mux6_o, rf1, rf2, nopi1, nopi2, nopi3, nopi4, nopo1, nopi5, nopi6 : std_logic_vector(15 downto 0);
signal ra, rb : std_logic_vector(2 downto 0);
signal pcp1o, pc1p1o, pcp2o, pc1p2o, pcp3o, pc1p3o, pcp4o, pc1p4o, pcp5o, pc1p5o : std_logic_vector(15 downto 0);
signal pr3o, pr4o, pm5o : arr;
signal ir2imm9, ir2imm6, ir3imm9, ir3imm6 : std_logic_vector(15 downto 0);
signal cin, zin, cf1, zf1, cf2, zf2 : std_logic;
signal alu3_en, imux, muxc5sel,  muxc6en,  p5_write, p6_write, p8_write, ei8en : std_logic;
signal ir4_write, p3_write, p4_write, p7_write, p7_rst, ir1_in, ir2_in, ir3_in, ir1_out, ir2_out, ir3_out : std_logic;
signal nop4, ctrl1_stall, ctrl2_stall, ctrl3_stall, pr_write, pr4_write : std_logic;
signal pr3, pr4, pm5 : arr;
signal pc1p4w : std_logic;
signal pc1p4 : std_logic;
signal pc1p5 : std_logic_vector(15 downto 0);
signal ir5in : std_logic_vector(15 downto 0);
signal ir5_write : std_logic;
signal mem_o : std_logic_vector(15 downto 0);
signal alu2en : std_logic;

signal mem_write : std_logic;
signal mem_read : std_logic;
signal ir4 : std_logic_vector(15 downto 0);
signal multim : std_logic;

signal ir5,memi_a,nopo2,nopo3,alu3a,ddbo1,alu3b,ddbo2,ddbo3,p8in,ir2,pcbo,p6o : std_logic_vector(15 downto 0);
signal rc_out : std_logic_vector(7 downto 0);
signal rc:std_logic_vector(2 downto 0);
signal ir1w,pcpw,pcp1w,pc1pw,ir2w,pcp3w,pc1p3w,p1_write,p2_write,ir3_write,multir,pc_rst3,pc1_rst3,pm4w:std_logic;
signal pc13o,pc14o,pc15o,alu3o,p4o,p5,ir3,ir3imm,alu2o,p5in,mux5in2,mux6in1, mux6in2, mux6in3,mux5in1,p6,mux5o: std_logic_vector(15 downto 0);
signal cout,zout,alu3en,cwr,zwr,p5_rst,p6_rst:std_logic;
signal selc4:std_logic_vector(2 downto 0);
signal cout_vec:std_logic_vector(0 downto 0);
signal selc6:std_logic_vector(1 downto 0);

begin
process(cout)
 begin 
  cout_vec(0)<=cout;
  end process;
--stage 1


--xxxxxxxxx
reg_f: rf port map(multi => multirf, rf_write => rf_write, rf_read=>rf_read,pcwr => pcwr,
        imm => rc_out,
        rf_in0 =>pm5o(0), rf_in1=>pm5o(1), rf_in2=>pm5o(2), rf_in3=>pm5o(3), rf_in4=>pm5o(4), pcin=>pcbo, rf_in5=>pm5o(5), rf_in6=>pm5o(6), rf_in7=>pm5o(7), rin=>mux6_o,
        ra1=>ra, ra2=>rb,rain=>rc,
        rdata1=>rf1, rdata2=>rf2,
       rf_out0=>pr3(0), rf_out1=>pr3(1), rf_out2=>pr3(2), rf_out3=>pr3(3), rf_out4=>pr3(4), rf_out5=>pr3(5), rf_out6=>pr3(6), rf_out7=>pr3(7),
		 pcout => memi_a,
        clk=>clk, rst=>rst);

inst_mem: inst_memory port map(mem_read=>'1',mem_A=>memi_a,mem_O=>nopi1);

ir1: pipeline port map(pipeout => nopi2,pipein=>nopo1,pipe_write=>ir1w,clk=>clk,rst=>rst);

cb1: control1 port map(rst => ctrl1_stall,ir_write=>ir1w,pc_write=>pcwr,alu_en=>alu1en,pc_pipe=>pcpw,pc1_pipe=>pcp1w);

alu_1: alu1 port map(A=>memi_a,en=>alu1en,Y=>pc1);

pcp1: pipeline port map(pipeout => pcp1o,pipein=>memi_a,pipe_write=>pcpw,clk=>clk,rst=>rst);

pc1p1: pipeline port map(pipeout => pc1p1o,pipein=>pc1,pipe_write=>pcp1w,clk=>clk,rst=>rst);

Qir2: pipeline port map(pipeout => nopi3,pipein=>nopo2,pipe_write=>ir1w,clk=>clk,rst=>rst);

pcp2: pipeline port map(pipeout => pcp2o,pipein=>pcp1o,pipe_write=>pcp2w,clk=>clk,rst=>rst);

pc1p2: pipeline port map(pipeout =>pc1p2o ,pipein=>pc1p1o,pipe_write=>pc1p2w,clk=>clk,rst=>rst);

cb2: control2 port map(rst => ctrl2_stall,ir1 => nopi2,ir2_write=>ir2w, pc_pipe=>pcp2w, pc1_pipe=>pc1p2w, pc_rst=>pc_rst, pc1_rst=>pc1_rst);--pc_rst,pc1_rst is a lose signal

cb3: control3 port map(rst=>ctrl3_stall,clk=>clk,ir2=>nopi3,rf_read=>rf_Read,pr_write=>pr_write,pc_pipe=>pcp3w, pc1_pipe=>pc1p3w, 
p1_write=>p1_write,p2_write=>p2_write,ir3_write=>ir3_write,multi=>multir,p7_write=>p7_write,p7_rst=>p7_rst,ra=>ra, rb=>rb,
             pc_rst=>pc_rst3, pc1_rst=>pc1_rst3); --multir,p7_rst,pc_rst3,pc1_rst3 is a lone signal connected to nothing        

pr3m: pipe8 port map(pipeout0=>pr3o(0),pipeout1=>pr3o(1),pipeout2=>pr3o(2),pipeout3=>pr3o(3),pipeout4=>pr3o(4),
pipeout5=>pr3o(5),pipeout6=>pr3o(6),pipeout7=>pr3o(7),
pipein0=>pr3(0),pipein1=>pr3(1),pipein2=>pr3(2),pipein3=>pr3(3),pipein4=>pr3(4),
pipein5=>pr3(5),pipein6=>pr3(6),pipein7=>pr3(7),
        pipe_write=>pr_write, clk=>clk, rst=>rst);
		  
pr4m: pipe8 port map(pipeout0 => pr4o(0), pipeout1 => pr4o(1), pipeout2 => pr4o(2), pipeout3 => pr4o(3), 
pipeout4 => pr4o(4), pipeout5 => pr4o(5), pipeout6 => pr4o(6), pipeout7 => pr4o(7), 
pipein0 => pr3o(0), pipein1 => pr3o(1), pipein2 => pr3o(2), pipein3 => pr3o(3), 
pipein4 => pr3o(4), pipein5 => pr3o(5), pipein6 => pr3o(6), pipein7 => pr3o(7), 
pipe_write => pr4_write, clk => clk, rst => rst);


pm5m: pipe8 port map(pipeout0 => pm5o(0), pipeout1 => pm5o(1), 
pipeout2 => pm5o(2), pipeout3 => pm5o(3), pipeout4 => pm5o(4), pipeout5 => pm5o(5), 
pipeout6 => pm5o(6), pipeout7 => pm5o(7), pipein0 => pm5(0), pipein1 => pm5(1), 
pipein2 => pm5(2), pipein3 => pm5(3), pipein4 => pm5(4), pipein5 => pm5(5), 
pipein6 => pm5(6), pipein7 => pm5(7), pipe_write => pm4w, clk => clk, rst => rst);

pcp3: pipeline port map(pipeout => pcp3o,pipein=>pcp2o,pipe_write=>pcp3w,clk=>clk,rst=>rst);

pc1p3: pipeline port map(pipeout => pc1p3o,pipein=>pc1p2o,pipe_write=>pc1p3w,clk=>clk,rst=>rst);

Qir3: pipeline port map(pipeout => nopi4,pipein=>nopo3,pipe_write=>ir3_write,clk=>clk,rst=>rst);

p1: pipeline port map(pipeout => alu3a,pipein=>ddbo1,pipe_write=>p1_write,clk=>clk,rst=>rst);

p2: pipeline port map(pipeout => alu3b,pipein=>ddbo2,pipe_write=>p2_write,clk=>clk,rst=>rst);

p7: pipeline port map(pipeout => p8in,pipein=>ddbo3,pipe_write=>p7_write,clk=>clk,rst=>rst);

se93: SignExtended9 port map(inp=>nopi3(8 downto 0),op=>ir2imm9);

se63: SignExtended6 port map(inp=>nopi3(5 downto 0),op=>ir2imm6);

ddb: ddblock port map(rst=>rst,ir2=>nopi3,clk=>clk,ir3=>nopi4,ir4=>ir5in, ir5=>ir5, rf1=>rf1, rf2=>rf2, pc13=>pc1p3o,
 pc14=>pc1p4o, pc15=>pc1p5, s4=>alu3o, s5=>mux5in1, mem_o=>p6o,p6=>mux6in2, s6=>mux6in1, ir2imm6=>ir2imm6, ir2imm9=>ir2imm9,
p1=>ddbo1, p2=>ddbo2, p7=>ddbo3,ctrl1_stall=>ctrl1_stall, ctrl2_stall=>ctrl2_stall, ctrl3_stall=>ctrl3_stall, nop4=>nop4);--p4o needs to be sorted

pc1p4m: pipeline port map(pipeout => pc1p4o,pipein=>pc1p3o,pipe_write=>pc1p4w,clk=>clk,rst=>rst);

cb4: c4 port map(rst=>rst,ir3=>nopi4,C_prev=>cout,Z_prev=>zout,ir4_wr=>ir4_write,P3_wr=>p3_write,
		P4_wr=>p4_write,en_ALU2=>alu2en,en_ALU3=>alu3_en,C_wr=>cwr,Z_wr=>zwr,
		P8_wr=>p8_write,pc1_wr=>pc1p4w,SEL_ALU3=>selc4,pipeline_wr=>pr4_write,sign_mux=>imux);

se94: SignExtended9 port map(inp=>nopi4(8 downto 0),op=>ir3imm9);

se64: SignExtended6 port map(inp=>nopi4(5 downto 0),op=>ir3imm6);
		
imuxx: MUX2x1 port map(S0=>imux,X0=>ir3imm6, X1=>ir3imm9,Y=> ir3imm, mux_en=>'1');



Creg: register_1bit port map(clk=>clk, reset=>rst, wrt=>cwr, din=>cin,dout=>cout);

Zreg: register_1bit port map(clk=>clk, reset=>rst, wrt=>zwr, din=>zin,dout=>zout);

Cfwd1: register_1bit port map(clk=>clk, reset=>rst, wrt=>'1', din=>cout,dout=>cf1);

Zfwd1: register_1bit port map(clk=>clk, reset=>rst, wrt=>'1', din=>zout,dout=>zf1);

Cfwd2: register_1bit port map(clk=>clk, reset=>rst, wrt=>'1', din=>cf1,dout=>cf2);

Zfwd2: register_1bit port map(clk=>clk, reset=>rst, wrt=>'1', din=>zf1,dout=>zf2);



alu_3: alu3 port map(A=>alu3a,B=>alu3b,C=>cout_vec,en=>alu3_en,sel=>selc4,C_flag=>cin,
		Z_flag=>zin,Y=>alu3o);

nopb: nop port map(Clk=>clk,Rst=>rst,C_Curr=>cout,Z_curr=>zout,nop4=>nop4,ir3_in=>nopi3, ir2_in=>nopi2, ir1_in=>nopi1,
			  ir1_out=>nopo1,ir2_out=>nopo2,ir3_out=>nopo3);
			  
pcb: pc_sel_blk port map(rst=>rst,clk=>clk,ALU2_out=>alu2o,ALU3_out=>alu3o,P7=>p8in, 
			PC_3=>memi_a,ir3=>nopi4,C_curr=>cin,Z_curr=>zin,PC1_3=>pc1,PC_new=>pcbo,stall=>ctrl1_stall);
			
cb5: control5 port map(rst=>rst, clk=>clk,ir4=>ir5in, mem_read=>mem_read, mem_write=>mem_write,
	mema_sel=>muxc5sel, pm_write=>pm4w, pc1_pipe=>pc1p4, p5_write=>p5_write, p6_write=>p6_write,
		ir5_write=>ir5_write, multi=>multim, p5_rst=>p5_rst, p6_rst=>p6_rst);
		
pc1p5m: pipeline port map(pipeout => pc1p5,pipein=>pc1p4o,pipe_write=>pc1p4,clk=>clk,rst=>rst);


alu_2: ALU2 port map(A=>pcp3o,IMM=>ir3imm,en=>'1',Y=>alu2o); 

p3: pipeline port map(pipeout => p5in,pipein=>alu3o,pipe_write=>p3_write,clk=>clk,rst=>rst);

p4: pipeline port map(pipeout => mux5in1,pipein=>alu3o,pipe_write=>p4_write,clk=>clk,rst=>rst);

p8: pipeline port map(pipeout => mux5in2,pipein=>p8in,pipe_write=>p8_write,clk=>clk,rst=>rst);



dm: data_memory port map(multi=>multim, mem_write=>mem_write, mem_read=>mem_read,imm => ir4(7 downto 0),
multi_in0=>pr4o(0),multi_in1=>pr4o(1),multi_in2=>pr4o(2),multi_in3=>pr4o(3),multi_in4=>pr4o(4),
multi_in5=>pr4o(5),multi_in6=>pr4o(6),multi_in7=>pr4o(7),
        mem_A=>mux5o,
        mem_I=>mux5in2,mem_O=>p6o,
		 multi_out0=>pm5(0),multi_out1=>pm5(1),multi_out2=>pm5(2),multi_out3=>pm5(3),multi_out4=>pm5(4),multi_out5=>pm5(5),
		 multi_out6=>pm5(6),multi_out7=>pm5(7),clk=>clk, rst=>rst);
		  
mux5: MUX2x1 port map(S0=>muxc5sel,X0=>mux5in1, X1=>mux5in2,Y=>mux5o, mux_en=>'1');


Qir4: pipeline port map(pipeout => ir5in,pipein=>nopi4,pipe_write=>ir4_write,clk=>clk,rst=>rst);
 		  
Qir5: pipeline port map(pipeout => ir5,pipein=>ir5in,pipe_write=>ir5_write,clk=>clk,rst=>rst);
 		  
Qp5: pipeline port map(pipeout => mux6in1,pipein=>p5in,pipe_write=>p5_write,clk=>clk,rst=>p5_rst);

Qp6: pipeline port map(pipeout => mux6in2,pipein=>p6o,pipe_write=>p4_write,clk=>clk,rst=>p6_rst);

mux6: MUX3x1 port map(S=>selc6,X0=>mux6in1, X1=>mux6in2, X2=>mux6in3, Y=> mux6_o,mux_en=>muxc6en);

cb6: control6 port map(clk=>clk,rst=>rst,ir5=>ir5,pc1_i=>pc1p5,C_prev=>cf2,Z_prev=>zf2,
       rf_wr=>rf_write,multi=>multirf,mux_p56_en=>muxc6en,
		  mux_p56_sel=>selc6,pipeline8_en=>ei8en,rc=>rc,
	     rc_out=>rc_out ); --replaced multir by multirf
i1<=nopo1;
i_1<=alu2o;
ddin<=pcp3o;
i2<=nopo2;
i3<=nopo3;
i4<=nopi4;
i5<=ir5in;
i6<=ir5;
pc<=memi_a;
dd1<=ddbo1;
dd2<=ddbo2;
dd3<=p8in;
r0<=pr3(0);
r1<=pr3(1);
r2<=pr3(2);
r3<=pr3(3);
r4<=pr3(4);
r5<=pr3(5);
r6<=pr3(6);
r7<=pr3(7);
ifw1<=zin;
alu3op<=alu3o;
alu3at<=alu3a;
alu3bt<=alu3b;
selalu<=ra;
c<=cout_vec;
stall<=ctrl1_stall;













end architecture;