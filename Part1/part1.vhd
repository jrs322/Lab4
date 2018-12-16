library IEEE;
use IEEE.STD_LOGIC_1164.ALL;

entity array_multplier is -- full module
  port(A: in range(0 to 3);
  B: in range(0 to 3);
  C: out range(0 to 8);
  );
end array_multplier;

architecture gate_level of array_multplier is
  signal s0, s1, s2, s3, s4, s5, s6, s7, s8, s9, s10, s11, s12: STD_LOGIC;
  signal c0, c1, c2, c3, c4, c5, c6, c7, c8, c9, c10, c11, c12, c13, c14, c15: STD_LOGIC;
  signal k0, k2, k3: STD_LOGIC;
  signal zero: = '0';

begin
  A_add: and_adder port map (C[0], c0, A[0], zero, B[0], zero);
  B_add: and_adder port map (s0, c1, A[0], zero, B[1], zero);
  C_add: and_adder port map (s1, c2, A[0], zero, B[2], zero);
  D_add: and_adder port map (s2, c3, A[0], zero, B[3], zero);
  E_add: and_adder port map (C[1], c4, A[1], s0, B[0], c0);
  F_add: and_adder port map (s3, c5, A[1], s1, B[1], c1);
  G_add: and_adder port map (s4, c6, A[1], s2, B[2], c2);
  H_add: and_adder port map (s5, c7, A[1], zero, B[3], c3);
  I_add: and_adder port map (C[2], c8, A[2], s3, B[0], c4);
  J_add: and_adder port map (s6, c9, A[2], s4, B[1], c5);
  K_add: and_adder port map (s7, c10, A[2], s5, B[2], c6);
  L_add: and_adder port map (s8, c11, A[2], zero, B[3], c7);
  M_add: and_adder port map (C[3], c12, A[3], s6, B[0], c8);
  N_add: and_adder port map (s9, c13, A[3], s7, B[1], c9);
  O_add: and_adder port map (s10, c14, A[3], s8, B[2], c10);
  P_add: and_adder port map (s11, c15, A[3], zero, B[3], c11);
  Q_add: full_adder port map (C[4], k0, s9, c12, zero); -- fulladder
  R_add: full_adder port map (C[5], k1, s10, c13, k0); -- fulladder
  S_add: full_adder port map (C[6], k2, s11, c14, k1); -- fulladder
  T_add: full_adder port map (C[7], k3, zero, c15, k2); -- fulladder

end architecture;









entity and_adder is --
  port (cin: in STD_LOGIC;
  B: in STD_LOGIC;
  SIN: in STD_LOGIC;
  A: in STD_LOGIC;
  CIN: in STD_LOGIC;
  SO: out STD_LOGIC;
  CO: out STD_LOGIC;
  );
end and_adder;

architecture gate_level of and_adder is
  signal X: in STD_LOGIC
begin
  X = A AND B;
  S <= X XOR CI XOR SIN;
  CO <= (X AND SIN) OR (CI AND X) OR (CI AND SIN);
end architecture;


entity full_adder is
  port (A: in STD_LOGIC;
  B: in STD_LOGIC;
  cin: in STD_LOGIC;
  S: out STD_LOGIC;
  co: out STD_LOGIC;
  );
end full_adder;

architecture gate_level of full_adder is
begin
  S <= A XOR B XOR cin;
  co <= (A AND B) OR (cin AND A) OR (cin AND B);
end gate_level;
