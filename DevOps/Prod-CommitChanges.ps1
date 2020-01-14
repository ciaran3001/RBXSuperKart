cd C:\Users\Ciaran\Desktop\Projects\RobloCart\Source
git checkout -b master
git branch -a

git add * 
git commit -m"Automatic Dev Commit Date: "$(Get-Date -UFormat "%A %m/%d/%Y %R %Z")
git push https://github.com/ciaran3001/RBX_SuperKart.git master:master
Read-Host