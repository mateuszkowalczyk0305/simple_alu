----------------------------------------------------------------------------------
-- Autor: Mateusz Kowalczyk
-- Numer Indeksu: 268533
-- Data oddania projektu: 26.01.2024.r
-- Temat: Kalkulator - test bench
----------------------------------------------------------------------------------
library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_TEXTIO.ALL;
use std.textio.all;

entity alu_tb is

end alu_tb;

architecture behavior of alu_tb is

    component simple_alu
    Port ( -- wejœcia
			  A : in STD_LOGIC_VECTOR (3 downto 0);
           B : in STD_LOGIC_VECTOR (3 downto 0);
           operator : in STD_LOGIC_VECTOR (1 downto 0);
			  clk : in std_logic;
			  reset: in std_logic;
			  -- wyjscia
           result : out STD_LOGIC_VECTOR (7 downto 0));
    end component;

-- wejœcia
   signal A : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
   signal B : STD_LOGIC_VECTOR (3 downto 0) := (others => '0');
   signal operator : STD_LOGIC_VECTOR (1 downto 0) := (others => '0');
	signal clk : STD_LOGIC := '0';
	signal reset : STD_LOGIC := '0';
-- wyjœcia
   signal result : STD_LOGIC_VECTOR (7 downto 0);

   file result_file : text is out "wyniki.txt";
	
	constant clk_period : time := 10 ns;
	

begin

   uut: simple_alu port map (
        A => A,
        B => B,
        operator => operator,
		  clk => clk,
		  reset => reset,
        result => result
   );
	-- Clock process definitions
   clk_process :process
   begin
		clk <= '0';
		wait for clk_period/2;
		clk <= '1';
		wait for clk_period/2;
   end process;


   stim_proc: process
   variable l: line; -- przypisanie "line" do zmiennej "1"
   begin	

		reset <= '1';
		wait for clk_period*5;
		
		reset <= '0';
		wait for clk_period*5;
		
		reset <= '1';
		wait for clk_period*5;
		
      A <= "0010"; B <= "0011"; operator <= "00";
      wait for clk_period*5;
      write(l, string'("Dodawanie Result: "));
      write(l, result);
      writeline(result_file, l);

      A <= "0100"; B <= "0011"; operator <= "01";
      wait for clk_period*5;
      write(l, string'("Odejmowanie Result: "));
      write(l, result);
      writeline(result_file, l);

      A <= "0011"; B <= "0010"; operator <= "10";
      wait for clk_period*5;
      write(l, string'("Mnozenie Result: "));
      write(l, result);
      writeline(result_file, l);

      A <= "0100"; B <= "0010"; operator <= "11";
      wait for clk_period*5;
      write(l, string'("Dzielenie Result: "));
      write(l, result);
      writeline(result_file, l);

      A <= "0100"; B <= "0000"; operator <= "11";
      wait for clk_period*5;
      write(l, string'("Dzielenie Przez Zero Result: "));
      write(l, result);
      writeline(result_file, l);

      wait;
   end process;

end behavior;