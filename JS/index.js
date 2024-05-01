/*
This file is part of RatioDelta library.

RatioDelta is free software:
you can redistribute it and/or modify it under the terms
of the GNU Lesser General Public License
as published by the Free Software Foundation,
either version 3 of the License,
or (at your option) any later version.

RatioDelta is distributed in the hope
that it will be useful,
but WITHOUT ANY WARRANTY;
without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.
See the GNU Lesser General Public License for more details.

You should have received a copy of
the GNU Lesser General Public License
along with RatioDelta.
If not, see <http://www.gnu.org/licenses/>.

©Copyright 2023-2024 Laurent Lyaudet
*/


export function fused_divide_add(a, b, c){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return a / b + c;
}


export function fused_divide_subtract(a, b, c){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return a / b - c;
}


export function fused_absolute_divide_add(a, b, c){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b + c);
}


export function fused_absolute_divide_subtract(a, b, c){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b - c);
}


export function scaled_fused_divide_add(a, b, c, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return (a / b + c) * scale;
}


export function scaled_fused_divide_subtract(a, b, c, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return (a / b - c) * scale;
}


export function scaled_fused_absolute_divide_add(a, b, c, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b + c) * scale;
}


export function scaled_fused_absolute_divide_subtract(a, b, c, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b - c) * scale;
}


export function fused_divide_increment(a, b){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return a / b + 1;
}


export function fused_divide_decrement(a, b){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return a / b - 1;
}


export function fused_absolute_divide_increment(a, b){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b + 1);
}


export function fused_absolute_divide_decrement(a, b){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b - 1);
}


export function scaled_fused_divide_increment(a, b, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return (a / b + 1) * scale;
}


export function scaled_fused_divide_decrement(a, b, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return (a / b - 1) * scale;
}


export function scaled_fused_absolute_divide_increment(a, b, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b + 1) * scale;
}


export function scaled_fused_absolute_divide_decrement(a, b, scale){
  /*
  It should be inlined.
  Maybe one day it will be a single assembly operation.
  */
  return Math.abs(a / b - 1) * scale;
}


export function ratio_iota(
  a,
  b,
  is_absolute = false,
  scale = 1,
  round_to = null,
  both_null = null,
  a_null = null,
  b_null = null,
  b_zero = null,
){
  /*
  Divide and increment, and more if affinity.
  */
  if(a === null){
    if(b === null){
      return both_null;
    }
    return a_null;
  }
  if(b === null){
    return b_null;
  }
  if(b === 0){
    return b_zero;
  }
  let result = null;
  if(is_absolute){
    result = scaled_fused_absolute_divide_increment(a, b, scale);
  }
  else{
    result = scaled_fused_divide_increment(a, b, scale);
  }
  if(round_to !== null){
    const shift = Math.pow(10, round_to);
    return Math.round(result * shift) / shift;
  }
  return result;
}


export function ratio_delta(
  a,
  b,
  is_absolute = false,
  scale = 1,
  round_to = null,
  both_null = null,
  a_null = null,
  b_null = null,
  b_zero = null,
){
  /*
  Divide and decrement, and more if affinity.
  */
  if(a === null){
    if(b === null){
      return both_null;
    }
    return a_null;
  }
  if(b === null){
    return b_null;
  }
  if(b === 0){
    return b_zero;
  }
  let result = null;
  if(is_absolute){
    result = scaled_fused_absolute_divide_decrement(a, b, scale);
  }
  else{
    result = scaled_fused_divide_decrement(a, b, scale);
  }
  if(round_to !== null){
    const shift = Math.pow(10, round_to);
    return Math.round(result * shift) / shift;
  }
  return result;
}


export function ratio_alpha(
  a,
  b,
  c,
  is_absolute = false,
  scale = 1,
  round_to = null,
  all_null = null,
  a_b_null = null,
  a_c_null = null,
  b_c_null = null,
  a_null = null,
  b_null = null,
  c_null = null,
  b_zero = null,
){
  /*
  Divide and add, and more if affinity.
  */
  if(a === null){
    if(b === null){
      if(c === null){
        return all_null;
      }
      return a_b_null;
    }
    if(c === null){
      return a_c_null;
    }
    return a_null;
  }
  if(b === null){
    if(c === null){
      return b_c_null;
    }
    return b_null;
  }
  if(c === null){
    return c_null;
  }
  if(b === 0){
    return b_zero;
  }
  let result = null;
  if(is_absolute){
    result = scaled_fused_absolute_divide_add(a, b, c, scale);
  }
  else{
    result = scaled_fused_divide_add(a, b, c, scale);
  }
  if(round_to !== null){
    const shift = Math.pow(10, round_to);
    return Math.round(result * shift) / shift;
  }
  return result;
}


export function ratio_sigma(
  a,
  b,
  c,
  is_absolute = false,
  scale = 1,
  round_to = null,
  all_null = null,
  a_b_null = null,
  a_c_null = null,
  b_c_null = null,
  a_null = null,
  b_null = null,
  c_null = null,
  b_zero = null,
){
  /*
  Divide and subtract, and more if affinity.
  */
  if(a === null){
    if(b === null){
      if(c === null){
        return all_null;
      }
      return a_b_null;
    }
    if(c === null){
      return a_c_null;
    }
    return a_null;
  }
  if(b === null){
    if(c === null){
      return b_c_null;
    }
    return b_null;
  }
  if(c === null){
    return c_null;
  }
  if(b === 0){
    return b_zero;
  }
  let result = null;
  if(is_absolute){
    result = scaled_fused_absolute_divide_subtract(a, b, c, scale);
  }
  else{
    result = scaled_fused_divide_subtract(a, b, c, scale);
  }
  if(round_to !== null){
    const shift = Math.pow(10, round_to);
    return Math.round(result * shift) / shift;
  }
  return result;
}

