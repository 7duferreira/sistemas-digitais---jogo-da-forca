LIBRARY ieee;
USE ieee.std_logic_1164.all;

ENTITY forca IS
    PORT  (V_SW: in std_logic_vector(10 downto 0);
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

type estados is (reset, zero, um, dois, tres, quatro, cinco, seis, sete, oito, nove);

signal atual, proximo : estados;
signal acertos : std_logic_vector (5 downto 0);

signal vidas : std_logic_vector (1 downto 0) := "11";

signal p : std_logic;
signal g : std_logic;

signal repetir : std_logic_vector (3 downto 0) := "0000";

begin

process (G_CLOCK_50, V_SW(10), p, g)
begin 
    if (V_SW(10) = '1') then
        atual <= reset;
    elsif (rising_edge(G_CLOCK_50) and (V_SW(10) = '0') and (p = '0') and (g = '0')) then
        atual <= proximo;
    end if;
end process;


process (atual, V_SW)
begin
    if (V_SW = "01000000000" or
    V_SW = "00100000000" or
    V_SW = "00010000000" or
    V_SW = "00001000000" or
    V_SW = "00000100000" or
    V_SW = "00000010000" or
    V_SW = "00000001000" or
    V_SW = "00000000100" or
    V_SW = "00000000010" or
    V_SW = "00000000001") then

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
    else
        proximo <= atual;
    end if;
end process;

process (atual)
begin
    case atual is
        when zero =>
            acertos(3) <= '1';
        when um =>
            acertos(5) <= '1';
        when dois =>
                acertos(0) <= '1';
        when tres =>
                acertos(2) <= '1';
        when quatro =>
            if (repetir(0) = '0') then
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
            repetir(0) <= '1';
        when cinco =>
            if (repetir(1) = '0') then
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
            repetir(1) <= '1';
        when seis =>
            if (repetir(2) = '0') then
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
            repetir(2) <= '1';
        when sete =>
                acertos(4) <= '1';
        when oito =>
                acertos(1) <= '1';
        when nove =>
            if (repetir(3) = '0') then
                if (vidas = "01") then
                    vidas <= "00";
                elsif (vidas = "10") then
                    vidas <= "01";
                elsif (vidas = "11") then
                    vidas <= "10";
                end if;
            end if;
            repetir(3) <= '1';
        when reset =>
            vidas <= "11";
            repetir <= "0000";
            acertos <= "000000";
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

G_HEX0 <= "1111001" when acertos(5) = '1' else 
    "0111111";
G_HEX1 <= "1111000" when acertos(4) = '1' else 
    "0111111";
G_HEX2 <= "1000000" when acertos(3) = '1' else 
    "0111111";
G_HEX3 <= "0110000" when acertos(2) = '1' else 
    "0111111";
G_HEX4 <= "0000000" when acertos(1) = '1' else 
    "0111111";
G_HEX5 <= "0100100" when acertos(0) = '1' else 
    "0111111";
G_HEX6 <= "0001100" when p = '1' else
            "1000010" when g = '1' else
            "1111111";
G_LEDG <= "000" when vidas = "00" else
            "100" when vidas = "01" else
            "110" when vidas = "10" else
            "111" when vidas = "11";
END TypeArchitecture;