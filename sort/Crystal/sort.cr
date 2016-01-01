require "option_parser"

print_out = false
OptionParser.parse! do |parser|
    parser.on("--print", "--print") { print_out = true }
end
v = [] of Int32
v_size = 4194304
i = 0
seed = 3
while i < v_size
    v << seed
    seed *= 27487
    seed %= 30491
    i += 1
end
v.sort!
if print_out
    puts v[279121]
end
