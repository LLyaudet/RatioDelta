-- This file is part of RatioDelta library.

-- RatioDelta is free software:
-- you can redistribute it and/or modify
-- it under the terms of the GNU Lesser General Public License
-- as published by the Free Software Foundation,
-- either version 3 of the License, or
-- (at your option) any later version.

-- RatioDelta is distributed in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY; without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
-- GNU Lesser General Public License for more details.

-- You should have received a copy of the
-- GNU Lesser General Public License along with RatioDelta.
-- If not, see <http://www.gnu.org/licenses/>.

-- ©Copyright 2023-2024 Laurent Lyaudet


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_add(
  a double precision,
  b double precision,
  c double precision
) RETURNS double precision AS $$
  SELECT (a/b + c)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_subtract(
  a double precision,
  b double precision,
  c double precision
) RETURNS double precision AS $$
  SELECT (a/b - c)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_add(
  a double precision,
  b double precision,
  c double precision
) RETURNS double precision AS $$
  SELECT abs(a/b + c)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_subtract(
  a double precision,
  b double precision,
  c double precision
) RETURNS double precision AS $$
  SELECT abs(a/b - c)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_add(
  a double precision,
  b double precision,
  c double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT (a/b + c) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_subtract(
  a double precision,
  b double precision,
  c double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT (a/b - c) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_add(
  a double precision,
  b double precision,
  c double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT abs(a/b + c) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_subtract(
  a double precision,
  b double precision,
  c double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT abs(a/b - c) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_increment(
  a double precision,
  b double precision
) RETURNS double precision AS $$
  SELECT (a/b + 1)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_divide_decrement(
  a double precision,
  b double precision
) RETURNS double precision AS $$
  SELECT (a/b - 1)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_increment(
  a double precision,
  b double precision
) RETURNS double precision AS $$
  SELECT abs(a/b + 1)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION fused_absolute_divide_decrement(
  a double precision,
  b double precision
) RETURNS double precision AS $$
  SELECT abs(a/b - 1)
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_increment(
  a double precision,
  b double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT (a/b + 1) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_divide_decrement(
  a double precision,
  b double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT (a/b - 1) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_increment(
  a double precision,
  b double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT abs(a/b + 1) * scale
$$ LANGUAGE SQL;


-- It should be inlined.
-- Maybe one day it will be a single assembly operation.
CREATE FUNCTION scaled_fused_absolute_divide_decrement(
  a double precision,
  b double precision,
  scale double precision
) RETURNS double precision AS $$
  SELECT abs(a/b - 1) * scale
$$ LANGUAGE SQL;


CREATE FUNCTION ratio_iota(
  a double precision,
  b double precision,
  is_absolute boolean DEFAULT FALSE,
  scale double precision DEFAULT 1,
  round_to smallint DEFAULT NULL,
  both_null double precision DEFAULT NULL,
  a_null double precision DEFAULT NULL,
  b_null double precision DEFAULT NULL,
  b_zero double precision DEFAULT NULL
) RETURNS double precision AS $$
  SELECT CASE
    WHEN a IS NULL AND b IS NULL THEN both_null
    WHEN a IS NULL THEN a_null
    WHEN b IS NULL THEN b_null
    WHEN b = 0 THEN b_zero
    WHEN is_absolute AND round_to IS NOT NULL
     THEN round(
       scaled_fused_absolute_divide_increment(a, b, scale),
       round_to
     )
    WHEN is_absolute
     THEN scaled_fused_absolute_divide_increment(a, b, scale)
    WHEN round_to IS NOT NULL
     THEN round(scaled_fused_divide_increment(a, b, scale), round_to)
    ELSE scaled_fused_divide_increment(a, b, scale)
  END
$$ LANGUAGE SQL;


CREATE FUNCTION ratio_delta(
  a double precision,
  b double precision,
  is_absolute boolean DEFAULT FALSE,
  scale double precision DEFAULT 1,
  round_to smallint DEFAULT NULL,
  both_null double precision DEFAULT NULL,
  a_null double precision DEFAULT NULL,
  b_null double precision DEFAULT NULL,
  b_zero double precision DEFAULT NULL
) RETURNS double precision AS $$
  SELECT CASE
    WHEN a IS NULL AND b IS NULL THEN both_null
    WHEN a IS NULL THEN a_null
    WHEN b IS NULL THEN b_null
    WHEN b = 0 THEN b_zero
    WHEN is_absolute AND round_to IS NOT NULL
     THEN round(
       scaled_fused_absolute_divide_decrement(a, b, scale),
       round_to
     )
    WHEN is_absolute
     THEN scaled_fused_absolute_divide_decrement(a, b, scale)
    WHEN round_to IS NOT NULL
     THEN round(scaled_fused_divide_decrement(a, b, scale), round_to)
    ELSE scaled_fused_divide_decrement(a, b, scale)
  END
$$ LANGUAGE SQL;


CREATE FUNCTION ratio_alpha(
  a double precision,
  b double precision,
  c double precision,
  is_absolute boolean DEFAULT FALSE,
  scale double precision DEFAULT 1,
  round_to smallint DEFAULT NULL,
  all_null double precision DEFAULT NULL,
  a_b_null double precision DEFAULT NULL,
  a_c_null double precision DEFAULT NULL,
  b_c_null double precision DEFAULT NULL,
  a_null double precision DEFAULT NULL,
  b_null double precision DEFAULT NULL,
  c_null double precision DEFAULT NULL,
  b_zero double precision DEFAULT NULL
) RETURNS double precision AS $$
  SELECT CASE
    WHEN a IS NULL AND b IS NULL AND c IS NULL THEN all_null
    WHEN a IS NULL AND b IS NULL THEN a_b_null
    WHEN a IS NULL AND c IS NULL THEN a_c_null
    WHEN b IS NULL AND c IS NULL THEN b_c_null
    WHEN a IS NULL THEN a_null
    WHEN b IS NULL THEN b_null
    WHEN c IS NULL THEN c_null
    WHEN b = 0 THEN b_zero
    WHEN is_absolute AND round_to IS NOT NULL
     THEN round(
       scaled_fused_absolute_divide_add(a, b, c, scale),
       round_to
     )
    WHEN is_absolute
     THEN scaled_fused_absolute_divide_add(a, b, c, scale)
    WHEN round_to IS NOT NULL
     THEN round(scaled_fused_divide_add(a, b, c, scale), round_to)
    ELSE scaled_fused_divide_add(a, b, c, scale)
  END
$$ LANGUAGE SQL;


CREATE FUNCTION ratio_sigma(
  a double precision,
  b double precision,
  c double precision,
  is_absolute boolean DEFAULT FALSE,
  scale double precision DEFAULT 1,
  round_to smallint DEFAULT NULL,
  all_null double precision DEFAULT NULL,
  a_b_null double precision DEFAULT NULL,
  a_c_null double precision DEFAULT NULL,
  b_c_null double precision DEFAULT NULL,
  a_null double precision DEFAULT NULL,
  b_null double precision DEFAULT NULL,
  c_null double precision DEFAULT NULL,
  b_zero double precision DEFAULT NULL
) RETURNS double precision AS $$
  SELECT CASE
    WHEN a IS NULL AND b IS NULL AND c IS NULL THEN all_null
    WHEN a IS NULL AND b IS NULL THEN a_b_null
    WHEN a IS NULL AND c IS NULL THEN a_c_null
    WHEN b IS NULL AND c IS NULL THEN b_c_null
    WHEN a IS NULL THEN a_null
    WHEN b IS NULL THEN b_null
    WHEN c IS NULL THEN c_null
    WHEN b = 0 THEN b_zero
    WHEN is_absolute AND round_to IS NOT NULL
     THEN round(
       scaled_fused_absolute_divide_subtract(a, b, c, scale),
       round_to
     )
    WHEN is_absolute
     THEN scaled_fused_absolute_divide_subtract(a, b, c, scale)
    WHEN round_to IS NOT NULL
     THEN round(
       scaled_fused_divide_subtract(a, b, c, scale),
       round_to
     )
    ELSE scaled_fused_divide_subtract(a, b, c, scale)
  END
$$ LANGUAGE SQL;
