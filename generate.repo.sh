#!/bin/bash
rm -f addons.xml addons.xml.md5

echo "<?xml version='1.0' encoding='UTF-8' standalone='yes'?>" > addons.xml
echo "<addons>" >> addons.xml

for addon in zips/*/; do
    cat ${addon}*/addon.xml | grep -v "<?xml" >> addons.xml
done

echo "</addons>" >> addons.xml
md5sum addons.xml | awk '{ print $1 }' > addons.xml.md5

