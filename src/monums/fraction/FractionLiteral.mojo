@nonmaterializable(Float)
@register_passable("trivial")
struct FractionLiteral:
    var numerator: IntLiteral
    var denominator: IntLiteral

    fn __init__(value: IntLiteral) -> Self:
        return Self{numerator: value, denominator: 1}

@register_passable("trivial")
struct Float:

    var value: FloatLiteral

    fn __init__(value: FloatLiteral) -> Self:
        return Self{value: value}

