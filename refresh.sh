REPONAME="wrkx-arch-repo"

cd x86_64

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

repo-add ${REPONAME}.db.tar.gz *.pkg.tar.zst

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

mv ${REPONAME}.db.tar.gz ${REPONAME}.db
mv ${REPONAME}.files.tar.gz ${REPONAME}.files
