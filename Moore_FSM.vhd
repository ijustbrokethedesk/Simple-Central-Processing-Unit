LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Moore_FSM IS

	port (
		data_in, clk, reset : in std_logic ;
		data_out 			  : out std_logic_vector(7 downto 0);
		current_state       : out std_logic_vector(3 downto 0)
	);
	
end Moore_FSM ;

architecture Behaviour of Moore_FSM is
type states is (s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10);
signal yfsm : states ;

begin

	process ( clk, reset )

	begin

		if reset = '0' then yfsm <= s0 ;

		elsif (rising_edge(clk) AND data_in = '1') then
			case yfsm is
			
				when s0 =>	yfsm <= s1;
				when s1 =>	yfsm <= s2;
				when s2 =>	yfsm <= s3;
				when s3 =>	yfsm <= s4;
				when s4 =>	yfsm <= s5;
				when s5 =>	yfsm <= s6;
				when s6 =>	yfsm <= s7;
				when s7 =>	yfsm <= s8;
				when s8 =>	yfsm <= s9;
				when s9 =>	yfsm <= s10;
				when s10 =>	yfsm <= s0;

			end case ;
		end if ;
	end process ;

	process ( yfsm )

	begin

		case yfsm is
			when s0  => current_state <= "0001" ;	data_out <= "10011000"; -- Add 152 to A
			when s1  => current_state <= "0010" ;	data_out <= "01000000"; -- Subtract 64 from A
			when s2  => current_state <= "0011" ;	data_out <= "00001111"; -- A AND      0b"1111"
			when s3  => current_state <= "0100" ;	data_out <= "11110000"; -- A OR   0b"11110000"
			when s4  => current_state <= "0101" ;	data_out <= "11111111"; -- A XOR  0b"11111111"
			when s5  => current_state <= "0110" ;	data_out <= "00000000"; -- NOT A
			when s6  => current_state <= "0111" ;	data_out <= "10101010"; -- A NAND 0b"10101010"
			when s7  => current_state <= "1000" ;	data_out <= "01010101"; -- A NOR  0b"01010101"
			when s8  => current_state <= "1001" ;	data_out <= "00000000"; -- A XNOR 0b"00000000"
			when s9  => current_state <= "1010" ;	data_out <= "00000000"; -- SHR A
			when s10 => current_state <= "1011" ;	data_out <= "00000000"; -- SHL A

		end case ;
	end process ;
end Behaviour ;