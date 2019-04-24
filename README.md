# pmap
Concurrent (multi-threaded) alternatives to map, andmap and for-each for Racket

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

I added a concurrent andmap variant: andpmap:
<pre>
(andpmap even? '(2 3 4))
-> #f
</pre>
<pre>
(andpmap even? '(2 4 6))
-> #t
</pre>

Cheers,

Dexter
