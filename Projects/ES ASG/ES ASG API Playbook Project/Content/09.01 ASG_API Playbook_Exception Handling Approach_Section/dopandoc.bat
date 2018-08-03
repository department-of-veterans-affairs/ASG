rmdir media

pandoc --extract-media ./ -t mediawiki -o "ASG_API Playbook_09.01 Exception Handling Approach_Section_01.04_SME Review Resolved.mediawiki" "ASG_API Playbook_09.01 Exception Handling Approach_Section_01.04_SME Review Resolved.docx"

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

pause
