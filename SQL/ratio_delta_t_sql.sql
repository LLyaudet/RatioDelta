-- This file is part of RatioDelta library.
--
-- RatioDelta is free software:
-- you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License
-- as published by the Free Software Foundation,
-- either version 3 of the License, or
-- (at your option) any later version.
--
-- RatioDelta is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR @a PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.
--
-- You should have received @a copy of the
-- GNU Lesser General Public License along with RatioDelta.
-- If not, see <http://www.gnu.org/licenses/>.
--
-- ©Copyright 2023-2024 Laurent Lyaudet

SET QUOTED_IDENTIFIER ON;
SET ANSI_NULLS ON;
SET NOCOUNT ON;
SET TRANSACTION ISOLATION LEVEL READ UNCOMMITTED;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_add(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b + @c);
END;
GO


-- SELECT dbo.fused_divide_add(1,1,1) AS Result;
-- GO
-- DECLARE @ret FLOAT(53);
-- EXEC @ret = dbo.fused_divide_add @a=1, @b=1, @c=1;
-- SELECT @ret;
-- GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_subtract(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b - @c);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_add(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b + @c);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_subtract(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b - @c);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_add(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b + @c) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_subtract(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b - @c) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_add(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b + @c) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_subtract(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b - @c) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_increment(
  @a FLOAT(53),
  @b FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b + 1);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_decrement(
  @a FLOAT(53),
  @b FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b - 1);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_increment(
  @a FLOAT(53),
  @b FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b + 1);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_decrement(
  @a FLOAT(53),
  @b FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b - 1);
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_increment(
  @a FLOAT(53),
  @b FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b + 1) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_decrement(
  @a FLOAT(53),
  @b FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN (@a/@b - 1) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_increment(
  @a FLOAT(53),
  @b FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b + 1) * @scale;
END;
GO


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_decrement(
  @a FLOAT(53),
  @b FLOAT(53),
  @scale FLOAT(53)
) RETURNS FLOAT(53)
WITH SCHEMABINDING,
  RETURNS NULL ON NULL INPUT
AS
BEGIN
  RETURN abs(@a/@b - 1) * @scale;
END;
GO


CREATE FUNCTION ratio_iota(
  @a FLOAT(53),
  @b FLOAT(53),
  @is_absolute BIT = 0,
  @scale FLOAT(53) = 1,
  @round_to SMALLINT = NULL,
  @both_null FLOAT(53) = NULL,
  @a_null FLOAT(53) = NULL,
  @b_null FLOAT(53) = NULL,
  @b_zero FLOAT(53) = NULL
) RETURNS FLOAT(53)
WITH SCHEMABINDING
AS
BEGIN
  RETURN CASE
    WHEN @a IS NULL AND @b IS NULL THEN @both_null
    WHEN @a IS NULL THEN @a_null
    WHEN @b IS NULL THEN @b_null
    WHEN @b = 0 THEN @b_zero
    WHEN @is_absolute = 1 AND @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_absolute_divide_increment(@a, @b, @scale),
       @round_to
     )
    WHEN @is_absolute = 1
     THEN dbo.scaled_fused_absolute_divide_increment(@a, @b, @scale)
    WHEN @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_divide_increment(@a, @b, @scale),
       @round_to
     )
    ELSE dbo.scaled_fused_divide_increment(@a, @b, @scale)
  END;
END;
GO


CREATE FUNCTION ratio_delta(
  @a FLOAT(53),
  @b FLOAT(53),
  @is_absolute BIT = 0,
  @scale FLOAT(53) = 1,
  @round_to SMALLINT = NULL,
  @both_null FLOAT(53) = NULL,
  @a_null FLOAT(53) = NULL,
  @b_null FLOAT(53) = NULL,
  @b_zero FLOAT(53) = NULL
) RETURNS FLOAT(53)
WITH SCHEMABINDING
AS
BEGIN
  RETURN CASE
    WHEN @a IS NULL AND @b IS NULL THEN @both_null
    WHEN @a IS NULL THEN @a_null
    WHEN @b IS NULL THEN @b_null
    WHEN @b = 0 THEN @b_zero
    WHEN @is_absolute = 1 AND @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_absolute_divide_decrement(@a, @b, @scale),
       @round_to
     )
    WHEN @is_absolute = 1
     THEN dbo.scaled_fused_absolute_divide_decrement(@a, @b, @scale)
    WHEN @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_divide_decrement(@a, @b, @scale),
       @round_to
     )
    ELSE dbo.scaled_fused_divide_decrement(@a, @b, @scale)
  END;
