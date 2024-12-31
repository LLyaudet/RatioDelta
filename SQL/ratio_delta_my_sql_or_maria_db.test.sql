-- This file is part of RatioDelta library.
--
-- RatioDelta is free software:
-- you can redistribute it and/or modify it under the terms
-- of the GNU Lesser General Public License
-- as published by the Free Software Foundation,
-- either version 3 of the License,
-- or (at your option) any later version.
--
-- RatioDelta is distributed
-- in the hope that it will be useful,
-- but WITHOUT ANY WARRANTY;
-- without even the implied warranty of
-- MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
-- See the GNU Lesser General Public License for more details.
--
-- You should have received a copy of
-- the GNU Lesser General Public License
-- along with RatioDelta.
-- If not, see <https://www.gnu.org/licenses/>.
--
-- ©Copyright 2023-2024 Laurent Lyaudet

SELECT CASE
  WHEN fused_divide_add(4, 2, 2) = 4
    THEN 'OK1'
  ELSE 'KO1'
  END;

SELECT CASE
  WHEN fused_divide_subtract(4, 2, 2) = 0
    THEN 'OK2'
  ELSE 'KO2'
  END;

SELECT CASE
  WHEN fused_absolute_divide_add(4, 2, -5) = 3
    THEN 'OK3'
  ELSE 'KO3'
  END;

SELECT CASE
  WHEN fused_absolute_divide_subtract(4, 2, 5) = 3
    THEN 'OK4'
  ELSE 'KO4'
  END;

SELECT CASE
  WHEN scaled_fused_divide_add(4, 2, 2, 10) = 40
    THEN 'OK5'
  ELSE 'KO5'
  END;

SELECT CASE
  WHEN scaled_fused_divide_subtract(4, 2, 1, 10) = 10
    THEN 'OK6'
  ELSE 'KO6'
  END;

SELECT CASE
  WHEN scaled_fused_absolute_divide_add(4, 2, -5, 10) = 30
    THEN 'OK7'
  ELSE 'KO7'
  END;

SELECT CASE
  WHEN scaled_fused_absolute_divide_subtract(4, 2, 5, 10) = 30
    THEN 'OK8'
  ELSE 'KO8'
  END;

SELECT CASE
  WHEN fused_divide_increment(4, 2) = 3
    THEN 'OK9'
  ELSE 'KO9'
  END;

SELECT CASE
  WHEN fused_divide_decrement(4, 2) = 1
    THEN 'OK10'
  ELSE 'KO10'
  END;

SELECT CASE
  WHEN fused_absolute_divide_increment(-4, 2) = 1
    THEN 'OK11'
  ELSE 'KO11'
  END;

SELECT CASE
  WHEN fused_absolute_divide_decrement(0, 1) = 1
    THEN 'OK12'
  ELSE 'KO12'
  END;

SELECT CASE
  WHEN scaled_fused_divide_increment(4, 2, 10) = 30
    THEN 'OK13'
  ELSE 'KO13'
  END;

SELECT CASE
  WHEN scaled_fused_divide_decrement(4, 2, 10) = 10
    THEN 'OK14'
  ELSE 'KO14'
  END;

SELECT CASE
  WHEN scaled_fused_absolute_divide_increment(-4, 2, 10) = 10
    THEN 'OK15'
  ELSE 'KO15'
  END;

SELECT CASE
  WHEN scaled_fused_absolute_divide_decrement(-4, 2, 10) = 30
    THEN 'OK16'
  ELSE 'KO16'
  END;

SELECT CASE
  WHEN ratio_iota(
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    'BOTH_NULL',
    NULL,
    NULL,
    NULL
  ) = 'BOTH_NULL' THEN 'OK17'
  ELSE 'KO17'
  END;

SELECT CASE
  WHEN ratio_iota(
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    'A_NULL',
    NULL,
    NULL
  ) = 'A_NULL' THEN 'OK18'
  ELSE 'KO18'
  END;

SELECT CASE
  WHEN ratio_iota(
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
   'B_NULL',
    NULL
  ) = 'B_NULL' THEN 'OK19'
  ELSE 'KO19'
  END;

SELECT CASE
  WHEN ratio_iota(
    1,
    0,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_ZERO'
  ) = 'B_ZERO' THEN 'OK20'
  ELSE 'KO20'
  END;

