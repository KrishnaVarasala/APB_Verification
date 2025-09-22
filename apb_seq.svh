class apb_seq extends uvm_sequence #(apb_seq_item);
  
  `uvm_object_utils(apb_seq)
  
  apb_seq_item tr;
  
  function new(string name = "apb_seq");
    super.new(name);
  endfunction
  
  virtual task body();
    repeat(25)
      begin
      tr = apb_seq_item::type_id::create("tr");
      start_item(tr);
      tr.randomize();
      finish_item(tr);
    end
  endtask
  
endclass
