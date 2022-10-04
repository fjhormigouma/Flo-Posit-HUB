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

entity Normalizer_ZO_6_6_6_F0_uid6 is   --!!no cambiado usar el otro
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid6 is
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

entity PositFastDecoder_8_2_F0_uid4 is      --!!no cambiado usar el otro
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2 downto 0);
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
signal pFrac :  std_logic_vector(2 downto 0);
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

entity Normalizer_ZO_6_6_6_F0_uid10 is   --!! cambiado para HUB
    port (X : in  std_logic_vector(5 downto 0);
          OZb : in  std_logic;
          Count : out  std_logic_vector(2 downto 0);
          R : out  std_logic_vector(5 downto 0)   );
end entity;

architecture arch of Normalizer_ZO_6_6_6_F0_uid10 is
signal level3 :  std_logic_vector(6 downto 0);
signal sozb :  std_logic;
signal count2 :  std_logic;
signal level2 :  std_logic_vector(6 downto 0);
signal count1 :  std_logic;
signal level1 :  std_logic_vector(6 downto 0);
signal count0 :  std_logic;
signal level0 :  std_logic_vector(6 downto 0);
signal sCount :  std_logic_vector(2 downto 0);
begin
   level3 <= X & '1' ;  --!! introduzco el ilsb . Se podria poner y desplazar aparte y luego poner una or. Eso solucionaría le caso todo 1 pero creo que es menos eficiente
   sozb<= OZb;
   count2<= '1' when level3(6 downto 3) = (6 downto 3=>sozb) else '0';
   level2<= level3(6 downto 0) when count2='0' else level3(2 downto 0) & (3 downto 0 => '0');

   count1<= '1' when level2(6 downto 4) = (6 downto 4=>sozb) else '0';
   level1<= level2(6 downto 0) when count1='0' else level2(4 downto 0) & (1 downto 0 => '0');

   count0<= '1' when level1(6 downto 6) = (6 downto 6=>sozb) else '0';
   level0<= level1(6 downto 0) when count0='0' else level1(5 downto 0) & (0 downto 0 => '0');

   R <= level0(5 downto 0);  --!! incluye el ilsb pero no el MSB que se desprecia despues
   sCount <= count2 & count1 & count0;
   Count <= "110" when sCount =  "111" else sCount;   --Cuando es todo 1 cuenta tambien el ilsb. Hay varias formas de solucionarlos. Esto es para hacerlo mas general y medio eficiente. Se podría detectar tambien el caso "todo 1" a la entrada. No se que será mas eficiente.
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

entity PositFastDecoder_8_2_F0_uid8 is
    port (X : in  std_logic_vector(7 downto 0);
          Sign : out  std_logic;
          SF : out  std_logic_vector(5 downto 0);
          Frac : out  std_logic_vector(2+1 downto 0); --ajustado indice
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
signal pFrac :  std_logic_vector(2+1 downto 0); --ajustado indice
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
   exp <= shiftedPosit(5 downto 4) XOR sgnVect; --ajustado indice, por que el msb estaba ya quitada
   pSF <= k & exp;
------------------------------- Extract fraction -------------------------------
   pFrac <= shiftedPosit(3 downto 0);  --!! incluye ilsb
   Sign <= sgn;
   SF <= pSF;
   Frac <= pFrac;
   NZN <= pNZN;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                           IntMultiplier_F0_uid12
-- VHDL generated for Kintex7 @ 0MHz
-- This operator is part of the Infinite Virtual Library FloPoCoLib
-- All rights reserved 
-- Authors: Martin Kumm, Florent de Dinechin, Kinga Illyes, Bogdan Popa, Bogdan Pasca, 2012
--------------------------------------------------------------------------------
-- combinatorial
-- Clock period (ns): inf
-- Target frequency (MHz): 0
-- Input signals: X Y
-- Output signals: R

library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity IntMultiplier_F0_uid12 is  --!!aumentado el tamaño
    port (X : in  std_logic_vector(5 downto 0); --+1
          Y : in  std_logic_vector(5 downto 0); --+1
          R : out  std_logic_vector(11 downto 0)   ); --+2
end entity;

architecture arch of IntMultiplier_F0_uid12 is
--signal XX_m13 :  std_logic_vector(4 downto 0);
--signal YY_m13 :  std_logic_vector(4 downto 0);
signal XX :  signed(-1+5+1 downto 0);--+1
signal YY :  signed(-1+5+1 downto 0);--+1
signal RR :  signed(-1+10+2 downto 0); --+2
begin
--   XX_m13 <= X ;  --Esto no se usa
--   YY_m13 <= Y ;
   XX <= signed(X);
   YY <= signed(Y);
   RR <= XX*YY;
   R <= std_logic_vector(RR(9+2 downto 0)); --+2
end architecture;

--------------------------------------------------------------------------------
--                   RightShifterSticky7_by_max_7_F0_uid17
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

--!! Eliminado todo lo referente al sticky por que no hace falta en multiplicacion

entity RightShifterSticky7_by_max_7_F0_uid17 is -- !!Reducido el tamaño porque no hace falta guard bit
    port (X : in  std_logic_vector(6-1 downto 0);
          S : in  std_logic_vector(2 downto 0);
          padBit : in  std_logic;
          R : out  std_logic_vector(6-1 downto 0));
    --      Sticky : out  std_logic   );
