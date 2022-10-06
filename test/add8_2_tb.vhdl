-- --------------------------------------------------------------------------------
-- --                        Normalizer_ZO_6_6_6_F50_uid6
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Florent de Dinechin, (2007-2020)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X OZb
-- -- Output signals: Count R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity Normalizer_ZO_6_6_6_F50_uid6 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(5 downto 0);
--           OZb : in  std_logic;
--           Count : out  std_logic_vector(2 downto 0);
--           R : out  std_logic_vector(5 downto 0)   );
-- end entity;

-- architecture arch of Normalizer_ZO_6_6_6_F50_uid6 is
-- signal level3 :  std_logic_vector(5 downto 0);
-- signal sozb :  std_logic;
-- signal count2 :  std_logic;
-- signal level2 :  std_logic_vector(5 downto 0);
-- signal count1 :  std_logic;
-- signal level1 :  std_logic_vector(5 downto 0);
-- signal count0 :  std_logic;
-- signal level0 :  std_logic_vector(5 downto 0);
-- signal sCount :  std_logic_vector(2 downto 0);
-- begin
--    level3 <= X ;
--    sozb<= OZb;
--    count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
--    level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

--    count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
--    level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

--    count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
--    level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

--    R <= level0;
--    sCount <= count2 & count1 & count0;
--    Count <= sCount;
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                       PositFastDecoder_8_2_F50_uid4
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Raul Murillo (2021-2022)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X
-- -- Output signals: Sign SF Frac NZN

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity PositFastDecoder_8_2_F50_uid4 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(7 downto 0);
--           Sign : out  std_logic;
--           SF : out  std_logic_vector(5 downto 0);
--           Frac : out  std_logic_vector(2 downto 0);
--           NZN : out  std_logic   );
-- end entity;

-- architecture arch of PositFastDecoder_8_2_F50_uid4 is
--    component Normalizer_ZO_6_6_6_F50_uid6 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(5 downto 0);
--              OZb : in  std_logic;
--              Count : out  std_logic_vector(2 downto 0);
--              R : out  std_logic_vector(5 downto 0)   );
--    end component;

-- signal sgn :  std_logic;
-- signal pNZN :  std_logic;
-- signal rc :  std_logic;
-- signal regPosit :  std_logic_vector(5 downto 0);
-- signal regLength :  std_logic_vector(2 downto 0);
-- signal shiftedPosit :  std_logic_vector(5 downto 0);
-- signal k :  std_logic_vector(3 downto 0);
-- signal sgnVect :  std_logic_vector(1 downto 0);
-- signal exp :  std_logic_vector(1 downto 0);
-- signal pSF :  std_logic_vector(5 downto 0);
-- signal pFrac :  std_logic_vector(2 downto 0);
-- begin
-- --------------------------- Start of vhdl generation ---------------------------
-- --------------------------- Sign bit & special cases ---------------------------
--    sgn <= X(7);
--    pNZN <= '0' when (X(6 downto 0) = "0000000") else '1';
-- -------------- Count leading zeros/ones of regime & shift it out --------------
--    rc <= X(6);
--    regPosit <= X(5 downto 0);
--    RegimeCounter: Normalizer_ZO_6_6_6_F50_uid6
--       port map ( clk  => clk,
--                  OZb => rc,
--                  X => regPosit,
--                  Count => regLength,
--                  R => shiftedPosit);
-- ----------------- Determine the scaling factor - regime & exp -----------------
--    k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
--    sgnVect <= (others => sgn);
--    exp <= shiftedPosit(4 downto 3) XOR sgnVect;
--    pSF <= k & exp;
-- ------------------------------- Extract fraction -------------------------------
--    pFrac <= shiftedPosit(2 downto 0);
--    Sign <= sgn;
--    SF <= pSF;
--    Frac <= pFrac;
--    NZN <= pNZN;
-- ---------------------------- End of vhdl generation ----------------------------
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                       Normalizer_ZO_6_6_6_F50_uid10
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Florent de Dinechin, (2007-2020)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X OZb
-- -- Output signals: Count R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity Normalizer_ZO_6_6_6_F50_uid10 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(5 downto 0);
--           OZb : in  std_logic;
--           Count : out  std_logic_vector(2 downto 0);
--           R : out  std_logic_vector(5 downto 0)   );
-- end entity;

