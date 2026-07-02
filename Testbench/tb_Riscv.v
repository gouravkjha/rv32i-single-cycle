`timescale 1ns / 1ps

module tb_Riscv();

reg clk;
reg rst;
integer i;

reg [31:0] expected_mem [0:31];

RV32I_SingleCycle_CPU dut (
    .clk(clk),
    .rst(rst)
);

initial clk = 1'b0;
always #5 clk = ~clk;

//-----------------------------------------------------
// Load Expected Register Values
//-----------------------------------------------------
initial begin
    $readmemh("Expected.mem", expected_mem);
end

initial begin
    i=0;
    rst = 1'b1;

    repeat(2) @(posedge clk);

    rst = 1'b0;

    // Wait until program finishes
    repeat(50) @(posedge clk);


    $display("      REGISTER FILE VERIFICATION    ");


    for(i = 0; i < 32; i = i + 1)
    begin
        if(dut.u_Register_File.regmem[i] === expected_mem[i])
            $display("x%0d : PASS | Expected = %08h | Actual = %08h",i,expected_mem[i],dut.u_Register_File.regmem[i]);
        
        
        else
            $display("x%0d : FAIL | Expected = %08h | Actual = %08h",i,expected_mem[i],dut.u_Register_File.regmem[i]);
        
      
    end
    
     $display("==============================================");
    
    
    
      $display(" PC VERIFICATION    ");
    
   if (dut.u_PC.PC === 32'h0000008c) 
        $display("PC VERIFICATION: PASS | Expected = 0000008c | Actual = %08h", dut.u_PC.PC);
    
    else 
        $display("PC VERIFICATION: FAIL | Expected = 0000008c | Actual = %08h", dut.u_PC.PC);
    

    $display("==============================================");
    
    
 repeat(5) @(posedge clk);
    $finish;

end

endmodule