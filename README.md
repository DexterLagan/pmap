# pmap
Concurrent (multi-threaded) alternatives to map and for-each for Racket

Sample usage:
<pre>
(pmap string-upcase '("naice" "world" "buddy"))
-> '("NAICE" "WORLD" "BUDDY")
</pre>
and
<pre>
(pfor-each string-upcase '("naice" "world" "buddy"))
-> #void
</pre>
