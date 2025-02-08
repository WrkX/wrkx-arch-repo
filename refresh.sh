REPONAME="wrkx-arch-repo"
cd  PKGBUILDs/wrkx-base-meta
makepkg
cd ../wrkx-desktop-meta
makepkg
cd ../wrkx-gaming-meta
makepkg
cd ../wrkx-misc-meta
makepkg

cd ../../x86_64

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

repo-add --verify --sign ${REPONAME}.db.tar.gz *.pkg.tar.zst

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

mv ${REPONAME}.db.tar.gz ${REPONAME}.db
mv ${REPONAME}.files.tar.gz ${REPONAME}.files
