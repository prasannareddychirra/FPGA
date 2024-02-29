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

// Uncomment the line below to allow signal type selection via the AXI interface
// This also enables full control over the initial start values for the generation counters
`define DACEXDES_ENABLETYPE_SELECTION

(* DowngradeIPIdentifiedWarnings="yes" *)
module exdes_rfdac_data_bram_stim #(
  
  parameter  mem_size                 = 131072, // memory size per channel in bits
  parameter  axi_addr_top             = 18      // top address of the AXI address bus

) (

   // AXI-Lite Interface
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWADDR"  *) input  wire [axi_addr_top:0] s_axi_awaddr   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWVALID" *) input  wire                  s_axi_awvalid  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi AWREADY" *) output wire                  s_axi_awready  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WDATA"   *) input  wire           [31:0] s_axi_wdata    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WVALID"  *) input  wire                  s_axi_wvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WREADY"  *) output wire                  s_axi_wready   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi WSTRB"   *) input  wire            [3:0] s_axi_wstrb    , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BRESP"   *) output wire            [1:0] s_axi_bresp    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BVALID"  *) output wire                  s_axi_bvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi BREADY"  *) input  wire                  s_axi_bready   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARADDR"  *) input  wire [axi_addr_top:0] s_axi_araddr   , //
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARVALID" *) input  wire                  s_axi_arvalid  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi ARREADY" *) output wire                  s_axi_arready  , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RDATA"   *) output wire           [31:0] s_axi_rdata    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RRESP"   *) output wire            [1:0] s_axi_rresp    , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RVALID"  *) output wire                  s_axi_rvalid   , // 
   (* X_INTERFACE_INFO = "xilinx.com:interface:aximm:1.0 s_axi RREADY"  *) input  wire                  s_axi_rready   , // 

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TDATA" *)       output wire [255:0] m00_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TVALID" *)      output wire         m00_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m00 TREADY" *)      input  wire         m00_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TDATA" *)       input  wire [255:0] s00_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TVALID" *)      input  wire         s00_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s00 TREADY" *)      output wire         s00_user_tready,     //
   input  wire           user_select_00, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TDATA" *)       output wire [255:0] m01_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TVALID" *)      output wire         m01_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m01 TREADY" *)      input  wire         m01_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TDATA" *)       input  wire [255:0] s01_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TVALID" *)      input  wire         s01_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s01 TREADY" *)      output wire         s01_user_tready,     //
   input  wire           user_select_01, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TDATA" *)       output wire [255:0] m02_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TVALID" *)      output wire         m02_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m02 TREADY" *)      input  wire         m02_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TDATA" *)       input  wire [255:0] s02_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TVALID" *)      input  wire         s02_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s02 TREADY" *)      output wire         s02_user_tready,     //
   input  wire           user_select_02, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TDATA" *)       output wire [255:0] m03_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TVALID" *)      output wire         m03_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m03 TREADY" *)      input  wire         m03_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TDATA" *)       input  wire [255:0] s03_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TVALID" *)      input  wire         s03_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s03 TREADY" *)      output wire         s03_user_tready,     //
   input  wire           user_select_03, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TDATA" *)       output wire [255:0] m10_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TVALID" *)      output wire         m10_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m10 TREADY" *)      input  wire         m10_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TDATA" *)       input  wire [255:0] s10_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TVALID" *)      input  wire         s10_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s10 TREADY" *)      output wire         s10_user_tready,     //
   input  wire           user_select_10, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TDATA" *)       output wire [255:0] m11_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TVALID" *)      output wire         m11_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m11 TREADY" *)      input  wire         m11_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TDATA" *)       input  wire [255:0] s11_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TVALID" *)      input  wire         s11_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s11 TREADY" *)      output wire         s11_user_tready,     //
   input  wire           user_select_11, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TDATA" *)       output wire [255:0] m12_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TVALID" *)      output wire         m12_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m12 TREADY" *)      input  wire         m12_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TDATA" *)       input  wire [255:0] s12_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TVALID" *)      input  wire         s12_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s12 TREADY" *)      output wire         s12_user_tready,     //
   input  wire           user_select_12, //

   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TDATA" *)       output wire [255:0] m13_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TVALID" *)      output wire         m13_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 m13 TREADY" *)      input  wire         m13_tready,     //
   
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TDATA" *)       input  wire [255:0] s13_user_tdata ,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TVALID" *)      input  wire         s13_user_tvalid,     //
   (* X_INTERFACE_INFO = "xilinx.com:interface:axis:1.0 s13 TREADY" *)      output wire         s13_user_tready,     //
   input  wire           user_select_13, //


   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m0_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m00:s00:m01:s01:m02:s02:m03:s03" *)
   input  wire           m0_axis_clock, //
   (* X_INTERFACE_INFO = "xilinx.com:signal:clock:1.0 m1_axis_clock CLK" *)
   (* X_INTERFACE_PARAMETER = "ASSOCIATED_BUSIF m10:s10:m11:s11:m12:s12:m13:s13" *)
   input  wire           m1_axis_clock, //


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

// ----------------------------------------------------------------------------
// Local params
// ----------------------------------------------------------------------------
// Block RAM local parameters
localparam C_NUM_MEMORY_BLOCK = 9;
localparam SELECT_MEM_WIDTH = clog2(C_NUM_MEMORY_BLOCK-1);
localparam C_S_AXI_ADDR_WIDTH = clog2((mem_size/32)-1)+SELECT_MEM_WIDTH+2;
localparam C_MEMORY_ADDR_WIDTH = clog2((mem_size/32)-1);
localparam C_MEMORY_DATA_WITH = 32;


// ----------------------------------------------------------------------------
// Wire declarations
// ----------------------------------------------------------------------------
wire                            enable;
wire                            timeout_enable;
wire                     [11:0] timeout_value;

wire  [clog2((mem_size/32)-1)-1:0] m00_dg_addra          ;//
wire                               m00_dg_wea            ;//
wire                               m00_dg_ena            ;//
wire                        [31:0] m00_dg_dina           ;//
wire                        [31:0] m00_dg_douta          ;//
wire                        [31:0] m00_dg_num_samples    ;//
wire                        [31:0] m00_mem_stop          ;//
wire                               m00_dg_enable_ram     ;//

wire              [255:0] m00_tdata_i;     //
wire                               m00_tvalid_i;     //
wire                               m00_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m01_dg_addra          ;//
wire                               m01_dg_wea            ;//
wire                               m01_dg_ena            ;//
wire                        [31:0] m01_dg_dina           ;//
wire                        [31:0] m01_dg_douta          ;//
wire                        [31:0] m01_dg_num_samples    ;//
wire                        [31:0] m01_mem_stop          ;//
wire                               m01_dg_enable_ram     ;//

wire              [255:0] m01_tdata_i;     //
wire                               m01_tvalid_i;     //
wire                               m01_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m02_dg_addra          ;//
wire                               m02_dg_wea            ;//
wire                               m02_dg_ena            ;//
wire                        [31:0] m02_dg_dina           ;//
wire                        [31:0] m02_dg_douta          ;//
wire                        [31:0] m02_dg_num_samples    ;//
wire                        [31:0] m02_mem_stop          ;//
wire                               m02_dg_enable_ram     ;//

wire              [255:0] m02_tdata_i;     //
wire                               m02_tvalid_i;     //
wire                               m02_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m03_dg_addra          ;//
wire                               m03_dg_wea            ;//
wire                               m03_dg_ena            ;//
wire                        [31:0] m03_dg_dina           ;//
wire                        [31:0] m03_dg_douta          ;//
wire                        [31:0] m03_dg_num_samples    ;//
wire                        [31:0] m03_mem_stop          ;//
wire                               m03_dg_enable_ram     ;//

wire              [255:0] m03_tdata_i;     //
wire                               m03_tvalid_i;     //
wire                               m03_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m10_dg_addra          ;//
wire                               m10_dg_wea            ;//
wire                               m10_dg_ena            ;//
wire                        [31:0] m10_dg_dina           ;//
wire                        [31:0] m10_dg_douta          ;//
wire                        [31:0] m10_dg_num_samples    ;//
wire                        [31:0] m10_mem_stop          ;//
wire                               m10_dg_enable_ram     ;//

wire              [255:0] m10_tdata_i;     //
wire                               m10_tvalid_i;     //
wire                               m10_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m11_dg_addra          ;//
wire                               m11_dg_wea            ;//
wire                               m11_dg_ena            ;//
wire                        [31:0] m11_dg_dina           ;//
wire                        [31:0] m11_dg_douta          ;//
wire                        [31:0] m11_dg_num_samples    ;//
wire                        [31:0] m11_mem_stop          ;//
wire                               m11_dg_enable_ram     ;//

wire              [255:0] m11_tdata_i;     //
wire                               m11_tvalid_i;     //
wire                               m11_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m12_dg_addra          ;//
wire                               m12_dg_wea            ;//
wire                               m12_dg_ena            ;//
wire                        [31:0] m12_dg_dina           ;//
wire                        [31:0] m12_dg_douta          ;//
wire                        [31:0] m12_dg_num_samples    ;//
wire                        [31:0] m12_mem_stop          ;//
wire                               m12_dg_enable_ram     ;//

wire              [255:0] m12_tdata_i;     //
wire                               m12_tvalid_i;     //
wire                               m12_tready_i;     //

wire  [clog2((mem_size/32)-1)-1:0] m13_dg_addra          ;//
wire                               m13_dg_wea            ;//
wire                               m13_dg_ena            ;//
wire                        [31:0] m13_dg_dina           ;//
wire                        [31:0] m13_dg_douta          ;//
wire                        [31:0] m13_dg_num_samples    ;//
wire                        [31:0] m13_mem_stop          ;//
wire                               m13_dg_enable_ram     ;//

wire              [255:0] m13_tdata_i;     //
wire                               m13_tvalid_i;     //
wire                               m13_tready_i;     //
wire                               start_data;
assign m00_mem_stop = (m00_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_00 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m0_axis_clock          ),
   .enable     ( m00_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m00_dg_addra           ),
   .wea        ( m00_dg_wea             ),
   .ena        ( m00_dg_ena             ),
   .dina       ( m00_dg_dina            ),
   .douta      ( m00_dg_douta           ),

   .endaddrb   ( m00_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m00_tdata_i            ),
   .axis_valid ( m00_tvalid_i           ),
   .axis_ready ( m00_tready_i           )

);

  assign m00_tdata         = (user_select_00 == 1'b1) ? s00_user_tdata :  m00_tdata_i;
  assign m00_tvalid        = (user_select_00 == 1'b1) ? s00_user_tvalid :  m00_tvalid_i;
  assign m00_tready_i      = (user_select_00 == 1'b1) ? 1'b0 : m00_tready;
  assign s00_user_tready = (user_select_00 == 1'b1) ? m00_tready : 1'b0;
assign m01_mem_stop = (m01_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_01 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m0_axis_clock          ),
   .enable     ( m01_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m01_dg_addra           ),
   .wea        ( m01_dg_wea             ),
   .ena        ( m01_dg_ena             ),
   .dina       ( m01_dg_dina            ),
   .douta      ( m01_dg_douta           ),

   .endaddrb   ( m01_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m01_tdata_i            ),
   .axis_valid ( m01_tvalid_i           ),
   .axis_ready ( m01_tready_i           )

);

  assign m01_tdata         = (user_select_01 == 1'b1) ? s01_user_tdata :  m01_tdata_i;
  assign m01_tvalid        = (user_select_01 == 1'b1) ? s01_user_tvalid :  m01_tvalid_i;
  assign m01_tready_i      = (user_select_01 == 1'b1) ? 1'b0 : m01_tready;
  assign s01_user_tready = (user_select_01 == 1'b1) ? m01_tready : 1'b0;
assign m02_mem_stop = (m02_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_02 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m0_axis_clock          ),
   .enable     ( m02_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m02_dg_addra           ),
   .wea        ( m02_dg_wea             ),
   .ena        ( m02_dg_ena             ),
   .dina       ( m02_dg_dina            ),
   .douta      ( m02_dg_douta           ),

   .endaddrb   ( m02_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m02_tdata_i            ),
   .axis_valid ( m02_tvalid_i           ),
   .axis_ready ( m02_tready_i           )

);

  assign m02_tdata         = (user_select_02 == 1'b1) ? s02_user_tdata :  m02_tdata_i;
  assign m02_tvalid        = (user_select_02 == 1'b1) ? s02_user_tvalid :  m02_tvalid_i;
  assign m02_tready_i      = (user_select_02 == 1'b1) ? 1'b0 : m02_tready;
  assign s02_user_tready = (user_select_02 == 1'b1) ? m02_tready : 1'b0;
assign m03_mem_stop = (m03_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_03 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m0_axis_clock          ),
   .enable     ( m03_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m03_dg_addra           ),
   .wea        ( m03_dg_wea             ),
   .ena        ( m03_dg_ena             ),
   .dina       ( m03_dg_dina            ),
   .douta      ( m03_dg_douta           ),

   .endaddrb   ( m03_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m03_tdata_i            ),
   .axis_valid ( m03_tvalid_i           ),
   .axis_ready ( m03_tready_i           )

);

  assign m03_tdata         = (user_select_03 == 1'b1) ? s03_user_tdata :  m03_tdata_i;
  assign m03_tvalid        = (user_select_03 == 1'b1) ? s03_user_tvalid :  m03_tvalid_i;
  assign m03_tready_i      = (user_select_03 == 1'b1) ? 1'b0 : m03_tready;
  assign s03_user_tready = (user_select_03 == 1'b1) ? m03_tready : 1'b0;
assign m10_mem_stop = (m10_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_10 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m1_axis_clock          ),
   .enable     ( m10_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m10_dg_addra           ),
   .wea        ( m10_dg_wea             ),
   .ena        ( m10_dg_ena             ),
   .dina       ( m10_dg_dina            ),
   .douta      ( m10_dg_douta           ),

   .endaddrb   ( m10_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m10_tdata_i            ),
   .axis_valid ( m10_tvalid_i           ),
   .axis_ready ( m10_tready_i           )

);

  assign m10_tdata         = (user_select_10 == 1'b1) ? s10_user_tdata :  m10_tdata_i;
  assign m10_tvalid        = (user_select_10 == 1'b1) ? s10_user_tvalid :  m10_tvalid_i;
  assign m10_tready_i      = (user_select_10 == 1'b1) ? 1'b0 : m10_tready;
  assign s10_user_tready = (user_select_10 == 1'b1) ? m10_tready : 1'b0;
assign m11_mem_stop = (m11_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_11 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m1_axis_clock          ),
   .enable     ( m11_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m11_dg_addra           ),
   .wea        ( m11_dg_wea             ),
   .ena        ( m11_dg_ena             ),
   .dina       ( m11_dg_dina            ),
   .douta      ( m11_dg_douta           ),

   .endaddrb   ( m11_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m11_tdata_i            ),
   .axis_valid ( m11_tvalid_i           ),
   .axis_ready ( m11_tready_i           )

);

  assign m11_tdata         = (user_select_11 == 1'b1) ? s11_user_tdata :  m11_tdata_i;
  assign m11_tvalid        = (user_select_11 == 1'b1) ? s11_user_tvalid :  m11_tvalid_i;
  assign m11_tready_i      = (user_select_11 == 1'b1) ? 1'b0 : m11_tready;
  assign s11_user_tready = (user_select_11 == 1'b1) ? m11_tready : 1'b0;
assign m12_mem_stop = (m12_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_12 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m1_axis_clock          ),
   .enable     ( m12_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m12_dg_addra           ),
   .wea        ( m12_dg_wea             ),
   .ena        ( m12_dg_ena             ),
   .dina       ( m12_dg_dina            ),
   .douta      ( m12_dg_douta           ),

   .endaddrb   ( m12_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m12_tdata_i            ),
   .axis_valid ( m12_tvalid_i           ),
   .axis_ready ( m12_tready_i           )

);

  assign m12_tdata         = (user_select_12 == 1'b1) ? s12_user_tdata :  m12_tdata_i;
  assign m12_tvalid        = (user_select_12 == 1'b1) ? s12_user_tvalid :  m12_tvalid_i;
  assign m12_tready_i      = (user_select_12 == 1'b1) ? 1'b0 : m12_tready;
  assign s12_user_tready = (user_select_12 == 1'b1) ? m12_tready : 1'b0;
assign m13_mem_stop = (m13_dg_num_samples / get_mem_width_in_samples(16,mem_size)) - 1;

exdes_xpm_mem_dg #(
   
  .wordWidth     (256),
  .memWordWidth  (get_mem_width_in_samples(16,mem_size)),
  .addrbWidth    (clog2((mem_size/(16 * get_mem_width_in_samples(16,mem_size)))-1)),
  .addrWidth     (clog2((mem_size/32)-1))

) dg_slice_13 (

   .clka       ( s_axi_aclk             ),
   .clkb       ( m1_axis_clock          ),
   .enable     ( m13_dg_enable_ram      ),   
   .hw_trigger   (1'b0                  ),
   .hw_trigger_en(1'b0                  ),

   .addra      ( m13_dg_addra           ),
   .wea        ( m13_dg_wea             ),
   .ena        ( m13_dg_ena             ),
   .dina       ( m13_dg_dina            ),
   .douta      ( m13_dg_douta           ),

   .endaddrb   ( m13_mem_stop           ),
   .start_data ( start_data             ),
   .axis_data  ( m13_tdata_i            ),
   .axis_valid ( m13_tvalid_i           ),
   .axis_ready ( m13_tready_i           )

);

  assign m13_tdata         = (user_select_13 == 1'b1) ? s13_user_tdata :  m13_tdata_i;
  assign m13_tvalid        = (user_select_13 == 1'b1) ? s13_user_tvalid :  m13_tvalid_i;
  assign m13_tready_i      = (user_select_13 == 1'b1) ? 1'b0 : m13_tready;
  assign s13_user_tready = (user_select_13 == 1'b1) ? m13_tready : 1'b0;

//-----------------------------------------------------------------------------
// Control and status registers
//-----------------------------------------------------------------------------
rfdac_exdes_ctrl_rfa # (
  .C_S_AXI_ADDR_WIDTH(C_S_AXI_ADDR_WIDTH),
  .C_MEMORY_ADDR_WIDTH(C_MEMORY_ADDR_WIDTH),
  .C_NUM_MEMORY_BLOCK(C_NUM_MEMORY_BLOCK),
  .C_MEM_SIZE(mem_size))
  rfdac_exdes_ctrl_i (
   .dac00_dg_addra               (m00_dg_addra       ), //
   .dac00_dg_wea                 (m00_dg_wea         ), //
   .dac00_dg_ena                 (m00_dg_ena         ), //
   .dac00_dg_dina                (m00_dg_dina        ), //
   .dac00_dg_douta               (m00_dg_douta       ), //
   .dac00_dg_num_samples         (m00_dg_num_samples ), //
   .dac00_dg_enable              (m00_dg_enable_ram  ), //
   .dac01_dg_addra               (m01_dg_addra       ), //
   .dac01_dg_wea                 (m01_dg_wea         ), //
   .dac01_dg_ena                 (m01_dg_ena         ), //
   .dac01_dg_dina                (m01_dg_dina        ), //
   .dac01_dg_douta               (m01_dg_douta       ), //
   .dac01_dg_num_samples         (m01_dg_num_samples ), //
   .dac01_dg_enable              (m01_dg_enable_ram  ), //
   .dac02_dg_addra               (m02_dg_addra       ), //
   .dac02_dg_wea                 (m02_dg_wea         ), //
   .dac02_dg_ena                 (m02_dg_ena         ), //
   .dac02_dg_dina                (m02_dg_dina        ), //
   .dac02_dg_douta               (m02_dg_douta       ), //
   .dac02_dg_num_samples         (m02_dg_num_samples ), //
   .dac02_dg_enable              (m02_dg_enable_ram  ), //
   .dac03_dg_addra               (m03_dg_addra       ), //
   .dac03_dg_wea                 (m03_dg_wea         ), //
   .dac03_dg_ena                 (m03_dg_ena         ), //
   .dac03_dg_dina                (m03_dg_dina        ), //
   .dac03_dg_douta               (m03_dg_douta       ), //
   .dac03_dg_num_samples         (m03_dg_num_samples ), //
   .dac03_dg_enable              (m03_dg_enable_ram  ), //
   .dac10_dg_addra               (m10_dg_addra       ), //
   .dac10_dg_wea                 (m10_dg_wea         ), //
   .dac10_dg_ena                 (m10_dg_ena         ), //
   .dac10_dg_dina                (m10_dg_dina        ), //
   .dac10_dg_douta               (m10_dg_douta       ), //
   .dac10_dg_num_samples         (m10_dg_num_samples ), //
   .dac10_dg_enable              (m10_dg_enable_ram  ), //
   .dac11_dg_addra               (m11_dg_addra       ), //
   .dac11_dg_wea                 (m11_dg_wea         ), //
   .dac11_dg_ena                 (m11_dg_ena         ), //
   .dac11_dg_dina                (m11_dg_dina        ), //
   .dac11_dg_douta               (m11_dg_douta       ), //
   .dac11_dg_num_samples         (m11_dg_num_samples ), //
   .dac11_dg_enable              (m11_dg_enable_ram  ), //
   .dac12_dg_addra               (m12_dg_addra       ), //
   .dac12_dg_wea                 (m12_dg_wea         ), //
   .dac12_dg_ena                 (m12_dg_ena         ), //
   .dac12_dg_dina                (m12_dg_dina        ), //
   .dac12_dg_douta               (m12_dg_douta       ), //
   .dac12_dg_num_samples         (m12_dg_num_samples ), //
   .dac12_dg_enable              (m12_dg_enable_ram  ), //
   .dac13_dg_addra               (m13_dg_addra       ), //
   .dac13_dg_wea                 (m13_dg_wea         ), //
   .dac13_dg_ena                 (m13_dg_ena         ), //
   .dac13_dg_dina                (m13_dg_dina        ), //
   .dac13_dg_douta               (m13_dg_douta       ), //
   .dac13_dg_num_samples         (m13_dg_num_samples ), //
   .dac13_dg_enable              (m13_dg_enable_ram  ), //

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

endmodule
