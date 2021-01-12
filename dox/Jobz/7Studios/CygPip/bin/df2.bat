pushd
echo Drive VolumeLabel   Disk:  Free         Total          Used          CurrentDir
echos   c:  %@format[-11,%@label[c:]] %@format[13,%@diskfree[c:, bc]] %@format[13,%@disktotal[c:, bc]] %@format[13,%@diskused[c:, bc]]
c: ^ echo  %@format[19,%_cwp]
echos   d:  %@format[-11,%@label[d:]] %@format[13,%@diskfree[d:, bc]] %@format[13,%@disktotal[d:, bc]] %@format[13,%@diskused[d:, bc]]
d: ^ echo  %@format[19,%_cwp]
echos   e:  %@format[-11,%@label[e:]] %@format[13,%@diskfree[e:, bc]] %@format[13,%@disktotal[e:, bc]] %@format[13,%@diskused[e:, bc]]
e: ^ echo  %@format[19,%_cwp]
echos   f:  %@format[-11,%@label[f:]] %@format[13,%@diskfree[f:, bc]] %@format[13,%@disktotal[f:, bc]] %@format[13,%@diskused[f:, bc]]
f: ^ echo  %@format[19,%_cwp]
echos   g:  %@format[-11,%@label[g:]] %@format[13,%@diskfree[g:, bc]] %@format[13,%@disktotal[g:, bc]] %@format[13,%@diskused[g:, bc]]
g: ^ echo  %@format[19,%_cwp]
echos   h:  %@format[-11,%@label[h:]] %@format[13,%@diskfree[h:, bc]] %@format[13,%@disktotal[h:, bc]] %@format[13,%@diskused[h:, bc]]
h: ^ echo  %@format[19,%_cwp]
echos   i:  %@format[-11,%@label[i:]] %@format[13,%@diskfree[i:, bc]] %@format[13,%@disktotal[i:, bc]] %@format[13,%@diskused[i:, bc]]
i: ^ echo  %@format[19,%_cwp]
echos   j:  %@format[-11,%@label[j:]] %@format[13,%@diskfree[j:, bc]] %@format[13,%@disktotal[j:, bc]] %@format[13,%@diskused[j:, bc]]
j: ^ echo  %@format[19,%_cwp]
echos   k:  %@format[-11,%@label[k:]] %@format[13,%@diskfree[k:, bc]] %@format[13,%@disktotal[k:, bc]] %@format[13,%@diskused[k:, bc]]
k: ^ echo  %@format[19,%_cwp]
echos   l:  %@format[-11,%@label[l:]] %@format[13,%@diskfree[l:, bc]] %@format[13,%@disktotal[l:, bc]] %@format[13,%@diskused[l:, bc]]
l: ^ echo  %@format[19,%_cwp]
echos   m:  %@format[-11,%@label[m:]] %@format[13,%@diskfree[m:, bc]] %@format[13,%@disktotal[m:, bc]] %@format[13,%@diskused[m:, bc]]
m: ^ echo  %@format[19,%_cwp]
echos   n:  %@format[-11,%@label[n:]] %@format[13,%@diskfree[n:, bc]] %@format[13,%@disktotal[n:, bc]] %@format[13,%@diskused[n:, bc]]
n: ^ echo  %@format[19,%_cwp]
echos   o:  %@format[-11,%@label[o:]] %@format[13,%@diskfree[o:, bc]] %@format[13,%@disktotal[o:, bc]] %@format[13,%@diskused[o:, bc]]
o: ^ echo  %@format[19,%_cwp]
echos   p:  %@format[-11,%@label[p:]] %@format[13,%@diskfree[p:, bc]] %@format[13,%@disktotal[p:, bc]] %@format[13,%@diskused[p:, bc]]
p: ^ echo  %@format[19,%_cwp]
echos   q:  %@format[-11,%@label[q:]] %@format[13,%@diskfree[q:, bc]] %@format[13,%@disktotal[q:, bc]] %@format[13,%@diskused[q:, bc]]
q: ^ echo  %@format[19,%_cwp]
echos   r:  %@format[-11,%@label[r:]] %@format[13,%@diskfree[r:, bc]] %@format[13,%@disktotal[r:, bc]] %@format[13,%@diskused[r:, bc]]
r: ^ echo  %@format[19,%_cwp]
echos TOTALS:
set temp_val=%@eval[%@diskfree[c:,b]+%@diskfree[d:,b]+%@diskfree[e:,b]+%@diskfree[f:,b]+%@diskfree[g:,b]+%@diskfree[h:,b]+%@diskfree[i:,b]+%@diskfree[j:,b]+%@diskfree[k:,b]+%@diskfree[l:,b]+%@diskfree[m:,b]+%@diskfree[n:,b]]
set temp_val=%@eval[%temp_val+%@diskfree[o:,b]+%@diskfree[p:,b]+%@diskfree[q:,b]+%@diskfree[r:,b]]
echos           %@format[14,%@comma[%temp_val]]
set temp_val=%@eval[%@disktotal[c:,b]+%@disktotal[d:,b]+%@disktotal[e:,b]+%@disktotal[f:,b]+%@disktotal[g:,b]+%@disktotal[h:,b]+%@disktotal[i:,b]+%@disktotal[j:,b]+%@disktotal[k:,b]+%@disktotal[l:,b]+%@disktotal[m:,b]+%@disktotal[n:,b]]
set temp_val=%@eval[%temp_val+%@disktotal[o:,b]+%@disktotal[p:,b]+%@disktotal[q:,b]+%@disktotal[r:,b]]
echos %@format[14,%@comma[%temp_val]]
set temp_val=%@eval[%@diskused[c:,b]+%@diskused[d:,b]+%@diskused[e:,b]+%@diskused[f:,b]+%@diskused[g:,b]+%@diskused[h:,b]+%@diskused[i:,b]+%@diskused[j:,b]+%@diskused[k:,b]+%@diskused[l:,b]+%@diskused[m:,b]+%@diskused[n:,b]]
set temp_val=%@eval[%temp_val+%@diskused[o:,b]+%@diskused[p:,b]+%@diskused[q:,b]+%@diskused[r:,b]]
echo %@format[14,%@comma[%temp_val]]
set temp_val=
popd