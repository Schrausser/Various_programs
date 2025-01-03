(*Das Programm TS.EXE greift auf p-Wert-Dateien zu und zählt die p-Werte, die kleiner als ein bestimmter α-Wert sind. Damit wird die Teststärke für bestimmte Design-Zellen bezüglich eines bestimmten α-Fehler-Niveaus ermittelt. Das Programm ist so angelegt, daß in einem Durchlauf alle 20 Design-Zellen einer Design-Zeile bearbeitet werden können. Es resultiert eine Datei, in der für die entsprechenden 20 Design-Zellen die Teststärkenwerte für α=0.05/0.1/0.2 sowie die Teststärkenwerte, die sich für 2 Gruppen von je 500 p-Werten ergeben, gespeichert sind.
The program TS.EXE accesses p-value files and counts p-values ​​that are smaller than a certain α-value. This determines the power for certain design cells with respect to a certain α-error level. The program is designed so that all 20 design cells of a design line can be processed in one run. The result is a file in which power values ​​for α=0.05/0.1/0.2 and power values ​​resulting for 2 groups of 500 p-values ​​each are stored for the corresponding 20 design cells.*)

program ts; 
uses crt; 
var stnr: string [3]; var p1name,p2name,tsname: string [30]; var stp1,stp2: string [7]; 
var p1datei,p2datei,tsdatei: text; 
var stark05e, stark10e, stark05z, stark10z, stark20e, stark20z,  kv05e1, kv05e2, kv10e1, kv10e2, kv20e1, kv20e2, kv05z1, kv05z2, kv10z1, kv10z2, kv20z1, kv20z2, anzahl, nrez, I, J, K, L, code: integer; 
var p1,p2: real; 
var kreuzval: array [1..1000] of 0..1; 
var rs: text;
begin randomize; 
assign (rs,'c:\simul3\info\rskval.lst'); 
rewrite (rs); 
writeln (rs,RandSeed:20);           
close (rs);   
write ('Nummer der ersten Zelle: '); 
readln (nrez);                                    
str (nrez,stnr);  
tsname:=concat('c:\simul3\ts',stnr,'.lst'); 
assign (tsdatei,tsname); 
rewrite (tsdatei);

for I:=(nrez) to (nrez+19) do   
begin     
str (I,stnr);    
p1name:=concat('c:\simul3\plager\p1z',stnr,'.lst');     p2name:=concat('c:\simul3\plager\p2z',stnr,'.lst');     
assign (p1datei,p1name);    
reset (p1datei);    
assign (p2datei,p2name);   
reset (p2datei);          
stark05e:=0;    
stark05z:=0;     
stark10e:=0;    
stark10z:=0;    
stark20e:=0;   
stark20z:=0;     
kv05e1:=0;     kv05e2:=0;     kv10e1:=0;     kv10e2:=0;     kv20e1:=0;     kv20e2:=0;     kv05z1:=0;     kv05z2:=0;     kv10z1:=0;     kv10z2:=0;     kv20z1:=0;     kv20z2:=0;     anzahl:=0;      
for K:=1 to 1000 do                
begin        
kreuzval [K] :=0;  (* aufbau eines feldes, 500 x 0, 500 x 1 *)         
end;      
J:=0;                  
repeat          
L:=(random(1000)+1);          
if kreuzval [L] = 0 then             
begin              
kreuzval [L] := 1; 
J:=J+1;             
end;     
until J=500;       
for J:=1 to 1000 do                         
begin         
readln (p1datei,stp1);         
val(stp1,p1,code);         
p1:=(int(10000*p1));         
readln (p2datei,stp2);         
val(stp2,p2,code);         
p2:=(int(10000*p2));                
if p1>500 then stark05e := stark05e + 1;                        if p1>1000 then stark10e := stark10e + 1;         
if p1>2000 then stark20e := stark20e + 1;          
if p2>500 then stark05z := stark05z + 1;         
if p2>1000 then stark10z := stark10z + 1;         
if p2>2000 then stark20z := stark20z + 1;  (* für Kreuzvalidierung: *)         
if kreuzval [J] = 0 then                             
begin            
if p1>500 then kv05e1 := kv05e1 + 1;            
if p1>1000 then kv10e1 := kv10e1 + 1;            
if p1>2000 then kv20e1 := kv20e1 + 1;             
if p2>500 then kv05z1 := kv05z1 + 1;            
if p2>1000 then kv10z1 := kv10z1 + 1;            
if p2>2000 then kv20z1 := kv20z1 + 1;            anzahl:=anzahl+1;            
end                         
else                                                        begin            
if p1>500 then kv05e2 := kv05e2 + 1;            
if p1>1000 then kv10e2 := kv10e2 + 1;            
if p1>2000 then kv20e2 := kv20e2 + 1;             
if p2>500 then kv05z2 := kv05z2 + 1;            
if p2>1000 then kv10z2 := kv10z2 + 1;            
if p2>2000 then kv20z2 := kv20z2 + 1;            
end;          
end;                    

close (p1datei);     
close (p2datei);                                                                                                                            writeln (tsdatei,'Zelle ',I,': Alpha=0.05; einseitig;  TS=',((1000stark05e)/1000):7:5); 
writeln (tsdatei,'Zelle ',I,': Alpha=0.10; einseitig;  TS=',((1000stark10e)/1000):7:5); 
writeln (tsdatei,'Zelle ',I,': Alpha=0.20; einseitig;  TS=',((1000stark20e)/1000):7:5); 
writeln (tsdatei); 
writeln (tsdatei,'Zelle',I,': Alpha=0.05; zweiseitig; TS=',((1000stark05z)/1000):7:5); 
writeln (tsdatei,'Zelle',I,': Alpha=0.10; zweiseitig; TS=',((1000stark10z)/1000):7:5); 
writeln (tsdatei,'Zelle',I,': Alpha=0.20; zweiseitig; TS=',((1000stark20z)/1000):7:5); 
writeln (tsdatei);       
writeln (tsdatei,'Kreuzvalidierung: 2 x 500 Experimente:'); writeln (tsdatei); 
writeln (tsdatei,'Zelle ',I,': Alpha=0.05; einseitig;  TS=',              ((500-kv05e1)/500):7:5,' / ',((500-kv05e2)/500):7:5);  
writeln (tsdatei,'Zelle ',I,': Alpha=0.10; einseitig;  TS = ',              ((500-kv10e1)/500):7:5,' / ',((500-kv10e2)/500):7:5);     writeln (tsdatei,'Zelle ',I,': Alpha=0.20; einseitig;  TS = ',              ((500-kv20e1)/500):7:5,' / ',((500-kv20e2)/500):7:5);     writeln (tsdatei);     
writeln (tsdatei,'Zelle ',I,': Alpha=0.05; zweiseitig; TS = ',              ((500-kv05z1)/500):7:5,' / ',((500-kv05z2)/500):7:5);     writeln (tsdatei,'Zelle ',I,': Alpha=0.10; zweiseitig; TS = ',              ((500-kv10z1)/500):7:5,' / ',((500-kv10z2)/500):7:5);     writeln (tsdatei,'Zelle ',I,': Alpha=0.20; zweiseitig; TS = ',              ((500-kv20z1)/500):7:5,' / ',((500-kv20z2)/500):7:5);     writeln (tsdatei);     
end;                       
close (tsdatei); 
end.  
