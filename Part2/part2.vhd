library IEEE;
use IEEE.STD_LOGIC_1164.all;
use IEEE.STD_LOGIC_UNSIGNED.all;

----------------------------------------------------
entity UNSIGNED_MULTIPLIER4x4 is
port (
CLK: in STD_LOGIC;
IN1, IN2: in STD_LOGIC_VECTOR(3 downto 0);
PRODUCT : out STD_LOGIC_VECTOR(7 downto 0));
end UNSIGNED_MULTIPLIER4x4;

architecture structure_view of UNSIGNED_MULTIPLIER4x4 is
  --component declrations
  component shift_register_p
  port(
  CLK, BIT_IN: in STD_LOGIC;
  LOAD_IN: in STD_LOGIC_VECTOR (3 downto 0);
  FULL_OUT: out STD_LOGIC_VECTOR(3 downto 0);
  BIT_OUT: out STD_LOGIC;
  );
  end component;
  component shift_register_a
    port (
    CLK, BIT_IN: in STD_LOGIC;
    LOAD_IN: in STD_LOGIC_VECTOR (3 downto 0);
    FULL_OUT: out STD_LOGIC_VECTOR(3 downto 0);
    );
  end component;

  component and_gate
    port (
      input_1    : in  std_logic;
      input_2    : in  std_logic;
      and_result : out std_logic
      );
  end component;

  component ADDER
  generic(n: natural :=2);
  port(	A:	in std_logic_vector(n-1 downto 0);
    B:	in std_logic_vector(n-1 downto 0);
    carry:	out std_logic;
    sum:	out std_logic_vector(n-1 downto 0)
  );
  end component;
  component  DFF
    port (
    CLK : in STD_LOGIC;
    D, RST : in STD_LOGIC;
    Q : out STD_LOGIC;
    );
  end component;

  --
  signal a_out : STD_LOGIC_VECTOR(3 downto 0);
  signal adder_out, adder_in : STD_LOGIC_VECTOR(3 downto 0);
  signal carry : STD_LOGIC;
  signal dff_out, dff_in : STD_LOGIC;
  signal and_out : STD_LOGIC_VECTOR(3 downto 0);
  signal p_bit : STD_LOGIC;
  signal p_out : STD_LOGIC_VECTOR(3 downto 0);

begin
  adder: ADDER generic map(4)
               port map (adder_out, p_out, dff_in, adder_out);
  and0: and_gate port map(IN2[0], a_out[0], adder_in[0]);
  and1: and_gate port map(IN2[1], a_out[0], adder_in[1]);
  and2: and_gate port map(IN2[2], a_out[0], adder_in[2]);
  and3: and_gate port map(IN2[3], a_out[0], adder_in[3]);
  a: shift_register_a port map(CLK,p_bit,IN1, a_out);
  p: shift_register_p port map(CLK, dff_out, adder_out, p_out, p_bit);
  dff :DFF port map(CLK, dff_in, RST, dff_out);
end structure_view;

---------------------------------------------------
entity shift_register_p is
port (
CLK, BIT_IN: in STD_LOGIC;
LOAD_IN: in STD_LOGIC_VECTOR (3 downto 0);
FULL_OUT: out STD_LOGIC_VECTOR(3 downto 0);
BIT_OUT: out STD_LOGIC;
);
end shift_register_p;
architecture Behavioral of shift_register_p is
  signal shift_register : STD_LOGIC_VECTOR(3 downto 0);
  begin
    if LOAD_IN'event then
      shift_register <= LOAD_IN;
    end if;
    process(CLK)
      BIT_IN <= shift_register(3);
      shift_register(2) <= shift_register(1);
      shift_register(1) <= shift_register(0);
      BIT_OUT <= shift_register(0);
    end process;
    FULL_OUT <= shift_register;
  end
----------------------------------------------------

entity shift_register_a is
  port (
  CLK, BIT_IN: in STD_LOGIC;
  LOAD_IN: in STD_LOGIC_VECTOR (3 downto 0);
  FULL_OUT: out STD_LOGIC_VECTOR(3 downto 0);
  );
end shift_register_a;

architecture Behavioral of shift_reg_a is
  signal shift_register : STD_LOGIC_VECTOR(3 downto 0);
  begin
    if LOAD_IN'event then
      shift_register <= LOAD_IN;
    end if;
    process(CLK)
    begin
      shift_register(3) <= BIT_IN;
      shift_register(2) <= shift_register(3);
      shift_register(1) <= shift_register(2);
      shift_register(0) <= shift_register(1);
    end process;
    FULL_OUT <= shift_register;
  end Behavioral;
  --------------------------------------------------

entity ADDER is
  generic(n: natural :=2);
  port(	A:	in std_logic_vector(n-1 downto 0);
  	B:	in std_logic_vector(n-1 downto 0);
  	carry:	out std_logic;
  	sum:	out std_logic_vector(n-1 downto 0)
  );

end ADDER;

architecture Behavioral of ADDER is
signal result: std_logic_vector(n downto 0);
begin
    result <= ('0' & A)+('0' & B);
    sum <= result(n-1 downto 0);
    carry <= result(n);

end Behavioral;

-----------------------------------------------------
entity  DFF is
  port (
  CLK : in STD_LOGIC;
  D, RST : in STD_LOGIC;
  Q : out STD_LOGIC;
  );
end DFF;

architecture Behavioral of DFF is

begin
  process(CLK)
    begin
      if( rising_edge(CLK)) then
      if( RST = '1') then
        Q <= '0';
      else
        Q <= D;
      end if;
      end if;
    end process;
end Behavioral;

--------------------------------
entity and_gate is
  port (
    input_1    : in  std_logic;
    input_2    : in  std_logic;
    and_result : out std_logic
    );
end and_gate;

architecture rtl of and_gate is
  signal and_gate : std_logic;
begin
  and_gate   <= input_1 and input_2;
  and_result <= and_gate;
end rtl;
