module srt

class Utils
    
    fun run(cmd: String): Int do
        var sys = new Sys
        return sys.system(cmd)
    end

    fun exec(cmd: String, arguments: nullable Array[String]): String do
        var sp = new IProcess.from_a(cmd, arguments)
        sp.wait
        assert sp.status == 0 else
            exit sp.status
        end
        var out = new FlatBuffer
        var c: Char
        loop
            var i = sp.read_char
            if sp.eof then break
            c = i.ascii
            out.add(c)
        end
        sp.close
        return out.to_s
    end

end

if args.length < 1 then
	print "Usage: srt <file>"
    exit 1
end

var source = args.shift
var utils = new Utils

var file = ["-bi", source]
var charset = utils.exec("file", file).split("charset=")

assert utils.run("iconv -f {charset[1]} -t UTF-8//TRANSLIT \"{source}\" > \"/tmp/{source}\"") == 0 else exit 1

assert utils.run("perl -pe 's/<.*?i>|<.*?b>|<.*?u>//gi' \"/tmp/{source}\" > \"/tmp/{source}.bak\"") == 0 else exit 1

assert utils.run("rm -rf \"/tmp/{source}\"") == 0 else exit 1

assert utils.run("mv \"/tmp/{source}.bak\" \"{source}\"") == 0 else exit 1

var stat = ["--format", "File: %n\nSize: %s", source]
var zenity = utils.exec("stat", stat)

assert utils.run("zenity --info --text=\"{zenity}\nCharset:{charset[1]}\"") == 0 else exit 1

exit 0


