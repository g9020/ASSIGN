EXP ; ; 9/4/23 9:49am
STT 
	;W !,$h
	;	
	S adrec="188 Lordship Road,Hackney,London,N16"
	W !,adrec,!
	D SETSWAPS^UPRNU
	S ^TPARAMS($J,"neutral")=1
	D GETUPRN^UPRNMGR(adrec,"","","","","")
	s apiuprn=$O(^TUPRN($J,"MATCHED",""))
	;d tomatch^UPRN(adno,"5.5.1") ;Match 1 address
	;s directuprn=$O(^TUPRN($J,"MATCHED",""))
	w !,"getuprn : ",apiuprn
	;w !,"tomatch : ",directuprn,!
	q