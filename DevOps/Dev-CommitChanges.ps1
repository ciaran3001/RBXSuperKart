cd C:\Users\Ciaran\Desktop\Projects\RobloCart\Source
git checkout Dev
git add * 
git commit -m"Automatic Commit Date: "$(Get-Date -UFormat "%A %m/%d/%Y %R %Z")
git push https://github.com/ciaran3001/RBX_SuperKart.git master
Read-Host