#! /bin/bash
# created by Ficow Shen

#工程绝对路径
project_path=$(pwd)

#工程名
project_name="ArtOfWuShu"

g_provisioning_profile="7c66496e-a1f4-4960-83de-2123eeae28e7"
g_sign_identity="iPhone Distribution: Suzhou Snail Digital Technology Co., Ltd (WSSN499SLU)"

#打包模式 Debug/Release
development_mode=Release

#scheme名
scheme_name="ArtOfWuShu"

#build文件夹路径
build_path=${project_path}/build

#plist文件所在路径
exportOptionsPlistPath=${project_path}/9inHelper/exportOptions.plist

#导出.ipa文件所在路径
exportFilePath=${project_path}/ipa/${development_mode}


echo '*** 正在 清理工程 ***'
xcodebuild \
clean -configuration ${development_mode} -quiet  || exit 
echo '*** 清理完成 ***'



echo '*** 正在 编译工程 For '${development_mode}
xcodebuild \
archive -project ${project_path}/${project_name}.xcodeproj \
-scheme ${scheme_name} \
-configuration ${development_mode} \
-archivePath ${build_path}/${project_name}.xcarchive 
CODE_SIGN_IDENTITY="${g_sign_identity}"
PROVISIONING_PROFILE="${g_provisioning_profile}" 


echo '*** 编译完成 ***'



echo '*** 正在 打包 ***'
xcodebuild -exportArchive -archivePath ${build_path}/${project_name}.xcarchive \
-configuration ${development_mode} \
-exportPath ${exportFilePath} \
-exportOptionsPlist ${exportOptionsPlistPath} \
CODE_SIGN_IDENTITY="${g_sign_identity}"
PROVISIONING_PROFILE="${g_provisioning_profile}"


if [ -e $exportFilePath/$scheme_name.ipa ]; then
    echo "*** .ipa文件已导出 ***"
    open $exportFilePath
else
    echo "*** 创建.ipa文件失败 ***"
fi
echo '*** 打包完成 ***'