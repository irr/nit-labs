module spawn

if args.length < 1 then
	print "Usage: spawn <cmd> [args...]"
    return
end

var cmd = args.shift
var arguments: nullable Array[String] = new Array[String]

for a in args do
    arguments.push(a)
end

var sp = new IProcess.from_a(cmd, arguments)
sp.wait

assert sp.status == 0 else
    print "spawn error {sp.status}"
end

var out = new RopeBuffer
var c: Char

loop
    var i = sp.read_char
    if sp.eof then break
    c = i.ascii
    out.add(c)
end

sp.close

print out.to_s



