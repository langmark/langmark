#!/usr/bin/env python3

import json
import subprocess
import datetime
import sys
import getopt

SHELL = '/bin/bash'
WALL_TIME = None
ONLY_TEST = None
ONLY_LANG = None

class Bench:
    workingDir = ''
    name = ''
    script = ''
    expected_result = None

    def __init__(self, workingDir, name, script, expected_result):
        self.workingDir = workingDir
        self.name = name
        self.script = script
        if expected_result:
            self.expected_result = str(expected_result).strip()

    def version(self):
        return self.execute('version', 'version.out')

    def prepare(self):
        return self.execute('pre_exec')

    def clear(self):
        return self.execute('clean')

    def run(self):
        out = self.execute('exec', 'time.out')
        if out == False:
            return { 'success': False, 'error': 'Error executing command!', 'details': '' }
        try:
            return { 'success': True, 'time': float(out) }
        except:
            return { 'success': False, 'error': 'Error getting the time', 'details': out }

    def runCheck(self):
        out = self.execute('print_exec', 'print.out')
        if out == False:
            return { 'success': False, 'error': 'Failed', 'details': 'Boh..' }
        if self.expected_result and self.expected_result != out.strip():
            return { 'success': False, 'error': 'Wrong answer', 'details': "'%s' != '%s'" % (self.expected_result, out.strip()) }
        return { 'success': True }

    def execute(self, command, output = None):
        ret = subprocess.call([SHELL, self.workingDir + '/' + self.script, command])
        if ret != 0: return False
        if output:   return self.readFile(output)
        return True

    def readFile(self, file):
        try:
            return open(self.workingDir + '/' + file, 'r').read()
        except:
            return '## File Not Found ##'

class LangTest:
    test = ''
    lang = ''
    expected_result = None
    wall_time = 10.0
    workingDir = ''
    commands = []

    def __init__(self, test, lang, expected_result, wall_time):
        self.test = test
        self.lang = lang
        self.expected_result = expected_result
        self.wall_time = wall_time
        self.workingDir = test + '/' + lang
        self.commands = json.loads(open(self.workingDir + '/commands.json', 'r').read())

    def run(self):
        tests = []
        for command in self.commands:
            res = self.runCommand(command)
            if res == False:
                yellow('    Test skipped...')
            else:
                tests.append(res)
        return tests


    def runCommand(self, command):
        print('    ' + self.test + ' | ' + self.lang + ' -> ' + command['name'] + ': ', flush=True, end='')
        bench = Bench(self.workingDir, command['name'], command['script'], self.expected_result)

        res = bench.prepare()
        if res == False:
            red('    Error preparing the run')
            return False

        version = bench.version()

        res = bench.runCheck()
        if res['success'] == False:
            red('    Error: ' + res['error'])
            red('    Details: ' + res['details'])
            return False

        time = 0.0
        tests = 0
        while time < self.wall_time:
            res = bench.run()
            if res['success'] == False:
                red('    Error: ' + res['error'])
                red('    Details: ' + res['details'])
                return False
            time += res['time']
            tests += 1
            print('.', flush=True, end='')

        average_time = round(time / tests, 3)
        print(' - time: ', end='', flush=True)
        if tests >= 5: green(str(average_time))
        else:          blue(str(average_time))

        res = bench.clear()
        if res == False:
            red('    Error cleaning')
            return False

        return {
            'name': command['name'],
            'time': average_time,
            'version': version
        }


class Test:
    configuration = {
        'languages': [],
        'wall_time': 10.0,
        'expected_result': None
    }
    name = ''

    def __init__(self, name):
        self.name = name
        config = json.loads(open(self.name + '/config.json', 'r').read())
        self.configuration['languages'] = config['languages']
        self.configuration['wall_time'] = WALL_TIME if WALL_TIME else config['wall_time']
        self.configuration['expected_result'] = config['expected_result']
        if not self.configuration['expected_result']:
            yellow('  Warning: the result check is disabled for this test')


    def run(self):
        results = {}
        for lang in self.configuration['languages']:
            if not ONLY_LANG or lang in ONLY_LANG:
                print("  > %s" % lang)
                results[lang] = self.runLang(lang)
            else:
                yellow("  > %s skipped..." % lang)
        return results

    def runLang(self, lang):
        langTest = LangTest(self.name, lang, self.configuration['expected_result'], self.configuration['wall_time'])
        return langTest.run()


def usage():
    print(">>> LangMark <<<")
    print("This program is written by")
    print("  2015-2016 Edoardo Morassutto <edoardo.morassutto@gmail.com>")
    print("  2015-2016 Dario Ostuni <another.code.996@gmail.com>")
    print()
    print("Usage: %s [-h | --help] [-w time | --wall_time time] [-t test | --test test] [-l lang | --lang lang]" % sys.argv[0])
    print()
    print("  -h      | --help")
    print("      Show this help and exit")
    print("  -w time | --wall_time time")
    print("      Set the global wall_time to 'time'")
    print("  -t test | --test test")
    print("      Execute only 'test'")
    print("  -l lang | --lang lang")
    print("      Execute only 'lang'")
    print(" test and lang are comma-separed lists")

def run():
    print('wall_time: ', end='')
    blue(str(WALL_TIME) if WALL_TIME else '[per test]')
    print('tests: ', end='')
    blue(str(ONLY_TEST) if ONLY_TEST else '[all]')
    print('langs: ', end='')
    blue(str(ONLY_LANG) if ONLY_LANG else '[all]')

    results = {}
    benchmarks = json.loads(open("benchmarks.json", "r").read())
    for benchmark in benchmarks:
        if not ONLY_TEST or benchmark in ONLY_TEST:
            print("> %s" % benchmark)
            test = Test(benchmark)
            results[benchmark] = test.run()
        else:
            yellow("> %s skipped..." % benchmark)

    filename = str(datetime.datetime.now()).replace("-", '').replace(":", '').replace(" ", '')[:14] + '.json'
    output = json.dumps(results, indent=4)
    print(output, file=open(filename, 'w'))

def yellow(str):
    print('\033[33m' + str + '\033[0m')
def green(str):
    print('\033[32;1m' + str + '\033[0m')
def blue(str):
    print('\033[34;1m' + str + '\033[0m')
def red(str):
    print('\033[31;1m' + str + '\033[0m')

def main(argv):
    global WALL_TIME
    global ONLY_TEST
    global ONLY_LANG

    try:
        opts, args = getopt.getopt(argv, 'hw:t:l:', [ 'help', 'wall_time=', 'test=', 'lang=' ])
    except getopt.GetoptError:
        usage()
        sys.exit(2)
    for opt, arg in opts:
        if opt in ('-h', '--help'):
            usage()
            sys.exit()

        elif opt in ('-w', '--wall_time'):
            try:
                WALL_TIME = float(arg)
            except:
                usage()
                red('wall_time must be a float')
                sys.exit(1)
            if WALL_TIME <= 0:
                usage()
                red('wall_time must be greater than zero')
                sys.exit(1)

        elif opt in ('-t', '--test'):
            ONLY_TEST = arg.split(',')

        elif opt in ('-l', '--lang'):
            ONLY_LANG = arg.split(',')

    run()

if __name__ == '__main__':
    main(sys.argv[1:])
