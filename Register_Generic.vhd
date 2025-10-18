LIBRARY ieee;
USE ieee.std_logic_1164.all;
entity Register_Generic IS
	port( 
		X        : IN std_logic_vector(7 downto 0);	-- 8-bit input
		res, clk : IN std_logic;
		Q        : OUT std_logic_vector(7 downto 0)	-- 8-bit output
	);
end Register_Generic;

architecture Behavior of Register_Generic is
	begin
	
	process (res, clk)
	
		begin
			if res = '0' then
				Q <= "00000000" ;
				
			elsif rising_edge(clk) then
				Q <= X ;
				
			end if ;
			
	end process ;
end Behavior ;
