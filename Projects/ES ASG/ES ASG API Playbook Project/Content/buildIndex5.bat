rem Dependency AutoHotKeyU64.exe
cd C:\GitHub\ES-ASG
git pull "https://github.com/department-of-veterans-affairs/ES-ASG" "master"

cd C:\GitHub\ES-ASG.wiki
git pull https:"//github.com/department-of-veterans-affairs/ES-ASG.wiki" "master"


SETLOCAL ENABLEDELAYEDEXPANSION

rem Set to working directory
cd "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content"

rem Create TOC.txt and add some heading info
echo "<^!-- Index Start -->">"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<h3>Last Generated: [%date%, %time%]</h3>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<ul>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"

for /r %%i in (.) do (

	if "%%i"=="C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\." (echo pass) else (

  	cd %%i

		call "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\buildindex5a"

		cd "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content"
	)

)

rem Add tail info
echo "</ul>">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"
echo "<^!-- Index Stop -->">>"C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\TOC.txt"

rem Trigger AutoHotKey
c:\GitHub\AutoHotkeyU64.exe "C:\GitHub\ES-ASG\Projects\ES ASG\ES ASG API Playbook Project\Content\ReplaceText.ahk"

rem push to GitHub Repo

cd "C:\GitHub\ES-ASG"
git add -f --all
git commit -m "Publish"
git push --all

cd "C:\GitHub\ES-ASG.wiki"
git add -f --all
git commit -m "Publish"
git push --all

