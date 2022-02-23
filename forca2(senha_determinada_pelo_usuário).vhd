LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY forca IS
    PORT  (V_SW: in std_logic_vector(17 downto 0);
        G_CLOCK_50: in std_logic;
        G_LEDG: out std_logic_vector(2 downto 0);
        G_HEX0: out std_logic_vector(6 downto 0);
        G_HEX1: out std_logic_vector(6 downto 0);
        G_HEX2: out std_logic_vector(6 downto 0);
        G_HEX3: out std_logic_vector(6 downto 0);
        G_HEX4: out std_logic_vector(6 downto 0);
        G_HEX5: out std_logic_vector(6 downto 0);
        G_HEX6: out std_logic_vector(6 downto 0)
        );
END forca;
ARCHITECTURE TypeArchitecture OF forca IS

type estados is (definir, d1, d2, d3, d4, d5, d6, reset, zero, um, dois, tres, quatro, cinco, seis, sete, oito, nove);

signal atual, proximo : estados;
signal acertos : std_logic_vector (5 downto 0);

signal vidas : std_logic_vector (1 downto 0) := "11";

signal p : std_logic;
signal g : std_logic;

signal part1: std_logic_vector(9 downto 0);
signal part2: std_logic_vector(9 downto 0);
signal part3: std_logic_vector(9 downto 0);
signal part4: std_logic_vector(9 downto 0);
signal part5: std_logic_vector(9 downto 0);
signal part6: std_logic_vector(9 downto 0);

begin

process (G_CLOCK_50, V_SW(10), p, g)
begin 
    if ((V_SW(10) = '1') and (V_SW(11) = '0')) then
        atual <= reset;
    elsif (rising_edge(G_CLOCK_50) and (V_SW(10) = '0') and (p = '0') and (g = '0') and (V_SW(11) = '0')) then
        atual <= proximo;
    elsif (rising_edge(G_CLOCK_50) and (V_SW(10) = '0') and (V_SW(11) = '1') and (p = '0') and (g = '0')) then 
        case atual is
            when d6 => 
                if (V_SW = "000000100000000000") then
                    atual <= reset;
                else
                    atual <= d6;
                end if;
            when d5 =>
                if (V_SW = "100000100000000000") then
                    atual <= d6;
                else
                    atual <= d5;
                end if;
            when d4 => 
                if (V_SW = "010000100000000000") then
                    atual <= d5;
                else
                    atual <= d4;
                end if;
            when d3 =>
                if (V_SW = "001000100000000000") then
                    atual <= d4;
                else
                    atual <= d3;
                end if;
            when d2 =>
                if (V_SW = "000100100000000000") then
                    atual <= d3;
                else
                    atual <= d2;
                end if;
            when d1 =>
                if (V_SW = "000010100000000000") then
                    atual <= d2;
                else
                    atual <= d1;
                end if;
            when definir =>
                if (V_SW = "000001100000000000") then
                    atual <= d1;
                else
                    atual <= definir;
                end if;
            when others =>
                atual <= definir;
        end case; 
    end if;
end process;

process (atual, part1, part2, part3, part4, part5, part6, V_SW(11))
begin
    if (V_SW(11) = '1') then 
        case atual is
            when d1 =>
                part1 <= V_SW(9 downto 0);
            when d2 =>
                part2 <= V_SW(9 downto 0);
            when d3 =>
                part3 <= V_SW(9 downto 0);
            when d4 =>
                part4 <= V_SW(9 downto 0);
            when d5 =>
                part5 <= V_SW(9 downto 0);
            when d6 =>
                part6 <= V_SW(9 downto 0);
            when others =>
                null;
        end case;
    end if;
end process;

