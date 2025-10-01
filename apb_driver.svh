class apb_driver extends uvm_driver #(apb_seq_item);
  
  `uvm_component_utils(apb_driver)
  
  apb_seq_item tr;
  virtual apb_if vif;
  
  function new(string name = "apb_driver",uvm_component parent = null);
    super.new(name,parent);
  endfunction
  
  virtual function void build_phase(uvm_phase phase);
    super.build_phase(phase);
    tr = apb_seq_item::type_id::create("tr");
    if(!uvm_config_db #(virtual apb_if)::get(this,"","vif",vif))
      `uvm_fatal("DRV","Cannot fetch the interface")
  endfunction
  
  virtual task run_phase(uvm_phase phase);
    reset();
    forever begin
      seq_item_port.get_next_item(tr);
      drive();
      seq_item_port.item_done();
    end
  endtask
  
  virtual task reset();
    vif.presetn <= 0;
    vif.psel <= 0;
    vif.pwrite <= 0;
    vif.paddr <= 0;
    vif.pwdata <= 0;
    @(posedge vif.pclk)
    vif.presetn <= 1;
    `uvm_info("DRV_RSTN","RESET DONE",UVM_NONE)
  endtask
    
    virtual task drive();
      vif.psel <= 1;
      vif.pwrite <= tr.pwrite;
      vif.penable <=0;
      vif.paddr <= tr.paddr;
      if(vif.pwrite==1)begin
      vif.pwdata <= tr.pwdata;
        `uvm_info("DRV if Write",$sformatf("Pwrite : %0d || Paddr : %0d || Pwdata : %0d",vif.pwrite,vif.paddr,vif.pwdata),UVM_NONE);
      end
      else begin
        tr.prdata <= vif.prdata;
      `uvm_info("DRV if read",$sformatf("Pwrite : %0d || Paddr : %0d || Pwdata : %0d",vif.pwrite,vif.paddr,vif.pwdata),UVM_NONE);
      end
      @(posedge vif.pclk)
      vif.penable <= 1;
      @(negedge vif.pready)
      vif.penable <= 0;
    endtask
    endclass
      
      
    
      
  
  