-- architecture arch of Normalizer_ZO_6_6_6_F50_uid10 is
-- signal level3 :  std_logic_vector(5 downto 0);
-- signal sozb :  std_logic;
-- signal count2 :  std_logic;
-- signal level2 :  std_logic_vector(5 downto 0);
-- signal count1 :  std_logic;
-- signal level1 :  std_logic_vector(5 downto 0);
-- signal count0 :  std_logic;
-- signal level0 :  std_logic_vector(5 downto 0);
-- signal sCount :  std_logic_vector(2 downto 0);
-- begin
--    level3 <= X ;
--    sozb<= OZb;
--    count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
--    level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

--    count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
--    level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

--    count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
--    level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

--    R <= level0;
--    sCount <= count2 & count1 & count0;
--    Count <= sCount;
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                       PositFastDecoder_8_2_F50_uid8
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Raul Murillo (2021-2022)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X
-- -- Output signals: Sign SF Frac NZN

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity PositFastDecoder_8_2_F50_uid8 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(7 downto 0);
--           Sign : out  std_logic;
--           SF : out  std_logic_vector(5 downto 0);
--           Frac : out  std_logic_vector(2 downto 0);
--           NZN : out  std_logic   );
-- end entity;

-- architecture arch of PositFastDecoder_8_2_F50_uid8 is
--    component Normalizer_ZO_6_6_6_F50_uid10 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(5 downto 0);
--              OZb : in  std_logic;
--              Count : out  std_logic_vector(2 downto 0);
--              R : out  std_logic_vector(5 downto 0)   );
--    end component;

-- signal sgn :  std_logic;
-- signal pNZN :  std_logic;
-- signal rc :  std_logic;
-- signal regPosit :  std_logic_vector(5 downto 0);
-- signal regLength :  std_logic_vector(2 downto 0);
-- signal shiftedPosit :  std_logic_vector(5 downto 0);
-- signal k :  std_logic_vector(3 downto 0);
-- signal sgnVect :  std_logic_vector(1 downto 0);
-- signal exp :  std_logic_vector(1 downto 0);
-- signal pSF :  std_logic_vector(5 downto 0);
-- signal pFrac :  std_logic_vector(2 downto 0);
-- begin
-- --------------------------- Start of vhdl generation ---------------------------
-- --------------------------- Sign bit & special cases ---------------------------
--    sgn <= X(7);
--    pNZN <= '0' when (X(6 downto 0) = "0000000") else '1';
-- -------------- Count leading zeros/ones of regime & shift it out --------------
--    rc <= X(6);
--    regPosit <= X(5 downto 0);
--    RegimeCounter: Normalizer_ZO_6_6_6_F50_uid10
--       port map ( clk  => clk,
--                  OZb => rc,
--                  X => regPosit,
--                  Count => regLength,
--                  R => shiftedPosit);
-- ----------------- Determine the scaling factor - regime & exp -----------------
--    k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
--    sgnVect <= (others => sgn);
--    exp <= shiftedPosit(4 downto 3) XOR sgnVect;
--    pSF <= k & exp;
-- ------------------------------- Extract fraction -------------------------------
--    pFrac <= shiftedPosit(2 downto 0);
--    Sign <= sgn;
--    SF <= pSF;
--    Frac <= pFrac;
--    NZN <= pNZN;
-- ---------------------------- End of vhdl generation ----------------------------
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                           DSPBlock_5x5_F50_uid16
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: 
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X Y
-- -- Output signals: R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity DSPBlock_5x5_F50_uid16 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(4 downto 0);
--           Y : in  std_logic_vector(4 downto 0);
--           R : out  std_logic_vector(9 downto 0)   );
-- end entity;

-- architecture arch of DSPBlock_5x5_F50_uid16 is
-- signal Mint :  std_logic_vector(9 downto 0);
-- signal M :  std_logic_vector(9 downto 0);
-- signal Rtmp :  std_logic_vector(9 downto 0);
-- begin
--    Mint <= std_logic_vector(signed(X) * signed(Y)); -- multiplier
--    M <= Mint(9 downto 0);
--    Rtmp <= M;
--    R <= Rtmp;
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                          IntMultiplier_F50_uid12
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Martin Kumm, Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X Y
-- -- Output signals: R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity IntMultiplier_F50_uid12 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(4 downto 0);
--           Y : in  std_logic_vector(4 downto 0);
--           R : out  std_logic_vector(9 downto 0)   );
-- end entity;

