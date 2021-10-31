program distance;
uses wincrt;

type tab=array[1..2,1..1000] of real;
var t:tab;
var z,c,i,j:integer;
var d,moy,s:real;

function remplissage(var t:tab):integer;
var c:integer;
var i,j:real;
begin
	c:=0; i:=-1.01; j:=-1.01;
	repeat
		j:=j+0.1;
		repeat
			i:=i+0.1;
			if ((i*i+j*j)<1) then begin
			c:=c+1;
                t[1,c]:=i;
               t[2,c]:=j;
                write('x : ',t[1,c]:2:2,' , y : ',t[2,c]:2:2,' , xý+yý= ',i*i+j*j:2:2);
                writeln;
                end;
            until i>=1.00;
            i:=-1.01;
    until j>=1.00;
    remplissage:=c;  
end;

    function calcul_distance(t:tab;i:integer;j:integer):real;
    var d:real;
    begin
    d:=sqrt((t[1,i]-t[1,j])*(t[1,i]-t[1,j])+(t[2,i]-t[2,j])*(t[2,i]-t[2,j]));
    calcul_distance:=d;
    end;


Begin
	z:=remplissage(t);
	writeln('Capacit‚ du tableau: 1000 points');
	writeln('Nombre de points g‚n‚r‚s maximum: 900');
	writeln('Nombre de points g‚n‚r‚s qui respectent l"‚quation: ',z);
	c:=0;
	s:=0;
	for i:=1 to z do Begin
	for j:=1 to z do begin
	c:=c+1;
	d:=calcul_distance(t,i,j);
	s:=s+d;
    end;
    end;
    moy:=s/(z*z);
    writeln('Distance moyenne entre deux points du disque: ',moy:20:20);
    writeln('Valeur attendue: ',128/(45*pi):20:20);
end.
