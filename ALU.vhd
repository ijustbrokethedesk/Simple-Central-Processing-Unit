LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

entity ALU is
	port ( 
		clk, res   : IN  std_logic;
		Opcode     : IN  std_logic_vector(3 downto 0);  -- 4-bit Opcode from Decoder
		RegA, RegB : IN  std_logic_vector(7 downto 0);	-- 8-bit inputs A & B
		Output     : OUT std_logic_vector(7 downto 0);  -- 8-bit Output
		NEGT		  : OUT std_logic;							-- Negative Flag
		OVFL		  : OUT std_logic							   -- Overflow Flag
	);
end ALU ;

architecture Behaviour of ALU is

	signal Result : std_logic_vector(8 downto 0);

	begin
	
	process ( clk, res )
		begin

		if res = '1' then
			Result <= (others => '0');

		elsif rising_edge(clk) then
			case opcode is
				when "0001" => Result <= std_logic_vector(('0' & unsigned(RegA)) + ('0' & unsigned(RegB)));
				
				when "0010" => Result <= std_logic_vector(('0' & signed(RegA)) - ('0' & signed(RegB)));
				
				when "0011" => Result <= '0' & (RegA AND RegB);
				
				when "0100" => Result <= '0' & (RegA OR RegB);
				
				when "0101" => Result <= '0' & (RegA XOR RegB);
				
				when "0110" => Result <= '0' & (NOT RegA);
				
				when "0111" => Result <= '0' & (NOT (RegA AND RegB));
				
				when "1000" => Result <= '0' & (NOT (RegA OR RegB));
				
				when "1001" => Result <= '0' & (NOT (RegA XOR RegB));
				
				when "1010" => Result <= "00" & RegA(6 downto 0);
				
				when "1011" => Result <= '0' & RegA(6 downto 0) & '0';
				
				when others => Result <= "---------";
				
			end case ;
			
		end if ;

		-- Signed Subtraction Overflow Check
		if opcode = "0010" then
		-- If MSB of A and B are different, and MSB of Result is different from A
			OVFL <= (RegA(7) XOR RegB(7)) AND (Result(7) XOR RegA(7));
			NEGT <= Result(7);
		
		else	
			OVFL <= Result(8);
			NEGT <= '0';
		
		end if;
		
		Output <= Result(7 downto 0);

	end process ;
end Behaviour ;