-- architecture arch of IntMultiplier_F50_uid12 is
--    component DSPBlock_5x5_F50_uid16 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(4 downto 0);
--              Y : in  std_logic_vector(4 downto 0);
--              R : out  std_logic_vector(9 downto 0)   );
--    end component;

-- signal XX_m13 :  std_logic_vector(4 downto 0);
-- signal YY_m13 :  std_logic_vector(4 downto 0);
-- signal tile_0_X :  std_logic_vector(4 downto 0);
-- signal tile_0_Y :  std_logic_vector(4 downto 0);
-- signal tile_0_output :  std_logic_vector(9 downto 0);
-- signal tile_0_filtered_output :  signed(9-0 downto 0);
-- signal bh14_w0_0 :  std_logic;
-- signal bh14_w1_0 :  std_logic;
-- signal bh14_w2_0 :  std_logic;
-- signal bh14_w3_0 :  std_logic;
-- signal bh14_w4_0 :  std_logic;
-- signal bh14_w5_0 :  std_logic;
-- signal bh14_w6_0 :  std_logic;
-- signal bh14_w7_0 :  std_logic;
-- signal bh14_w8_0 :  std_logic;
-- signal bh14_w9_0 :  std_logic;
-- signal tmp_bitheapResult_bh14_9 :  std_logic_vector(9 downto 0);
-- signal bitheapResult_bh14 :  std_logic_vector(9 downto 0);
-- begin
--    XX_m13 <= X ;
--    YY_m13 <= Y ;
--    tile_0_X <= X(4 downto 0);
--    tile_0_Y <= Y(4 downto 0);
--    tile_0_mult: DSPBlock_5x5_F50_uid16
--       port map ( clk  => clk,
--                  X => tile_0_X,
--                  Y => tile_0_Y,
--                  R => tile_0_output);

--    tile_0_filtered_output <= signed(tile_0_output(9 downto 0));
--    bh14_w0_0 <= tile_0_filtered_output(0);
--    bh14_w1_0 <= tile_0_filtered_output(1);
--    bh14_w2_0 <= tile_0_filtered_output(2);
--    bh14_w3_0 <= tile_0_filtered_output(3);
--    bh14_w4_0 <= tile_0_filtered_output(4);
--    bh14_w5_0 <= tile_0_filtered_output(5);
--    bh14_w6_0 <= tile_0_filtered_output(6);
--    bh14_w7_0 <= tile_0_filtered_output(7);
--    bh14_w8_0 <= tile_0_filtered_output(8);
--    bh14_w9_0 <= tile_0_filtered_output(9);

--    -- Adding the constant bits 
--       -- All the constant bits are zero, nothing to add

--    tmp_bitheapResult_bh14_9 <= bh14_w9_0 & bh14_w8_0 & bh14_w7_0 & bh14_w6_0 & bh14_w5_0 & bh14_w4_0 & bh14_w3_0 & bh14_w2_0 & bh14_w1_0 & bh14_w0_0;
--    bitheapResult_bh14 <= tmp_bitheapResult_bh14_9;
--    R <= bitheapResult_bh14(9 downto 0);
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                   RightShifterSticky7_by_max_7_F50_uid21
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X S padBit
-- -- Output signals: R Sticky

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity RightShifterSticky7_by_max_7_F50_uid21 is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(6 downto 0);
--           S : in  std_logic_vector(2 downto 0);
--           padBit : in  std_logic;
--           R : out  std_logic_vector(6 downto 0);
--           Sticky : out  std_logic   );
-- end entity;

