#!/bin/bash

CURRENTDIR=`dirname $0`
BUILDDIR=$CURRENTDIR/tmp-build-dir
INSTALLDIR=$BUILDDIR/opt

DOWNLOADURL=
PORKCHOP=http://porkchop/released
EAPDIR=JBEAP-6
EAPVERSION=6.2.0
EAPNAME=jboss-eap-
PATCHVERSION=6.2.3
PATCHNAME=$(printf '%s%s-patch.zip' "$EAPNAME" "$PATCHVERSION")
EAPZIPDIRNAME=$(printf '%s%s' "$EAPNAME" "6.2")
distribution=$(printf '%s%s.zip' "$EAPNAME" "$EAPVERSION")
#distribution=jboss-eap-6.2.0.zip
files=( $distribution $PATCHNAME )

# Only supports retrieving the minor EAP release and one micro patch release
for f in "${files[@]}"; do
  if [ ! -f "$f" ]; then
    echo "File [$f] not found!"
    if [[ "$f" =~ "$EAPVERSION" ]]
    then
      # minor
      DOWNLOADURL=$(printf '%s/%s/%s/%s' "$PORKCHOP" "$EAPDIR" "$EAPVERSION" "$distribution")
    else
      # micro
      DOWNLOADURL=$(printf '%s/%s/%s/%s' "$PORKCHOP" "$EAPDIR" "$PATCHVERSION" "$PATCHNAME")
    fi
    echo "Attempting to download [$DOWNLOADURL]..."
    wget -q -T 10 $DOWNLOADURL
    if [ $? -gt 0 ]; then
      echo "Error downloading $DOWNLOADURL.  Exiting"
      exit 1
    fi
  fi
done


# Clean up the build dir
echo "$(date -R) Preparing directory structure"
rm -rf $BUILDDIR
mkdir -p $INSTALLDIR

# Unpack the main EAP distribution
echo "$(date -R) Unpacking EAP distribution $distribution"
unzip -q $distribution -d $INSTALLDIR/

# Upgrade
if [ -f "$PATCHNAME" ]; then
  echo "$(date -R) Upgrading EAP distribution using $PATCHNAME"
  $INSTALLDIR/$EAPZIPDIRNAME/bin/jboss-cli.sh --command="patch apply $PATCHNAME"
else
  echo "Patch file [$PATCHNAME] not found"
fi

echo "$(date -R) Installing launch script"
cp $CURRENTDIR/launch.sh $INSTALLDIR/$EAPZIPDIRNAME/bin/

echo "$(date -R) Creating package with the layer"
#tar -czf $EAPNAME$PATCHVERSION-layer.tar.gz -C $BUILDDIR .
zPWD=`pwd`
cd $BUILDDIR
zip -qr $EAPNAME$PATCHVERSION-layer.zip .
cd $zPWD
mv $BUILDDIR/$EAPNAME$PATCHVERSION-layer.zip .

echo "$(date -R) Done!"
