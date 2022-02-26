`timescale 1ns / 1ps

`include "debouncer.v"
`include "pmod_ssd.v"

module top(input i_clock_125MHz,
           input i_btn,
           output o_seg_a,
           output o_seg_b,
           output o_seg_c,
           output o_seg_d,
           output o_seg_e,
           output o_seg_f,
           output o_seg_g,
           output o_seg_sel);
    
    reg [7:0] reg_value;
    reg btn_delay;
    
    wire btn;
    wire btn_pulse;
    wire reset = 1'b0;
    
    debouncer debouncer0(.i_clock (i_clock_125MHz),
                         .i_reset (reset),
                         .i_button(i_btn),
                         .o_button(btn));
    
    always @(posedge i_clock_125MHz)
      btn_delay <= btn;
      
    assign btn_pulse = ~btn_delay & btn;
    
    always @(posedge i_clock_125MHz)
      if (btn_pulse)
        reg_value <= reg_value + 1;
    
    pmod_ssd pmod_ssd0(.i_clock_125MHz(i_clock_125MHz),
                       .i_data        (reg_value),
                       .o_seg_a       (o_seg_a),
                       .o_seg_b       (o_seg_b),
                       .o_seg_c       (o_seg_c),
                       .o_seg_d       (o_seg_d),
                       .o_seg_e       (o_seg_e),
                       .o_seg_f       (o_seg_f),
                       .o_seg_g       (o_seg_g),
                       .o_seg_sel     (o_seg_sel));  
endmodule
