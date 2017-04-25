#!/bin/python
'''
Different implementations of the insertion sort algorithm.
The following techniques are used:
    - A: temp-variable --> tuple-reassignment
    - B: range (list) --> xrange (generator)
    - C: return array --> in-place mutable sort

When the letters A, B, and C are used in the function names, they indicate
if the technique on the right-hand side of the list shown above is used or
not.
'''


def insertion_sorted(array):
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            temp = array[j-1]
            array[j-1] = array[j]
            array[j] = temp
            j -= 1
    return array


def insertion_sortedA(array):
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            array[j-1], array[j] = array[j], array[j-1]
            j -= 1
    return array


def insertion_sortedB(array):
    for i in xrange(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            temp = array[j-1]
            array[j-1] = array[j]
            array[j] = temp
            j -= 1
    return array


def insertion_sortedC(array):
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            temp = array[j-1]
            array[j-1] = array[j]
            array[j] = temp
            j -= 1


def insertion_sortedAB(array):
    for i in xrange(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            array[j-1], array[j] = array[j], array[j-1]
            j -= 1
    return array


def insertion_sortedAC(array):
    for i in range(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            array[j-1], array[j] = array[j], array[j-1]
            j -= 1


def insertion_sortedBC(array):
    for i in xrange(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            temp = array[j-1]
            array[j-1] = array[j]
            array[j] = temp
            j -= 1


def insertion_sortedABC(array):
    for i in xrange(1, len(array)):
        j = i
        while j > 0 and array[j-1] > array[j]:
            array[j-1], array[j] = array[j], array[j-1]
            j -= 1
