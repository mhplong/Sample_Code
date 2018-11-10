#!/usr/bin/python
from random import random

def multiply(x, y):
    return x * y

def randomDie(number):
    return int(random() * number + 1)

mult = multiply(3, 2)

print(mult)
print(randomDie(5))