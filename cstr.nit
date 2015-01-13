module cstr

# nitc cstr.nit && ./cstr && rmn cstr

class W
    fun wrap(s: String) : String import String.length, String.to_cstring, NativeString.to_s `{
        #include <string.h>
        char *c_msg;
        int msg_len;
        c_msg = String_to_cstring(s);
        msg_len = String_length(s);
        printf( "in method W::wrap(%s)(len=%d), from C\n", c_msg, msg_len);
        c_msg[0] = 'a';
        return NativeString_to_s(c_msg);
    `}
end

var w = new W
print(w.wrap("Alessandra"))


