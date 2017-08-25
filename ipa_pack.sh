#! /bin/sh

echo "开始执行shell脚本"

 shellpath=$(cd "$(dirname "$0")";pwd)
# $g_distribution="Release"  # "Release" or "Debug" 不再由外部传入，批处理打包只打release包
# $g_code_root_directory= "/Users/shenjie/Documents/Myproject/jiuyin/9inHelper" #项目代码根目录
# $g_target_name=           'ArtOfWuShu' #要打包的target名称 支持逗号拼接
# $g_product_name=          'ArtOfWuShu' #要打包的产品名称 对应的是是Build Settings 里的Product Name选项 支持逗号拼接
# $g_show_name=             'artofwushu123' #IPA包名称 支持逗号拼接
# $g_provisioning_profile=  '7c66496e-a1f4-4960-83de-2123eeae28e7' #打包用的签名 支持逗号拼接
# $g_res_name=              'mingjiao1.png' #打包所用资源的名称 支持逗号拼接
# $g_res_path=              '/Users/shenjie/Downloads/Pictures' #打包所用资源的路径 支持逗号拼接

# #请注意以上参数如果要打多个包 各个参数用逗号拼接的个数必须相等否则打包出错

# g_lib_proj_root_directory="${g_code_root_directory}" #ios 工程根目录

# echo "$g_lib_proj_root_directory"

# g_main_proj_directory="${g_lib_proj_root_directory}"

# g_dest_res_path="${g_main_proj_directory}/Resource/" #要拷贝到的目录
# echo "项目主工程所在目录:${g_main_proj_directory}  资源名称:${g_res_name}  资源路径:${g_res_path}" 

 apppath="products/apps"
 ipapath="products/ipas"

#打包模式 Debug/Release
development_mode=Release 

#项目代码根目录                                  
g_main_proj_directory="/Users/shenjie/Documents/Myproject/jiuyin/9inHelper" 

#要打包的target名称
g_target_name="ArtOfWuShu"   


g_ipa_name="ArtOfWuShu"    

#build文件夹路径                                                          
g_build_path=${g_main_proj_directory}/build

#exportOptions.plist文件所在路径
exportOptionsPlistPath=${g_main_proj_directory}/9inHelper/exportOptions.plist

#清理工程
clear_mainproj()
{
    cd $g_main_proj_directory
    rm -r $apppath
    mkdir $apppath
      
    echo '*** 正在 清理工程 ***'
    xcodebuild \
    clean -configuration ${development_mode}
    echo '*** 清理完成 ***'
   
}


#创建 ipa 生成目录
MakeIpaDir()
{
    cd $g_main_proj_directory
    mkdir $ipapath
    # ipapath_with_date="$ipapath/$(date +%y%m%d_%H%M)"
    # mkdir $ipapath_with_date
}


