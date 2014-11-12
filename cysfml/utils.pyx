cdef set ITERABLE_CLASSES = {list, tuple}


cpdef bint is_iterable(obj):
    return obj.__class__ in ITERABLE_CLASSES


cpdef bint richcmp_floats(float x, float y, int op):
    if op == 0: # <
        return x < y
    elif op == 1: # <=
        return x <= y
    elif op == 2: # ==
        return x == y
    elif op == 3: # !=
        return x != y
    elif op == 4: # >
        return x > y
    elif op == 5: # >=
        return x >= y


cpdef bint richcmp_ints(int x, int y, int op):
    if op == 0: # <
        return x < y
    elif op == 1: # <=
        return x <= y
    elif op == 2: # ==
        return x == y
    elif op == 3: # !=
        return x != y
    elif op == 4: # >
        return x > y
    elif op == 5: # >=
        return x >= y


cpdef bint richcmp_unsigned_ints(unsigned int x, unsigned int y, int op):
    if op == 0: # <
        return x < y
    elif op == 1: # <=
        return x <= y
    elif op == 2: # ==
        return x == y
    elif op == 3: # !=
        return x != y
    elif op == 4: # >
        return x > y
    elif op == 5: # >=
        return x >= y
