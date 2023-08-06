library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

library neorv32;
use neorv32.neorv32_package.all;

entity neorv32_pynq is
  port (
    clk_i       : in  std_ulogic;
    rstn_i      : in  std_ulogic;
    gpio_o      : out std_ulogic_vector(7 downto 0);
    uart0_txd_o : out std_ulogic;
    uart0_rxd_i : in  std_ulogic;
    uart1_txd_o : out std_ulogic;
    uart1_rxd_i : in  std_ulogic
  );
end entity;

architecture neorv32_pynq_rtl of neorv32_pynq is
  signal con_gpio_o : std_ulogic_vector(63 downto 0);
begin
  neorv32_top_inst: neorv32_top
  generic map (
    CLOCK_FREQUENCY            => 100000000,
    INT_BOOTLOADER_EN          => true,
    CPU_EXTENSION_RISCV_C      => true,
    CPU_EXTENSION_RISCV_M      => true,
    CPU_EXTENSION_RISCV_Zicntr => true,
    CPU_IPB_ENTRIES            => 2,
    MEM_INT_IMEM_EN            => true,
    MEM_INT_IMEM_SIZE          => 16*1024,
    MEM_INT_DMEM_EN            => true,
    MEM_INT_DMEM_SIZE          => 8*1024,
    IO_GPIO_NUM                => 8,
    IO_MTIME_EN                => true,
    IO_UART0_EN                => true,
    IO_UART1_EN                => true
  )
  port map (
    clk_i       => clk_i,
    rstn_i      => rstn_i,
    gpio_o      => con_gpio_o,
    uart0_txd_o => uart0_txd_o,
    uart0_rxd_i => uart0_rxd_i,
    uart1_txd_o => uart1_txd_o,
    uart1_rxd_i => uart1_rxd_i
  );

  gpio_o <= con_gpio_o(7 downto 0);
end architecture;
