from .combinatorics import *
from .constants import *
from .iterative import *
from .lookup import generate_lookup

#------ Prime ------#
#

#------ Mersenne ------#
#

#------ Divisor ------#
#
@always_inline
fn gcd(a: IntLiteral, b: IntLiteral) -> IntLiteral:
    var _a: IntLiteral = a
    var _b: IntLiteral = b
    while _b != 0:
        let _c: IntLiteral = _a % _b
        _a = _b
        _b = _c
    return _a