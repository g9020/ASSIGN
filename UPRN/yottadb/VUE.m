VUE ; ; 7/21/23 1:23pm
	;
	QUIT
	;	
INT ;
	s ^%W(17.6001,"B","POST","api2/fileupload2","UPLOAD^VUE",1001)=""
	s ^%W(17.6001,1001,0)="POST"
	s ^%W(17.6001,1001,1)="api2/fileupload2"
	s ^%W(17.6001,1001,2)="UPLOAD^VUE"
	s ^%W(17.6001,1001,"AUTH")=2
	;	
	S ^%W(17.6001,"B","GET","api2/activity","ACT^VUE",1002)=""
	S ^%W(17.6001,1002,0)="GET"
	S ^%W(17.6001,1002,1)="api2/activity"
	S ^%W(17.6001,1002,2)="ACT^VUE"
	S ^%W(17.6001,1002,"AUTH")=2
	;	
	s ^%W(17.6001,"B","GET","api2/filedownload2","DOWNLOAD^VUE",1003)=""
	S ^%W(17.6001,1003,0)="GET"
	S ^%W(17.6001,1003,1)="api2/filedownload2"
	S ^%W(17.6001,1003,2)="DOWNLOAD^VUE"
	S ^%W(17.6001,1003,"AUTH")=2
	;	
	S ^%W(17.6001,"B","GET","api2/getinfo","SINGLE^VUE",888)=""
	S ^%W(17.6001,888,"AUTH")=2
	S ^%W(17.6001,888,0)="GET"
	S ^%W(17.6001,888,1)="api2/getinfo"
	S ^%W(17.6001,888,2)="SINGLE^VUE"
	;	
	S ^%W(17.6001,"B","GET","api2/getuprn","INT2^NEL",889)=""
	S ^%W(17.6001,889,"AUTH")=2
	S ^%W(17.6001,889,0)="GET"
	S ^%W(17.6001,889,1)="api2/getuprn"
	S ^%W(17.6001,889,2)="INT2^NEL"
	S ^%W(17.6001,"B","GET","api2/download3","DOWNLOAD^UPRNUI3",1004)=""
	S ^%W(17.6001,1004,0)="GET"
	S ^%W(17.6001,1004,1)="api2/download3"
	S ^%W(17.6001,1004,2)="DOWNLOAD^UPRNUI3"
	S ^%W(17.6001,1004,"AUTH")=2
	;	
ZREG ; register
	set ^%W(17.6001,"B","POST","api2/register","REG^VUE",567774)=""
	set ^%W(17.6001,567774,"AUTH")=2
	;	
	; get register
	set ^%W(17.6001,"B","GET","api2/getreg","GETREG^VUE",567779)=""
	set ^%W(17.6001,567779,"AUTH")=2
	QUIT
	;
EMAIL set ^%W(17.6001,"B","GET","api2/authCheck","EMAILCHK^VUE",567784)=""
	set ^%W(17.6001,567784,"AUTH")=2
	quit
	;
SINGLE(result,arguments) ;
	;
	D GETMUPRN^UPRNHOOK2(.result,.arguments)
	;zwr result
	;
	QUIT	
	;	
EMAILCHK(result,arguments) 
	new token,y,p,b
	;	
	K ^TMP($J)
	S ^TMP($J,1)="{""authenticated"": false}"
	;	
	S token=$G(HTTPREQ("header","authorization"))
	;	
	S ^TST=token
	;	
	s y=$p(token,"Bearer ",2)
	s p=$$DECODE^BASE64($p(y,".",2))
	i p["Vt5ScFwss" do
	. k b
	. D DECODE^VPRJSON($name(p),$name(b),$name(err))
	. S ok=$$EMAILCHK^CURL3(.b)
	. S ^PS=ok
	. if ok'=-2 S ^TMP($J,1)="{""authenticated"": true}"
	. ;if ok=-2 D SETERROR^VPRJRUT(217)
	. quit
	set result("mime")="application/json, text/plain, */*"
	set result=$na(^TMP($J))
	quit
	;	
REG(arguments,body,result) 
	S ZRET=$$REG^UPRNUI2(.arguments,.body,.result)
	QUIT ZRET
	;	
UPLOAD(arguments,body,result)
	S ZRET=$$UPLOAD^UPRNUI2(.arguments,.body,.result)
	QUIT ZRET
	;	
GETREG(result,arguments) 
	D GETREG^UPRNUI2(.result,.arguments)
	QUIT
	;	
ACT(result,arguments) 
	D ACT^UPRNACT(.result,.arguments)
	QUIT
	;	
DOWNLOAD(result,arguments) 
	D DOWNLOAD^UPRNUI2(.result,.arguments)
	QUIT
	;