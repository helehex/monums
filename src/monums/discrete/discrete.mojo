@register_passable("trivial")
struct Discrete[fraction: Float64]:

    var value: Int

    fn __init__(value: Tuple[Int]) -> Self:
        return Self{value: value.get[0,Int]()}

    fn fracture(self) -> Float64:
        return self.value * self.fraction

    fn __str__(self) -> String:
        return String(self.fracture())


    #------( Arithmetic )------#
    #
    #--- addition
    fn __add__(self, other: Self) -> Self:
        return Self(self.value + other.value)

    fn __add__(self, other: Int) -> Float64:
        return self.fracture() + other

    fn __add__(self, other: Float64) -> Float64:
        return self.fracture() + other

    #--- subtract
    fn __sub__(self, other: Self) -> Self:
        return Self(self.value - other.value)

    fn __sub__(self, other: Int) -> Float64:
        return self.fracture() - other

    fn __sub__(self, other: Float64) -> Float64:
        return self.fracture() - other

    #--- multiplication
    fn __mul__(self, other: Self) -> Float64:
        return self.fracture() * other

    fn __mul__(self, other: Int) -> Self:
        return Self(self.value * other)

    fn __mul__(self, other: Float64) -> Float64:
        return self.fracture() * other

    #--- division
    fn __truediv__(self, other: Self) -> Float64:
        return self.fracture() / other.fracture()

    fn __truediv__(self, other: Int) -> Float64:
        return self.fracture() / other

    fn __truediv__(self, other: Float64) -> Float64:
        return self.fracture() / other

    fn __floordiv__(self, other: Self) -> Self:
        return Self(self.value // other.value)

    fn __floordiv__(self, other: Int) -> Self:
        return Self(self.value // other)

    fn __floordiv__(self, other: Float64) -> Float64:
        return self.fracture() // other

    #------( Reverse Arithmetic )------#
    #
    #--- addition
    fn __radd__(self, other: Int) -> Float64:
        return other + self.fracture()

    fn __radd__(self, other: Float64) -> Float64:
        return other + self.fracture()

    #--- subtract
    fn __rsub__(self, other: Int) -> Float64:
        return self.fracture() - other

    fn __rsub__(self, other: Float64) -> Float64:
        return self.fracture() - other

    #--- multiplication
    fn __rmul__(self, other: Int) -> Self:
        return Self(self.value * other)

    fn __rmul__(self, other: Float64) -> Float64:
        return self.fracture() * other

    #--- division
    fn __rtruediv__(self, other: Int) -> Float64:
        return other / self.fracture()

    fn __rtruediv__(self, other: Float64) -> Float64:
        return other / self.fracture()

    fn __rfloordiv__(self, other: Int) -> Self:
        return Self((other / (self.fracture()*self.fraction)).to_int())

    fn __rfloordiv__(self, other: Float64) -> Float64:
        return other // self.fracture()