import random
from sys import maxsize
import csv
import os


def generate_random_integers(number, start=-maxsize-1, stop=maxsize):
    random_ints = [random.randint(start, stop) for _ in xrange(number)]
    return random_ints


def save_data_set(array):
    with open("randints.csv", "w") as csv_file:
        writer = csv.writer(csv_file, delimiter=",")
        writer.writerow(array)


def numbers(of_type):
    with open("randints.csv", "r") as csv_file:
        reader = csv.reader(csv_file, delimiter=",")
        # print len(list(reader)[0])
        # print list(reader)[0][0:10]
        return [of_type(i) for i in list(reader)[0]]


def init():
    random.seed(2017)
    if not os.path.isfile("randints.csv"):
        print "Generating new numbers"
        random_ints = generate_random_integers(int(1e4))
        save_data_set(random_ints)
    else:
        print "Numbers already generated"

init()

if __name__ == "__main__":
    print "Initializing testdata set"
    init()
