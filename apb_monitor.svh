class apb_monitor extends uvm_monitor;
  `uvm_component_utils(apb_monitor)
  
  apb_seq_item tr;
  virtual apb_if vif;
  uvm_analysis_port #(apb_seq_item) sender;
  
  function new(string name = "apb_monitor",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = apb_seq_item::type_id::create("tr");
    if(!uvm_config_db #(virtual apb_if)::get(this," ","vif",vif))
      `uvm_fatal("MON","Fetching interface is failed");
    sender = new("sender",this);
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    forever begin
      @(posedge vif.pclk)
        if(vif.presetn && vif.pwrite && vif.pready)begin
        tr.psel = vif.psel;
        tr.penable = vif.penable;
        tr.paddr = vif.paddr;
      tr.pwdata = vif.pwdata;
          tr.pwrite = vif.pwrite;
          sender.write(tr);
          `uvm_info("MON if Write",$sformatf("Pwrite : %0d || Paddr : %0d || Pwdata : %0d",vif.pwrite,vif.paddr,vif.pwdata),UVM_NONE);
      end
      else if(vif.presetn && !vif.pwrite && vif.pready)begin
        tr.psel = vif.psel;
        tr.penable = vif.penable;
        tr.paddr = vif.paddr;
        tr.prdata = vif.prdata;
        tr.pwrite = vif.pwrite;
        sender.write(tr);
        `uvm_info("MON if read",$sformatf("Pwrite : %0d || Paddr : %0d || Pwdata : %0d",vif.pwrite,vif.paddr,vif.pwdata),UVM_NONE);
      end
    end    
  endtask
endclass
  
    
      
