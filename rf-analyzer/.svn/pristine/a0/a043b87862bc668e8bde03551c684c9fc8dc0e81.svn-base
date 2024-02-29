-------------------------------------------------------------------------------
-- Copyright (c) 2020 Knowledge Resources GmbH
-------------------------------------------------------------------------------

library ieee;
use ieee.std_logic_1164.all;


entity mux_sel is
	generic (
		N          : natural := 1
	);
	port (
		cs_n   : in  std_logic_vector(N-1 downto 0);
		I      : in  std_logic_vector(N-1 downto 0);
		O      : out std_logic
	);
end entity mux_sel;

architecture structure of mux_sel is
begin
  process(cs_n, I)
  begin
    O   <= '0';
    for x in I'range loop
      if cs_n(x)='0' then
        O <= I(x);
        exit;
      end if;
    end loop;
  end process;

end architecture structure;
