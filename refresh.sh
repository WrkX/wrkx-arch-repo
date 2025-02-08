increment_version() {
  local PKGBUILD_FILE="PKGBUILD"

  # Check if PKGBUILD exists
  if [[ ! -f "$PKGBUILD_FILE" ]]; then
    echo "PKGBUILD file not found!"
    return 1
  fi

  # Extract the current version from the PKGBUILD file
  current_version=$(grep -oP '^pkgver=\K[0-9]+\.[0-9]+' "$PKGBUILD_FILE")

  # Check if version is found
  if [[ -z "$current_version" ]]; then
    echo "Could not find version in PKGBUILD."
    return 1
  fi

  # Increment the version (e.g., 1.1 -> 1.2)
  new_version=$(echo "$current_version" | awk -F. '{print $1"."$2+1}')

  # Use sed to replace the version in the PKGBUILD file
  sed -i "s/^pkgver=$current_version/pkgver=$new_version/" "$PKGBUILD_FILE"

  # Confirm the change
  echo "Version updated from $current_version to $new_version in PKGBUILD"
}



REPONAME="wrkx-arch-repo"
cd  PKGBUILDs
find . -type f -name "*.tar.zst" -exec rm -f {} \;

cd wrkx-base-meta
increment_version
makepkg
cd ../wrkx-desktop-meta
increment_version
makepkg
cd ../wrkx-gaming-meta
increment_version
makepkg
cd ../wrkx-misc-meta
increment_version
makepkg

cd ../../x86_64

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

repo-add --verify --sign ${REPONAME}.db.tar.gz *.pkg.tar.zst

rm -f ${REPONAME}.db
rm -f ${REPONAME}.files

mv ${REPONAME}.db.tar.gz ${REPONAME}.db
mv ${REPONAME}.files.tar.gz ${REPONAME}.files
