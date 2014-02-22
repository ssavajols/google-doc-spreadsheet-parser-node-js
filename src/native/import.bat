@echo off 

set /p login=Veuillez indiquer votre login: 
set /p password=Veuillez indiquer votre mot de passe: 

node app.js %login% %password%