process (atual, V_SW)
begin
    if (V_SW = "000000001000000000" or
    V_SW = "000000000100000000" or
    V_SW = "000000000010000000" or
    V_SW = "000000000001000000" or
    V_SW = "000000000000100000" or
    V_SW = "000000000000010000" or
    V_SW = "000000000000001000" or
    V_SW = "000000000000000100" or
    V_SW = "000000000000000010" or
    V_SW = "000000000000000001") then

        if (V_SW(0)='1') then
            proximo <= zero;
        elsif (V_SW(1)='1') then
            proximo <= um;
        elsif (V_SW(2)='1') then
            proximo <= dois;
        elsif (V_SW(3)='1') then
            proximo <= tres;
        elsif (V_SW(4)='1') then
            proximo <= quatro;
        elsif (V_SW(5)='1') then
            proximo <= cinco;
        elsif (V_SW(6)='1') then
            proximo <= seis;
        elsif (V_SW(7)='1') then
            proximo <= sete;
        elsif (V_SW(8)='1') then
            proximo <= oito;
        elsif (V_SW(9)='1') then
            proximo <= nove;
        end if;
    elsif (V_SW(11) = '0') then
        proximo <= atual;
    end if;
end process;

process (atual)
begin
    case atual is
        when definir => 
            G_HEX5 <= "0111111";
            G_HEX4 <= "0111111";
            G_HEX3 <= "0111111";
            G_HEX2 <= "0111111";
            G_HEX1 <= "0111111";
            G_HEX0 <= "0111111";
            vidas <= "11";
            acertos <= "000000";
            part1 <= "0000000000";
            part2 <= "0000000000";
            part3 <= "0000000000";
            part4 <= "0000000000";
            part5 <= "0000000000";
            part6 <= "0000000000";
        when reset =>
            G_HEX5 <= "0111111";
            G_HEX4 <= "0111111";
            G_HEX3 <= "0111111";
            G_HEX2 <= "0111111";
            G_HEX1 <= "0111111";
            G_HEX0 <= "0111111";
            vidas <= "11";
            acertos <= "000000";
        when zero =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "1000000";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "1000000";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "1000000";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "1000000";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "1000000";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "1000000";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when um =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "1111001";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "1111001";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "1111001";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "1111001";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "1111001";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "1111001";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when dois =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0100100";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0100100";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0100100";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0100100";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0100100";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0100100";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when tres =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0110000";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0110000";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0110000";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0110000";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0110000";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0110000";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when quatro =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0011001";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0011001";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0011001";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0011001";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0011001";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0011001";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when cinco =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0010010";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0010010";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0010010";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0010010";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0010010";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0010010";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when seis =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0000010";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0000010";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0000010";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0000010";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0000010";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0000010";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when sete =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "1111000";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "1111000";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "1111000";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "1111000";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "1111000";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "1111000";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when oito =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0000000";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0000000";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0000000";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0000000";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0000000";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0000000";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when nove =>
            if (part1 = V_SW(9 downto 0)) then 
                G_HEX5 <= "0010000";
                acertos(0) <= '1';
            elsif (part2 = V_SW(9 downto 0)) then 
                G_HEX4 <= "0010000";
                acertos(1) <= '1';
            elsif (part3 = V_SW(9 downto 0)) then 
                G_HEX3 <= "0010000";
                acertos(2) <= '1';
            elsif (part4 = V_SW(9 downto 0)) then 
                G_HEX2 <= "0010000";
                acertos(3) <= '1';
            elsif (part5 = V_SW(9 downto 0)) then 
                G_HEX1 <= "0010000";
                acertos(4) <= '1';
            elsif (part6 = V_SW(9 downto 0)) then 
                G_HEX0 <= "0010000";
                acertos(5) <= '1';
            else 
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
        when others =>
            null;
    end case;
end process;

process (acertos, atual, V_SW(10))
begin
    if acertos = "111111" then
        g <= '1';
    else 
        g <= '0';
    end if;
    if vidas = "00" then
        p <= '1';
    else
        p <= '0';
    end if;
end process;

G_HEX6 <= "0001100" when p = '1' else
            "1000010" when g = '1' else
            "1111111";
G_LEDG <= "000" when vidas = "00" else
            "100" when vidas = "01" else
            "110" when vidas = "10" else
            "111" when vidas = "11";
END TypeArchitecture;







