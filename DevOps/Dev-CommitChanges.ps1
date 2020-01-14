cd C:\Users\Ciaran\Desktop\Projects\RobloCart\Source
git checkout -b Dev
git branch -a

git add * 
git commit -m"Automatic Commit Date: "$(Get-Date -UFormat "%A %m/%d/%Y %R %Z")
git push https://github.com/ciaran3001/RBX_SuperKart.git Dev:Dev
Read-Host