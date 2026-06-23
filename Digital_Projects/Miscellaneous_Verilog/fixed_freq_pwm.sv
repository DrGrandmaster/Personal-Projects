/*
Basic PWM Generator.
Provides PWM waveform at a fixed frequency; the input clock frequency.
*/

module fixed_freq_pwm   #(
                            parameter   W = 8
                        ) (
                            input   bit                 clk,
                            input   logic               rstb,
                            input   logic               enable,
                            input   logic   [(W-1):0]   duty,
                            output  logic               pwm
                        );

    logic [(W-1):0] count;

    up_down_counter #(
                        .W
                    ) counter (
                        .clk,
                        .rstb,
                        .load(0),
                        .count_in('0),
                        .enable,
                        .up(1),
                        .count
                    );

    always_comb begin : pwm_out
        
        /* 
            By using < we stay true to the formula duty cycle = duty / 2^BITS.
            Thus our output range (after LPF) is VDD*[0, 255/256].
            If we use <=, it is VDD*[1/256, 1].
            Zero output is more important generally than VDD, as we have other ways of getting that.
        */
        pwm = (count < duty) && (enable && rstb);

    end

endmodule