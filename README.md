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
SELECT * FROM supplier_order WHERE ratio_delta(supplier_order.invoiced_total, supplier_order.invoiced_total, 0, 0, 0, 0) > 0.05;
```



