----------------------------------------------------------------------------------
-- Autor: Mateusz Kowalczyk
-- Numer Indeksu: 268533
-- Data oddania projektu: 26.01.2024.r
-- Temat: Kalkulator - module file
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

entity simple_alu is
    Port ( 
			-- input
			A : in STD_LOGIC_VECTOR (3 downto 0);
         B : in STD_LOGIC_VECTOR (3 downto 0);
         operator : in STD_LOGIC_VECTOR (1 downto 0);
			clk : in std_logic;
			reset: in std_logic;
			-- output
         result : out STD_LOGIC_VECTOR (7 downto 0));
			
end simple_alu;

architecture Behavioral of simple_alu is
begin
    process(A, B, operator, clk, reset)
    begin
	 
	 if rising_edge(clk) and reset = '1' then
		case operator is
			 when "00" => -- dodawanie
				  result <= "0000" & std_logic_vector(unsigned(A) + unsigned(B));
			 when "01" => -- odejmowanie
				  result <= "0000" & std_logic_vector(unsigned(A) - unsigned(B));
			 when "10" => -- mno¿enie
				  result <= std_logic_vector(unsigned(A) * unsigned(B));
			 when "11" => -- dzielenie ze sprawdzeniem czy nie dzielimy przez zero
				  if B /= "0000" and A /= "0000" then
						result <= "0000" & std_logic_vector(unsigned(A) / unsigned(B));
				  else
						result <= "00000000"; 
				  end if;
			 when others =>
				  result <= (others => '0'); 
		end case;
		end if;

    end process;
end Behavioral;




