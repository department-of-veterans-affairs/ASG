set aImage="https://github.com/department-of-veterans-affairs/ES-ASG/raw/master/Projects/ES%%20ASG/ES%%20ASG%%20API%%20Playbook%%20Project/Content/01.00%%20ASG_API%%20Playbook_Introduction_Section/media/"

rmdir media

rem get the last .docx file
for /R %%f in (*.docx) do set aFile=%%~nf

rem convert .docx to .mediawiki and extract images
pandoc --extract-media ./ -t mediawiki -o "%aFile%.mediawiki" "%aFile%.docx"

rem "!" + (Get-Content $path | Out-String) | Set-Content $path

rem Add TOC to the beginning of the file
powershell -Command "'__TOC__' + (13 -as [char]) + (10 -as [char]) + (gc '%aFile%.mediawiki' -encoding UTF8 | Out-String) | Out-File '%aFile%.mediawiki'" -encoding UTF8

rem Fix up image URLs
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.emf', '.png' | Out-File '%aFile%.mediawiki'" -encoding UTF8
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.jpeg', '.png' | Out-File '%aFile%.mediawiki'" -encoding UTF8
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.jpg', '.png' | Out-File '%aFile%.mediawiki'" -encoding UTF8
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.gif', '.png' | Out-File '%aFile%.mediawiki'" -encoding UTF8
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace '.tmp', '.png' | Out-File '%aFile%.mediawiki'" -encoding UTF8
powershell -Command "(gc '%aFile%.mediawiki' -encoding UTF8) -replace 'File:.//media/', '%aImage%' | Out-File '%aFile%.mediawiki'" -encoding UTF8

rem housekeeping and move Wiki for publishing
del *.bak
copy "%aFile%.mediawiki" "C:\GitHub\ES-ASG.wiki"

rem convert all image files to .png
cd media
for /R %%f in (*.emf) do (
	magick %%~nf.emf %%~nf.png
)

for /R %%f in (*.jpeg) do (
	magick %%~nf.jpeg %%~nf.png
)

for /R %%f in (*.jpg) do (
	magick %%~nf.jpg %%~nf.png
)

for /R %%f in (*.tmp) do (
	magick %%~nf.tmp %%~nf.png
)

for /R %%f in (*.gif) do (
	magick %%~nf.gif %%~nf.png
)

rem push to GitHub Repo

git add -f --all
git commit -m "Publish"
git push --all

cd "C:\GitHub\ES-ASG.wiki"

git add -f --all
git commit -m "Publish"
git push --all

pause