SELECT CASE
  WHEN ratio_iota(
    -4,
    3,
    TRUE,
    10,
    2,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 3.33 THEN 'OK21'
  ELSE 'KO21'
  END;

SELECT CASE
  WHEN ratio_iota(
    -4,
    2,
    TRUE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 10 THEN 'OK22'
  ELSE 'KO22'
  END;

SELECT CASE
  WHEN ratio_iota(
    -4,
    3,
    FALSE,
    1,
    2,
    NULL,
    NULL,
    NULL,
    NULL
  ) = -0.33 THEN 'OK23'
  ELSE 'KO23'
  END;

SELECT CASE
  WHEN ratio_iota(
    4,
    2,
    FALSE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 30 THEN 'OK24'
  ELSE 'KO24'
  END;

SELECT CASE
  WHEN ratio_delta(
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    'BOTH_NULL',
    NULL,
    NULL,
    NULL
  ) = 'BOTH_NULL' THEN 'OK25'
  ELSE 'KO25'
  END;

SELECT CASE
  WHEN ratio_delta(
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    'A_NULL',
    NULL,
    NULL
  ) = 'A_NULL' THEN 'OK26'
  ELSE 'KO26'
  END;

SELECT CASE
  WHEN ratio_delta(
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
   'B_NULL',
    NULL
  ) = 'B_NULL' THEN 'OK27'
  ELSE 'KO27'
  END;

SELECT CASE
  WHEN ratio_delta(
    1,
    0,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_ZERO'
  ) = 'B_ZERO' THEN 'OK28'
  ELSE 'KO28'
  END;

SELECT CASE
  WHEN ratio_delta(
    2,
    3,
    TRUE,
    10,
    2,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 3.33 THEN 'OK29'
  ELSE 'KO29'
  END;

SELECT CASE
  WHEN ratio_delta(
    -4,
    2,
    TRUE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 30 THEN 'OK30'
  ELSE 'KO30'
  END;

SELECT CASE
  WHEN ratio_delta(
    2,
    3,
    FALSE,
    1,
    2,
    NULL,
    NULL,
    NULL,
    NULL
  ) = -0.33 THEN 'OK31'
  ELSE 'KO31'
  END;

SELECT CASE
  WHEN ratio_delta(
    4,
    2,
    FALSE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 10 THEN 'OK32'
  ELSE 'KO32'
  END;

SELECT CASE
  WHEN ratio_alpha(
    NULL,
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    'ALL_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'ALL_NULL' THEN 'OK33'
  ELSE 'KO33'
  END;

SELECT CASE
  WHEN ratio_alpha(
    NULL,
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    'A_B_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'A_B_NULL' THEN 'OK34'
  ELSE 'KO34'
  END;

SELECT CASE
  WHEN ratio_alpha(
    NULL,
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    'A_C_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'A_C_NULL' THEN 'OK35'
  ELSE 'KO35'
  END;

SELECT CASE
  WHEN ratio_alpha(
    1,
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_C_NULL',
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'B_C_NULL' THEN 'OK36'
  ELSE 'KO36'
  END;

SELECT CASE
  WHEN ratio_alpha(
    NULL,
    1,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'A_NULL',
    NULL,
    NULL,
    NULL
  ) = 'A_NULL' THEN 'OK37'
  ELSE 'KO37'
  END;

SELECT CASE
  WHEN ratio_alpha(
    1,
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_NULL',
    NULL,
    NULL
  ) = 'B_NULL' THEN 'OK38'
  ELSE 'KO38'
  END;

SELECT CASE
  WHEN ratio_alpha(
    1,
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'C_NULL',
    NULL
  ) = 'C_NULL' THEN 'OK39'
  ELSE 'KO39'
  END;

SELECT CASE
  WHEN ratio_alpha(
    1,
    0,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_ZERO'
  ) = 'B_ZERO' THEN 'OK40'
  ELSE 'KO40'
  END;

SELECT CASE
  WHEN ratio_alpha(
    -4,
    3,
    1,
    TRUE,
    10,
    2,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 3.33 THEN 'OK41'
  ELSE 'KO41'
  END;

SELECT CASE
  WHEN ratio_alpha(
    -4,
    2,
    1,
    TRUE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 10 THEN 'OK42'
  ELSE 'KO42'
  END;

SELECT CASE
  WHEN ratio_alpha(
    -4,
    3,
    1,
    FALSE,
    1,
    2,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = -0.33 THEN 'OK43'
  ELSE 'KO43'
  END;

SELECT CASE
  WHEN ratio_alpha(
    4,
    2,
    1,
    FALSE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 30 THEN 'OK44'
  ELSE 'KO44'
  END;

SELECT CASE
  WHEN ratio_sigma(
    NULL,
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    'ALL_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'ALL_NULL' THEN 'OK45'
  ELSE 'KO45'
  END;

SELECT CASE
  WHEN ratio_sigma(
    NULL,
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    'A_B_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'A_B_NULL' THEN 'OK46'
  ELSE 'KO46'
  END;

SELECT CASE
  WHEN ratio_sigma(
    NULL,
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    'A_C_NULL',
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'A_C_NULL' THEN 'OK47'
  ELSE 'KO47'
  END;

SELECT CASE
  WHEN ratio_sigma(
    1,
    NULL,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_C_NULL',
    NULL,
    NULL,
    NULL,
    NULL
  ) = 'B_C_NULL' THEN 'OK48'
  ELSE 'KO48'
  END;

SELECT CASE
  WHEN ratio_sigma(
    NULL,
    1,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'A_NULL',
    NULL,
    NULL,
    NULL
  ) = 'A_NULL' THEN 'OK49'
  ELSE 'KO49'
  END;

SELECT CASE
  WHEN ratio_sigma(
    1,
    NULL,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_NULL',
    NULL,
    NULL
  ) = 'B_NULL' THEN 'OK50'
  ELSE 'KO50'
  END;

SELECT CASE
  WHEN ratio_sigma(
    1,
    1,
    NULL,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'C_NULL',
    NULL
  ) = 'C_NULL' THEN 'OK51'
  ELSE 'KO51'
  END;

SELECT CASE
  WHEN ratio_sigma(
    1,
    0,
    1,
    FALSE,
    1,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    'B_ZERO'
  ) = 'B_ZERO' THEN 'OK52'
  ELSE 'KO52'
  END;

SELECT CASE
  WHEN ratio_sigma(
    2,
    3,
    1,
    TRUE,
    10,
    2,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 3.33 THEN 'OK53'
  ELSE 'KO53'
  END;

SELECT CASE
  WHEN ratio_sigma(
    -4,
    2,
    1,
    TRUE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 30 THEN 'OK54'
  ELSE 'KO54'
  END;

SELECT CASE
  WHEN ratio_sigma(
    2,
    3,
    1,
    FALSE,
    1,
    2,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = -0.33 THEN 'OK55'
  ELSE 'KO55'
  END;

SELECT CASE
  WHEN ratio_sigma(
    4,
    2,
    1,
    FALSE,
    10,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL,
    NULL
  ) = 10 THEN 'OK56'
  ELSE 'KO56'
  END;

