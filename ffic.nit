module ffic

class A
    var my_attr = 1234
    fun foo `{
        printf( "in method A::foo, from C\n" );
    `}

    fun bar( n : Char ) : Bool `{
        printf( "in method A::bar( %d ), from C\n", n );
        return 1;
    `}

    fun baz( msg : String ) import String.length, String.to_cstring, my_attr, my_attr= `{
        char *c_msg;
        int msg_len;

        /* String_to_cstring is a callback to msg.to_cstring */
        c_msg = String_to_cstring( msg );

        /* String_length is a callback to msg.length */
        msg_len = String_length( msg );

        printf( "received msg: %s, of length = %d\n", c_msg, msg_len );

        /* A_my_attr is a callback to the getter of self.my_attr */
        printf( "old attr %d\n", A_my_attr(recv) );

        /* A_my_attr is a callback to the setter of self.my_attr= */
        A_my_attr__assign( recv, msg_len );
    `}
end

var a = new A
a.foo
print a.bar('A')
a.baz("ALE")
print "my_attr = len(msg): {a.my_attr}"
