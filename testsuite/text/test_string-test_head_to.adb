--
--  Copyright (C) 2026, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

separate (Test_String)
procedure Test_Head_To is
begin
   declare
      --  `null` string, before first character

      S : VSS.Strings.Virtual_String;
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.Before_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (H.Is_Null);
   end;

   declare
      --  `null` string, up to first character

      S : VSS.Strings.Virtual_String;
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (H.Is_Null);
   end;

   declare
      --  `null` string, up to last character

      S : VSS.Strings.Virtual_String;
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_Last_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (H.Is_Null);
   end;

   declare
      --  `null` string, after last character

      S : VSS.Strings.Virtual_String;
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.After_Last_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (H.Is_Null);
   end;

   declare
      --  An empty string, before first character

      S : constant VSS.Strings.Virtual_String := "";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.Before_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
   end;

   declare
      --  An empty string, up to first character

      S : constant VSS.Strings.Virtual_String := "";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      --  Position after last character is valid position
   end;

   declare
      --  An empty string, up to last character

      S : constant VSS.Strings.Virtual_String := "";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_Last_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      --  Position after last character is valid position
   end;

   declare
      --  An empty string, after last character

      S : constant VSS.Strings.Virtual_String := "";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.After_Last_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      --  Position after last character is valid position
   end;

   declare
      --  Single character string, before first character

      S : constant VSS.Strings.Virtual_String := "A";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.Before_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
   end;

   declare
      --  Single character string, at first character

      S : constant VSS.Strings.Virtual_String := "A";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_First_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = S);
   end;

   declare
      --  Single character string, at last character

      S : constant VSS.Strings.Virtual_String := "A";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_Last_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = S);
   end;

   declare
      --  Single character string, after last character

      S : constant VSS.Strings.Virtual_String := "A";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.After_Last_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = S);
   end;

   declare
      --  Miltiple characters string, before first character

      S : constant VSS.Strings.Virtual_String := "ABC";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.Before_First_Character);

   begin
      Test_Support.Assert (H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
   end;

   declare
      --  Multiple characters string, at first character

      S : constant VSS.Strings.Virtual_String := "ABC";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_First_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = "A");
   end;

   declare
      --  Multiple characters string, at last character

      S : constant VSS.Strings.Virtual_String := "ABC";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.At_Last_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = S);
   end;

   declare
      --  Multiple characters string, after last character

      S : constant VSS.Strings.Virtual_String := "A";
      H : constant VSS.Strings.Virtual_String :=
        S.Head_To (S.After_Last_Character);

   begin
      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = S);
   end;

   declare
      --  Multiple characters string, intermediate position

      S : constant VSS.Strings.Virtual_String := "ABC";
      J : VSS.Strings.Character_Iterators.Character_Iterator :=
        S.At_First_Character;
      H : VSS.Strings.Virtual_String;

   begin
      Test_Support.Assert (J.Forward);

      H := S.Head_To (J);

      Test_Support.Assert (not H.Is_Empty);
      Test_Support.Assert (not H.Is_Null);
      Test_Support.Assert (H = "AB");
   end;
end Test_Head_To;
