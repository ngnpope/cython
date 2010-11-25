# cython: language_level=3

def list_comp_in_closure():
    """
    >>> list_comp_in_closure()
    [0, 4, 8]
    """
    x = 'abc'
    def f():
        return x
    result = [x*2 for x in range(5) if x % 2 == 0]
    assert x == 'abc' # don't leak in Py3 code
    assert f() == 'abc' # don't leak in Py3 code
    return result

def genexpr_in_closure():
    """
    >>> genexpr_in_closure()
    [0, 4, 8]
    """
    x = 'abc'
    def f():
        return x
    result = list( x*2 for x in range(5) if x % 2 == 0 )
    assert x == 'abc' # don't leak in Py3 code
    assert f() == 'abc' # don't leak in Py3 code
    return result

def genexpr_scope_in_closure():
    """
    >>> genexpr_scope_in_closure()
    [0, 4, 8]
    """
    i = 2
    x = 'abc'
    def f():
        return i, x
    result = list( x*i for x in range(5) if x % 2 == 0 )
    assert x == 'abc' # don't leak in Py3 code
    assert f() == 2,'abc' # don't leak in Py3 code
    return result
