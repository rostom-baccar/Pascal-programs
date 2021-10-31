program vigenene;
uses wincrt;

type matrice=array['A'..'Z','A'..'Z'] of char;
type tab=array[1..6] of char;

var ch,ch1:string; m:matrice; cle:string; a,b,c:char; i:integer;

//la matrice est initialisée à l'alphabet décallé de i lettres selon la colonne
procedure remplissage_matrice(var m:matrice);
var i,j:char;
begin
	for i:='A' to 'Z' do begin
		for j:='A' to 'Z' do begin
			m[i,j]:=chr(ord('A')+((ord(j)-65)+(ord(i)-65)) mod 26);
        end;
        end;
end;

//fonction vérifiant l'existence d'une lettre dans une chaine de caractères
function existence(ch:string;c:char):boolean;
var i:integer; t:boolean;
begin
	t:=false;
	i:=0;
	repeat
	i:=i+1;
			if ch[i]=c then t:=true;
until (t=true) or (i=length(ch));
existence:=t;
end;

//fonction de décryptage retournant la chaine de caractères décryptée
function decryptage(ch:string; m:matrice; cle:string):string;
var mot:string; i:integer; 
begin
	mot:='';
	for i:=1 to length(ch) do begin
		mot:=mot+m[ch[i],cle[(i mod 3)+1]];
    end;
decryptage:=mot;	
end;

begin
ch1:='';
//phrase à décrypter
ch:='RMUUWQPMQGXHWBGGKKKNITMUXWWTMGGXHEPH';

remplissage_matrice(m);
i:=0;

//triple boucle for pour générer toutes les clés possibles
for a:='A' to 'Z' do begin
	for b:='A' to 'Z' do begin
		if a<>b then begin
		for c:='A' to 'Z' do begin
			if b<>c then begin

				cle:=a+b+c;
				ch1:=decryptage(ch,m,cle);
				if (ch1[12]='E') and (existence(ch1,'X')=false) and (existence(ch1,'W')=false) then begin //3 suppositions afin de réduire le champ de recherche
				i:=i+1;
                writeln(ch1);
                end;
                cle:='';
            end;
        end;
    end;
end;
end;

	writeln(i); //nombre de clairs possibles suivant les suppositions faites 
	writeln(26*25*24); //nombre de clairs possibles sans les suppositions	 
			


	
end.