-- architecture arch of RightShifterSticky7_by_max_7_F50_uid21 is
-- signal ps :  std_logic_vector(2 downto 0);
-- signal Xpadded :  std_logic_vector(6 downto 0);
-- signal level3 :  std_logic_vector(6 downto 0);
-- signal stk2 :  std_logic;
-- signal level2 :  std_logic_vector(6 downto 0);
-- signal stk1 :  std_logic;
-- signal level1 :  std_logic_vector(6 downto 0);
-- signal stk0 :  std_logic;
-- signal level0 :  std_logic_vector(6 downto 0);
-- begin
--    ps<= S;
--    Xpadded <= X;
--    level3<= Xpadded;
--    stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
--    level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(6 downto 4);
--    stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
--    level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(6 downto 2);
--    stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
--    level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(6 downto 1);
--    R <= level0;
--    Sticky <= stk0;
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                       PositFastEncoder_8_2_F50_uid19
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Raul Murillo (2021-2022)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: Sign SF Frac Guard Sticky NZN
-- -- Output signals: R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.std_logic_arith.all;
-- use ieee.std_logic_unsigned.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity PositFastEncoder_8_2_F50_uid19 is
--     port (clk : in std_logic;
--           Sign : in  std_logic;
--           SF : in  std_logic_vector(6 downto 0);
--           Frac : in  std_logic_vector(2 downto 0);
--           Guard : in  std_logic;
--           Sticky : in  std_logic;
--           NZN : in  std_logic;
--           R : out  std_logic_vector(7 downto 0)   );
-- end entity;

-- architecture arch of PositFastEncoder_8_2_F50_uid19 is
--    component RightShifterSticky7_by_max_7_F50_uid21 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(6 downto 0);
--              S : in  std_logic_vector(2 downto 0);
--              padBit : in  std_logic;
--              R : out  std_logic_vector(6 downto 0);
--              Sticky : out  std_logic   );
--    end component;

-- signal rc :  std_logic;
-- signal rcVect :  std_logic_vector(3 downto 0);
-- signal k :  std_logic_vector(3 downto 0);
-- signal sgnVect :  std_logic_vector(1 downto 0);
-- signal exp :  std_logic_vector(1 downto 0);
-- signal ovf :  std_logic;
-- signal regValue :  std_logic_vector(2 downto 0);
-- signal regNeg :  std_logic;
-- signal padBit :  std_logic;
-- signal inputShifter :  std_logic_vector(6 downto 0);
-- signal shiftedPosit :  std_logic_vector(6 downto 0);
-- signal stkBit :  std_logic;
-- signal unroundedPosit :  std_logic_vector(6 downto 0);
-- signal lsb :  std_logic;
-- signal rnd :  std_logic;
-- signal stk :  std_logic;
-- signal round :  std_logic;
-- signal roundedPosit :  std_logic_vector(6 downto 0);
-- signal unsignedPosit :  std_logic_vector(6 downto 0);
-- begin
-- --------------------------- Start of vhdl generation ---------------------------
-- ----------------------------- Get value of regime -----------------------------
--    rc <= SF(SF'high);
--    rcVect <= (others => rc);
--    k <= SF(5 downto 2) XOR rcVect;
--    sgnVect <= (others => Sign);
--    exp <= SF(1 downto 0) XOR sgnVect;
--    -- Check for regime overflow
--    ovf <= '1' when (k > "0101") else '0';
--    regValue <= k(2 downto 0) when ovf = '0' else "110";
-- -------------- Generate regime - shift out exponent and fraction --------------
--    regNeg <= Sign XOR rc;
--    padBit <= NOT(regNeg);
--    inputShifter <= regNeg & exp & Frac & Guard;
--    RegimeGenerator: RightShifterSticky7_by_max_7_F50_uid21
--       port map ( clk  => clk,
--                  S => regValue,
--                  X => inputShifter,
--                  padBit => padBit,
--                  R => shiftedPosit,
--                  Sticky => stkBit);
--    unroundedPosit <= padBit & shiftedPosit(6 downto 1);
-- ---------------------------- Round to nearest even ----------------------------
--    lsb <= shiftedPosit(1);
--    rnd <= shiftedPosit(0);
--    stk <= stkBit OR Sticky;
--    round <= rnd AND (lsb OR stk OR ovf);
--    roundedPosit <= unroundedPosit + round;
-- -------------------------- Check sign & Special Cases --------------------------
--    unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
--    R <= Sign & unsignedPosit;
-- ---------------------------- End of vhdl generation ----------------------------
-- end architecture;

-- --------------------------------------------------------------------------------
-- --                                 PositMult
-- --                          (PositMult_8_2_F50_uid2)
-- -- VHDL generated for Kintex7 @ 50MHz
-- -- This operator is part of the Infinite Virtual Library FloPoCoLib
-- -- All rights reserved 
-- -- Authors: Raul Murillo (2021-2022)
-- --------------------------------------------------------------------------------
-- -- Pipeline depth: 0 cycles
-- -- Clock period (ns): 20
-- -- Target frequency (MHz): 50
-- -- Input signals: X Y
-- -- Output signals: R

-- library ieee;
-- use ieee.std_logic_1164.all;
-- use ieee.numeric_std.all;
-- library std;
-- use std.textio.all;
-- library work;

-- entity PositMult is
--     port (clk : in std_logic;
--           X : in  std_logic_vector(7 downto 0);
--           Y : in  std_logic_vector(7 downto 0);
--           R : out  std_logic_vector(7 downto 0)   );
-- end entity;

-- architecture arch of PositMult is
--    component PositFastDecoder_8_2_F50_uid4 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(7 downto 0);
--              Sign : out  std_logic;
--              SF : out  std_logic_vector(5 downto 0);
--              Frac : out  std_logic_vector(2 downto 0);
--              NZN : out  std_logic   );
--    end component;

