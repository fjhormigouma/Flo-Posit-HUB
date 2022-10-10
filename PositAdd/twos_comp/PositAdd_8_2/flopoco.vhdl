--------------------------------------------------------------------------------
--                        Normalizer_ZO_6_6_6_F0_uid6
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_6_6_6_F0_uid6 is   --!! cambiado para HUB introduciendo el ilsb. no vale para normalizar el resultado
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid6 is
signal level3 :  std_logic_vector(5+1 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5+1 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5+1 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5+1 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X & '1' ;  --!! introduzco el ilsb . Se podria poner y desplazar aparte y luego poner una or. Eso solucionaría le caso todo 1 pero creo que es menos eficiente ;
   sozb<= OZb;
   count2<= '1' when level3(5+1 downto 2+1) = (5+1 downto 2+1=>sozb) else '0';
   level2<= level3(5+1 downto 0) when count2='0' else level3(1+1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5+1 downto 4+1) = (5+1 downto 4+1=>sozb) else '0';
   level1<= level2(5+1 downto 0) when count1='0' else level2(3+1 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5+1 downto 5+1) = (5+1 downto 5+1=>sozb) else '0';
   level0<= level1(5+1 downto 0) when count0='0' else level1(4+1 downto 0) & (0 downto 0 => '0');

    R <= level0(5 downto 0);  --!! incluye el ilsb pero no el MSB que se desprecia despues
    sCount <= count2 & count1 & count0;
   Count <= "110" when sCount =  "111" else sCount;   --Cuando es todo 1 cuenta tambien el ilsb. Hay varias formas de solucionarlos. Esto es para hacerlo mas general y medio eficiente. Se podría detectar tambien el caso "todo 1" a la entrada. No se que será mas eficiente.
end architecture;

--------------------------------------------------------------------------------
--                        PositFastDecoder_8_2_F0_uid4
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastDecoder_8_2_F0_uid4 is  --adaptado a HUB
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2+1 downto 0); --ajustado indice
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_8_2_F0_uid4 is
   component Normalizer_ZO_6_6_6_F0_uid6 is
      port ( X : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(5 downto 0);
signal regLength :  std_logic_vector(2 downto 0);
signal shiftedPosit :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(5 downto 0);
signal pFrac :  std_logic_vector(2+1 downto 0);   --ajustado
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(7);
   pNZN <= '0' when (X(6 downto 0) = "0000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(6);
   regPosit <= X(5 downto 0);
   RegimeCounter: Normalizer_ZO_6_6_6_F0_uid6
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(4+1 downto 3+1) XOR sgnVect; --ajustado indice, porque el msb estaba ya quitada
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(2+1 downto 0);  --!! incluye ilsb
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                        Normalizer_ZO_6_6_6_F0_uid10
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_6_6_6_F0_uid10 is   --No cambiado, no usado
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid10 is
signal level3 :  std_logic_vector(5 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X ;
   sozb<= OZb;
   count2<= '1' when level3(5 downto 2) = (5 downto 2=>sozb) else '0';
   level2<= level3(5 downto 0) when count2='0' else level3(1 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(5 downto 4) = (5 downto 4=>sozb) else '0';
   level1<= level2(5 downto 0) when count1='0' else level2(3 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(5 downto 5) = (5 downto 5=>sozb) else '0';
   level0<= level1(5 downto 0) when count0='0' else level1(4 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                        PositFastDecoder_8_2_F0_uid8
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X
-- Output signals: Sign SF Frac NZN

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastDecoder_8_2_F0_uid8 is            -- no cambiado, no usado
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
          NZN : out  std_logic   );
end entity;

architecture arch of PositFastDecoder_8_2_F0_uid8 is
   component Normalizer_ZO_6_6_6_F0_uid10 is
      port ( X : in  std_logic_vector(5 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(5 downto 0)   );
   end component;

signal sgn :  std_logic;
signal pNZN :  std_logic;
signal rc :  std_logic;
signal regPosit :  std_logic_vector(5 downto 0);
signal regLength :  std_logic_vector(2 downto 0);
signal shiftedPosit :  std_logic_vector(5 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal pSF :  std_logic_vector(5 downto 0);
signal pFrac :  std_logic_vector(2 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
--------------------------- Sign bit & special cases ---------------------------
   sgn <= X(7);
   pNZN <= '0' when (X(6 downto 0) = "0000000") else '1';
-------------- Count leading zeros/ones of regime & shift it out --------------
   rc <= X(6);
   regPosit <= X(5 downto 0);
   RegimeCounter: Normalizer_ZO_6_6_6_F0_uid10
      port map ( OZb => rc,
                 X => regPosit,
                 Count => regLength,
                 R => shiftedPosit);
----------------- Determine the scaling factor - regime & exp -----------------
   k <= "0" & regLength when rc /= sgn else "1" & NOT(regLength);
   sgnVect <= (others => sgn);
   exp <= shiftedPosit(4 downto 3) XOR sgnVect;
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(2 downto 0);
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                   RightShifterSticky7_by_max_7_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky7_by_max_7_F0_uid12 is     --!!No usado, se usa otro (uid18) que si está modificado. 
    port (X : in  std_logic_vector(6 downto 0);
          S : in  std_logic_vector(2 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(6 downto 0);
          Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky7_by_max_7_F0_uid12 is
signal ps :  std_logic_vector(2 downto 0);
signal Xpadded :  std_logic_vector(6 downto 0);
signal level3 :  std_logic_vector(6 downto 0);
signal stk2 :  std_logic;
signal level2 :  std_logic_vector(6 downto 0);
signal stk1 :  std_logic;
signal level1 :  std_logic_vector(6 downto 0);
signal stk0 :  std_logic;
signal level0 :  std_logic_vector(6 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level3<= Xpadded;
   stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(6 downto 4);
   stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(6 downto 2);
   stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(6 downto 1);
   R <= level0;
   Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                        Normalizer_ZO_8_8_7_F0_Normalizer
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Florent de Dinechin, (2007-2020)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X OZb
-- Output signals: Count R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity Normalizer_ZO_8_8_7_F0_uid14 is   --Simplemente ajustar el tamaño
    port (X : in  std_logic_vector(7-2 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(7-2 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_8_8_7_F0_uid14 is
signal level3 :  std_logic_vector(7-2 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(7-2 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(7-2 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(7-2 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X ;
   sozb<= OZb;
   count2<= '1' when level3(7-2 downto 4-2) = (7-2 downto 4-2=>sozb) else '0';
   level2<= level3(7-2 downto 0) when count2='0' else level3(3-2 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(7-2 downto 6-2) = (7-2 downto 6-2=>sozb) else '0';
   level1<= level2(7-2 downto 0) when count1='0' else level2(5-2 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(7-2 downto 7-2) = (7-2 downto 7-2=>sozb) else '0';
   level0<= level1(7-2 downto 0) when count0='0' else level1(6-2 downto 0) & (0 downto 0 => '0');

   R <= level0;
   sCount <= count2 & count1 & count0;
   Count <= sCount;
end architecture;

--------------------------------------------------------------------------------
--                   RightShifterSticky7_by_max_7_F0_uid18
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Bogdan Pasca (2008-2011), Florent de Dinechin (2008-2019)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X S padBit
-- Output signals: R Sticky

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity RightShifterSticky7_by_max_7_F0_uid18 is -- !!Reducido el tamaño porque no hace falta guard bit
    port (X : in  std_logic_vector(6-1 downto 0);  --ajustado
          S : in  std_logic_vector(2 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(6-1 downto 0));--ajustado
          --Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky7_by_max_7_F0_uid18 is
signal ps :  std_logic_vector(2 downto 0);
signal Xpadded :  std_logic_vector(6-1 downto 0); --ajustado
signal level3 :  std_logic_vector(6-1 downto 0);--ajustado
--signal stk2 :  std_logic;
signal level2 :  std_logic_vector(6-1 downto 0);--ajustado
--signal stk1 :  std_logic;
signal level1 :  std_logic_vector(6-1 downto 0);--ajustado
--signal stk0 :  std_logic;
signal level0 :  std_logic_vector(6-1 downto 0);--ajustado
begin
   ps<= S;
   Xpadded <= X;
   level3<= Xpadded;
  -- stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(6-1 downto 4);--ajustado
  -- stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(6-1 downto 2);--ajustado
   --stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(6-1 downto 1);--ajustado
   R <= level0;
  -- Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastEncoder_8_2_F0_uid16
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: Sign SF Frac Guard Sticky NZN
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositFastEncoder_8_2_F0_uid16 is
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(6 downto 0);
          Frac : in  std_logic_vector(2 downto 0);
         -- Guard : in  std_logic;
         -- Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositFastEncoder_8_2_F0_uid16 is
   component RightShifterSticky7_by_max_7_F0_uid18 is
      port ( X : in  std_logic_vector(6-1 downto 0);-- -1
             S : in  std_logic_vector(2 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(6-1 downto 0));
             --Sticky : out  std_logic   );
   end component;

signal rc :  std_logic;
signal rcVect :  std_logic_vector(3 downto 0);
signal k :  std_logic_vector(3 downto 0);
signal sgnVect :  std_logic_vector(1 downto 0);
signal exp :  std_logic_vector(1 downto 0);
signal ovf :  std_logic;
signal regValue :  std_logic_vector(2 downto 0);
signal regNeg :  std_logic;
signal padBit :  std_logic;
signal inputShifter :  std_logic_vector(6-1 downto 0); -- -1 porque he quitado el guard bit
signal shiftedPosit :  std_logic_vector(6-1 downto 0);
--signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(6 downto 0);
--signal lsb :  std_logic;
--signal rnd :  std_logic;
--signal stk :  std_logic;
--signal round :  std_logic;
signal roundedPosit :  std_logic_vector(6 downto 0);
signal unsignedPosit :  std_logic_vector(6 downto 0);
begin
--------------------------- Start of vhdl generation ---------------------------
----------------------------- Get value of regime -----------------------------
   rc <= SF(SF'high);
   rcVect <= (others => rc);
   k <= SF(5 downto 2) XOR rcVect;
   sgnVect <= (others => Sign);
   exp <= SF(1 downto 0) XOR sgnVect;
   -- Check for regime overflow
   ovf <= '1' when (k > "0101") else '0';
   regValue <= k(2 downto 0) when ovf = '0' else "110";
-------------- Generate regime - shift out exponent and fraction --------------
   regNeg <= Sign XOR rc;
   padBit <= NOT(regNeg);
   inputShifter <= regNeg & exp & Frac;-- & Guard;
   RegimeGenerator: RightShifterSticky7_by_max_7_F0_uid18
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit);
                 --Sticky => stkBit);
   roundedPosit <= padBit & shiftedPosit(5 downto 1) & (shiftedPosit(0) OR ovf);  --!! vble destino cambiada y eliminado el guard del shited.El lsb tien que ser 1 si ovf para el minimo positivo y el máximo negativo;
---------------------------- Round to nearest even ----------------------------
  -- lsb <= shiftedPosit(1);
 --  rnd <= shiftedPosit(0);
 --  stk <= stkBit OR Sticky;
 --  round <= rnd AND (lsb OR stk OR ovf);
 --  roundedPosit <= unroundedPosit + round;
-------------------------- Check sign & Special Cases --------------------------
   unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
   R <= Sign & unsignedPosit;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                                 PositAdder
--                          (PositAdder_8_2_F0_uid2)
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Raul Murillo (2021)
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.std_logic_arith.all;
use ieee.std_logic_unsigned.all;
library std;
use std.textio.all;
library work;

entity PositAdder is
    port (X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositAdder is
   component PositFastDecoder_8_2_F0_uid4 is
      port ( X : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2+1 downto 0); --ajustado
             NZN : out  std_logic   );
   end component;

   component PositFastDecoder_8_2_F0_uid8 is
      port ( X : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             NZN : out  std_logic   );
   end component;

   component RightShifterSticky7_by_max_7_F0_uid18 is       --Cambiada la unidad
      port ( X : in  std_logic_vector(6-1 downto 0);
             S : in  std_logic_vector(2 downto 0);
             padBit : in  std_logic;
             R : out  std_logic_vector(6-1 downto 0));
             --Sticky : out  std_logic   );
   end component;

   component Normalizer_ZO_8_8_7_F0_uid14 is    --ajustado el tamaño
      port ( X : in  std_logic_vector(7-2 downto 0);
             OZb : in  std_logic;
             Count : out  std_logic_vector(2 downto 0);
             R : out  std_logic_vector(7-2 downto 0)   );
   end component;

   component PositFastEncoder_8_2_F0_uid16 is
      port ( Sign : in  std_logic;
             SF : in  std_logic_vector(6 downto 0);
             Frac : in  std_logic_vector(2 downto 0);
             --Guard : in  std_logic;
             --Sticky : in  std_logic;
             NZN : in  std_logic;
             R : out  std_logic_vector(7 downto 0)   );
   end component;

signal X_sgn :  std_logic;
signal X_sf :  std_logic_vector(5 downto 0);
signal X_f :  std_logic_vector(2+1 downto 0);  -- +1
signal X_nzn :  std_logic;
signal Y_sgn :  std_logic;
signal Y_sf :  std_logic_vector(5 downto 0);
signal Y_f :  std_logic_vector(2+1 downto 0);   -- +1
signal Y_nzn :  std_logic;
signal X_not_zero :  std_logic;
signal X_nar :  std_logic;
signal Y_not_zero :  std_logic;
signal Y_nar :  std_logic;
signal is_larger :  std_logic;
signal larger_sf :  std_logic_vector(5 downto 0);
signal smaller_sf :  std_logic_vector(5 downto 0);
signal larger_frac :  std_logic_vector(4+1 downto 0); -- +1
signal smaller_frac :  std_logic_vector(4+1 downto 0); -- +1
signal offset :  std_logic_vector(5 downto 0);
signal shift_saturate :  std_logic;
signal frac_offset :  std_logic_vector(2 downto 0);
signal input_shifter :  std_logic_vector(6-1 downto 0); --ajustado para quitar rnd y stk e incluir el ilsb
signal pad_bit :  std_logic;
signal shifted_frac :  std_logic_vector(6-1 downto 0); --ajustado para quitar rnd y stk e incluir el ilsb
signal stk_tmp :  std_logic;
signal smaller_frac_sh :  std_logic_vector(4+1 downto 0); --+1 incluye ilsb
--signal grd_tmp :  std_logic;
--signal rnd_tmp :  std_logic;
signal add_frac :  std_logic_vector(5+1 downto 0); --+1 incluye ilsb
--signal grd_bit :  std_logic;
--signal rnd_bit :  std_logic;
signal stk_bit :  std_logic;
signal count_type :  std_logic;
signal add_frac_shift :  std_logic_vector(7-2 downto 0); --ajustado para quitar rnd y stk e incluir el ilsb
signal count :  std_logic_vector(2 downto 0);
signal norm_frac_tmp :  std_logic_vector(7-2 downto 0);  --ajustado para quitar rnd y stk e incluir el ilsb
signal add_sf :  std_logic_vector(6 downto 0);
signal is_not_zero :  std_logic;
signal is_nar :  std_logic;
signal XY_nzn :  std_logic;
signal sign :  std_logic;
signal norm_frac :  std_logic_vector(2 downto 0);
--signal grd :  std_logic;
--signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands ----------------------------
   X_decoder: PositFastDecoder_8_2_F0_uid4
      port map ( X => X,
                 Frac => X_f,
                 NZN => X_nzn,
                 SF => X_sf,
                 Sign => X_sgn);
   Y_decoder: PositFastDecoder_8_2_F0_uid4  --Solo este esta adaptado a HUB
      port map ( X => Y,
                 Frac => Y_f,
                 NZN => Y_nzn,
                 SF => Y_sf,
                 Sign => Y_sgn);
--------------------------- Check for Zeros and NaRs ---------------------------
   X_not_zero <= X_sgn OR X_nzn;
   X_nar <= X_sgn AND NOT(X_nzn);
   Y_not_zero <= Y_sgn OR Y_nzn;
   Y_nar <= Y_sgn AND NOT(Y_nzn);
---------------------- Compare operands and adjust values ----------------------
   is_larger <= '1' when (signed(X_sf) > signed(Y_sf)) else '0';
   with is_larger  select  larger_sf <= 
      X_sf when '1',
      Y_sf when '0',
      "------" when others;
   with is_larger  select  smaller_sf <= 
      Y_sf when '1',
      X_sf when '0',
      "------" when others;
   with is_larger  select  larger_frac <= 
      (X_sgn & (NOT(X_sgn) AND X_not_zero) & X_f) when '1',
      (Y_sgn & (NOT(Y_sgn) AND Y_not_zero) & Y_f) when '0',
      "------" when others;                       --cuidado añadir un "-"
   with is_larger  select  smaller_frac <= 
      (Y_sgn & (NOT(Y_sgn) AND Y_not_zero) & Y_f) when '1',
      (X_sgn & (NOT(X_sgn) AND X_not_zero) & X_f) when '0',
      "------" when others;                        --cuidado añadir un "-"
---------------- Compute exponents difference & align fractions ----------------
   offset <= larger_sf - smaller_sf;
   -- Saturate maximum offset
   shift_saturate <= '0' when (offset(5 downto 3) = "0000") else '1';
   frac_offset <= CONV_STD_LOGIC_VECTOR(7,3) when shift_saturate = '1' else offset(2 downto 0);
   -- Align fractions - right shift the smaller one
   input_shifter <= smaller_frac; --& "00";   --los dos bits adicionales no hacen falta poruqe no se redondea
   pad_bit <= smaller_frac(smaller_frac'high) AND (NOT shift_saturate);    --Sin esta modificación, mantisas fuera de rango  restan 1 ulp del valor mas grande y pueden modificar el exponente en casos que no debería
   RightShifterFraction: RightShifterSticky7_by_max_7_F0_uid18
      port map ( S => frac_offset,
                 X => input_shifter,
                 padBit => pad_bit,
                 R => shifted_frac); --
                 --Sticky => stk_tmp);
   smaller_frac_sh <= shifted_frac;  -- ajustado tamaño
  -- grd_tmp <= shifted_frac(1);
   --rnd_tmp <= shifted_frac(0);   --No hacen falta
-------------------------------- Add fractions --------------------------------
   add_frac <= (larger_frac(4+1) & larger_frac) + (smaller_frac_sh(4+1) & smaller_frac_sh);
   --grd_bit <= grd_tmp;  No hace falta
  -- rnd_bit <= rnd_tmp;
  -- stk_bit <= stk_tmp;
   -- Normalization of fraction
   count_type <= add_frac(5+1);  -- ajustado el indice
   add_frac_shift <= add_frac(4+1 downto 0);-- & grd_bit & rnd_bit & stk_bit;
   FractionNormalizer: Normalizer_ZO_8_8_7_F0_uid14
      port map ( OZb => count_type,
                 X => add_frac_shift,
                 Count => count,
                 R => norm_frac_tmp);
   -- Correct final exponent
   add_sf <= (larger_sf(5) & larger_sf) - ("0000" & count) + 1;
--------------------------- Data Rounding & Encoding ---------------------------
   is_not_zero <= '0' when (count ="111") else '1'; --Aunque en teoria solo hay 6 bits al ir metiendo ceros saldría 7. Con count_type=1 como mucho saldria 6
  -- is_not_zero <= '0';
   is_nar <= X_nar OR Y_nar;
   XY_nzn <= is_not_zero AND NOT(is_nar);
   sign <= is_nar OR (is_not_zero AND add_frac(5+1));
   norm_frac <= norm_frac_tmp(4 downto 2);      --ajustado los limites
   --grd <= norm_frac_tmp(3);
   --stk <= norm_frac_tmp(2) OR norm_frac_tmp(1) OR norm_frac_tmp(0);
   PositEncoder: PositFastEncoder_8_2_F0_uid16
      port map ( Frac => norm_frac,
                 --Guard => grd,
                 NZN => XY_nzn,
                 SF => add_sf,
                 Sign => sign,
                 --Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

