from math import max

# Eisenstein integers:

#
#             +i
#       +w          -v
#
#
#   -1        0        +1
#
#
#       +v          -w
#             -i    
#

# +1  ~ po
# -v  ~ nevo
# +i  ~ poim
# +w  ~ powo
# -1  ~ ne
# +v  ~ povo
# -i  ~ neim
# -w  ~ newo

# re  ~ real axis      (+1 -1)
# wo  ~ eisen.+ axis   (+w -w)
# vo  ~ eisen.- axis   (+v -v)
# im  ~ imaginary axis (+i -i)


alias EisInt = EisInt_rewo

@register_passable("trivial")
struct EisInt_rewo:
    var re: Int
    var wo: Int
    
    @always_inline
    fn __init__() -> Self:
        return Self{re: 0, wo: 0}
    
    @always_inline
    fn __init__(po: Int) -> Self:
        return Self{re: po, wo: 0}
    
    @always_inline
    fn __init__(re: Int, wo: Int) -> Self:
        return Self{re: re, wo: wo}
    
    @always_inline
    fn __add__(a: Self, b: Self) -> Self:
        return Self(a.re + b.re, a.wo + b.wo)
    
    @always_inline #wo_add acts more like subtract than add
    fn __wo_add__(a: Self, b: Self) -> Self:
        return Self(a.re - b.wo, a.wo + b.re - b.wo)
    
    @always_inline #vo_add acts more like subtract than add
    fn __vo_add__(a: Self, b: Self) -> Self:
        return Self(a.re - b.re + b.wo, a.wo - b.re)
    
    @always_inline
    fn __sub__(a: Self, b: Self) -> Self:
        return Self(a.re - b.re, a.wo - b.wo)
    
    @always_inline
    fn __wo_sub__(a: Self, b: Self) -> Self:
        return Self(a.re + b.re - b.wo, a.wo + b.re)
    
    @always_inline
    fn __vo_sub__(a: Self, b: Self) -> Self:
        return Self(a.re + b.wo, a.wo - b.re + b.wo)
    
    @always_inline
    fn __mul__(a: Self, b: Int) -> Self:
        return Self(a.re * b, a.wo * b)
    
    @always_inline
    fn __mul__(a: Self, b: Self) -> Self:
        let c = -(a.wo * b.wo)
        return Self((a.re * b.re) + c, (a.re * b.wo) + (a.wo * b.re) + c)
    
    @always_inline
    fn __floordiv__(a: Self, b: Self) -> Self:
        let div = (b.re * b.re) + (b.wo * b.wo) - (b.re * b.wo)
        let arebwo = a.re * b.wo
        return Self(((a.re * b.re) + (a.wo * b.wo) - arebwo) // div, ((a.wo * b.re) - arebwo) // div)
    
    @always_inline
    fn conj(self) -> Self:
        return Self(self.re - self.wo, -self.wo)
    
    @always_inline
    fn coef_po(self) -> Int:
        return max(0, self.re + max(0, -self.wo))
    
    @always_inline
    fn coef_powo(self) -> Int:
        return max(0, self.wo + max(0, -self.re))
    
    @always_inline
    fn coef_povo(self) -> Int:
        return max(max(0, -self.re), max(0, -self.wo))
    
    @always_inline
    fn coef_ne(self) -> Int:
        return max(0, -self.re + max(0, self.wo))
    
    @always_inline
    fn coef_newo(self) -> Int:
        return max(max(0, self.re), max(0, self.wo))
    
    @always_inline
    fn coef_nevo(self) -> Int:
        return max(0, -self.wo + max(0, self.re))
    
    @always_inline
    fn str_raw(self) -> String:
        return String(self.re) + "re + " + String(self.wo) + "wo"
    
    @always_inline
    fn str_po(self) -> String:
        return "(" + String(self.coef_powo()) + "<+" + String(self.coef_po()) + "+>" + String(self.coef_povo()) + ")"
    
    @always_inline
    fn str_ne(self) -> String:
        return "(" + String(self.coef_newo()) + "->" + String(self.coef_ne()) + "<-" + String(self.coef_nevo()) + ")"
    
    @always_inline
    fn print_raw(self):
        print(self.str_raw())

    @always_inline
    fn print_po(self):
        print(self.str_po())
    
    @always_inline
    fn print_ne(self):
        print(self.str_ne())