end entity;

architecture arch of RightShifterSticky7_by_max_7_F0_uid17 is
signal ps :  std_logic_vector(2 downto 0);
signal Xpadded :  std_logic_vector(5 downto 0);
signal level3 :  std_logic_vector(5 downto 0);
--signal stk2 :  std_logic;
signal level2 :  std_logic_vector(5 downto 0);
--signal stk1 :  std_logic;
signal level1 :  std_logic_vector(5 downto 0);
--signal stk0 :  std_logic;
signal level0 :  std_logic_vector(5 downto 0);
begin
   ps<= S;
   Xpadded <= X;
   level3<= Xpadded;
 --  stk2 <= '1' when (level3(3 downto 0)/="0000" and ps(2)='1')   else '0';
   level2 <=  level3 when  ps(2)='0'    else (3 downto 0 => padBit) & level3(5 downto 4);
 -- stk1 <= '1' when (level2(1 downto 0)/="00" and ps(1)='1') or stk2 ='1'   else '0';
   level1 <=  level2 when  ps(1)='0'    else (1 downto 0 => padBit) & level2(5 downto 2);
 --stk0 <= '1' when (level1(0 downto 0)/="0" and ps(0)='1') or stk1 ='1'   else '0';
   level0 <=  level1 when  ps(0)='0'    else (0 downto 0 => padBit) & level1(5 downto 1);
   R <= level0;
--  Sticky <= stk0;
end architecture;

--------------------------------------------------------------------------------
--                       PositFastEncoder_8_2_F0_uid15
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

entity PositFastEncoder_8_2_F0_uid15 is  
    port (Sign : in  std_logic;
          SF : in  std_logic_vector(6 downto 0);
          Frac : in  std_logic_vector(2 downto 0);
         -- Guard : in  std_logic;
         -- Sticky : in  std_logic;
          NZN : in  std_logic;
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositFastEncoder_8_2_F0_uid15 is
   component RightShifterSticky7_by_max_7_F0_uid17 is
      port ( X : in  std_logic_vector(6-1 downto 0);  --porque falta guard bit
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
signal shiftedPosit :  std_logic_vector(6-1 downto 0); -- -1 porque he quitado el guard bit
signal stkBit :  std_logic;
signal unroundedPosit :  std_logic_vector(6 downto 0);
signal lsb :  std_logic;
signal rnd :  std_logic;
signal stk :  std_logic;
signal round :  std_logic;
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
   inputShifter <= regNeg & exp & Frac;  -- eliminado el guardbit
   RegimeGenerator: RightShifterSticky7_by_max_7_F0_uid17
      port map ( S => regValue,
                 X => inputShifter,
                 padBit => padBit,
                 R => shiftedPosit);
                 --Sticky => stkBit);
   roundedPosit <= padBit & shiftedPosit (5 downto 1) & (shiftedPosit(0) OR ovf);  --!! vble destino cambiada y eliminado el guard del shited.El lsb tien que ser 1 si ovf para el minimo positivo y el máximo negativo
---------------------------- Round to nearest even ----------------------------
--!!Todo el redondeo y sticky se puede eliminado aunque podria ser biased, estudiarsi haria falta sticky para unbiased
--   lsb <= shiftedPosit(1);
--   rnd <= shiftedPosit(0);
--  stk <= stkBit OR Sticky;
--  round <= rnd AND (lsb OR stk OR ovf);   !! el ovf esta aqui  para un el minimo positivo y el máximo negativo
 --  roundedPosit <= unroundedPosit + round;
-------------------------- Check sign & Special Cases --------------------------
   unsignedPosit <= roundedPosit when NZN = '1' else (others => '0');
   R <= Sign & unsignedPosit;
---------------------------- End of vhdl generation ----------------------------
end architecture;

--------------------------------------------------------------------------------
--                           PositMult
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
use ieee.numeric_std.all;
library std;
use std.textio.all;
library work;

entity PositMult is
    port (X : in  std_logic_vector(7 downto 0);
          Y : in  std_logic_vector(7 downto 0);
          R : out  std_logic_vector(7 downto 0)   );
end entity;

architecture arch of PositMult is
   component PositFastDecoder_8_2_F0_uid4 is
      port ( X : in  std_logic_vector(7 downto 0);
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2 downto 0);
             NZN : out  std_logic   );
   end component;

   component PositFastDecoder_8_2_F0_uid8 is
      port ( X : in  std_logic_vector(7 downto 0); 
             Sign : out  std_logic;
             SF : out  std_logic_vector(5 downto 0);
             Frac : out  std_logic_vector(2+1 downto 0);--ajustado
             NZN : out  std_logic   );
   end component;

   component IntMultiplier_F0_uid12 is
      port ( X : in  std_logic_vector(5 downto 0); -- +1
             Y : in  std_logic_vector(5 downto 0); -- +1
             R : out  std_logic_vector(11 downto 0)   );-- +2
   end component;

   component PositFastEncoder_8_2_F0_uid15 is
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
signal X_f :  std_logic_vector(2+1 downto 0);   -- +1
signal X_nzn :  std_logic;
signal Y_sgn :  std_logic;
signal Y_sf :  std_logic_vector(5 downto 0);
signal Y_f :  std_logic_vector(2+1 downto 0);   -- +1
signal Y_nzn :  std_logic;
signal XY_nzn :  std_logic;
signal X_nar :  std_logic;
signal Y_nar :  std_logic;
signal XX_f :  std_logic_vector(5 downto 0); -- +1
signal YY_f :  std_logic_vector(5 downto 0);-- +1
signal XY_f :  std_logic_vector(11 downto 0);-- +2
signal XY_sgn :  std_logic;
signal XY_ovfExtra :  std_logic;
signal XY_ovf :  std_logic;
signal XY_normF :  std_logic_vector(6 downto 0);
signal XY_ovfBits :  std_logic_vector(1 downto 0);
signal XY_sf :  std_logic_vector(6 downto 0);
signal XY_finalSgn :  std_logic;
signal XY_frac :  std_logic_vector(2 downto 0);
--signal grd :  std_logic;
--signal stk :  std_logic;
begin
--------------------------- Start of vhdl generation ---------------------------
---------------------------- Decode X & Y operands ----------------------------
   X_decoder: PositFastDecoder_8_2_F0_uid8   --!! unidad HUB
      port map ( X => X,
                 Frac => X_f,
                 NZN => X_nzn,
                 SF => X_sf,
                 Sign => X_sgn);
   Y_decoder: PositFastDecoder_8_2_F0_uid8
      port map ( X => Y,
                 Frac => Y_f,
                 NZN => Y_nzn,
                 SF => Y_sf,
                 Sign => Y_sgn);
