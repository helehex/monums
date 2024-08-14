from utils import StaticTuple

#------ Lookup Tables ------#
#

# probably dont need two different functions here,
# im just using an alias for now, to be sure it all runs at compile time.
# but the compiler seems good enough to do it automaically. should test it.

fn generate_lookup[T: AnyTrivialRegType, seq: fn(Int)->T, amount: Int]() -> StaticTuple[T, amount]:
    """
    Use when the index to access a sequence cannot be known at compile time.
    """
    alias result = _generate_lookup[T, seq, amount]()
    return result

fn _generate_lookup[T: AnyTrivialRegType, seq: fn(Int)->T, amount: Int]() -> StaticTuple[T, amount]:
    var result: StaticTuple[T, amount] = StaticTuple[T, amount]()
    for i in range(amount):
        result[i] = seq(i)
    return result