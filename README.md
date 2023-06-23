# RatioDelta
An unknown but somewhat common arithmetic operation

In accounting, it is common to compute (a/b - 1), or (a/b - 1) * 100 if you want percents.
Following Knuth's advice "Name and conquer", we give the name ratio-delta to the binary operation a/b - 1.
We do know that Knuth can safely apply his advice, whilst for mere mortals the answer is mostly "Don't piss me off with your fancy name." ;)

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
      WHEN a is NULL and b is NULL THEN both_null
      WHEN a is NULL THEN a_null
      WHEN b is NULL THEN b_null
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


