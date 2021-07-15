swipl -v -o ngac-server -g ngac_server -c ngac.pl 
swipl -v -o cme -g cme -c cme_sim.pl

./ngac-server.exe &
./cme.exe