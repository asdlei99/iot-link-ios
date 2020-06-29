#!/bin/sh

#bin/bsah - l

rc=$(git rev-parse --short HEAD)
#echo $rc
sed -i "" '/LinkAPP_VERSION/ s/$/.'$rc'/' LinkApp/Supporting\ Files/LinkAppCommon.xcconfig

rm -rf Podfile.lock
/usr/local/bin/pod install --verbose --no-repo-update
 
BUILD_TYPE=$1

 
xcodebuild clean -workspace LinkApp.xcworkspace -scheme LinkApp -configuration $BUILD_TYPE
 
xcodebuild archive -workspace LinkApp.xcworkspace -scheme LinkApp -configuration $BUILD_TYPE -archivePath LinkApp.xcarchive -UseModernBuildSystem=NO
 
if [ $1 == 'Debug' ]; then
    xcodebuild -exportArchive -archivePath LinkApp.xcarchive -exportOptionsPlist .github/script/ExportOptionsDevelop.plist  -exportPath ./
else
    xcodebuild -exportArchive -archivePath LinkApp.xcarchive -exportOptionsPlist .github/script/ExportOptionsRelease.plist  -exportPath ./
fi


 
