/*
Up-Down Counter of W bits (default W = 8) with async reset, enable, and parallel load.
!Note! Timings from derived clock unsuitable for high speed applications.
*/

module up_down_counter #(
                            parameter   W = 8
                        ) (
                            input   bit                 clk,
                            input   logic               rstb,
                            input   logic               load,
                            input   logic   [(W-1):0]   count_in,
                            input   logic               enable,
                            input   logic               up,
                            output  logic   [(W-1):0]   count
                        );
    
    always_ff @( posedge clk or negedge rstb) begin : counter_update
        
        priority if ( !rstb )

            count <= 0;
        
        else if ( load )

            count <= count_in;

        else if ( enable )

            unique if ( up )

                count <= count + 1;

            else
                
                count <= count - 1;

        else

            count <= count;
            
    end : counter_update

endmodule