module MITI_PLL_Divider (
        input  logic clk,
        input  logic sync_inl,
        input  logic sync_inh,
        output logic clk_out,
        output logic clk_fix
        );

logic   [5:0]  counter, counter_dl;
logic   sync_inh_reg, sync_inl_reg;

always_ff @(posedge clk) begin

	sync_inh_reg <= sync_inh;
	counter_dl   <= counter;
	clk_out      <= (counter_dl[5] && sync_inl_reg) ? counter_dl[4] : counter[4];

	clk_fix      <= counter[4];

	if (!sync_inh && sync_inh_reg) 
		begin
		  counter      <= 0;
		  sync_inl_reg <= sync_inl;
		end 
	else 
		counter      <= counter  + 6'b000001;
	end // @posedge clk

endmodule