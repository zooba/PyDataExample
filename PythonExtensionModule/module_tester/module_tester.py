from itertools import islice
from random import random
from superfastcode import fast_map_tanh
from sys import exit
from time import perf_counter

DATA = iter(lambda: (random() - 0.5) * 3.0, None)
COUNT = 1000000

e = 2.7182818284590452353602874713527

def sinh(x):
    return (1 - e ** (-2 * x)) / (2 * e ** -x)

def cosh(x):
    return (1 + e ** (-2 * x)) / (2 * e ** -x)

def tanh(x):
    return sinh(x) / cosh(x)

def sequence_tanh(data):
    '''Applies the hyperbolic tangent function to map all values in
    the sequence to a value between -1.0 and 1.0.
    '''
    result = []
    for x in data:
        result.append(tanh(x))
    return result

def check_result(result):
    for d in result:
        assert -1 <= d <= 1, " incorrect values"

def test1():
    data = islice(DATA, COUNT)
    start_count = perf_counter()
    try:
        return sequence_tanh(data)
    finally:
        print('test1 took {:.3f} seconds\n\n'.format(perf_counter() - start_count))

def test2():
    data = islice(DATA, COUNT)
    start_count = perf_counter()
    try:
        return list(map(tanh, data))
    finally:
        print('test2 took {:.3f} seconds\n\n'.format(perf_counter() - start_count))

def test3():
    data = islice(DATA, COUNT)
    start_count = perf_counter()
    try:
        return fast_map_tanh(data)
    finally:
        print('test3 took {:.3f} seconds\n\n'.format(perf_counter() - start_count))


def main_1():
    input('''Start test1 - list.append\n\n    result = []\n    for x in data:\n        result.append(tanh(x))\n\nPress Enter to start . . .''')
    r = test1()
    check_result(r)

    input('''Start test2 - map(tanh)...\n\n    list(map(tanh, data))\n\nPress Enter to start . . .''')
    r = test2()
    check_result(r)

def main():
    try:
        main_1()
    except KeyboardInterrupt:
        # Press Ctrl+C to skip the previous tests to save time
        pass

    input('''Start test3 - C extension...\n\n    from superfastcode import fast_map_tanh\n    fast_map_tanh(data)\n\nPress Enter to start . . .''')
    r = test3()
    check_result(r)

if __name__ == "__main__":
    exit(main() or 0)
