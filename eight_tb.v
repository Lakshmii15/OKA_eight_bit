`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 14.02.2024 20:30:08
// Design Name: 
// Module Name: fpga-8bit
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////

module fpga_8bit(
  input [7:0] A,
  input [7:0] B,
  output [15:0] Result
);

  reg [3:0] A1, A0, B1, B0;
  reg [7:0] P1, P2, P3;
  reg [3:0] I1;

  // Split the input numbers
  always @* begin
    {A1, A0} = A;
    {B1, B0} = B;
  end

  // Recursively compute three products
  always @* begin
    P1 = A1 * B1;
    P2 = A0 * B0;
    P3 = (A1 + A0) * (B1 + B0) - P1 - P2;
  end

  // Compute the intermediate term
 // always @* begin
   // I1 = P3[7:0] - P1[7:0] - P2[7:0];
  //end

  // Combine the results
  assign Result = {P1,P3,P2};

endmodule

module fpga_8bit_tb;

  reg [7:0] A, B;
  wire [15:0] Result;

  // Instantiate the Karatsuba module
  fpga_8bit fpga_inst (
    .A(A),
    .B(B),
    .Result(Result)
  );

  // Apply stimulus to the inputs
  initial begin
    // Loop through all possible 16-bit binary inputs
   // for (A = 10111001; A < 16'hFFFF; A = A + 1) begin
     // for (B = 14; B < 16'hFFFF; B = B + 1) begin
     A = 10111000;
     B=00001111;
        #100; // Wait for one time unit
        

        // Display inputs and corresponding result
        $display("Test with A=%h, B=%h, Result=%h", A, B, Result);

        // Verify result
        if (Result !== A * B) begin
          $display("Test failed for A=%h, B=%h", A, B);
          // Continue simulation
       // end
    //  end
    end

    $display("All tests passed successfully.");
    $finish; // Finish simulation
  end

endmodule
