LIBRARY ieee;
USE ieee.std_logic_1164.all;

entity Span4x8 is
	port (
	DIN  : IN  std_logic_vector(3 downto 0);
	DOUT : OUT std_logic_vector(7 downto 0)
	);
end Span4x8 ;

architecture Behaviour of Span4x8 is
	
	begin
	
	DOUT <= "0000" & DIN;

end Behaviour;