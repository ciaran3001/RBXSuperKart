cd C:\Users\Ciaran\Desktop\Projects\RobloCart\Source
git checkout Dev
git add * 
git commit -m"Dev Branch Commit Date: "$(Get-Date -UFormat "%A %m/%d/%Y %R %Z")
git push https://github.com/ciaran3001/RBX_SuperKart.git Dev
Read-Host