END;
GO


CREATE FUNCTION ratio_alpha(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @is_absolute BIT = 0,
  @scale FLOAT(53) = 1,
  @round_to SMALLINT = NULL,
  @all_null FLOAT(53) = NULL,
  @a_b_null FLOAT(53) = NULL,
  @a_c_null FLOAT(53) = NULL,
  @b_c_null FLOAT(53) = NULL,
  @a_null FLOAT(53) = NULL,
  @b_null FLOAT(53) = NULL,
  @c_null FLOAT(53) = NULL,
  @b_zero FLOAT(53) = NULL
) RETURNS FLOAT(53)
WITH SCHEMABINDING
AS
BEGIN
  RETURN CASE
    WHEN @a IS NULL AND @b IS NULL AND @c IS NULL THEN @all_null
    WHEN @a IS NULL AND @b IS NULL THEN @a_b_null
    WHEN @a IS NULL AND @c IS NULL THEN @a_c_null
    WHEN @b IS NULL AND @c IS NULL THEN @b_c_null
    WHEN @a IS NULL THEN @a_null
    WHEN @b IS NULL THEN @b_null
    WHEN @c IS NULL THEN @c_null
    WHEN @b = 0 THEN @b_zero
    WHEN @is_absolute = 1 AND @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_absolute_divide_add(@a, @b, @c, @scale),
       @round_to
     )
    WHEN @is_absolute = 1
     THEN dbo.scaled_fused_absolute_divide_add(@a, @b, @c, @scale)
    WHEN @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_divide_add(@a, @b, @c, @scale),
       @round_to
     )
    ELSE dbo.scaled_fused_divide_add(@a, @b, @c, @scale)
  END;
END;
GO


CREATE FUNCTION ratio_sigma(
  @a FLOAT(53),
  @b FLOAT(53),
  @c FLOAT(53),
  @is_absolute BIT = 0,
  @scale FLOAT(53) = 1,
  @round_to SMALLINT = NULL,
  @all_null FLOAT(53) = NULL,
  @a_b_null FLOAT(53) = NULL,
  @a_c_null FLOAT(53) = NULL,
  @b_c_null FLOAT(53) = NULL,
  @a_null FLOAT(53) = NULL,
  @b_null FLOAT(53) = NULL,
  @c_null FLOAT(53) = NULL,
  @b_zero FLOAT(53) = NULL
) RETURNS FLOAT(53)
WITH SCHEMABINDING
AS
BEGIN
  RETURN CASE
    WHEN @a IS NULL AND @b IS NULL AND @c IS NULL THEN @all_null
    WHEN @a IS NULL AND @b IS NULL THEN @a_b_null
    WHEN @a IS NULL AND @c IS NULL THEN @a_c_null
    WHEN @b IS NULL AND @c IS NULL THEN @b_c_null
    WHEN @a IS NULL THEN @a_null
    WHEN @b IS NULL THEN @b_null
    WHEN @c IS NULL THEN @c_null
    WHEN @b = 0 THEN @b_zero
    WHEN @is_absolute = 1 AND @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_absolute_divide_subtract(@a, @b, @c, @scale),
       @round_to
     )
    WHEN @is_absolute = 1
     THEN dbo.scaled_fused_absolute_divide_subtract(
       @a, @b, @c, @scale
     )
    WHEN @round_to IS NOT NULL
     THEN round(
       dbo.scaled_fused_divide_subtract(@a, @b, @c, @scale),
       @round_to
     )
    ELSE dbo.scaled_fused_divide_subtract(@a, @b, @c, @scale)
  END;
END;
GO

-- Test with:
-- This doesn't work... SELECT dbo.ratio_alpha(@a=1, @b=1, @c=1);
-- But the two solutions below do work...
-- Almost there ;) Improve :)
-- SELECT dbo.ratio_alpha(1,1,1,0,1,
-- NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL,NULL);
-- GO
-- DECLARE @ret FLOAT(53);
-- EXEC @ret = dbo.ratio_alpha @a=1, @b=1, @c=1;
-- SELECT @ret;
-- GO

