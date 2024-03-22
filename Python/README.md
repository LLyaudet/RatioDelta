# RatioDelta

![PyPI - Python Version](https://img.shields.io/pypi/pyversions/ratio-delta)
[![pypi-version](https://img.shields.io/pypi/v/ratio-delta.svg)](https://pypi.org/project/ratio-delta/)
[![Downloads](https://img.shields.io/pypi/dm/ratio-delta)](https://pypistats.org/packages/ratio-delta)
[![Code style: black](https://img.shields.io/badge/code%20style-black-000000.svg)](https://github.com/psf/black)
[![Imports: isort](https://img.shields.io/badge/%20imports-isort-%231674b1?style=flat&labelColor=ef8336)](https://pycqa.github.io/isort/)
[![Checked with mypy](https://www.mypy-lang.org/static/mypy_badge.svg)](https://mypy-lang.org/)
[![linting: pylint](https://img.shields.io/badge/linting-pylint-yellowgreen)](https://github.com/pylint-dev/pylint)
[![CodeFactor](https://www.codefactor.io/repository/github/llyaudet/RatioDelta/badge/main)](https://www.codefactor.io/repository/github/llyaudet/RatioDelta/overview/main)
[![CodeClimateMaintainability](https://api.codeclimate.com/v1/badges/23218bfc6b7b7dd5c2aa/maintainability)](https://codeclimate.com/github/LLyaudet/RatioDelta/maintainability)
[![Codacy Badge](https://app.codacy.com/project/badge/Grade/d4c03e8e52194c1fb3fb51bb58c4f54c)](https://app.codacy.com/gh/LLyaudet/RatioDelta/dashboard?utm_source=gh&utm_medium=referral&utm_content=&utm_campaign=Badge_grade)
![GitHub top language](https://img.shields.io/github/languages/top/llyaudet/RatioDelta)
![GitHub License](https://img.shields.io/github/license/llyaudet/RatioDelta)
![GitHub code size in bytes](https://img.shields.io/github/languages/code-size/llyaudet/RatioDelta)
[![GitHub Sponsors](https://img.shields.io/github/sponsors/LLyaudet)](https://github.com/sponsors/LLyaudet)

|     **An unknown? but somewhat common arithmetic operation**     |

In accounting, it is common to compute (a/b - 1),
or (a/b - 1) * 100 if you want percents.
Following Knuth's advice "Name and conquer",
we give the name ratio-delta to the binary operation a/b - 1.
We do know that Knuth can safely apply his advice,
whilst for mere mortals the answer is mostly
"Don't piss me off with your fancy name." ;)

If you think relative error, fused divide-add,
or fused divide-subtract, you're right but read-on :)

Here is a potential implementation with error handling
for PostgreSQL:
```sql
CREATE FUNCTION ratio_delta(
  a double precision,
  b double precision,
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
      ELSE a/b - 1
    END
$$ LANGUAGE SQL;

-- Test it
SELECT ratio_delta(1, 2);
SELECT ratio_delta(NULL, NULL, -100, -101, -102, -103);
SELECT ratio_delta(NULL, 2, -100, -101, -102, -103);
SELECT ratio_delta(1, NULL, -100, -101, -102, -103);
SELECT ratio_delta(1, 0, -100, -101, -102, -103);
```

## What is it good for?

If accounting department wants to compare the invoiced total
of a supplier order compared to the expected price of
what you ordered to your supplier,
they may ask you a report with all supplier orders where ratio-delta
of invoiced total and expected total is more than 5 percent.
First of by having a name, you can communicate efficiently
and precisely with the accounting department,
instead of:

- "The ratio is more than 5 percents"
  which has clearly a different meaning
  (so you want any supplier order where the invoice is at least
  one twentieth of expected price? really?),
- "The difference is more than 5 percents"
  which has clearly another different meaning
  (so you want any supplier order where the invoice is at least
  5 cents above the expected price? really?).

Secondly, your SQL is readable and simple:
```sql
SELECT * FROM supplier_order
WHERE ratio_delta(
  supplier_order.invoiced_total,
  supplier_order.expected_total,
  0, 0, 0, 0
) > 0.05;
```

Make sure to have a look at the issues on GitHub!

## Variants

The word we propose can easily be combined with the following:

- absolute ratio-delta: abs(a/b - 1)
- ratio-delta percent: (a/b - 1) * 100
- absolute ratio-delta percent: abs(a/b - 1) * 100

Moreover, you can add rounding.
You can obtain a synthetic function with (too) many arguments like:
```sql
CREATE FUNCTION ratio_delta(
  a double precision,
  b double precision,
  is_absolute boolean DEFAULT FALSE,
  is_percent boolean DEFAULT FALSE,
  round_to smallint DEFAULT NULL,
  both_null double precision DEFAULT NULL,
  a_null double precision DEFAULT NULL,
  b_null double precision DEFAULT NULL,
  b_zero double precision DEFAULT NULL
) RETURNS double precision AS $$
    SELECT CASE
      WHEN a IS NULL and b IS NULL THEN both_null
      WHEN a IS NULL THEN a_null
      WHEN b IS NULL THEN b_null
      WHEN b = 0 THEN b_zero
      WHEN is_absolute
       AND is_percent
       AND round_to IS NOT NULL
       THEN round(abs(a/b - 1) * 100, round_to)
      WHEN is_absolute AND is_percent THEN abs(a/b - 1) * 100
      WHEN is_absolute AND round_to IS NOT NULL
       THEN round(abs(a/b - 1), round_to)
      WHEN is_percent AND round_to IS NOT NULL
       THEN round((a/b - 1) * 100, round_to)
      WHEN is_absolute THEN abs(a/b - 1)
      WHEN is_percent THEN (a/b - 1) * 100
      WHEN round_to IS NOT NULL THEN round(a/b - 1, round_to)
      ELSE a/b - 1
    END
$$ LANGUAGE SQL;
```
It will factorize your code and be completely "flexible".
But I do not know a way to specialize
and inline it to be efficient in SQL.
You can still do, for example:
```sql
CREATE FUNCTION absolute_rounded_ratio_delta(
  a double precision,
  b double precision,
  round_to smallint DEFAULT NULL,
) RETURNS double precision AS $$
    SELECT ratio_delta(a, b, TRUE, FALSE, round_to, 0, 0, 0, 0)
$$ LANGUAGE SQL;
```

The "full-feature" function can be slightly optimized (less branching)
and generalized with a "scale" argument instead of "is_percent":
```sql
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
      WHEN a IS NULL and b IS NULL THEN both_null
      WHEN a IS NULL THEN a_null
      WHEN b IS NULL THEN b_null
      WHEN b = 0 THEN b_zero
      WHEN is_absolute AND round_to IS NOT NULL
       THEN round(abs(a/b - 1) * scale, round_to)
      WHEN is_absolute THEN abs(a/b - 1) * scale
      WHEN round_to IS NOT NULL
       THEN round((a/b - 1) * scale, round_to)
      ELSE (a/b - 1) * scale
    END
$$ LANGUAGE SQL;
```
But again, it would be nice if the SQL interpreter knows to drop
the multiplication if scale is the constant 1.

## Relative error

Ratio-delta is closely related to relative error
which is most of the time "absolute ratio-delta":
abs(a/b - 1) = abs((a-b)/b),
where a is the approximation and b is the exact value:
<https://en.wikipedia.org/wiki/Approximation_error>.
Sometimes the term (signed) relative error denotes the ratio-delta:
<https://mathworld.wolfram.com/RelativeError.html>.
But the term absolute relative error would be ambiguous
with absolute error abs(a-b).
Moreover the term relative error is not neutral
and is domain specific (error analysis domain),
instead of denoting what is done.

```sql
CREATE FUNCTION absolute_rounded_ratio_delta(
  a double precision,
  b double precision,
  round_to smallint DEFAULT NULL,
) RETURNS double precision AS $$
    SELECT ratio_delta(a, b, TRUE, 1, round_to, 0, 0, 0, 0)
$$ LANGUAGE SQL;
```

is the same as:

```sql
CREATE FUNCTION rounded_relative_error(
  a double precision,
  b double precision,
  round_to smallint DEFAULT NULL,
) RETURNS double precision AS $$
    SELECT ratio_delta(a, b, TRUE, 1, round_to, 0, 0, 0, 0)
$$ LANGUAGE SQL;
```

This detour from accounting to relative error via a new name
was the opportunity to give you SQL functions for it,
and see that no major database has a function
for (signed) relative error:
- <https://www.postgresql.org/docs/current/functions-math.html>
- <https://mariadb.com/kb/en/numeric-functions/>
- <https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html>
- <https://docs.oracle.com/cd/E49933_01/server.770/es_eql/src/ceql_functions_numeric.html>
- <https://learn.microsoft.com/en-us/sql/odbc/reference/appendixes/numeric-functions?view=sql-server-ver16>

There also does not seem to have any CPU architecture
that has instructions for (signed) relative error.

We use relative error by hand
to analyze the properties of floating-point numbers,
but there is no shortcut to analyze relative errors
in significant hardware and software.

The fact is that error handling made it useful for us
to define such functions in SQL.
It would probably be a good thing
that it is available for more software parts like databases.
And even maybe it would yield significant optimization with hardware.

## Other uses

I asked a friend of mine if he saw any use in physics.
He told me:
"Not later than last week, I was using it with variable offset
for a Laser Doppler vibrometer
<https://en.wikipedia.org/wiki/Laser_Doppler_vibrometer>.
For each frequency f, I had to compute:

Normalized displacement corrected for each frequency
 = Measured displacement / applied tension - measure offset

<=> |H(f)| = abs(D(f) / U(f) - Offset (f))

It is frequent for measuring devices:

H = (A / B - O)*G

Default Offset O=1

Default gain G=100
"

"
Another more frequent example is in impedancemetry,

Z(f) = U(f) / I(f)

but, in practice, you must calibrate your device

Z_corrected := U_measured / I_measured - Z_calibration
"

Let's continue to name and conquer, and call:

- ratio-offset
  when an offset is applied positively or negatively to a ratio,
- ratio-iota when a unit offset is added a/b + 1 (iota as increment),
- ratio-alpha when a variable offset is added
  (alpha as add, it is a ternary operation a/b + c),
- ratio-delta when a unit offset is subtracted
  (delta as decrement, I have been lucky with my initial choice),
- ratio-sigma when a variable offset is subtracted
  (sigma as subtract, it is a ternary operation a/b - c),
- absolute... when we take the absolute value,
- rounded... when we round the result,
- scaled... when a scale/gain is applied.

Just in case, if someone does not know or if it hurts someone:

- "add a to b" corresponds to "a + b",
- "increment a by b" corresponds to "a := a + b".

Hence, yes I'm slightly abusing semantics
since most increments in source code happen to be increments by 1.
And it is handy to distinguish between "a + b" and "a + 1"
(or between "a := a + b" and "a := a + 1"),
by using "increment" when the second operand is 1
and "add" when the second operand is variable.
I'm not the first to use this trick,
and will probably not be the last ;).

For hardware, the topic of ratio-alpha and ratio-sigma
has been addressed in academic papers on fused divide-add:
- <https://ieeexplore.ieee.org/abstract/document/5451057>
- <https://ieeexplore.ieee.org/document/5349981>
- <https://ieeexplore.ieee.org/abstract/document/7280029>

It was already envisionned in 1994:
- <https://www.researchgate.net/profile/Michael-Flynn-7/publication/3043776_Design_issues_in_division_and_other_floating-point_operations/links/5467be1a0cf2f5eb18036e1e/Design-issues-in-division-and-other-floating-point-operations.pdf>

But we could not check if someone linked explicitely
relative error with fused divide-add.
(A paper about fused divide-add/subtract can talk about relative error
as a tool to analyze the fused divide-add/subtract method,
without noting that the relative error can be computed
by a fused divide-subtract
and we do not have access to most of full-texts on the subject.)

But it does not seem to be in current Instruction Set Architectures:

- <https://cdrdv2.intel.com/v1/dl/getContent/671110>
- <https://developer.arm.com/documentation/ddi0602/2023-03/SIMD-FP-Instructions?lang=en>

With dedicated function in software,
it may be easier to use dedicated hardware if it exists one day.

## Voltage divider, and beyond?

If we look at ratio-iota (a/b) + 1,
when you have a voltage divider (<https://en.wikipedia.org/wiki/Voltage_divider>)
with two resistors,
the coefficient applied to tension is (Z2/(Z1+Z2)) = 1 / (Z1/Z2 + 1).
Thus, we could, but probably should not, add:

- inverted... when you take the inverse of it.

And the coefficient in a voltage divider
is inverted ratio-iota, for example.
But it is clearly not the most efficient way to compute it.
And if we look at the variable offset versions of it:

- inverted ratio-alpha: 1/(a/b + c) = 1/((a + bc)/b) = b/(a + bc),
- inverted ratio-sigma: 1/(a/b - c) = 1/((a - bc)/b) = b/(a - bc),

we can see the fused multiply-add a + bc = bc + a,
but we cannot see the fused multiply-subtract a - bc != bc - a
<https://www.ibm.com/docs/en/aix/7.1?topic=set-fmsub-fms-floating-multiply-subtract-instruction>.
We do not know if there may be uses
for fused multiply-subtract of type 2 a - bc
on top of fused multiply-subtract of type 1 bc - a.

Other uses of ratio-iota appears
with differential and operational amplifiers,
see
<https://www.electronique-et-informatique.fr/anglais/Amplificateur_differentiel.php>
for example.

## Source code

The source code is available for SQL, Python, and PHP currently.
It is quite verbose and repetitive because we wanted to explicit
what could be assembly operation in our point of view.

