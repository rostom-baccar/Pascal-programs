program huffmann5;
uses wincrt;

//d‚claration du type tab dont la variable t contiendra la probabilit‚ d'apparition de chaque lettre, les lettres non utilis‚es ayant une probabilit‚ de 0 par initialisation
type tab=array['A'..'Z'] of integer; 

//d‚claration du type cellule qui contiendra, pour chaque lettre et pour chaque noeud cr‚‚ sa probabilit‚ ainsi que son code
type cellule= record 
    lettre:String;
    prob:integer;
    code:integer;
    next:^cellule;
end;

//d‚claration d'un tableau de cellule pour stocker toutes les cellules des lettres et des noeuds
type tab_cell=array[1..100] of cellule;
var ch,ch1,ch2,ch3:string; t:tab; i:integer; c:char;  cell:tab_cell;

//proc‚dure remplissant le tableau t en mettant pour chaque indice de lettre la probabilit‚ d'apparition dans la chaine de caractŠres ch
procedure tableau_frequence(ch:string; var t:tab);
var i:integer; c:char;
begin
for i:=1 to length(ch) do begin
t[ch[i]]:=t[ch[i]]+1;
end;
end;

//proc‚dure initialisant le tableau t … la valeur de 0 pour chaque indice de lettre
procedure initialisation1(var t:tab);
var i:char;
begin
	for i:='A' to 'Z' do t[i]:=0;
end;

//fonciton prenant une chaine de caractŠres comme entr‚e et renvoyant la mˆme chaine de caractŠres mais sans espaces et en majuscule en sortie
function sans_espaces_maj(ch:string):string;
var i:integer; ch1:string;
begin
ch1:='';
	for i:=1 to length(ch) do begin
		if ch[i]<>' ' then ch1:=ch1+upcase(ch[i]);
    end;
   sans_espaces_maj:=ch1;
end; 

//fonction ‚liminant la redondance de lettre dans une chaine de caractŠres donn‚e en se basant sur la fr‚quence d'apparition de chaque lettre  (non nulle)
function filtre(t:tab):string;
var c:char; ch:string;
begin
	ch:='';
	for c:='A' to 'Z' do begin
	if t[c]<>0 then begin
		ch:=ch+c;
    end;
end;
filtre:=ch;
end;

//fonction renvoyant la probabilit‚ maximale contenue dans le tableau t
function max_prob(ch:string; t:tab):integer;
var i,c:integer; 
begin
	c:=1;
	for i:=1 to length(ch) do begin
		if t[ch[i]]>t[ch[c]] then c:=i
		else if t[ch[i]]=t[ch[c]] then begin
			if ch[i]<ch[c] then c:=i;
        end;
    end;
max_prob:=c;
end;

//fonction renvoyant une chaine de carctŠres dont les lettres sont tri‚es par ordre d‚croissant de leur probabilit‚ d'apparition dans la chaine de caractŠres originale (en se basant sur t)
function tri(ch2:string; t:tab):string;
var ch3:string; c:char; i,j:integer; 
begin
	ch3:='';
	for j:=1 to length(ch2) do begin
	i:=max_prob(ch2,t); 
	c:=ch2[i];
	ch3:=ch3+c;
	delete(ch2,i,1);
end;
tri:=ch3;
end;

//fonction transf‚rant les informations de lettre et de probabilit‚ du tableau t aux cellules cr‚‚es 
procedure transfert(ch:string; t:tab; var cell:tab_cell);
var i:integer;
begin
	for i:=1 to length(ch) do begin
		cell[i].lettre:=ch[i];
		cell[i].prob:=t[ch[i]];
    end;
end;

//fonction qui cherche le minimum d'une liste
function min1_cell(cell:tab_cell;l,j:integer):integer;
var i,min1:integer;
begin
	min1:=0;
	for i:=1 to l+j do begin
		if cell[i].prob<cell[min1].prob then min1:=i
		else if cell[i].prob=cell[min1].prob then min1:=i;
    end;
min1_cell:=min1;
end;

//fonction qui cherche le 2Šme minimun d'une liste, en prenant en compte donc le premier minimum
function min2_cell(cell:tab_cell;min1,l,j:integer):integer;
var i,min2:integer;
begin
	min2:=0;
	for i:=1 to l+j do begin
		if (cell[i].prob<cell[min2].prob) and (i<>min1) then min2:=i
		else if (cell[i].prob=cell[min2].prob) and (i<>min1) then min2:=i;
    end;
min2_cell:=min2;
end;

//proc‚dure qui ‚tablit le code de chaque lettre et noeud
procedure actualisation(ch:string; var cell:tab_cell);
var i,j,s,min1,min2:integer; ch1,ch2,ch3:string; p:^cellule;
begin
	j:=0; s:=0;
	for i:=1 to length(ch) do s:=s+cell[i].prob;
	repeat
	j:=j+1;

	min1:=min1_cell(cell,length(ch),j-1);
    min2:=min2_cell(cell,min1,length(ch),j-1);
    
    cell[length(ch)+j].prob:=cell[min1].prob+cell[min2].prob;
    
    cell[min1].code:=1;
    cell[min2].code:=0;
    
    cell[min1].next:=@cell[length(ch)+j];
    cell[min2].next:=@cell[length(ch)+j];
    
    cell[min1].prob:=s;
    cell[min2].prob:=s;
    
    until j=length(ch)-1;
    
    ch1:=''; ch2:=''; ch3:='';
        
    for i:=1 to length(ch) do begin
    	  p:=@cell[i];
    	 while p^.next <>nil do begin
    	str(p^.code,ch2);
    	ch3:=ch2+ch3;
    	p:=p^.next;
    end;
        writeln('Code de ',cell[i].lettre,' : ',ch3);
         ch3:='';
    end;
    end;

begin
	
initialisation1(t);
writeln('Saisir la chaŒne de caractŠres … coder');
readln(ch);
ch1:=sans_espaces_maj(ch);
tableau_frequence(ch1,t);
ch2:=filtre(t);
ch3:=tri(ch2,t);
transfert(ch3,t,cell);
for i:=1 to length(ch3) do writeln('La lettre ',cell[i].lettre,' apparaŒt avec une probabilit‚ de : ',cell[i].prob);
actualisation(ch3,cell);

end.
