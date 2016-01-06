from subprocess import *
from tempfile import TemporaryFile

SHELL = '/bin/bash'

class Bench:
    workingDir = ''
    test = ''
    name = ''
    script = {}
    expected_result = None

    def __init__(self, workingDir, test, name, script, expected_result):
        self.workingDir = workingDir
        self.test = test
        self.name = name
        self.script = script
        if expected_result:
            self.expected_result = str(expected_result).strip()

    def getPrepareCommand(self):
        if 'compile' in self.script:
            return self.script['compile']
        else:
            return [
                ['cp', '%f', '%o'],
                ['chmod', '+x', '%o']
            ]

    def getRunCommand(self):
        if 'run' in self.script:
            return ['/usr/bin/time', '-f', '%U'] + self.script['run']
        else:
            return ['/usr/bin/time', '-f', '%U', './%o']

    def getRunPrintCommand(self):
        if 'print' in self.script:
            return self.script['print']
        else:
            return self.getRunCommand() + ['--print']

    def getClearCommand(self):
        files = ['*.out', '*.bin', '%o']
        if 'other_files' in self.script:
            files.extend(self.script['other_files'])
        return ['rm', '-rf'] + files



    def getOutputFile(self):
        if 'output' in self.script:
            return self.script['output']
        else:
            return self.getBaseName() + '.bin'

    def getInputFile(self):
        return self.script['input']

    def getBaseName(self):
        return self.test + '-' + self.name



    def version(self):
        return self.executeMultiple(self.script['version'])

    def prepare(self):
        return self.executeMultiple(self.getPrepareCommand())

    def clear(self):
        return self.execute(self.getClearCommand())

    def run(self):
        out = self.execute(self.getRunCommand())
        if out == False:
            return { 'success': False, 'error': 'Error executing command!', 'details': '' }
        try:
            return { 'success': True, 'time': float(out['err']) }
        except:
            return { 'success': False, 'error': 'Error getting the time', 'details': str(out) }

    def runCheck(self):
        out = self.execute(self.getRunPrintCommand())
        if out == False:
            return { 'success': False, 'error': 'Failed', 'details': 'Boh..' }
        if self.expected_result and self.expected_result != out['out'].strip():
            return {
                'success': False,
                'error': 'Wrong answer',
                'details': "'%s' != '%s'" % (self.expected_result, out['out'].strip())
            }
        return { 'success': True }


    def executeMultiple(self, commands):
        res = ''
        for command in commands:
            out = self.execute(command)
            if not out:
                return False
            else:
                res += out['out'] + out['err']
        return res

    def execute(self, command):
        try:
            command = list(map(self.prepareParameter, command))
            proc = Popen(command, stdout=PIPE, stderr=PIPE, cwd=self.workingDir)
            stdout, stderr = proc.communicate()
            stdout = str(stdout, 'utf-8')
            stderr = str(stderr, 'utf-8')
            if proc.returncode != 0:
                print("Command %s in dir %s failed! (exit-code = %d)" % (str(command), self.workingDir, proc.returncode))
                print("STDOUT")
                print(stdout)
                print("STDERR")
                print(stderr)
                return False
            return {'out': stdout, 'err': stderr, 'code': proc.returncode}
        except Exception as e:
            print(e)
            return False

    def prepareParameter(self, param):
        param = param.replace('%f', self.getInputFile())
        param = param.replace('%o', self.getOutputFile())
        param = param.replace('%b', self.getBaseName())
        param = param.replace('%t', self.test)
        return param

class ScriptBench:
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
            return {
                'success': False,
                'error': 'Wrong answer',
                'details': "'%s' != '%s'" % (self.expected_result, out.strip())
            }
        return { 'success': True }

    def execute(self, command, output = None):
        ret = call([SHELL, self.workingDir + '/' + self.script, command])
        if ret != 0: return False
        if output:   return self.readFile(output)
        return True

    def readFile(self, file):
        try:
            return open(self.workingDir + '/' + file, 'r').read()
        except:
            return '## File Not Found ##'
