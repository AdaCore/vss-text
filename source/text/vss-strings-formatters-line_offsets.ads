--
--  Copyright (C) 2025, AdaCore
--
--  SPDX-License-Identifier: Apache-2.0 WITH LLVM-exception
--

--  Instantiation of generic integer formatter package for `Line_Offset` type.

with VSS.Strings.Formatters.Generic_Integers;

package VSS.Strings.Formatters.Line_Offsets is
  new VSS.Strings.Formatters.Generic_Integers (VSS.Strings.Line_Offset)
    with Preelaborate;