--    component PositFastDecoder_8_2_F50_uid8 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(7 downto 0);
--              Sign : out  std_logic;
--              SF : out  std_logic_vector(5 downto 0);
--              Frac : out  std_logic_vector(2 downto 0);
--              NZN : out  std_logic   );
--    end component;

--    component IntMultiplier_F50_uid12 is
--       port ( clk : in std_logic;
--              X : in  std_logic_vector(4 downto 0);
--              Y : in  std_logic_vector(4 downto 0);
--              R : out  std_logic_vector(9 downto 0)   );
--    end component;

--    component PositFastEncoder_8_2_F50_uid19 is
--       port ( clk : in std_logic;
--              Sign : in  std_logic;
--              SF : in  std_logic_vector(6 downto 0);
--              Frac : in  std_logic_vector(2 downto 0);
--              Guard : in  std_logic;
--              Sticky : in  std_logic;
--              NZN : in  std_logic;
--              R : out  std_logic_vector(7 downto 0)   );
--    end component;

-- signal X_sgn :  std_logic;
-- signal X_sf :  std_logic_vector(5 downto 0);
-- signal X_f :  std_logic_vector(2 downto 0);
-- signal X_nzn :  std_logic;
-- signal Y_sgn :  std_logic;
-- signal Y_sf :  std_logic_vector(5 downto 0);
-- signal Y_f :  std_logic_vector(2 downto 0);
-- signal Y_nzn :  std_logic;
-- signal XY_nzn :  std_logic;
-- signal X_nar :  std_logic;
-- signal Y_nar :  std_logic;
-- signal XX_f :  std_logic_vector(4 downto 0);
-- signal YY_f :  std_logic_vector(4 downto 0);
-- signal XY_f :  std_logic_vector(9 downto 0);
-- signal XY_sgn :  std_logic;
-- signal XY_ovfExtra :  std_logic;
-- signal XY_ovf :  std_logic;
-- signal XY_normF :  std_logic_vector(6 downto 0);
-- signal XY_ovfBits :  std_logic_vector(1 downto 0);
-- signal XY_sf :  std_logic_vector(6 downto 0);
-- signal XY_finalSgn :  std_logic;
-- signal XY_frac :  std_logic_vector(2 downto 0);
-- signal grd :  std_logic;
-- signal stk :  std_logic;
-- begin
-- --------------------------- Start of vhdl generation ---------------------------
-- ---------------------------- Decode X & Y operands ----------------------------
--    X_decoder: PositFastDecoder_8_2_F50_uid4
--       port map ( clk  => clk,
--                  X => X,
--                  Frac => X_f,
--                  NZN => X_nzn,
--                  SF => X_sf,
--                  Sign => X_sgn);
--    Y_decoder: PositFastDecoder_8_2_F50_uid8
--       port map ( clk  => clk,
--                  X => Y,
--                  Frac => Y_f,
--                  NZN => Y_nzn,
--                  SF => Y_sf,
--                  Sign => Y_sgn);
-- -------------------------------- Multiply X & Y --------------------------------
--    -- Sign and Special Cases Computation
--    XY_nzn <= X_nzn AND Y_nzn;
--    X_nar <= X_sgn AND NOT(X_nzn);
--    Y_nar <= Y_sgn AND NOT(Y_nzn);
--    -- Multiply the fractions (using FloPoCo IntMultiplier)
--    XX_f <= X_sgn & NOT(X_sgn) & X_f;
--    YY_f <= Y_sgn & NOT(Y_sgn) & Y_f;
--    FracMultiplier: IntMultiplier_F50_uid12
--       port map ( clk  => clk,
--                  X => XX_f,
--                  Y => YY_f,
--                  R => XY_f);
--    XY_sgn <= XY_f(9);
--    XY_ovfExtra <= NOT(XY_sgn) AND XY_f(8);
--    XY_ovf <=  (XY_sgn XOR XY_f(7));
--    XY_normF <= XY_f(6 downto 0) when (XY_ovfExtra OR XY_ovf) = '1' else (XY_f(5 downto 0) & '0');
--    -- Add the exponent values
--    XY_ovfBits <= XY_ovfExtra & XY_ovf;
--    XY_sf <= std_logic_vector(unsigned(X_sf(X_sf'high) & X_sf) + unsigned(Y_sf(Y_sf'high) & Y_sf) + unsigned(XY_ovfBits));
-- ----------------------------- Generate final posit -----------------------------
--    XY_finalSgn <= XY_sgn when XY_nzn = '1' else (X_nar OR Y_nar);
--    XY_frac <= XY_normF(6 downto 4);
--    grd <= XY_normF(3);
--    stk <= '0' when (XY_normF(2 downto 0) = "000") else '1';
--    PositEncoder: PositFastEncoder_8_2_F50_uid19
--       port map ( clk  => clk,
--                  Frac => XY_frac,
--                  Guard => grd,
--                  NZN => XY_nzn,
--                  SF => XY_sf,
--                  Sign => XY_finalSgn,
--                  Sticky => stk,
--                  R => R);
-- ---------------------------- End of vhdl generation ----------------------------
-- end architecture;

