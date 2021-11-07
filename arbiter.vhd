library IEEE;
use IEEE.STD_LOGIC_1164.ALL;



entity arbit is
 Port ( clk, rst: in std_logic;
        sys1: in std_logic;
        sys2: in std_logic;
        prio : in std_logic;
        mem_rdy : in std_logic;
        data1 : in std_logic_vector(7 downto 0);
        data2 : in std_logic_vector(7 downto 0);
        data_out : out std_logic_vector(7 downto 0);
        g1 : out std_logic;
        g2 : out std_logic;
        cmd_rdy : out std_logic;
        cmd_out : out std_logic := '0';
        addr_out : out std_logic_vector(7 downto 0));
end arbit;

architecture Behavioral of arbit is

type state is (s0,s1,s2,s3,s4,s5,s6);
signal present, nexts: state;

begin 

process(clk, rst)

begin
 if (rst = '1') then
      present <= s0;
  elsif (clk = '1' and clk'event) then
      present <= nexts;
  end if;
end process;

process(present, mem_rdy, sys1, sys2, prio, data1, data2)
begin
    nexts <= s0;
    case present is
    when s0 =>
      if mem_rdy = '1' then
         if prio = '1' and sys1 = '1' and sys2 = '0' then
            data_out <= data1; 
            addr_out <= data1;
            g1 <= '1';  
            g2 <= '0'; 
            cmd_rdy <= '1';
            nexts <= s1;
         else
            nexts <= s0;
         end if;
         
         if prio = '1' and sys1 = '0' and sys2 = '1' then
            data_out <= data2;
            g1 <= '0';
            g2 <= '1';   
            cmd_rdy <= '1';
            nexts <= s2;
         else
            nexts <= s0;
    end if;
    
    if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s3;  
     else
          nexts <= s0;
    end if;
    
   if prio = '1' and sys1 = '1' and sys2 = '0' then
          data_out <= data1; 
          addr_out <= data1;
          g1 <= '1';  
          g2 <= '0'; 
          cmd_rdy <= '1';
          nexts <= s4;
     else
          nexts <= s0;
    end if;
    
    if prio = '1' and sys1 = '0' and sys2 = '1' then
          data_out <= data2;
          g1 <= '0';
          g2 <= '1';   
          cmd_rdy <= '1';
          nexts <= s5;
       else
          nexts <= s0;
    end if;
    
    if prio = '1' and sys2 = '0' and sys1 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';     
          nexts <= s6;
   else
    nexts <= s0;
    end if;
   
  else 
    nexts <= s0;
  end if;
 
 when s1 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if;
        
  when s2 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if;
   when s3 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if;  
    when s4 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if;   
     when s5 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if; 
      when s6 =>
       if prio = '1' and sys1 = '0' and sys2 = '0' then
          data_out <= "00000000";
          addr_out <= "00000000";
          g1 <= '0';  
          g2 <= '0';  
          cmd_rdy <= '0';
          nexts <= s0;  
        end if;
  end case;
 end process;
end Behavioral;