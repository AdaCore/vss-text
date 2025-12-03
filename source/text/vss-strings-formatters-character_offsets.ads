--
--  Copyright (C) 2025, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Instantiation of generic integer formatter package for `Character_Offset`
--  type.

with VSS.Strings.Formatters.Generic_Integers;

package VSS.Strings.Formatters.Character_Offsets is
  new VSS.Strings.Formatters.Generic_Integers (VSS.Strings.Character_Offset)
    with Preelaborate;
