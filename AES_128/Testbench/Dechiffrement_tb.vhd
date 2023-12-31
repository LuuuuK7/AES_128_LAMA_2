--	  ________  ________  ________  ___  __    ________  ________  _______           ________  _______   ________           _________  ________     
--	 |\   __  \|\   __  \|\   ____\|\  \|\  \ |\   __  \|\   ____\|\  ___ \         |\   __  \|\  ___ \ |\   ____\         |\___   ___\\   __  \    
--	 \ \  \|\  \ \  \|\  \ \  \___|\ \  \/  /|\ \  \|\  \ \  \___|\ \   __/|        \ \  \|\  \ \   __/|\ \  \___|_        \|___ \  \_\ \  \|\ /_   
--	  \ \   ____\ \   __  \ \  \    \ \   ___  \ \   __  \ \  \  __\ \  \_|/__       \ \   __  \ \  \_|/_\ \_____  \            \ \  \ \ \   __  \  
--	   \ \  \___|\ \  \ \  \ \  \____\ \  \\ \  \ \  \ \  \ \  \|\  \ \  \_|\ \       \ \  \ \  \ \  \_|\ \|____|\  \            \ \  \ \ \  \|\  \ 
--	    \ \__\    \ \__\ \__\ \_______\ \__\\ \__\ \__\ \__\ \_______\ \_______\       \ \__\ \__\ \_______\____\_\  \            \ \__\ \ \_______\
--	     \|__|     \|__|\|__|\|_______|\|__| \|__|\|__|\|__|\|_______|\|_______|        \|__|\|__|\|_______|\_________\            \|__|  \|_______|
--	                                                                                                       \|_________|                             
                                                                                                                                          
-----------------------------------------------------
-- testbench de tout
-----------------------------------------------------
-- Auteur : Groupe LAMA
-- Date   : fevrier 2023
------------------------------------------------------


library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;
use work.my_package.all;
use work.my_package_2.all; 
use work.package_dechiffrement.all;


entity Dechiffrement_tb is
end Dechiffrement_tb;

architecture arch of Dechiffrement_tb is

	component aes_top_du_top is 
	Port (
		clk     : in  std_logic;
		rstn    : in  std_logic;
		key_in  : in  std_logic_vector(127 downto 0);
		cipher  : in  std_logic_vector(127 downto 0);
		clear   : out std_logic_vector(127 downto 0)
		);

  end component;

signal clk		: std_logic := '0';
signal rstn		: std_logic := '0';		
signal key_in	: std_logic_vector(127 downto 0);-- := x"2b7e151628aed2a6abf7158809cf4f3c";
signal cipher 	: std_logic_vector(127 downto 0);--  := x"3902DC1925DC116A8409850B1DFB9732";
signal clear 	: std_logic_vector(127 downto 0);
 
begin

  TOP_DU_TOP: aes_top_du_top 
    port map(
      clk      	=> clk,
	  rstn		=> rstn,
	  key_in   	=> key_in,
	  cipher   	=> cipher,
	  clear    	=> clear
    );

    -- G�n�ration d'une horloge
    clk_process: process
    begin
        wait for 5 ns;
        clk <= not clk;
    end process;

 -- Processus de simulation
    stim_proc: process
    begin
		rstn <= '0';
		wait for 100 ns;
		rstn <= '1';

		key_in <= x"2b7e151628aed2a6abf7158809cf4f3c";		
		cipher <= x"3902DC1925DC116A8409850B1DFB9732";
		wait for 300 ns;

		key_in <= x"DEADBEEFDEADBEEFDEADBEEFDEADBEEF";
		wait for 300 ns;
		 
		key_in <= x"2b7e151628aed2a6abf7158809cf4f3c";
		wait for 300 ns;
		
		report "Simulation termin�e";
		wait;
    end process;
	


end architecture;
