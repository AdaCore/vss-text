--
--  Copyright (C) 2026, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

with VSS.Characters;

separate (Test_String)
procedure Test_Trim is

   function All_White_Space return Wide_Wide_String;

   ---------------------
   -- All_White_Space --
   ---------------------

   function All_White_Space return Wide_Wide_String is
      Buffer : Wide_Wide_String (1 .. 128);
      Last   : Natural := Buffer'First - 1;

   begin
      for C in VSS.Characters.Virtual_Character loop
         if VSS.Characters.Is_Valid_Virtual_Character (C)
           and then VSS.Characters.Get_White_Space (C)
         then
            Last := Last + 1;
            Buffer (Last) := Wide_Wide_Character (C);
         end if;
      end loop;

      Test_Support.Assert (Last >= Buffer'First);
      --  At least single character has been added.

      return Buffer (Buffer'First .. Last);
   end All_White_Space;

begin
   declare
      --  `null` string

      S : VSS.Strings.Virtual_String;
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (T.Is_Empty);
      Test_Support.Assert (T.Is_Null);
   end;

   declare
      --  empty string

      S : constant VSS.Strings.Virtual_String := "";
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
   end;

   declare
      --  Only `White_Space` characters

      S : constant VSS.Strings.Virtual_String :=
        VSS.Strings.To_Virtual_String (All_White_Space);
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
   end;

   declare
      --  Leading `White_Space` characters

      S : constant VSS.Strings.Virtual_String :=
        VSS.Strings.To_Virtual_String (All_White_Space & "A  B");
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (not T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
      Test_Support.Assert (T = "A  B");
   end;

   declare
      --  Trailing `White_Space` characters

      S : constant VSS.Strings.Virtual_String :=
        VSS.Strings.To_Virtual_String ("A  B" & All_White_Space);
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (not T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
      Test_Support.Assert (T = "A  B");
   end;

   declare
      --  Leading and trailing `White_Space` characters

      S : constant VSS.Strings.Virtual_String :=
        VSS.Strings.To_Virtual_String
          (All_White_Space & "A  B" & All_White_Space);
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (not T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
      Test_Support.Assert (T = "A  B");
   end;

   declare
      --  None of leading and trailing `White_Space` characters

      S : constant VSS.Strings.Virtual_String :=
        VSS.Strings.To_Virtual_String ("A  B");
      T : constant VSS.Strings.Virtual_String := S.Trim;

   begin
      Test_Support.Assert (not T.Is_Empty);
      Test_Support.Assert (not T.Is_Null);
      Test_Support.Assert (T = S);
   end;
end Test_Trim;
