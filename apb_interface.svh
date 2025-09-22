interface apb_if;
  logic presetn;
  logic pclk;
  logic psel;
  logic penable;
  logic pwrite;
  logic [31:0] paddr; 
  logic [31:0]pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;
endinterface
