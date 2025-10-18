LIBRARY ieee ;
USE ieee.std_logic_1164.all ;
USE ieee.numeric_std.all;

entity BCD_to_SSEG is
	port (
		Neg_flag : IN std_logic;
		X  		: IN std_logic_vector(7 downto 0);
		D1   		: OUT std_logic_vector(6 downto 0);
		D2   		: OUT std_logic_vector(6 downto 0);
		D3   		: OUT std_logic_vector(6 downto 0);
		Sign 		: OUT std_logic
	);

end BCD_to_SSEG ;

architecture Behavior of BCD_to_SSEG is

	function BCD_to_Digit(digit : unsigned(3 downto 0)) return std_logic_vector is
		begin
	
		case digit is
			when "0000" => return NOT "1111110";
			when "0001" => return NOT "0110000";
			when "0010" => return NOT "1101101";
			when "0011" => return NOT "1111001";
			when "0100" => return NOT "0110011";
			when "0101" => return NOT "1011011";
			when "0110" => return NOT "1011111";
			when "0111" => return NOT "1110000";
			when "1000" => return NOT "1111111";
			when "1001" => return NOT "1111011";
			when others => return     "-------";
		end case;
		 
	end function;

	begin

	process(X)
	
		variable Shift_register : unsigned(19 downto 0);
	
		begin
	
        Shift_register := (others => '0');
		  
		  if Neg_flag = '1' then
				Shift_register(7 downto 0) := unsigned(NOT X) + 1;
		  else
				Shift_register(7 downto 0) := unsigned(X);
		  end if;

        for i in 7 downto 0 loop
		  
            if Shift_register(19 downto 16) >= to_unsigned(5,4) then
                Shift_register(19 downto 16) := Shift_register(19 downto 16) + 3;
            end if;
				
            if Shift_register(15 downto 12) >= to_unsigned(5,4) then
                Shift_register(15 downto 12) := Shift_register(15 downto 12) + 3;
            end if;
				
            if Shift_register(11 downto  8) >= to_unsigned(5,4) then
                Shift_register(11 downto  8) := Shift_register(11 downto  8) + 3;
            end if;

            Shift_register := Shift_register(18 downto 0) & '0';
				
        end loop;
		
		D1 <= BCD_to_Digit(Shift_register(11 downto  8));
		D2 <= BCD_to_Digit(Shift_register(15 downto 12));
		D3 <= BCD_to_Digit(Shift_register(19 downto 16));
		sign <= Neg_flag;
	
	end process;
end Behavior ;