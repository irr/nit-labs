module sql3

import sqlite3

if args.length < 1 then
	print "Usage: sql3 <db> <n>"
else
	var sql3 = new Sqlite3DB.open(args[0])
    var last = false
    loop
        var db = sql3.create_table("t1(a, b UNIQUE);")
        if db then
            print "Database created: {db}"
        else
            assert sql3.execute("DROP TABLE t1;") else
                print "Fatal error in module sql3"
            end
        end
        if db or last then break
        last = true
    end
    var n = args[1].to_i
    for x in [1..n] do
        var res = sql3.insert(" INTO t1 VALUES({x}, {x*10});")
        print "Tuple ({x}, {x*10}) inserted: {res}" 
    end
    var stmt = sql3.select(" * FROM t1 ORDER BY a;")
    assert stmt != null else 
        print "Fatal error in module sql3"
    end
    for row in stmt.iterator do
        for i in [0..row.length] do
            var name = row[i].name
            var value = row[i].value
            if value != null then print "{name}: {value}"
        end
    end
    sql3.close
end
