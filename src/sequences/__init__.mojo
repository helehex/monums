# x----------------------------------------------------------------------------------------------x #
# | MIT License
# | Copyright (c) 2024 Helehex
# x----------------------------------------------------------------------------------------------x #
"""Deprecated Sequences. Moving to gen."""

from .combinatorics import *
from .constants import *

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
        var _c: IntLiteral = _a % _b
        _a = _b
        _b = _c
    return _a