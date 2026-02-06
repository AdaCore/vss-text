--
--  Copyright (C) 2026, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Utility subprograms to access Unicode Character database data.

with VSS.Unicode;
with VSS.Implementation.UCD_Core;

package VSS.Implementation.UCD_Utilities with Preelaborate is

   function Extract_Core_Data
     (Code : VSS.Unicode.Code_Point)
      return VSS.Implementation.UCD_Core.Core_Data_Record with Inline;
   --  Return core data record for the given character.

end VSS.Implementation.UCD_Utilities;
