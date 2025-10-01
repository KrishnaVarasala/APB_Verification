class apb_env extends uvm_env;
  `uvm_component_utils(apb_env)
  
  apb_agent agnt;
  apb_scoreboard sco;
  
  function new(string name = "apb_env",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    agnt = apb_agent::type_id::create("agnt",this);
    sco = apb_scoreboard::type_id::create("sco",this);
  endfunction
  
  virtual function void connect_phase(uvm_phase phase);
    super.connect_phase(phase);
    agnt.mon.sender.connect(sco.recv);
  endfunction
endclass
    