--------------------------------------------------------------------------------
--                       TestBench_PositMult_F50_uid23
-- VHDL generated for Kintex7 @ 50MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, Cristian Klein, Nicolas Brunie (2007-2010)
--------------------------------------------------------------------------------
library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity TestBench_Positadder_F50_uid23 is
end entity;

architecture behavorial of TestBench_Positadder_F50_uid23 is
   component PositAdder is
      port ( --clk : in std_logic;
             X : in  std_logic_vector(7 downto 0);
             Y : in  std_logic_vector(7 downto 0);
             R : out  std_logic_vector(7 downto 0)   );
   end component;
signal X :  std_logic_vector(7 downto 0);
signal Y :  std_logic_vector(7 downto 0);
signal R :  std_logic_vector(7 downto 0);
signal clk :  std_logic;
signal rst :  std_logic;

   -- FP compare function (found vs. real)
   function fp_equal(a : std_logic_vector; b : std_logic_vector) return boolean is
   begin
      if b(b'high downto b'high-1) = "01" then
         return a = b;
      elsif b(b'high downto b'high-1) = "11" then
         return (a(a'high downto a'high-1)=b(b'high downto b'high-1));
      else
         return a(a'high downto a'high-2) = b(b'high downto b'high-2);
      end if;
   end;



 -- converts std_logic into a character
   function chr(sl: std_logic) return character is
      variable c: character;
   begin
      case sl is
         when 'U' => c:= 'U';
         when 'X' => c:= 'X';
         when '0' => c:= '0';
         when '1' => c:= '1';
         when 'Z' => c:= 'Z';
         when 'W' => c:= 'W';
         when 'L' => c:= 'L';
         when 'H' => c:= 'H';
         when '-' => c:= '-';
      end case;
      return c;
   end chr;
   -- converts bit to std_logic (1 to 1)
   function to_stdlogic(b : bit) return std_logic is
       variable sl : std_logic;
   begin
      case b is 
         when '0' => sl := '0';
         when '1' => sl := '1';
      end case;
      return sl;
   end to_stdlogic;
   -- converts std_logic into a string (1 to 1)
   function str(sl: std_logic) return string is
    variable s: string(1 to 1);
    begin
      s(1) := chr(sl);
      return s;
   end str;
   -- converts std_logic_vector into a string (binary base)
   -- (this also takes care of the fact that the range of
   --  a string is natural while a std_logic_vector may
   --  have an integer range)
   function str(slv: std_logic_vector) return string is
      variable result : string (1 to slv'length);
      variable r : integer;
   begin
      r := 1;
      for i in slv'range loop
         result(r) := chr(slv(i));
         r := r + 1;
      end loop;
      return result;
   end str;




   -- test isZero
   function iszero(a : std_logic_vector) return boolean is
   begin
      return  a = (a'high downto 0 => '0');
   end;


   -- FP IEEE compare function (found vs. real)
   function fp_equal_ieee(a : std_logic_vector; b : std_logic_vector; we : integer; wf : integer) return boolean is
   begin
      if a(wf+we downto wf) = b(wf+we downto wf) and b(we+wf-1 downto wf) = (we downto 1 => '1') then
         if iszero(b(wf-1 downto 0)) then return  iszero(a(wf-1 downto 0));
         else return not iszero(a(wf - 1 downto 0));
         end if;
      else
         return a(a'high downto 0) = b(b'high downto 0);
      end if;
   end;
begin

   test: PositAdder
      port map (-- clk  => clk,
                 X => X,
                 Y => Y,
                 R => R);

   -- Ticking clock signal
   process
   begin
      clk <= '0';
      wait for 5 ns;
      clk <= '1';
      wait for 5 ns;
   end process;

   -- Reading the input from a file 
   process
      variable inline : line; 
      variable counter : integer := 1;
      variable errorCounter : integer := 0;
      variable possibilityNumber : integer := 0;
      variable localErrorCounter : integer := 0;
      variable tmpChar : character;
      file inputsFile : text is "testadd8.input"; 
      variable V_X : bit_vector(7 downto 0);
      variable V_Y : bit_vector(7 downto 0);
      variable V_R : bit_vector(7 downto 0);
   begin
      -- Send reset
      rst <= '1';
      wait for 10 ns;
      rst <= '0';
      while not endfile(inputsFile) loop
          -- positionning inputs
         readline(inputsFile,inline);
         read(inline ,V_X);
         read(inline,tmpChar);
         X <= to_stdlogicvector(V_X);
         read(inline ,V_Y);
         read(inline,tmpChar);
         Y <= to_stdlogicvector(V_Y);
         readline(inputsFile,inline);
         wait for 10 ns;
      end loop;
      wait for 10000 ns; -- wait for simulation to finish
   end process;
          -- verifying the corresponding output
         process
      variable inline0 : line; 
      variable inline : line; 
      variable counter : integer := 1;
      variable errorCounter : integer := 0;
      variable possibilityNumber : integer := 0;
      variable localErrorCounter : integer := 0;
      variable tmpChar : character;
      file inputsFile : text is "testadd8.input"; 
      variable V_R : bit_vector(7 downto 0);
      variable expected_R: string (1 to 1000);
      variable expected_size_R : integer;
   begin
          wait for 10 ns;
      wait for 2 ns; -- no pipeline here
      while not endfile(inputsFile) loop
          -- positionning inputs
         readline(inputsFile,inline0);
         readline(inputsFile,inline);
         read(inline, possibilityNumber);
         localErrorCounter := 0;
         read(inline,tmpChar);
         expected_size_R := inline'Length;
         expected_R := inline.all & (expected_size_R+1 to 1000 => ' ');
         if possibilityNumber = 0 then
            localErrorCounter := 0;
         elsif possibilityNumber = 1 then 
            read(inline ,V_R);
            if not (R= to_stdlogicvector(V_R)) then 
                errorCounter := errorCounter + 1;
               assert false report("Line " & integer'image(counter) & " of input file, incorrect output for R: " & lf & "  expected value: " & expected_R(1 to expected_size_R) & lf & "          result: " & str(R)) ;
            end if;
         else
            for i in possibilityNumber downto 1 loop 
               read(inline ,V_R);
               read(inline,tmpChar);
               if (R= to_stdlogicvector(V_R))  then localErrorCounter := 1; end if;
            end loop;
             if (localErrorCounter = 0) then 
               errorCounter := errorCounter + 1; -- incrementing global error counter
               assert false report("Line " & integer'image(counter) & " of input file, incorrect output for R: " & lf & " expected values: " & expected_R(1 to expected_size_R) & lf & "          result: " & str(R)) ;
            end if;
         end if;
          wait for 10 ns; -- wait for pipeline to flush
         counter := counter + 2;
      end loop;
      report (integer'image(errorCounter) & " error(s) encoutered.");
      report "End of simulation" severity note;
   end process;

end architecture;

