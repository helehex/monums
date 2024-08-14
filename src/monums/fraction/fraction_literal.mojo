from ..sequences import gcd

@nonmaterializable(Float64)
@register_passable("trivial")
struct FractionLiteral:
    var numerator: IntLiteral
    var denominator: IntLiteral

    fn __init__(inout self, value: IntLiteral):
        self.numerator = value
        self.denominator = 1

    # fn __init__(value: FloatLiteral) -> Self:
    #     var num: FloatLiteral = value
    #     var i: IntLiteral = 0
    #     while num != num.to_int():
    #         num = num * 64
    #         i += 1
    #     let den: IntLiteral = 64**i
    #     let div: IntLiteral = gcd(num, den)
    #     return Self{numerator: num/div, denominator: den/div}