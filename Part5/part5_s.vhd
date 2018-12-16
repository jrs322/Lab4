library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity circuit5 is
  port(
  CLK, e, w: in STD_LOGIC;
  s: out STD_LOGIC;
  );
end circuit5;

architecture gate_level of circuit5 is
  component DFF
    port(
    CLK, D in STD_LOGIC;
    Q: out STD_LOGIC;
    );
  end component;
  signal d1, d2, q1, q2: std_logic;
begin
  dff1 : DFF port map(CLK, d1, q1);
  dff2 : DFF port map(CLK, d2, q2);
  d1 <= e or ((not q2) and q1) or (q1 and w);
  d2 <= w or ((not q1) and q2) or (q2 and e);
  s <= (q1 nor q2);
end architecture;

entity  DFF is
  port (
  CLK, D : in STD_LOGIC;
  Q : out STD_LOGIC;
  );
end DFF;

architecture Behavioral of DFF is

begin
  process(CLK)
    begin
      if( rising_edge(CLK)) then
        Q <= D;
      end if;
    end process;
end Behavioral;
