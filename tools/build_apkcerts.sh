tools=$dir/../tools/
echo "Build apkcerts.txt"
adb pull /data/system/packages.xml $tools
python $tools/apkcerts.py $tools/packages.xml $tools/apkcerts.txt
for file in `ls $dir/port/system/framework/*.apk`
do
    apk=`basename $file`
    echo "name=\"$apk\" certificate=\"build/target/product/security/platform.x509.pem\" private_key=\"build/target/product/security/platform.pk8\"" >> $tools/apkcerts.txt
done
rm $tools/packages.xml
sed -i '' 's/build\/target\/product\/security/\..\/tools\/security/g' $tools/apkcerts.txt;
