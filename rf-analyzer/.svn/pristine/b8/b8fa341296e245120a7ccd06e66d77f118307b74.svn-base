// DISCLAIMER
// This disclaimer is not a license and does not grant any
// rights to the materials distributed herewith. Except as
// otherwise provided in a valid license issued to you by
// Xilinx, and to the maximum extent permitted by applicable
// law: (1) THESE MATERIALS ARE MADE AVAILABLE "AS IS" AND
// WITH ALL FAULTS, AND XILINX HEREBY DISCLAIMS ALL WARRANTIES
// AND CONDITIONS, EXPRESS, IMPLIED, OR STATUTORY, INCLUDING
// BUT NOT LIMITED TO WARRANTIES OF MERCHANTABILITY, NON-
// INFRINGEMENT, OR FITNESS FOR ANY PARTICULAR PURPOSE; and
// (2) Xilinx shall not be liable (whether in contract or tort,
// including negligence, or under any other theory of
// liability) for any loss or damage of any kind or nature
// related to, arising under or in connection with these
// materials, including for any direct, or any indirect,
// special, incidental, or consequential loss or damage
// (including loss of data, profits, goodwill, or any type of
// loss or damage suffered as a result of any action brought
// by a third party) even if such damage or loss was
// reasonably foreseeable or Xilinx had been advised of the
// possibility of the same.
// 
// CRITICAL APPLICATIONS
// Xilinx products are not designed or intended to be fail-
// safe, or for use in any application requiring fail-safe
// performance, such as life-support or safety devices or
// systems, Class III medical devices, nuclear facilities,
// applications related to the deployment of airbags, or any
// other applications that could lead to death, personal
// injury, or severe property or environmental damage
// (individually and collectively, "Critical
// Applications"). Customer assumes the sole risk and
// liability of any use of Xilinx products in Critical
// Applications, subject only to applicable laws and
// regulations governing limitations on product liability.
// 
// THIS COPYRIGHT NOTICE AND DISCLAIMER MUST BE RETAINED AS
// PART OF THIS FILE AT ALL TIMES. 
`timescale 1ps / 1ps

(* DowngradeIPIdentifiedWarnings="yes" *)
module exdes_rfadc_data_bram_capture #(
  parameter  mem_size            = 131072, // memory size per channel in bits
  parameter  axi_addr_top        = 18,     // top address of the AXI address bus
  parameter  use_div2_clk_0      = 0,      // ADC0. Select for high fabric clock rates. Memory is doubled and run at half the speed
  parameter  use_div2_clk_1      = 0,      // ADC1. Select for high fabric clock rates. Memory is doubled and run at half the speed
  parameter  use_div2_clk_2      = 0,      // ADC2. Select for high fabric clock rates. Memory is doubled and run at half the speed
  parameter  use_div2_clk_3      = 0       // ADC3. Select for high fabric clock rates. Memory is doubled and run at half the speed
) (

   // AXI-Lite Interface
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR"  *) input  wire [axi_addr_top:0]  s_axi_awaddr   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input  wire                   s_axi_awvalid  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output wire                   s_axi_awready  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA"   *) input  wire           [31:0]  s_axi_wdata    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID"  *) input  wire                   s_axi_wvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY"  *) output wire                   s_axi_wready   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB"   *) input  wire            [3:0]  s_axi_wstrb    , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP"   *) output wire            [1:0]  s_axi_bresp    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID"  *) output wire                   s_axi_bvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY"  *) input  wire                   s_axi_bready   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR"  *) input  wire [axi_addr_top:0]  s_axi_araddr   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input  wire                   s_axi_arvalid  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output wire                   s_axi_arready  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA"   *) output wire           [31:0]  s_axi_rdata    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP"   *) output wire            [1:0]  s_axi_rresp    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID"  *) output wire                   s_axi_rvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY"  *) input  wire                   s_axi_rready   ,  // 


   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TDATA" *)       input  wire [127:0] s00_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TVALID" *)      input  wire         s00_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TREADY" *)      output wire         s00_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TDATA" *)       output wire [127:0] m00_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TVALID" *)      output wire         m00_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TREADY" *)      input  wire         m00_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TDATA" *)       input  wire [127:0] s01_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TVALID" *)      input  wire         s01_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TREADY" *)      output wire         s01_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TDATA" *)       output wire [127:0] m01_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TVALID" *)      output wire         m01_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TREADY" *)      input  wire         m01_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TDATA" *)       input  wire [127:0] s02_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TVALID" *)      input  wire         s02_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TREADY" *)      output wire         s02_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TDATA" *)       output wire [127:0] m02_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TVALID" *)      output wire         m02_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TREADY" *)      input  wire         m02_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TDATA" *)       input  wire [127:0] s03_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TVALID" *)      input  wire         s03_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TREADY" *)      output wire         s03_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TDATA" *)       output wire [127:0] m03_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TVALID" *)      output wire         m03_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TREADY" *)      input  wire         m03_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TDATA" *)       input  wire [127:0] s10_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TVALID" *)      input  wire         s10_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TREADY" *)      output wire         s10_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TDATA" *)       output wire [127:0] m10_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TVALID" *)      output wire         m10_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TREADY" *)      input  wire         m10_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TDATA" *)       input  wire [127:0] s11_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TVALID" *)      input  wire         s11_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TREADY" *)      output wire         s11_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TDATA" *)       output wire [127:0] m11_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TVALID" *)      output wire         m11_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TREADY" *)      input  wire         m11_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TDATA" *)       input  wire [127:0] s12_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TVALID" *)      input  wire         s12_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TREADY" *)      output wire         s12_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TDATA" *)       output wire [127:0] m12_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TVALID" *)      output wire         m12_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TREADY" *)      input  wire         m12_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TDATA" *)       input  wire [127:0] s13_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TVALID" *)      input  wire         s13_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TREADY" *)      output wire         s13_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TDATA" *)       output wire [127:0] m13_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TVALID" *)      output wire         m13_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TREADY" *)      input  wire         m13_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s20 TDATA" *)       input  wire [127:0] s20_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s20 TVALID" *)      input  wire         s20_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s20 TREADY" *)      output wire         s20_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m20 TDATA" *)       output wire [127:0] m20_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m20 TVALID" *)      output wire         m20_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m20 TREADY" *)      input  wire         m20_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s21 TDATA" *)       input  wire [127:0] s21_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s21 TVALID" *)      input  wire         s21_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s21 TREADY" *)      output wire         s21_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m21 TDATA" *)       output wire [127:0] m21_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m21 TVALID" *)      output wire         m21_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m21 TREADY" *)      input  wire         m21_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s22 TDATA" *)       input  wire [127:0] s22_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s22 TVALID" *)      input  wire         s22_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s22 TREADY" *)      output wire         s22_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m22 TDATA" *)       output wire [127:0] m22_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m22 TVALID" *)      output wire         m22_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m22 TREADY" *)      input  wire         m22_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s23 TDATA" *)       input  wire [127:0] s23_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s23 TVALID" *)      input  wire         s23_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s23 TREADY" *)      output wire         s23_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m23 TDATA" *)       output wire [127:0] m23_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m23 TVALID" *)      output wire         m23_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m23 TREADY" *)      input  wire         m23_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s30 TDATA" *)       input  wire [127:0] s30_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s30 TVALID" *)      input  wire         s30_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s30 TREADY" *)      output wire         s30_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m30 TDATA" *)       output wire [127:0] m30_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m30 TVALID" *)      output wire         m30_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m30 TREADY" *)      input  wire         m30_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s31 TDATA" *)       input  wire [127:0] s31_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s31 TVALID" *)      input  wire         s31_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s31 TREADY" *)      output wire         s31_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m31 TDATA" *)       output wire [127:0] m31_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m31 TVALID" *)      output wire         m31_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m31 TREADY" *)      input  wire         m31_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s32 TDATA" *)       input  wire [127:0] s32_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s32 TVALID" *)      input  wire         s32_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s32 TREADY" *)      output wire         s32_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m32 TDATA" *)       output wire [127:0] m32_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m32 TVALID" *)      output wire         m32_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m32 TREADY" *)      input  wire         m32_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s33 TDATA" *)       input  wire [127:0] s33_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s33 TVALID" *)      input  wire         s33_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s33 TREADY" *)      output wire         s33_tready, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m33 TDATA" *)       output wire [127:0] m33_tdata , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m33 TVALID" *)      output wire         m33_tvalid, //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m33 TREADY" *)      input  wire         m33_tready, //
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s0_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s00:m00:s01:m01:s02:m02:s03:m03" *)
   input  wire           s0_axis_clock, //
   input  wire           s0_div2_axis_clock, //
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s1_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s10:m10:s11:m11:s12:m12:s13:m13" *)
   input  wire           s1_axis_clock, //
   input  wire           s1_div2_axis_clock, //
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s2_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s20:m20:s21:m21:s22:m22:s23:m23" *)
   input  wire           s2_axis_clock, //
   input  wire           s2_div2_axis_clock, //
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s3_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s30:m30:s31:m31:s32:m32:s33:m33" *)
   input  wire           s3_axis_clock, //
   input  wire           s3_div2_axis_clock, //


   // AXI-Lite Clock/Reset. Be explicit with the IPI interface declarations
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 s_axi_aclk CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF s_axi" *)
   input  wire           s_axi_aclk   ,
   (* X_INTERFACE_INFO = "xilinx.com:signal:reset:1.0 s_axi_aresetn RST" *)
   (* X_INTERFACE_PARAMETER = "POLARITY ACTIVE_LOW" *)
   input  wire           s_axi_aresetn
  
  );

//------------------------------------------------------------------------------
// Function clog2 - returns the integer ceiling of the base 2 logarithm of x,
//------------------------------------------------------------------------------
function integer clog2;
input [31:0] Depth;
integer i;
begin
 i = Depth;     
 for(clog2 = 0; i > 0; clog2 = clog2 + 1)
   i = i >> 1;
end
endfunction

//------------------------------------------------------------------------------
// Function get_mem_width_in_samples - returns the output data width of the memory,
//------------------------------------------------------------------------------
function integer get_mem_width_in_samples;
input [31:0] no_of_samples;
input [31:0] memory_size;
integer val;
begin
 if (memory_size > 131072) begin
   val = 16;
 end
 else begin
   if (no_of_samples <= 8) begin
     val = 8;
   end
   else begin
     val = 16;
   end
 end
 get_mem_width_in_samples = val;
end
endfunction

// RF Analyzer local parameters
localparam C_NUM_MEMORY_BLOCK = 17;
localparam SELECT_MEM_WIDTH = clog2(C_NUM_MEMORY_BLOCK-1);
localparam C_S_AXI_ADDR_WIDTH = clog2((mem_size/32)-1)+SELECT_MEM_WIDTH+2;
localparam C_MEMORY_ADDR_WIDTH = clog2((mem_size/32)-1);
localparam C_MEMORY_DATA_WITH = 32;

// ----------------------------------------------------------------------------
// Variable declarations
// ----------------------------------------------------------------------------
wire        enable;
wire        timeout_enable;
wire [11:0] timeout_value;


wire             [clog2((mem_size/32)-1)-1:0] s00_ds_addrb          ;//
wire                                          s00_ds_web            ;//
wire                                          s00_ds_enb            ;//
wire                                   [31:0] s00_ds_dinb           ;//
wire                                   [31:0] s00_ds_doutb          ;//
wire                                   [31:0] s00_ds_num_samples    ;//
wire                                   [31:0] s00_mem_stop          ;//
wire                                          s00_ds_enable_ram     ; //
wire                                          s00_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s01_ds_addrb          ;//
wire                                          s01_ds_web            ;//
wire                                          s01_ds_enb            ;//
wire                                   [31:0] s01_ds_dinb           ;//
wire                                   [31:0] s01_ds_doutb          ;//
wire                                   [31:0] s01_ds_num_samples    ;//
wire                                   [31:0] s01_mem_stop          ;//
wire                                          s01_ds_enable_ram     ; //
wire                                          s01_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s02_ds_addrb          ;//
wire                                          s02_ds_web            ;//
wire                                          s02_ds_enb            ;//
wire                                   [31:0] s02_ds_dinb           ;//
wire                                   [31:0] s02_ds_doutb          ;//
wire                                   [31:0] s02_ds_num_samples    ;//
wire                                   [31:0] s02_mem_stop          ;//
wire                                          s02_ds_enable_ram     ; //
wire                                          s02_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s03_ds_addrb          ;//
wire                                          s03_ds_web            ;//
wire                                          s03_ds_enb            ;//
wire                                   [31:0] s03_ds_dinb           ;//
wire                                   [31:0] s03_ds_doutb          ;//
wire                                   [31:0] s03_ds_num_samples    ;//
wire                                   [31:0] s03_mem_stop          ;//
wire                                          s03_ds_enable_ram     ; //
wire                                          s03_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s10_ds_addrb          ;//
wire                                          s10_ds_web            ;//
wire                                          s10_ds_enb            ;//
wire                                   [31:0] s10_ds_dinb           ;//
wire                                   [31:0] s10_ds_doutb          ;//
wire                                   [31:0] s10_ds_num_samples    ;//
wire                                   [31:0] s10_mem_stop          ;//
wire                                          s10_ds_enable_ram     ; //
wire                                          s10_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s11_ds_addrb          ;//
wire                                          s11_ds_web            ;//
wire                                          s11_ds_enb            ;//
wire                                   [31:0] s11_ds_dinb           ;//
wire                                   [31:0] s11_ds_doutb          ;//
wire                                   [31:0] s11_ds_num_samples    ;//
wire                                   [31:0] s11_mem_stop          ;//
wire                                          s11_ds_enable_ram     ; //
wire                                          s11_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s12_ds_addrb          ;//
wire                                          s12_ds_web            ;//
wire                                          s12_ds_enb            ;//
wire                                   [31:0] s12_ds_dinb           ;//
wire                                   [31:0] s12_ds_doutb          ;//
wire                                   [31:0] s12_ds_num_samples    ;//
wire                                   [31:0] s12_mem_stop          ;//
wire                                          s12_ds_enable_ram     ; //
wire                                          s12_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s13_ds_addrb          ;//
wire                                          s13_ds_web            ;//
wire                                          s13_ds_enb            ;//
wire                                   [31:0] s13_ds_dinb           ;//
wire                                   [31:0] s13_ds_doutb          ;//
wire                                   [31:0] s13_ds_num_samples    ;//
wire                                   [31:0] s13_mem_stop          ;//
wire                                          s13_ds_enable_ram     ; //
wire                                          s13_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s20_ds_addrb          ;//
wire                                          s20_ds_web            ;//
wire                                          s20_ds_enb            ;//
wire                                   [31:0] s20_ds_dinb           ;//
wire                                   [31:0] s20_ds_doutb          ;//
wire                                   [31:0] s20_ds_num_samples    ;//
wire                                   [31:0] s20_mem_stop          ;//
wire                                          s20_ds_enable_ram     ; //
wire                                          s20_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s21_ds_addrb          ;//
wire                                          s21_ds_web            ;//
wire                                          s21_ds_enb            ;//
wire                                   [31:0] s21_ds_dinb           ;//
wire                                   [31:0] s21_ds_doutb          ;//
wire                                   [31:0] s21_ds_num_samples    ;//
wire                                   [31:0] s21_mem_stop          ;//
wire                                          s21_ds_enable_ram     ; //
wire                                          s21_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s22_ds_addrb          ;//
wire                                          s22_ds_web            ;//
wire                                          s22_ds_enb            ;//
wire                                   [31:0] s22_ds_dinb           ;//
wire                                   [31:0] s22_ds_doutb          ;//
wire                                   [31:0] s22_ds_num_samples    ;//
wire                                   [31:0] s22_mem_stop          ;//
wire                                          s22_ds_enable_ram     ; //
wire                                          s22_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s23_ds_addrb          ;//
wire                                          s23_ds_web            ;//
wire                                          s23_ds_enb            ;//
wire                                   [31:0] s23_ds_dinb           ;//
wire                                   [31:0] s23_ds_doutb          ;//
wire                                   [31:0] s23_ds_num_samples    ;//
wire                                   [31:0] s23_mem_stop          ;//
wire                                          s23_ds_enable_ram     ; //
wire                                          s23_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s30_ds_addrb          ;//
wire                                          s30_ds_web            ;//
wire                                          s30_ds_enb            ;//
wire                                   [31:0] s30_ds_dinb           ;//
wire                                   [31:0] s30_ds_doutb          ;//
wire                                   [31:0] s30_ds_num_samples    ;//
wire                                   [31:0] s30_mem_stop          ;//
wire                                          s30_ds_enable_ram     ; //
wire                                          s30_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s31_ds_addrb          ;//
wire                                          s31_ds_web            ;//
wire                                          s31_ds_enb            ;//
wire                                   [31:0] s31_ds_dinb           ;//
wire                                   [31:0] s31_ds_doutb          ;//
wire                                   [31:0] s31_ds_num_samples    ;//
wire                                   [31:0] s31_mem_stop          ;//
wire                                          s31_ds_enable_ram     ; //
wire                                          s31_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s32_ds_addrb          ;//
wire                                          s32_ds_web            ;//
wire                                          s32_ds_enb            ;//
wire                                   [31:0] s32_ds_dinb           ;//
wire                                   [31:0] s32_ds_doutb          ;//
wire                                   [31:0] s32_ds_num_samples    ;//
wire                                   [31:0] s32_mem_stop          ;//
wire                                          s32_ds_enable_ram     ; //
wire                                          s32_ds_working        ; //

wire             [clog2((mem_size/32)-1)-1:0] s33_ds_addrb          ;//
wire                                          s33_ds_web            ;//
wire                                          s33_ds_enb            ;//
wire                                   [31:0] s33_ds_dinb           ;//
wire                                   [31:0] s33_ds_doutb          ;//
wire                                   [31:0] s33_ds_num_samples    ;//
wire                                   [31:0] s33_mem_stop          ;//
wire                                          s33_ds_enable_ram     ; //
wire                                          s33_ds_working        ; //
wire                                          start_data;

// ----------------------------------------------------------------------------
// Data generator tile 0
// ----------------------------------------------------------------------------
assign s00_mem_stop = (s00_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_0),
  .mem_size      (mem_size)
) ds_slice_00 (

  .clka            (s0_axis_clock        ),
  .clka_div2       (s0_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s00_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s00_ds_addrb         ),
  .web             (s00_ds_web           ),
  .enb             (s00_ds_enb           ),
  .dinb            (s00_ds_dinb          ),
  .doutb           (s00_ds_doutb         ),
  
  .endaddra        (s00_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s00_ds_working       ),
  
  .axis_data       (s00_tdata            ),
  .axis_valid      (s00_tvalid           )
);

assign s00_tready = s00_ds_enable_ram | m00_tready;

// ----------------------------------------------------------------------------
// Data generator tile 0
// ----------------------------------------------------------------------------
assign s01_mem_stop = (s01_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_0),
  .mem_size      (mem_size)
) ds_slice_01 (

  .clka            (s0_axis_clock        ),
  .clka_div2       (s0_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s01_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s01_ds_addrb         ),
  .web             (s01_ds_web           ),
  .enb             (s01_ds_enb           ),
  .dinb            (s01_ds_dinb          ),
  .doutb           (s01_ds_doutb         ),
  
  .endaddra        (s01_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s01_ds_working       ),
  
  .axis_data       (s01_tdata            ),
  .axis_valid      (s01_tvalid           )
);

assign s01_tready = s01_ds_enable_ram | m01_tready;

// ----------------------------------------------------------------------------
// Data generator tile 0
// ----------------------------------------------------------------------------
assign s02_mem_stop = (s02_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_0),
  .mem_size      (mem_size)
) ds_slice_02 (

  .clka            (s0_axis_clock        ),
  .clka_div2       (s0_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s02_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s02_ds_addrb         ),
  .web             (s02_ds_web           ),
  .enb             (s02_ds_enb           ),
  .dinb            (s02_ds_dinb          ),
  .doutb           (s02_ds_doutb         ),
  
  .endaddra        (s02_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s02_ds_working       ),
  
  .axis_data       (s02_tdata            ),
  .axis_valid      (s02_tvalid           )
);

assign s02_tready = s02_ds_enable_ram | m02_tready;

// ----------------------------------------------------------------------------
// Data generator tile 0
// ----------------------------------------------------------------------------
assign s03_mem_stop = (s03_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_0),
  .mem_size      (mem_size)
) ds_slice_03 (

  .clka            (s0_axis_clock        ),
  .clka_div2       (s0_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s03_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s03_ds_addrb         ),
  .web             (s03_ds_web           ),
  .enb             (s03_ds_enb           ),
  .dinb            (s03_ds_dinb          ),
  .doutb           (s03_ds_doutb         ),
  
  .endaddra        (s03_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s03_ds_working       ),
  
  .axis_data       (s03_tdata            ),
  .axis_valid      (s03_tvalid           )
);

assign s03_tready = s03_ds_enable_ram | m03_tready;

// ----------------------------------------------------------------------------
// Data generator tile 1
// ----------------------------------------------------------------------------
assign s10_mem_stop = (s10_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_1),
  .mem_size      (mem_size)
) ds_slice_10 (

  .clka            (s1_axis_clock        ),
  .clka_div2       (s1_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s10_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s10_ds_addrb         ),
  .web             (s10_ds_web           ),
  .enb             (s10_ds_enb           ),
  .dinb            (s10_ds_dinb          ),
  .doutb           (s10_ds_doutb         ),
  
  .endaddra        (s10_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s10_ds_working       ),
  
  .axis_data       (s10_tdata            ),
  .axis_valid      (s10_tvalid           )
);

assign s10_tready = s10_ds_enable_ram | m10_tready;

// ----------------------------------------------------------------------------
// Data generator tile 1
// ----------------------------------------------------------------------------
assign s11_mem_stop = (s11_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_1),
  .mem_size      (mem_size)
) ds_slice_11 (

  .clka            (s1_axis_clock        ),
  .clka_div2       (s1_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s11_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s11_ds_addrb         ),
  .web             (s11_ds_web           ),
  .enb             (s11_ds_enb           ),
  .dinb            (s11_ds_dinb          ),
  .doutb           (s11_ds_doutb         ),
  
  .endaddra        (s11_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s11_ds_working       ),
  
  .axis_data       (s11_tdata            ),
  .axis_valid      (s11_tvalid           )
);

assign s11_tready = s11_ds_enable_ram | m11_tready;

// ----------------------------------------------------------------------------
// Data generator tile 1
// ----------------------------------------------------------------------------
assign s12_mem_stop = (s12_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_1),
  .mem_size      (mem_size)
) ds_slice_12 (

  .clka            (s1_axis_clock        ),
  .clka_div2       (s1_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s12_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s12_ds_addrb         ),
  .web             (s12_ds_web           ),
  .enb             (s12_ds_enb           ),
  .dinb            (s12_ds_dinb          ),
  .doutb           (s12_ds_doutb         ),
  
  .endaddra        (s12_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s12_ds_working       ),
  
  .axis_data       (s12_tdata            ),
  .axis_valid      (s12_tvalid           )
);

assign s12_tready = s12_ds_enable_ram | m12_tready;

// ----------------------------------------------------------------------------
// Data generator tile 1
// ----------------------------------------------------------------------------
assign s13_mem_stop = (s13_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_1),
  .mem_size      (mem_size)
) ds_slice_13 (

  .clka            (s1_axis_clock        ),
  .clka_div2       (s1_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s13_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s13_ds_addrb         ),
  .web             (s13_ds_web           ),
  .enb             (s13_ds_enb           ),
  .dinb            (s13_ds_dinb          ),
  .doutb           (s13_ds_doutb         ),
  
  .endaddra        (s13_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s13_ds_working       ),
  
  .axis_data       (s13_tdata            ),
  .axis_valid      (s13_tvalid           )
);

assign s13_tready = s13_ds_enable_ram | m13_tready;

// ----------------------------------------------------------------------------
// Data generator tile 2
// ----------------------------------------------------------------------------
assign s20_mem_stop = (s20_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_2),
  .mem_size      (mem_size)
) ds_slice_20 (

  .clka            (s2_axis_clock        ),
  .clka_div2       (s2_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s20_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s20_ds_addrb         ),
  .web             (s20_ds_web           ),
  .enb             (s20_ds_enb           ),
  .dinb            (s20_ds_dinb          ),
  .doutb           (s20_ds_doutb         ),
  
  .endaddra        (s20_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s20_ds_working       ),
  
  .axis_data       (s20_tdata            ),
  .axis_valid      (s20_tvalid           )
);

assign s20_tready = s20_ds_enable_ram | m20_tready;

// ----------------------------------------------------------------------------
// Data generator tile 2
// ----------------------------------------------------------------------------
assign s21_mem_stop = (s21_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_2),
  .mem_size      (mem_size)
) ds_slice_21 (

  .clka            (s2_axis_clock        ),
  .clka_div2       (s2_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s21_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s21_ds_addrb         ),
  .web             (s21_ds_web           ),
  .enb             (s21_ds_enb           ),
  .dinb            (s21_ds_dinb          ),
  .doutb           (s21_ds_doutb         ),
  
  .endaddra        (s21_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s21_ds_working       ),
  
  .axis_data       (s21_tdata            ),
  .axis_valid      (s21_tvalid           )
);

assign s21_tready = s21_ds_enable_ram | m21_tready;

// ----------------------------------------------------------------------------
// Data generator tile 2
// ----------------------------------------------------------------------------
assign s22_mem_stop = (s22_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_2),
  .mem_size      (mem_size)
) ds_slice_22 (

  .clka            (s2_axis_clock        ),
  .clka_div2       (s2_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s22_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s22_ds_addrb         ),
  .web             (s22_ds_web           ),
  .enb             (s22_ds_enb           ),
  .dinb            (s22_ds_dinb          ),
  .doutb           (s22_ds_doutb         ),
  
  .endaddra        (s22_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s22_ds_working       ),
  
  .axis_data       (s22_tdata            ),
  .axis_valid      (s22_tvalid           )
);

assign s22_tready = s22_ds_enable_ram | m22_tready;

// ----------------------------------------------------------------------------
// Data generator tile 2
// ----------------------------------------------------------------------------
assign s23_mem_stop = (s23_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_2),
  .mem_size      (mem_size)
) ds_slice_23 (

  .clka            (s2_axis_clock        ),
  .clka_div2       (s2_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s23_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s23_ds_addrb         ),
  .web             (s23_ds_web           ),
  .enb             (s23_ds_enb           ),
  .dinb            (s23_ds_dinb          ),
  .doutb           (s23_ds_doutb         ),
  
  .endaddra        (s23_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s23_ds_working       ),
  
  .axis_data       (s23_tdata            ),
  .axis_valid      (s23_tvalid           )
);

assign s23_tready = s23_ds_enable_ram | m23_tready;

// ----------------------------------------------------------------------------
// Data generator tile 3
// ----------------------------------------------------------------------------
assign s30_mem_stop = (s30_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_3),
  .mem_size      (mem_size)
) ds_slice_30 (

  .clka            (s3_axis_clock        ),
  .clka_div2       (s3_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s30_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s30_ds_addrb         ),
  .web             (s30_ds_web           ),
  .enb             (s30_ds_enb           ),
  .dinb            (s30_ds_dinb          ),
  .doutb           (s30_ds_doutb         ),
  
  .endaddra        (s30_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s30_ds_working       ),
  
  .axis_data       (s30_tdata            ),
  .axis_valid      (s30_tvalid           )
);

assign s30_tready = s30_ds_enable_ram | m30_tready;

// ----------------------------------------------------------------------------
// Data generator tile 3
// ----------------------------------------------------------------------------
assign s31_mem_stop = (s31_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_3),
  .mem_size      (mem_size)
) ds_slice_31 (

  .clka            (s3_axis_clock        ),
  .clka_div2       (s3_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s31_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s31_ds_addrb         ),
  .web             (s31_ds_web           ),
  .enb             (s31_ds_enb           ),
  .dinb            (s31_ds_dinb          ),
  .doutb           (s31_ds_doutb         ),
  
  .endaddra        (s31_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s31_ds_working       ),
  
  .axis_data       (s31_tdata            ),
  .axis_valid      (s31_tvalid           )
);

assign s31_tready = s31_ds_enable_ram | m31_tready;

// ----------------------------------------------------------------------------
// Data generator tile 3
// ----------------------------------------------------------------------------
assign s32_mem_stop = (s32_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_3),
  .mem_size      (mem_size)
) ds_slice_32 (

  .clka            (s3_axis_clock        ),
  .clka_div2       (s3_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s32_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s32_ds_addrb         ),
  .web             (s32_ds_web           ),
  .enb             (s32_ds_enb           ),
  .dinb            (s32_ds_dinb          ),
  .doutb           (s32_ds_doutb         ),
  
  .endaddra        (s32_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s32_ds_working       ),
  
  .axis_data       (s32_tdata            ),
  .axis_valid      (s32_tvalid           )
);

assign s32_tready = s32_ds_enable_ram | m32_tready;

// ----------------------------------------------------------------------------
// Data generator tile 3
// ----------------------------------------------------------------------------
assign s33_mem_stop = (s33_ds_num_samples / get_mem_width_in_samples(8,mem_size)) - 1;

exdes_xpm_mem_ds  #( 
  .wordWidth     (128),
  .memWordWidth  (get_mem_width_in_samples(8,mem_size)),
  .addraWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(8,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1)),
  .use_div2_clk  (use_div2_clk_3),
  .mem_size      (mem_size)
) ds_slice_33 (

  .clka            (s3_axis_clock        ),
  .clka_div2       (s3_div2_axis_clock   ),
  .clkb            (s_axi_aclk           ),
  .enable          (s33_ds_enable_ram    ),
  .hw_trigger      (1'b0                 ),
  .hw_trigger_en   (1'b0                 ),
  
  .addrb           (s33_ds_addrb         ),
  .web             (s33_ds_web           ),
  .enb             (s33_ds_enb           ),
  .dinb            (s33_ds_dinb          ),
  .doutb           (s33_ds_doutb         ),
  
  .endaddra        (s33_mem_stop         ),
  .start_data      (start_data           ),
  .working         (s33_ds_working       ),
  
  .axis_data       (s33_tdata            ),
  .axis_valid      (s33_tvalid           )
);

assign s33_tready = s33_ds_enable_ram | m33_tready;

//-----------------------------------------------------------------------------
// Control register map.
//-----------------------------------------------------------------------------
rfadc_exdes_ctrl_rfa # (
  .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
  .C_MEMORY_ADDR_WIDTH(C_MEMORY_ADDR_WIDTH),
  .C_NUM_MEMORY_BLOCK(C_NUM_MEMORY_BLOCK),
  .C_MEM_SIZE(mem_size))
  rfadc_exdes_ctrl_i (
  .adc00_ds_addrb               (s00_ds_addrb      ), //
  .adc00_ds_web                 (s00_ds_web        ), //
  .adc00_ds_enb                 (s00_ds_enb        ), //
  .adc00_ds_dinb                (s00_ds_dinb       ), //
  .adc00_ds_doutb               (s00_ds_doutb      ), //
  .adc00_ds_num_samples         (s00_ds_num_samples), //
  .adc00_ds_enable              (s00_ds_enable_ram ), //
  .adc00_ds_working             (s00_ds_working    ), //
  .adc01_ds_addrb               (s01_ds_addrb      ), //
  .adc01_ds_web                 (s01_ds_web        ), //
  .adc01_ds_enb                 (s01_ds_enb        ), //
  .adc01_ds_dinb                (s01_ds_dinb       ), //
  .adc01_ds_doutb               (s01_ds_doutb      ), //
  .adc01_ds_num_samples         (s01_ds_num_samples), //
  .adc01_ds_enable              (s01_ds_enable_ram ), //
  .adc01_ds_working             (s01_ds_working    ), //
  .adc02_ds_addrb               (s02_ds_addrb      ), //
  .adc02_ds_web                 (s02_ds_web        ), //
  .adc02_ds_enb                 (s02_ds_enb        ), //
  .adc02_ds_dinb                (s02_ds_dinb       ), //
  .adc02_ds_doutb               (s02_ds_doutb      ), //
  .adc02_ds_num_samples         (s02_ds_num_samples), //
  .adc02_ds_enable              (s02_ds_enable_ram ), //
  .adc02_ds_working             (s02_ds_working    ), //
  .adc03_ds_addrb               (s03_ds_addrb      ), //
  .adc03_ds_web                 (s03_ds_web        ), //
  .adc03_ds_enb                 (s03_ds_enb        ), //
  .adc03_ds_dinb                (s03_ds_dinb       ), //
  .adc03_ds_doutb               (s03_ds_doutb      ), //
  .adc03_ds_num_samples         (s03_ds_num_samples), //
  .adc03_ds_enable              (s03_ds_enable_ram ), //
  .adc03_ds_working             (s03_ds_working    ), //
  .adc10_ds_addrb               (s10_ds_addrb      ), //
  .adc10_ds_web                 (s10_ds_web        ), //
  .adc10_ds_enb                 (s10_ds_enb        ), //
  .adc10_ds_dinb                (s10_ds_dinb       ), //
  .adc10_ds_doutb               (s10_ds_doutb      ), //
  .adc10_ds_num_samples         (s10_ds_num_samples), //
  .adc10_ds_enable              (s10_ds_enable_ram ), //
  .adc10_ds_working             (s10_ds_working    ), //
  .adc11_ds_addrb               (s11_ds_addrb      ), //
  .adc11_ds_web                 (s11_ds_web        ), //
  .adc11_ds_enb                 (s11_ds_enb        ), //
  .adc11_ds_dinb                (s11_ds_dinb       ), //
  .adc11_ds_doutb               (s11_ds_doutb      ), //
  .adc11_ds_num_samples         (s11_ds_num_samples), //
  .adc11_ds_enable              (s11_ds_enable_ram ), //
  .adc11_ds_working             (s11_ds_working    ), //
  .adc12_ds_addrb               (s12_ds_addrb      ), //
  .adc12_ds_web                 (s12_ds_web        ), //
  .adc12_ds_enb                 (s12_ds_enb        ), //
  .adc12_ds_dinb                (s12_ds_dinb       ), //
  .adc12_ds_doutb               (s12_ds_doutb      ), //
  .adc12_ds_num_samples         (s12_ds_num_samples), //
  .adc12_ds_enable              (s12_ds_enable_ram ), //
  .adc12_ds_working             (s12_ds_working    ), //
  .adc13_ds_addrb               (s13_ds_addrb      ), //
  .adc13_ds_web                 (s13_ds_web        ), //
  .adc13_ds_enb                 (s13_ds_enb        ), //
  .adc13_ds_dinb                (s13_ds_dinb       ), //
  .adc13_ds_doutb               (s13_ds_doutb      ), //
  .adc13_ds_num_samples         (s13_ds_num_samples), //
  .adc13_ds_enable              (s13_ds_enable_ram ), //
  .adc13_ds_working             (s13_ds_working    ), //
  .adc20_ds_addrb               (s20_ds_addrb      ), //
  .adc20_ds_web                 (s20_ds_web        ), //
  .adc20_ds_enb                 (s20_ds_enb        ), //
  .adc20_ds_dinb                (s20_ds_dinb       ), //
  .adc20_ds_doutb               (s20_ds_doutb      ), //
  .adc20_ds_num_samples         (s20_ds_num_samples), //
  .adc20_ds_enable              (s20_ds_enable_ram ), //
  .adc20_ds_working             (s20_ds_working    ), //
  .adc21_ds_addrb               (s21_ds_addrb      ), //
  .adc21_ds_web                 (s21_ds_web        ), //
  .adc21_ds_enb                 (s21_ds_enb        ), //
  .adc21_ds_dinb                (s21_ds_dinb       ), //
  .adc21_ds_doutb               (s21_ds_doutb      ), //
  .adc21_ds_num_samples         (s21_ds_num_samples), //
  .adc21_ds_enable              (s21_ds_enable_ram ), //
  .adc21_ds_working             (s21_ds_working    ), //
  .adc22_ds_addrb               (s22_ds_addrb      ), //
  .adc22_ds_web                 (s22_ds_web        ), //
  .adc22_ds_enb                 (s22_ds_enb        ), //
  .adc22_ds_dinb                (s22_ds_dinb       ), //
  .adc22_ds_doutb               (s22_ds_doutb      ), //
  .adc22_ds_num_samples         (s22_ds_num_samples), //
  .adc22_ds_enable              (s22_ds_enable_ram ), //
  .adc22_ds_working             (s22_ds_working    ), //
  .adc23_ds_addrb               (s23_ds_addrb      ), //
  .adc23_ds_web                 (s23_ds_web        ), //
  .adc23_ds_enb                 (s23_ds_enb        ), //
  .adc23_ds_dinb                (s23_ds_dinb       ), //
  .adc23_ds_doutb               (s23_ds_doutb      ), //
  .adc23_ds_num_samples         (s23_ds_num_samples), //
  .adc23_ds_enable              (s23_ds_enable_ram ), //
  .adc23_ds_working             (s23_ds_working    ), //
  .adc30_ds_addrb               (s30_ds_addrb      ), //
  .adc30_ds_web                 (s30_ds_web        ), //
  .adc30_ds_enb                 (s30_ds_enb        ), //
  .adc30_ds_dinb                (s30_ds_dinb       ), //
  .adc30_ds_doutb               (s30_ds_doutb      ), //
  .adc30_ds_num_samples         (s30_ds_num_samples), //
  .adc30_ds_enable              (s30_ds_enable_ram ), //
  .adc30_ds_working             (s30_ds_working    ), //
  .adc31_ds_addrb               (s31_ds_addrb      ), //
  .adc31_ds_web                 (s31_ds_web        ), //
  .adc31_ds_enb                 (s31_ds_enb        ), //
  .adc31_ds_dinb                (s31_ds_dinb       ), //
  .adc31_ds_doutb               (s31_ds_doutb      ), //
  .adc31_ds_num_samples         (s31_ds_num_samples), //
  .adc31_ds_enable              (s31_ds_enable_ram ), //
  .adc31_ds_working             (s31_ds_working    ), //
  .adc32_ds_addrb               (s32_ds_addrb      ), //
  .adc32_ds_web                 (s32_ds_web        ), //
  .adc32_ds_enb                 (s32_ds_enb        ), //
  .adc32_ds_dinb                (s32_ds_dinb       ), //
  .adc32_ds_doutb               (s32_ds_doutb      ), //
  .adc32_ds_num_samples         (s32_ds_num_samples), //
  .adc32_ds_enable              (s32_ds_enable_ram ), //
  .adc32_ds_working             (s32_ds_working    ), //
  .adc33_ds_addrb               (s33_ds_addrb      ), //
  .adc33_ds_web                 (s33_ds_web        ), //
  .adc33_ds_enb                 (s33_ds_enb        ), //
  .adc33_ds_dinb                (s33_ds_dinb       ), //
  .adc33_ds_doutb               (s33_ds_doutb      ), //
  .adc33_ds_num_samples         (s33_ds_num_samples), //
  .adc33_ds_enable              (s33_ds_enable_ram ), //
  .adc33_ds_working             (s33_ds_working    ), //

  .start_data                   (start_data      ),
  .timeout_enable               (timeout_enable  ),
  .timeout_value                (timeout_value   ),

  .timeout_enable_in            (timeout_enable  ),
  .timeout_value_in             (timeout_value   ),

  .s_axi_aclk                   (s_axi_aclk      ),
  .s_axi_aresetn                (s_axi_aresetn   ),

  .s_axi_awaddr                 (s_axi_awaddr    ),
  .s_axi_awprot                 (3'b111          ),
  .s_axi_awvalid                (s_axi_awvalid   ),
  .s_axi_awready                (s_axi_awready   ),
  .s_axi_wdata                  (s_axi_wdata     ),
  .s_axi_wstrb                  (s_axi_wstrb     ),
  .s_axi_wvalid                 (s_axi_wvalid    ),
  .s_axi_wready                 (s_axi_wready    ),
  .s_axi_bresp                  (s_axi_bresp     ),
  .s_axi_bvalid                 (s_axi_bvalid    ),
  .s_axi_bready                 (s_axi_bready    ),
  .s_axi_araddr                 (s_axi_araddr    ),
  .s_axi_arprot                 (3'b111          ),
  .s_axi_arvalid                (s_axi_arvalid   ),
  .s_axi_arready                (s_axi_arready   ),
  .s_axi_rdata                  (s_axi_rdata     ),
  .s_axi_rresp                  (s_axi_rresp     ),
  .s_axi_rvalid                 (s_axi_rvalid    ),
  .s_axi_rready                 (s_axi_rready    )

);
   assign m00_tdata   = s00_tdata;
   assign m00_tvalid  = s00_tvalid;
   assign m01_tdata   = s01_tdata;
   assign m01_tvalid  = s01_tvalid;
   assign m02_tdata   = s02_tdata;
   assign m02_tvalid  = s02_tvalid;
   assign m03_tdata   = s03_tdata;
   assign m03_tvalid  = s03_tvalid;
   assign m10_tdata   = s10_tdata;
   assign m10_tvalid  = s10_tvalid;
   assign m11_tdata   = s11_tdata;
   assign m11_tvalid  = s11_tvalid;
   assign m12_tdata   = s12_tdata;
   assign m12_tvalid  = s12_tvalid;
   assign m13_tdata   = s13_tdata;
   assign m13_tvalid  = s13_tvalid;
   assign m20_tdata   = s20_tdata;
   assign m20_tvalid  = s20_tvalid;
   assign m21_tdata   = s21_tdata;
   assign m21_tvalid  = s21_tvalid;
   assign m22_tdata   = s22_tdata;
   assign m22_tvalid  = s22_tvalid;
   assign m23_tdata   = s23_tdata;
   assign m23_tvalid  = s23_tvalid;
   assign m30_tdata   = s30_tdata;
   assign m30_tvalid  = s30_tvalid;
   assign m31_tdata   = s31_tdata;
   assign m31_tvalid  = s31_tvalid;
   assign m32_tdata   = s32_tdata;
   assign m32_tvalid  = s32_tvalid;
   assign m33_tdata   = s33_tdata;
   assign m33_tvalid  = s33_tvalid;

endmodule
