# pmap
Concurrent alternatives to map and for-each for Racket

Sample usage:
<pre>
(pmap string-upcase '("naice" "world" "buddy"))
-> '("NAICE" "WORLD" "BUDDY")
</pre>
