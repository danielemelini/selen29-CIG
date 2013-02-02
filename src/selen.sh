  
 # This is file "selen.sh", created by "config.f90" on 2013.02.01 18.17.04
   
 echo ''
 echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
 echo '     SELEN, a Sea levEL EquatioN solver, Version 2.9     '
 echo '                  gfortran VERSION                       '
 echo '      Web page: http://fcolleoni.free.fr/SELEN.html      '
 echo '   http://www.fis.uniurb.it/spada/SELEN_minipage.html    '
 echo '   Send comments, requests of help and suggestions to:   '
 echo '                <giorgio.spada@gmail.com>                '
 echo '                            -                            '
 echo '                    Copyright(C) 2008                    '
 echo '     Giorgio Spada, Florence Colleoni & Paolo Stocchi    '
 echo '                          * * *                          '
 echo '     This programs comes with  ABSOLUTELY NO WARRANTY    '
 echo ' This is free software and you are welcome to distribute '
 echo '              it under certain conditions.               '
 echo '    For details, visit  <http://www.gnu.org/licenses/>   '
 echo '                  or edit file COPYING                   '
 echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
 echo ''
  
  
 echo '---------------------------------------'
 echo ' >>> 0. Compiling the SELEN programs...'
 echo '---------------------------------------'
 echo '--- shtools.f90'
                                                                   -O3 -c shtools.f90
 echo '--- harmonics.f90'
                                                                   -O3 -c harmonics.f90
 echo '--- sle.f90'
                                                                   sle.f90 harmonics.o -o sle.exe -O3
 echo '--- px.f90'
                                                                   px.f90 harmonics.o -o px.exe
 echo '--- px_rec.f90'
                                                                   px_rec.f90 harmonics.o  -o pxrec.exe
  
  
 echo ''
 echo '----------------------------'
 echo ' >>> 1. Executing SELEN  ...'
 echo '----------------------------'
  
 #echo --------------------------------------------------------
 echo                                                          
  echo '---> Working directory: '                                                                                                    
 #echo --------------------------------------------------------
  
 #echo ------------------------------------------------------
 echo
  echo '---> Output data will be stored into directory '            
 #echo ------------------------------------------------------
 if [ ! -d              ]
 then
 mkdir             /
 mkdir             /bin/
 mkdir             /px/
 mkdir             /wnw/
 mkdir             /log/
 mkdir             /of/
 mkdir             /of/degree_variance/
 mkdir             /��Om�    
 mkdir             /��Om�    /original/
 mkdir             /��Om�    /esl/
 mkdir             /��Om�    /rechonstructed/
 mkdir             /��Om�    /sh/
 mkdir             /TABOO/
 mkdir             /Love-Numbers-by-TABOO/
 mkdir             /rsl/
 mkdir             /rsl/rsl-sites/
 mkdir             /rsl/rsl-curves/
 mkdir             /rsl/rsl-curves/ps/
 mkdir             /rsl/rsl-curves/pdf/
 mkdir             /rsl/rsl-scplot/
 mkdir             /rsl/rsl-misfit/
 mkdir             /rsl/rsl-table/
 mkdir             /rsl/rsl-zones/
 mkdir             /rsl/rsl-contours/
 mkdir             /tgauges/
 mkdir             /tgauges/tgauges-sites/
 mkdir             /tgauges/tgauges-scplots/
 mkdir             /tgauges/tgauges-predictions/
 mkdir             /gmaps/
 mkdir             /geod/
 mkdir             /geod/sites/
 mkdir             /geod/3dmaps/
 mkdir             /geod/3dmaps/northamerica/
 mkdir             /geod/3dmaps/fennoscandia/
 mkdir             /geod/3dmaps/mediterranean/
 mkdir             /rmaps/
 mkdir             /rmaps/sun_data
 mkdir             /rmaps/Italy
 mkdir             /rmaps/Mediterranean
 mkdir             /rmaps/Europe
 mkdir             /rmaps/Fennoscandia
 mkdir             /rmaps/Greenland
 mkdir             /rmaps/North_America
 mkdir             /rmaps/Antarctica
 mkdir             /stokes/
 else
 echo
 echo '+++>  WARNING/ a repository already exists with name: '            
     
 echo '+++>  [existing data will be overwritten]'
     
 fi
  
 #echo --------------------------------------------------------
 echo                                                          
  echo '---> PX.F90: Hicosahedral pixelization of the sphere  '
 #echo --------------------------------------------------------
 ./px.exe
 cp px.dat             /px
 cp pxa.dat             /px
 cp px-lat.dat             /px
  
 #echo ---------------------------------------
 echo
  echo '---> px.gmt: Separating wet from dry pixels'
 #echo ---------------------------------------
 sh px.gmt
 cp weta.dat             /px
 cp drya.dat             /px
  
 #echo ---------------------------------------
 echo
  echo '---> PX_REC.F90: Merging the wet & dry pixels tables'
 #echo ---------------------------------------
 ./pxrec.exe
 cp px-table.dat             /px
 mv px.gmt             /px
  
 #echo ------------------------------------------------------
 echo
  echo '+++> A SH file already exists with name:'                     
 #echo ------------------------------------------------------
 cp                      sh.bin
  
 #echo -----------------------------------------------------------
 echo
  echo '+++> An OF SH file already exists with name:'                     
 #echo -----------------------------------------------------------
 cp                      shof.dat
 cp                                  /of
  
 #echo --------------------------------------------------------------------
 echo
  echo '---> Importing '                     from ICE-MODELS/
 #echo --------------------------------------------------------------------
 cp ./ICE-MODELS/                     ./                    
  
 #echo ------------------------------------------------------------
 echo                                                                    
  echo '---> Ice harmonics are pre-computed in file: '                    
 #echo ------------------------------------------------------------
 cp                      shice.dat
  
 #echo  ------------------------------------------------------------------- 
 echo 
  echo  '---> SLE.F90: Solving the Sea Level Equation - SLE - for FIXED coastlines'
 #echo  ------------------------------------------------------------------- 
                                                                                                      ./sle.exe
  
  
 echo ''
 echo '------------------------------------'
 echo ' >>> 2. Cleaning up the directory...'
 echo '------------------------------------'
 if [ -f  ./gmtdefaults4  ]
 then
 /bin/rm -v ./gmtdefaults4
 fi
 /bin/rm -v *brok*.dat
 mv selen.log             /log/
 cp config.dat             /log/
 cp config.f90             /log/
 cp data.inc             /log/
 cp selen.sh             /log/
 mv pxa.dat             /px
 mv weta.dat             /px/
 mv drya.dat             /px/
 mv px-lat.dat             /px/
 mv px.dat             /px/
 mv px-table.dat             /px/
 mv                                    /��Om�    /original/
 echo ''
 echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
 echo '     SELEN, a Sea levEL EquatioN solver, Version 2.9     '
 echo '                      g95  VERSION                       '
 echo '      Web page: http://fcolleoni.free.fr/SELEN.html      '
 echo '   http://www.fis.uniurb.it/spada/SELEN_minipage.html    '
 echo '   Send comments, requests of help and suggestions to:   '
 echo '                <giorgio.spada@gmail.com>                '
 echo '                            -                            '
 echo '                    Copyright(C) 2008                    '
 echo '     Giorgio Spada, Florence Colleoni & Paolo Stocchi    '
 echo '                          * * *                          '
 echo '     This programs comes with  ABSOLUTELY NO WARRANTY    '
 echo ' This is free software and you are welcome to distribute '
 echo '              it under certain conditions.               '
 echo '    For details, visit  <http://www.gnu.org/licenses/>   '
 echo '                  or edit file COPYING                   '
 echo '- - - - - - - - - - - - - - - - - - - - - - - - - - - - -'
 echo ''
 echo ''
 echo ' >>> Outputs for this run are available in directory: '            
