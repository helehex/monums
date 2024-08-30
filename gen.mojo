# x----------------------------------------------------------------------------------------------x #
# | MIT License
# | Copyright (c) 2024 Helehex
# x----------------------------------------------------------------------------------------------x #

from src import gen

alias cache_path: String = "./src/cache/"


fn main() raises:
    gen.generate_lookup[gen.next_fibonacci](cache_path, "fibonacci", 0, 30, (0, 1), 1)
    gen.generate_lookup[gen.next_factorial](cache_path, "factorial", 0, 21, (0, 1), 1)