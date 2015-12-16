#!/usr/bin/env python3

import json
import subprocess
import datetime
import sys

time_wall = 10.0

if len(sys.argv) >= 2:
    time_wall = float(sys.argv[1])

output = dict()
benchmarks = json.loads(open("benchmarks.json", "r").read())
for benchmark in benchmarks:
    output[benchmark] = dict()
    langs = json.loads(open(benchmark + "/languages.json", "r").read())
    for lang in langs:
        output[benchmark][lang] = list()
        commands = json.loads(open(benchmark + "/" + lang + "/commands.json", "r").read())
        wd = benchmark + "/" + lang + "/"
        for command in commands:
            print(benchmark + " | " + lang + " -> " + command["name"] + ": ", flush=True, end='')
            script = wd + command["script"]
            subprocess.call(["/bin/bash", script, "pre_exec"])
            subprocess.call(["/bin/bash", script, "print_exec"])
            time_sum = 0.0
            time_num = 0
            while time_sum <= time_wall:
                subprocess.call(["/bin/bash", script, "exec"])
                time_num += 1
                time_sum += float(open(wd + "time.out", "r").read())
                print(".", flush=True, end='')
            subprocess.call(["/bin/bash", script, "version"])
            version_string = open(wd + "version.out", "r").read()
            result = open(wd + "print.out", "r").read().strip("\n")
            print(" result:", result, "-", "time:", round(time_sum / time_num, 3), flush=True)
            subprocess.call(["/bin/bash", script, "clean"])
            output[benchmark][lang].append({"name": command["name"], "time": round(time_sum / time_num, 3), "version": version_string})
print(json.dumps(output, indent=4), file=open(str(datetime.datetime.now()).replace("-", '').replace(":", '').replace(" ", '')[:14] + ".json", "w"))
