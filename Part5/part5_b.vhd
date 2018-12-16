library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

entity circuit5 is
  port(
  E,W : in  STD_LOGIC;
  S: out STD_LOGIC;
  );
end circuit5;

architecture Behavioral of circuit5 is

  signal q1, q2: STD_LOGIC;
begin
  q1 <= E or ((not q2) and q1) or (q1 and W);
  q2 <= W or ((not q1) and q2) or (q2 and E);
  S <= (q1 nor q2);
end architecture;
