# RatioDelta
An unknown? but somewhat common arithmetic operation

In accounting, it is common to compute (a/b - 1), or (a/b - 1) * 100 if you want percents.
Following Knuth's advice "Name and conquer", we give the name ratio-delta to the binary operation a/b - 1.
We do know that Knuth can safely apply his advice, whilst for mere mortals the answer is mostly "Don't piss me off with your fancy name." ;)

If you think relative error, you're right but read-on :)

Here is a potential implementation with error handling for PostgreSQL:
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

If accounting department wants to compare the invoiced total of a supplier order compared to the expected price of what you ordered to your supplier,
they may ask you a report with all supplier orders where ratio-delta of invoiced total and expected total is more than 5 percent.
First of by having a name, you can communicate efficiently and precisely with the accounting department,
instead of:

- "The ratio is more than 5 percents" which has clearly a different meaning
  (so you want any supplier order where the invoice is at least one twentieth of expected price? really?),
- "The difference is more than 5 percents" which has clearly another different meaning
  (so you want any supplier order where the invoice is at least 5 cents above the expected price? really?).

Secondly, your SQL is readable and simple:
```sql
SELECT * FROM supplier_order
WHERE ratio_delta(supplier_order.invoiced_total, supplier_order.expected_total, 0, 0, 0, 0) > 0.05;
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
      WHEN is_absolute AND is_percent AND round_to IS NOT NULL THEN round(abs(a/b - 1) * 100, round_to)
      WHEN is_absolute AND is_percent THEN abs(a/b - 1) * 100
      WHEN is_absolute AND round_to IS NOT NULL THEN round(abs(a/b - 1), round_to)
      WHEN is_percent AND round_to IS NOT NULL THEN round((a/b - 1) * 100, round_to)
      WHEN is_absolute THEN abs(a/b - 1)
      WHEN is_percent THEN (a/b - 1) * 100
      WHEN round_to IS NOT NULL THEN round(a/b - 1, round_to)
      ELSE a/b - 1 
    END
$$ LANGUAGE SQL;
```
It will factorize your code and be completely "flexible".
But I do not know a way to specialize and inline it to be efficient in SQL.
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

The "full-feature" function can be slightly optimized (less branching) and generalized with a "scale" argument instead of "is_percent":
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
      WHEN is_absolute AND round_to IS NOT NULL THEN round(abs(a/b - 1) * scale, round_to)
      WHEN is_absolute THEN abs(a/b - 1) * scale
      WHEN round_to IS NOT NULL THEN round((a/b - 1) * scale, round_to)
      ELSE (a/b - 1) * scale
    END
$$ LANGUAGE SQL;
```
But again, it would be nice if the SQL interpreter knows to drop the multiplication if scale is the constant 1.

## Relative error

Ratio-delta is closely related to relative error which is most of the time "absolute ratio-delta": abs(a/b - 1) = abs((a-b)/b),
where a is the approximation and b is the exact value: <https://en.wikipedia.org/wiki/Approximation_error>.
Sometimes the term (signed) relative error denotes the ratio-delta: <https://mathworld.wolfram.com/RelativeError.html>.
But the term absolute relative error would be ambiguous with absolute error abs(a-b).
Moreover the term relative error is not neutral and is domain specific (error analysis domain),
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

This detour from accounting to relative error via a new name was the opportunity to give you SQL functions for it,
and see that no major database has a function for (signed) relative error:
- <https://www.postgresql.org/docs/current/functions-math.html>
- <https://mariadb.com/kb/en/numeric-functions/>
- <https://dev.mysql.com/doc/refman/8.0/en/numeric-functions.html>
- <https://docs.oracle.com/cd/E49933_01/server.770/es_eql/src/ceql_functions_numeric.html>
- <https://learn.microsoft.com/en-us/sql/odbc/reference/appendixes/numeric-functions?view=sql-server-ver16>

There also does not seem to have any CPU architecture that has instructions for (signed) relative error.

We use relative error by hand to analyze the properties of floating-point numbers,
but there is no shortcut to analyze relative errors in significant hardware and software.

The fact is that error handling made it useful for us to define such functions in SQL.
It would probably be a good thing that it is available for more software parts like databases.
And even maybe it would yield significant optimization with hardware.



