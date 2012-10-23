entity fifo is
 generic
 (
  DATA_WIDTH := 8; -- in bits
  FIFO_DEPTH := 8 -- in bytes
 );
 port
 (
  rst: in std_logic;
  clk: in std_logic;
  rdata: out std_logic_vector((DATA_WIDTH - 1) downto 0);
  ren: in std_logic;
  wdata: in std_logic_vector((DATA_WIDTH - 1) downto 0);
  wen: in std_logic;
  is_full: out std_logic;
  is_empty: std_logic
 );
end fifo;