-------------------------------- Multiply X & Y --------------------------------
   -- Sign and Special Cases Computation
   XY_nzn <= X_nzn AND Y_nzn;
   X_nar <= X_sgn AND NOT(X_nzn);
   Y_nar <= Y_sgn AND NOT(Y_nzn);
  -- Multiply the fractions (using FloPoCo IntMultiplier)
   XX_f <= X_sgn & NOT(X_sgn) & X_f;
   YY_f <= Y_sgn & NOT(Y_sgn) & Y_f;
   FracMultiplier: IntMultiplier_F0_uid12  --!!aumentado tamaño multiplicador
      port map ( X => XX_f,
                 Y => YY_f,
                 R => XY_f);
   XY_sgn <= XY_f(11);  --!! 9+2
   XY_ovfExtra <= NOT(XY_sgn) AND XY_f(10); --!!8+2
   XY_ovf <=  (XY_sgn XOR XY_f(9));   --!!7+2
   XY_normF <= XY_f(8 downto 2) when (XY_ovfExtra OR XY_ovf) = '1' else (XY_f(7 downto 1)); --!!  normalización rehecha +2 para ajustar los indices, ampliacion rango en el else
   -- Add the exponent values
   XY_ovfBits <= XY_ovfExtra & XY_ovf;
   XY_sf <= std_logic_vector(unsigned(X_sf(X_sf'high) & X_sf) + unsigned(Y_sf(Y_sf'high) & Y_sf) + unsigned(XY_ovfBits));
----------------------------- Generate final posit -----------------------------
   XY_finalSgn <= XY_sgn when XY_nzn = '1' else (X_nar OR Y_nar);
   XY_frac <= XY_normF(6 downto 4);
   --grd <= XY_normF(3);      --!! al quitar hay que cambiar el right shifter
   --stk <= '0' when (XY_normF(2 downto 0) = "000") else '1';
   PositEncoder: PositFastEncoder_8_2_F0_uid15 
      port map ( Frac => XY_frac,
	  
                 --Guard => grd,
                 NZN => XY_nzn,
                 SF => XY_sf,
                 Sign => XY_finalSgn,
                -- Sticky => stk,
                 R => R);
---------------------------- End of vhdl generation ----------------------------
end architecture;

