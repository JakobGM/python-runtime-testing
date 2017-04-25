#!/bin/python2.7
import csv
import timeit
from collections import OrderedDict


def experiment_plan(csv_file='plan.csv'):
    # The factors for each consecutive experiment
    plan = OrderedDict()

    with open(csv_file, "r") as plan_file:
        reader = csv.reader(plan_file, delimiter=",")

        # Skip the header section of the csv file
        next(reader)

        # First column is the experiment number
        # The remaining columns are -1 = False and 1 = True
        for exp in reader:
            plan[int(exp[0])] = [bool(int(x) + 1) for x in exp[1:]]

        factors = ('A', 'B', 'C',)

        for key, value in plan.iteritems():
            func_name = 'insertion_sorted'
            num_type = 'float' if value[3] else 'int'

            # Assemble the function names based on the flags
            for index, flag in enumerate(value[0:3]):
                func_name += factors[index] if flag else ''

            plan[key] = (func_name, num_type)

        return plan


def save_results(results):
    with open('results.csv', 'w') as csv_results:
        writer = csv.writer(csv_results, delimiter=",")
        writer.writerow(("time",))
        for value in results.itervalues():
            writer.writerow((value,))


def run_experiments(repetitions=3):
    plan = experiment_plan()
    results = OrderedDict()

    for exp_number, implementation in plan.iteritems():
        setup = 'from generate_random import numbers;\
                from sorting_algorithms import %s;\
                array = numbers(of_type=%s)'

        setup = setup % (implementation[0], implementation[1])

        timer = timeit.Timer(
            '%s(array)' % implementation[0],
            setup=setup,
        )
        time = min(timer.repeat(repeat=repetitions, number=1))
        results[exp_number] = time

        print "Finished experiment number", exp_number, "of", len(plan)

    return results


if __name__ == "__main__":
    print "Running experiments..."
    results = run_experiments()

    print "Experiments finished. Saving results"
    save_results(results)
