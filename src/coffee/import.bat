@echo off 

set /p login=Veuillez indiquer votre login: 
set /p password=Veuillez indiquer votre mot de passe: 

npm --login=%login% --pass=%password% run-script import