#构建
build()
{
    cd $g_main_proj_directory

    target_name=${arr_target[$i]}
    product_name=${arr_product_name[$i]}
    show_name=${arr_show_name[$i]}
    provisioning_profile=${arr_provisioning_profile[$i]}

    # copy_resource $res_path $res_name $show_name

    echo '*** 正在 编译工程 For '${development_mode}
    xcodebuild \
    archive -project ${g_main_proj_directory}/${g_target_name}.xcodeproj \
    -scheme ${g_target_name} \
    -configuration ${development_mode}
    -archivePath ${g_build_path}/${g_product_name}.xcarchive 
    echo '*** 编译完成 ***'


    echo "2. 开始打包ipa..."
    appfile="$g_main_proj_directory/$apppath/$g_distribution-iphoneos/$g_product_name.app"
    ipafile="$g_main_proj_directory/$ipapath/$ipapath/$(date +%y%m%d_%H%M)/$g_product_name.ipa"
    ipa_dsym="$g_main_proj_directory/$apppath/$g_distribution-iphoneos/${g_product_name}.app.dSYM"

    # xcodebuild -exportArchive -archivePath ${g_main_proj_directory}/${g_product_name}.xcarchive -exportOptionsPlist ${exportOptionsPlistPath} -exportPath ${ipafile}
   
    xcodebuild \
    -exportArchive -archivePath ${g_build_path}/${g_product_name}.xcarchive \
    -configuration ${development_mode} \
    -exportPath ${ipafile} \
    -exportOptionsPlist ${exportOptionsPlistPath} 

    echo "    >>>> 打包ipa完成：$ipafile"

    channelipaname="${g_ipa_name}_$(date +%Y%m%d%H%M)".ipa
    channelipa_dsym="${g_ipa_name}_$(date +%m%d%H%M).app.dSYM"
    echo "3. 正在拷贝ipa:$channelipaname"
    cp $ipafile $ipapath/$channelipaname
    cp -R $ipa_dsym $ipapath/$channelipa_dsym                       #  //拷贝dSYM文件

    # echo "5. 删除build/ 文件夹目录........................"
    # rm -rf "build/"
    echo "    >>>> 完成渠道包:${show_name}_${res_name}.........."

    # # str_res_names=${arr_res_name[$i]}
    # # str_res_paths=${arr_res_path[$i]}
    # IFS=":"
    # # arr_res_name_single_target=($str_res_names)
    # # arr_res_path_single_target=($str_res_paths)
    # IFS="$OLD_IFS"
    # num_res=${#arr_res_name_single_target[@]}
    # for ((j=0;j<num_res;j++))
    # do
    #     res_name=${arr_res_name_single_target[$j]}
    #     res_path=${arr_res_path_single_target[$j]}
    #     # echo "一共需要生成的包[$g_show_name] ,当前正在生成的包名称[$show_name], 资源名称[$res_name],资源路径[$res_path] "


    #     # copy_resource $res_path $res_name $show_name
    
    #     xcodebuild -target $target_name -configuration $g_distribution  PROVISIONING_PROFILE_SPECIFIER=$provisioning_profile     #  //Build项目
    #     if [ $? != 0 ]
    #     then

    #         echo "[$(date +%y%m%d_%H:%M:%S)]<<打包-链接>>[$show_name]渠道: 资源[$res_name] 打包异常请注意检查,签名[$provisioning_profile]">$param/temp.txt
    #         exit 0
    #     fi

    #     echo "2. 开始打包ipa..."
    #     appfile="$g_main_proj_directory$apppath/$g_distribution-iphoneos/$g_product_name.app"
    #     ipafile="$g_main_proj_directory$apppath/$g_distribution-iphoneos/$g_product_name.ipa"
    #     ipa_dsym="$g_main_proj_directory$apppath/$g_distribution-iphoneos/${g_product_name}.app.dSYM"
    #     /usr/bin/xcrun -sdk iphoneos PackageApplication -v "$appfile" -o "$ipafile"
    #     if [ $? != 0 ]
    #     then
    #         echo "[$(date +%y%m%d_%H:%M:%S)]<<打包-生成IPA>>[$show_name]渠道: 资源[$res_name] 打包异常请注意检查,签名[$provisioning_profile]">$param/temp.txt
    #         exit 0
    #     fi

    #     # echo "	>>>> 打包ipa完成：$ipafile"
  
    #     channelipaname="${product_name}_$(date +%Y%m%d%H%M)_${show_name}_${res_name}".ipa
    #     channelipa_dsym="${product_name}_$(date +%m%d%H%M).app.dSYM"
    #     # echo "3. 正在拷贝ipa:$channelipaname"
    #     cp $ipafile $ipapath/$channelipaname
    #     cp -R $ipa_dsym $ipapath/$channelipa_dsym                       #  //拷贝dSYM文件

    #     # echo "5. 删除build/ 文件夹目录........................"
    #     rm -rf "build/"
    #     # echo "	>>>> 完成渠道包:${show_name}_${res_name}.........."
    # done
  done
}



clear_mainproj
MakeIpaDir
build 
# $shellpath/openfinder.sh $ipapath
echo ">>>>>>>>>> 打包完成 . "
exit 1
