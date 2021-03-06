FUNCTION readtab, file, nc, nl, nh, SEPARATOR = separator

;
; from, FILE, read a table of ' ' delimited NC columns and NL lines into a 
; floating point array.  read NH lines as header.
;

if (n_elements(separator) EQ 0) THEN separator=' '
openr,LUN, file, /GET_LUN

if(nh gt 0 ) then BEGIN 
header =strarr(nh) 
 readf,LUN,header
END ELSE header=''

data = strarr(nc, nl)
tmp = ''
for i = 0, nl-1 DO BEGIN
 
  readf,LUN,tmp
ptmp=str_sep(tmp, separator, /trim)
a=where(ptmp NE separator and ptmp NE '',na)
if na gt 0 then data[0:na-1,i]=ptmp[a]

;  data(*,i) = (str_sep(tmp, separator, /trim))

;  tmp2= (str_sep(tmp, '', /trim))
;  a=where(tmp2 ne separator)
;  data(*,i)=tmp2(a)
end
FREE_LUN, LUN

mData = {header:header, Data:data}
return, mdata
END
