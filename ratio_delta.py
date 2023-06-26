"""
This file is part of RatioDelta library.

RatioDelta is free software: you can redistribute it and/or modify
it under the terms of the GNU Lesser General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

RatioDelta is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.    See the
GNU Lesser General Public License for more details.

You should have received a copy of the GNU Lesser General Public License
along with RatioDelta.    If not, see <http://www.gnu.org/licenses/>.

©Copyright 2023 Laurent Lyaudet
"""


def fused_divide_add(
    a: float,
    b: float,
    c: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b + c)


def fused_divide_subtract(
    a: float,
    b: float,
    c: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b - c)


def fused_absolute_divide_add(
    a: float,
    b: float,
    c: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b + c)


def fused_absolute_divide_subtract(
    a: float,
    b: float,
    c: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b - c)


def scaled_fused_divide_add(
    a: float,
    b: float,
    c: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b + c) * scale


def scaled_fused_divide_subtract(
    a: float,
    b: float,
    c: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b - c) * scale


def scaled_fused_absolute_divide_add(
    a: float,
    b: float,
    c: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b + c) * scale


def scaled_fused_absolute_divide_subtract(
    a: float,
    b: float,
    c: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b - c) * scale

def fused_divide_increment(
    a: float,
    b: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b + 1)


def fused_divide_decrement(
    a: float,
    b: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b - 1)


def fused_absolute_divide_increment(
    a: float,
    b: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b + 1)


def fused_absolute_divide_decrement(
    a: float,
    b: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b - 1)


def scaled_fused_divide_increment(
    a: float,
    b: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b + 1) * scale


def scaled_fused_divide_decrement(
    a: float,
    b: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return (a/b - 1) * scale


def scaled_fused_absolute_divide_increment(
    a: float,
    b: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b + 1) * scale


def scaled_fused_absolute_divide_decrement(
    a: float,
    b: float,
    scale: float,
) -> float:
    """
    It should be inlined.
    Maybe one day it will be a single assembly operation.
    """
    return abs(a/b - 1) * scale


def ratio_alpha(
    a: float,
    b: float,
    is_absolute: bool = False,
    scale: float = 1,
    round_to: int = None,
    both_null: float = None,
    a_null: float = None,
    b_null: float = None,
    b_zero: float = None,
) -> float: 
    if a is None:
        if b is None:
            return both_null
        return a_null
    if b is None:
        return b_null
    if b == 0:
        return b_zero
    if is_absolute:
        result = scaled_fused_absolute_divide_increment(a, b, scale)
    else:
        result = scaled_fused_divide_increment(a, b, scale)
    if round_to is not None:
        return round(result, round_to)
    return result


def ratio_delta(
    a: float,
    b: float,
    is_absolute boolean = False,
    scale: float = 1,
    round_to: int = None,
    both_null: float = None,
    a_null: float = None,
    b_null: float = None,
    b_zero: float = None,
) -> float:
    if a is None:
        if b is None:
            return both_null
        return a_null
    if b is None:
        return b_null
    if b == 0:
        return b_zero
    if is_absolute:
        result = scaled_fused_absolute_divide_decrement(a, b, scale)
    else:
        result = scaled_fused_divide_decrement(a, b, scale)
    if round_to is not None:
        return round(result, round_to)
    return result


def ratio_beta(
    a: float,
    b: float,
    c: float,
    is_absolute boolean = False,
    scale: float = 1,
    round_to: int = None,
    all_null: float = None,
    a_b_null: float = None,
    a_c_null: float = None,
    b_c_null: float = None,
    a_null: float = None,
    b_null: float = None,
    c_null: float = None,
    b_zero: float = None,
) -> float:
    if a is None:
        if b is None:
            if c is None:
                return all_null
            return a_b_null
        if c is None:
            return a_c_null
        return a_null
    if b is None:
        if c is None:
            return b_c_null
        return b_null
    if c is None:
        return c_null
    if b == 0:
        return b_zero
    if is_absolute:
        result = scaled_fused_absolute_divide_add(a, b, c, scale)
    else:
        result = scaled_fused_divide_add(a, b, c, scale)
    if round_to is not None:
        return round(result, round_to)
    return result


def ratio_sigma(
    a: float,
    b: float,
    c: float,
    is_absolute boolean = False,
    scale: float = 1,
    round_to: int = None,
    all_null: float = None,
    a_b_null: float = None,
    a_c_null: float = None,
    b_c_null: float = None,
    a_null: float = None,
    b_null: float = None,
    c_null: float = None,
    b_zero: float = None,
) -> float:
    if a is None:
        if b is None:
            if c is None:
                return all_null
            return a_b_null
        if c is None:
            return a_c_null
        return a_null
    if b is None:
        if c is None:
            return b_c_null
        return b_null
    if c is None:
        return c_null
    if b == 0:
        return b_zero
    if is_absolute:
        result = scaled_fused_absolute_divide_subtract(a, b, c, scale)
    else:
        result = scaled_fused_divide_subtract(a, b, c, scale)
    if round_to is not None:
        return round(result, round_to)
    return result
