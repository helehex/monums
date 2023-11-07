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



#------------ re (+) wo ------------#
#---
#---
alias IntE_rewo = ESIMD_rewo[DType.index,1]

@value
@nonmaterializable(IntE_rewo)
@register_passable("trivial")
struct LitIntE_rewo:

    #------[ Alias ]------#
    #
    alias Coef = IntLiteral


    #------< Data >------#
    #
    var re: Self.Coef
    var wo: Self.Coef


    #------( Initialize )------#
    #
    @always_inline("nodebug")
    fn __init__(re: Self.Coef, wo: Self.Coef = 0) -> Self:
        return Self{re: re, wo: wo}

    @always_inline("nodebug")
    fn __init__(wo: Self.Coef, po: Self.Coef, vo: Self.Coef) -> Self:
        return Self{re: po-vo, wo: wo-vo}


    #------( Arithmetic )------#
    #
    @always_inline("nodebug")
    fn __add__(a: Self, b: Self) -> Self:
        return Self(a.re + b.re, a.wo + b.wo)
    
    @always_inline("nodebug") # wo_add acts more like subtract than add
    fn wo_add(a: Self, b: Self) -> Self:
        return Self(a.re - b.wo, a.wo + b.re - b.wo)
    
    @always_inline("nodebug") # vo_add acts more like subtract than add
    fn vo_add(a: Self, b: Self) -> Self:
        return Self(a.re - b.re + b.wo, a.wo - b.re)
    
    @always_inline("nodebug")
    fn __sub__(a: Self, b: Self) -> Self:
        return Self(a.re - b.re, a.wo - b.wo)
    
    @always_inline("nodebug") # wo_sub acts more like add than subtract
    fn wo_sub(a: Self, b: Self) -> Self:
        return Self(a.re + b.re - b.wo, a.wo + b.re)
    
    @always_inline("nodebug") # vo_sub acts more like add than subtract
    fn vo_sub(a: Self, b: Self) -> Self:
        return Self(a.re + b.wo, a.wo - b.re + b.wo)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self.Coef) -> Self:
        return Self(a.re * b, a.wo * b)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self) -> Self:
        let c: Self.Coef = -(a.wo * b.wo)
        return Self((a.re * b.re) + c, (a.re * b.wo) + (a.wo * b.re) + c)
    
    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self.Coef) -> Self:
        return Self(a.re//b, a.wo//b)

    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self) -> Self:
        let div: Self.Coef = b.re*b.re + b.wo*b.wo - b.re*b.wo
        let arebwo: Self.Coef = a.re * b.wo
        return Self(a.re*b.re + a.wo*b.wo - arebwo, a.wo*b.re - arebwo) // div
    

    #------( Unary )------#
    #
    @always_inline("nodebug")
    fn __neg__(self) -> Self:
        return Self(-self.re, -self.wo)

    @always_inline("nodebug")
    fn conj(self) -> Self:
        return Self(self.re - self.wo, -self.wo)
    
    @always_inline("nodebug")
    fn coef_po(self) -> Self.Coef:
        return max(0, self.re + max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_powo(self) -> Self.Coef:
        return max(0, self.wo + max(0, -self.re))
    
    @always_inline("nodebug")
    fn coef_povo(self) -> Self.Coef:
        return max(max(0, -self.re), max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_ne(self) -> Self.Coef:
        return max(0, -self.re + max(0, self.wo))
    
    @always_inline("nodebug")
    fn coef_newo(self) -> Self.Coef:
        return max(0, -self.wo + max(0, self.re))

    @always_inline("nodebug")
    fn coef_nevo(self) -> Self.Coef:
        return max(max(0, self.re), max(0, self.wo))
    

    #------( Formatting )------#
    #
    @always_inline("nodebug")
    fn str_rewo(self) -> String:
        return String(self.re) + "re + " + String(self.wo) + "wo"
    
    @always_inline("nodebug")
    fn str_po(self) -> String:
        return "(" + String(self.coef_powo()) + "<+" + String(self.coef_po()) + "+>" + String(self.coef_povo()) + ")"
    
    @always_inline("nodebug")
    fn str_ne(self) -> String:
        return "(" + String(self.coef_newo()) + "->" + String(self.coef_ne()) + "<-" + String(self.coef_nevo()) + ")"
    
    @always_inline("nodebug")
    fn str_(self) -> String:
        return self.str_po()

    @always_inline("nodebug")
    fn print_rewo(self):
        print(self.str_rewo())

    @always_inline("nodebug")
    fn print_po(self):
        print(self.str_po())
    
    @always_inline("nodebug")
    fn print_ne(self):
        print(self.str_ne())

    @always_inline("nodebug")
    fn print_(self):
        self.print_po()


@value
@register_passable("trivial")
struct ESIMD_rewo[dt: DType, sw: Int]:

    #------[ Alias ]------#
    #
    alias Lit = LitIntE_rewo
    alias Coef = SIMD[dt,sw]
    alias Unit = ESIMD_rewo[dt,1]


    #------< Data >------#
    #
    var re: Self.Coef
    var wo: Self.Coef


    #------( Initialize )------#
    #
    @always_inline("nodebug")
    fn __init__(lit: Self.Lit) -> Self:
        return Self{re: lit.re, wo: lit.wo}

    @always_inline("nodebug")
    fn __init__(lit: Self.Lit.Coef) -> Self:
        return Self{re: lit, wo: 0}

    @always_inline("nodebug")
    fn __init__(re: Self.Coef, wo: Self.Coef = 0) -> Self:
        return Self{re: re, wo: wo}

    @always_inline("nodebug")
    fn __init__(wo: Self.Coef, po: Self.Coef, vo: Self.Coef) -> Self:
        return Self{re: po-vo, wo: wo-vo}
    

    #------( Arithemtic )------#
    #
    @always_inline("nodebug")
    fn __add__(a: Self, b: Self) -> Self:
        return Self(a.re + b.re, a.wo + b.wo)
    
    @always_inline("nodebug") # wo_add acts more like subtract than add
    fn wo_add(a: Self, b: Self) -> Self:
        return Self(a.re - b.wo, a.wo + b.re - b.wo)
    
    @always_inline("nodebug") # vo_add acts more like subtract than add
    fn vo_add(a: Self, b: Self) -> Self:
        return Self(a.re - b.re + b.wo, a.wo - b.re)
    
    @always_inline("nodebug")
    fn __sub__(a: Self, b: Self) -> Self:
        return Self(a.re - b.re, a.wo - b.wo)
    
    @always_inline("nodebug") # wo_sub acts more like add than subtract
    fn wo_sub(a: Self, b: Self) -> Self:
        return Self(a.re + b.re - b.wo, a.wo + b.re)
    
    @always_inline("nodebug") # vo_sub acts more like add than subtract
    fn vo_sub(a: Self, b: Self) -> Self:
        return Self(a.re + b.wo, a.wo - b.re + b.wo)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self.Coef) -> Self:
        return Self(a.re * b, a.wo * b)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self) -> Self:
        let c = -(a.wo * b.wo)
        return Self((a.re * b.re) + c, (a.re * b.wo) + (a.wo * b.re) + c)
    
    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self.Coef) -> Self:
        return Self(a.re//b, a.wo//b)

    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self) -> Self:
        let div = b.re*b.re + b.wo*b.wo - b.re*b.wo
        let arebwo = a.re * b.wo
        return Self(a.re*b.re + a.wo*b.wo - arebwo, a.wo*b.re - arebwo) // div


    #------( Get / Set )------#
    #
    @always_inline("nodebug")
    fn __getitem__(self, index: Int) -> Self.Unit:
        return Self.Unit(self.re[index], self.wo[index])

    @always_inline("nodebug")
    fn __setitem__(inout self, index: Int, item: Self.Unit):
        self.re[index] = item.re
        self.wo[index] = item.wo
    

    #------( Unary )------#
    #
    @always_inline("nodebug")
    fn __neg__(self) -> Self:
        return Self(-self.re, -self.wo)

    @always_inline("nodebug")
    fn conj(self) -> Self:
        return Self(self.re - self.wo, -self.wo)
    
    @always_inline("nodebug")
    fn coef_po(self) -> Self.Coef:
        return max(0, self.re + max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_powo(self) -> Self.Coef:
        return max(0, self.wo + max(0, -self.re))
    
    @always_inline("nodebug")
    fn coef_povo(self) -> Self.Coef:
        return max(max(0, -self.re), max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_ne(self) -> Self.Coef:
        return max(0, -self.re + max(0, self.wo))
    
    @always_inline("nodebug")
    fn coef_newo(self) -> Self.Coef:
        return max(0, -self.wo + max(0, self.re))

    @always_inline("nodebug")
    fn coef_nevo(self) -> Self.Coef:
        return max(max(0, self.re), max(0, self.wo))
    

    #------( Formatting )------#
    #
    @always_inline("nodebug")
    fn str_wovo[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return String(self.wo) + "wo + " + String(self.wo) + "vo"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_wovo() + seperator
        return result + self[sw - 1].str_wovo()
            
    @always_inline("nodebug")
    fn str_po[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return "(" + String(self.coef_powo()) + "<+" + String(self.coef_po()) + "+>" + String(self.coef_povo()) + ")"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_po() + seperator
        return result + self[sw - 1].str_po()
    
    @always_inline("nodebug")
    fn str_ne[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return "(" + String(self.coef_newo()) + "->" + String(self.coef_ne()) + "<-" + String(self.coef_nevo()) + ")"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_ne() + seperator
        return result + self[sw - 1].str_ne()
    
    @always_inline("nodebug")
    fn str_[seperator: String = " "](self) -> String:
        return self.str_po[seperator]()

    @always_inline("nodebug")
    fn print_wovo[seperator: String = "\n"](self):
        print(self.str_wovo[seperator]())

    @always_inline("nodebug")
    fn print_po[seperator: String = "\n"](self):
        print(self.str_po[seperator]())
    
    @always_inline("nodebug")
    fn print_ne[seperator: String = "\n"](self):
        print(self.str_ne[seperator]())

    @always_inline("nodebug")
    fn print_[seperator: String = " "](self):
        self.print_po[seperator]()




#------------ wo + vo ------------#
#---
#---
alias IntE_wovo = ESIMD_wovo[DType.index,1]

@value
@nonmaterializable(IntE_wovo)
@register_passable("trivial")
struct LitIntE_wovo:

    #------[ Alias ]------#
    #
    alias Coef = IntLiteral


    #------< Data >------#
    #
    var wo: Self.Coef
    var vo: Self.Coef


    #------( Initialize )------#
    #
    @always_inline("nodebug")
    fn __init__(re: Self.Coef) -> Self:
        return Self{wo: -re, vo: -re}

    @always_inline("nodebug")
    fn __init__(wo: Self.Coef, po: Self.Coef, vo: Self.Coef) -> Self:
        return Self{wo: wo-po, vo: vo-po}
    

    #------( Arithmetic )------#
    #
    @always_inline("nodebug")
    fn __add__(a: Self, b: Self) -> Self:
        return Self(a.wo + b.wo, a.vo + b.vo)
    
    @always_inline("nodebug") # wo_add acts more like subtract than add
    fn wo_add(a: Self, b: Self) -> Self:
        return Self(a.wo - b.vo, a.vo + b.wo - b.vo)
    
    @always_inline("nodebug") # vo_add acts more like subtract than add
    fn vo_add(a: Self, b: Self) -> Self:
        return Self(a.wo + b.vo - b.wo, a.vo - b.wo)
    
    @always_inline("nodebug")
    fn __sub__(a: Self, b: Self) -> Self:
        return Self(a.wo - b.wo, a.vo - b.vo)
    
    @always_inline("nodebug") # wo_sub acts more like add than subtract
    fn wo_sub(a: Self, b: Self) -> Self:
        return Self(a.wo + b.vo, a.vo - b.wo + b.vo)
    
    @always_inline("nodebug") # vo_sub acts more like add than subtract
    fn vo_sub(a: Self, b: Self) -> Self:
        return Self(a.wo - b.vo + b.wo, a.vo + b.wo)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self.Coef) -> Self:
        return Self(a.wo*b, a.vo*b)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self) -> Self:
        let c: Self.Coef = a.wo*b.vo + a.vo*b.wo
        return Self(a.vo*b.vo - c, a.wo*b.wo - c)

    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self.Coef) -> Self:
        return Self(a.wo//b, a.vo//b)
    
    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self) -> Self:
        return (a*b.conj()) // (b.wo*b.wo + b.vo*b.vo - b.wo*b.vo)
    

    #------( Unary)------#
    #
    @always_inline("nodebug")
    fn __neg__(self) -> Self:
        return Self(-self.wo, -self.vo)

    @always_inline("nodebug")
    fn conj(self) -> Self:
        return Self(self.vo, self.wo)
    
    @always_inline("nodebug")
    fn coef_po(self) -> Self.Coef:
        return max(max(0, -self.wo), max(0, -self.vo))
    
    @always_inline("nodebug")
    fn coef_powo(self) -> Self.Coef:
        return max(0, self.wo + max(0, -self.vo))
    
    @always_inline("nodebug")
    fn coef_povo(self) -> Self.Coef:
        return max(0, self.vo + max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_ne(self) -> Self.Coef:
        return max(max(0, self.wo), max(0, self.vo))
    
    @always_inline("nodebug")
    fn coef_newo(self) -> Self.Coef:
        return max(0, -self.wo + max(0, self.vo))
    
    @always_inline("nodebug")
    fn coef_nevo(self) -> Self.Coef:
        return max(0, -self.vo + max(0, self.wo))
    

    #------( Formatting )------#
    #
    @always_inline("nodebug")
    fn str_wovo(self) -> String:
        return String(self.wo) + "wo + " + String(self.wo) + "vo"
    
    @always_inline("nodebug")
    fn str_po(self) -> String:
        return "(" + String(self.coef_powo()) + "<+" + String(self.coef_po()) + "+>" + String(self.coef_povo()) + ")"

    @always_inline("nodebug")
    fn str_ne(self) -> String:
        return "(" + String(self.coef_newo()) + "->" + String(self.coef_ne()) + "<-" + String(self.coef_nevo()) + ")"

    @always_inline("nodebug")
    fn str_(self) -> String:
        return self.str_po()

    @always_inline("nodebug")
    fn print_wovo(self):
        print(self.str_wovo())

    @always_inline("nodebug")
    fn print_po(self):
        print(self.str_po())

    @always_inline("nodebug")
    fn print_ne(self):
        print(self.str_ne())
    
    @always_inline("nodebug")
    fn print_(self):
        self.print_po()




@value
@register_passable("trivial")
struct ESIMD_wovo[dt: DType, sw: Int]:

    #------[ Alias ]------#
    #
    alias Lit = LitIntE_wovo
    alias Coef = SIMD[dt,sw]
    alias Unit = ESIMD_wovo[dt,1]

    #------< Data >------#
    #
    var wo: Self.Coef
    var vo: Self.Coef
    

    #------( Initialize )------#
    #
    @always_inline("nodebug")
    fn __init__(lit: Self.Lit) -> Self:
        return Self{wo: lit.wo, vo: lit.vo}
    
    @always_inline("nodebug")
    fn __init__(re: Self.Coef) -> Self:
        return Self{wo: -re, vo: -re}
    
    @always_inline("nodebug")
    fn __init__(wo: Self.Coef, vo: Self.Coef) -> Self:
        return Self{wo: wo, vo: vo}

    @always_inline("nodebug")
    fn __init__(wo: Self.Coef, po: Self.Coef, vo: Self.Coef) -> Self:
        return Self{wo: wo-po, vo: vo-po}
    

    #------( Arithmetic )------#
    #
    @always_inline("nodebug")
    fn __add__(a: Self, b: Self) -> Self:
        return Self(a.wo + b.wo, a.vo + b.vo)
    
    @always_inline("nodebug") # wo_add acts more like subtract than add
    fn wo_add(a: Self, b: Self) -> Self:
        return Self(a.wo - b.vo, a.vo + b.wo - b.vo)
    
    @always_inline("nodebug") # vo_add acts more like subtract than add
    fn vo_add(a: Self, b: Self) -> Self:
        return Self(a.wo + b.vo - b.wo, a.vo - b.wo)
    
    @always_inline("nodebug")
    fn __sub__(a: Self, b: Self) -> Self:
        return Self(a.wo - b.wo, a.vo - b.vo)
    
    @always_inline("nodebug") # wo_sub acts more like add than subtract
    fn wo_sub(a: Self, b: Self) -> Self:
        return Self(a.wo + b.vo, a.vo - b.wo + b.vo)
    
    @always_inline("nodebug") # vo_sub acts more like add than subtract
    fn vo_sub(a: Self, b: Self) -> Self:
        return Self(a.wo - b.vo + b.wo, a.vo + b.wo)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self.Coef) -> Self:
        return Self(a.wo*b, a.vo*b)
    
    @always_inline("nodebug")
    fn __mul__(a: Self, b: Self) -> Self:
        let c = a.wo*b.vo + a.vo*b.wo
        return Self(a.vo*b.vo - c, a.wo*b.wo - c)

    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self.Coef) -> Self:
        return Self(a.wo//b, a.vo//b)
    
    @always_inline("nodebug")
    fn __floordiv__(a: Self, b: Self) -> Self:
        return (a*b.conj()) // (b.wo*b.wo + b.vo*b.vo - b.wo*b.vo)
    

    #------( Get / Set )------#
    #
    @always_inline("nodebug")
    fn __getitem__(self, index: Int) -> Self.Unit:
        return Self.Unit(self.wo[index], self.vo[index])

    @always_inline("nodebug")
    fn __setitem__(inout self, index: Int, item: Self.Unit):
        self.wo[index] = item.wo
        self.vo[index] = item.vo


    #------( Unary )------#
    #
    @always_inline("nodebug")
    fn __neg__(self) -> Self:
        return Self(-self.wo, -self.vo)

    @always_inline("nodebug")
    fn conj(self) -> Self:
        return Self(self.vo, self.wo)
    
    @always_inline("nodebug")
    fn coef_po(self) -> Self.Coef:
        return max(max(0, -self.wo), max(0, -self.vo))
    
    @always_inline("nodebug")
    fn coef_powo(self) -> Self.Coef:
        return max(0, self.wo + max(0, -self.vo))
    
    @always_inline("nodebug")
    fn coef_povo(self) -> Self.Coef:
        return max(0, self.vo + max(0, -self.wo))
    
    @always_inline("nodebug")
    fn coef_ne(self) -> Self.Coef:
        return max(max(0, self.wo), max(0, self.vo))
    
    @always_inline("nodebug")
    fn coef_newo(self) -> Self.Coef:
        return max(0, -self.wo + max(0, self.vo))
    
    @always_inline("nodebug")
    fn coef_nevo(self) -> Self.Coef:
        return max(0, -self.vo + max(0, self.wo))


    #------( Formatting )------#
    #
    @always_inline("nodebug")
    fn str_wovo[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return String(self.wo) + "wo + " + String(self.wo) + "vo"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_wovo() + seperator
        return result + self[sw - 1].str_wovo()
            
    @always_inline("nodebug")
    fn str_po[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return "(" + String(self.coef_powo()) + "<+" + String(self.coef_po()) + "+>" + String(self.coef_povo()) + ")"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_po() + seperator
        return result + self[sw - 1].str_po()
    
    @always_inline("nodebug")
    fn str_ne[seperator: String = "\n"](self) -> String:
        @parameter
        if sw == 1:
            return "(" + String(self.coef_newo()) + "->" + String(self.coef_ne()) + "<-" + String(self.coef_nevo()) + ")"
        
        var result: String = ""
        @unroll
        for i in range(sw - 1): result += self[i].str_ne() + seperator
        return result + self[sw - 1].str_ne()

    @always_inline("nodebug")
    fn str_[seperator: String = " "](self) -> String:
        return self.str_po[seperator]()
    
    @always_inline("nodebug")
    fn print_wovo[seperator: String = "\n"](self):
        print(self.str_wovo[seperator]())

    @always_inline("nodebug")
    fn print_po[seperator: String = "\n"](self):
        print(self.str_po[seperator]())
    
    @always_inline("nodebug")
    fn print_ne[seperator: String = "\n"](self):
        print(self.str_ne[seperator]())

    @always_inline("nodebug")
    fn print_[seperator: String = " "](self):
        self.print_po[seperator]()




#------ max ------#
#---
from math import max as max_

@always_inline("nodebug")
fn max(a: Int, b: Int) -> Int:
    return max_(a, b)

@always_inline("nodebug")
fn max[dt: DType, sw: Int](a: SIMD[dt,sw], b: SIMD[dt,sw]) -> SIMD[dt,sw]:
    return max_(a, b)

@always_inline("nodebug")
fn max(a: IntLiteral, b: IntLiteral) -> IntLiteral:  # <-------- ternary doesnt work yet for IntLiteral
    if a > b:
        return a
    else:
        return b


#------ min ------#
#---
from math import min as min_

@always_inline("nodebug")
fn min(a: Int, b: Int) -> Int:
    return min_(a, b)

@always_inline("nodebug")
fn min[dt: DType, sw: Int](a: SIMD[dt,sw], b: SIMD[dt,sw]) -> SIMD[dt,sw]:
    return min_(a, b)

@always_inline("nodebug")
fn min(a: IntLiteral, b: IntLiteral) -> IntLiteral:  # <-------- ternary doesnt work yet for IntLiteral
    if a < b:
        return a
    else:
        return b