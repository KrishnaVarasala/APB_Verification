//Transaction Class : will add modifiers to the declared interface signals and will add constraints

class apb_seq_item extends uvm_sequence_item;
  `uvm_object_utils(apb_seq_item)
  
  logic presetn;
  logic pclk;
  logic psel;
  logic penable;
  rand logic pwrite;
  rand logic [31:0] paddr; 
  rand logic [31:0] pwdata;
  logic [31:0] prdata;
  logic pready;
  logic pslverr;
  
  function new(string name = "apb_seq_item");
    super.new(name);
  endfunction
  
  constraint c1 {paddr >0 && paddr < 15;
                }
  constraint c2 {pwrite dist {1:=5 , 0:=7};
                }
  constraint c3 {pwdata > 0 && pwdata < 256;
                }
endclass
