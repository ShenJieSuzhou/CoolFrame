![这里写图片描述](https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/icon.png)
# CoolFrame
iOS搭建高可用APP框架，实现快速开发

自己从事APP开发也有两年的时间了，基本上也是半路出家（之前写过一阶段C++服务器逻辑），幸亏网上的学习资源比较多，于是少走了许多的弯路。

我觉得我们做互联网的就应该致力于开源这种精神，既有利于帮助别人也方便提高自己的水平，于是我就想写一个开源的APP界面框架，而且还是轻量级的，方便快速二次开发上架。

CoolFrame 是基于MVC架构的iOS轻量级框架，其中用到了SDWebImage图片加载框架，AFNetworking框架，MJRefresh上下拉刷新框架，JSONKIT。其中界面布局用到了UItableview以及UIcollectionView，详细的的介绍如何使用它们生成用户体验度高的APP。目前已适配iOS11和iPhoneX 。如果你觉得很好，请给个 Star ✨。

# 预览
<table>
    <tr>
        <td><img src="https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/1.jpg"></td>
        <td><img src="https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/2.PNG"></td>
        <td><img src="https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/3.PNG"></td>
        <td><img src="https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/4.PNG"></td>
        <td><img src="https://github.com/ShenJieSuzhou/CoolFrame/blob/master/screenshot/5.PNG"></td>
    </tr>
</table>

# 功能介绍
1. 添加了APP启动图片，以及广告页面。
2. 首页采用了类似淘宝APP风格的界面布局，采用的方式为自定义UITableView，通过读取json文件来加载布局。
3. 我的页面风格使用的是UICollectionView方式。

# 安装步骤

**注：强烈建议真机测试，模拟器会出现较多问题**
1. 下载项目。
2. 找到并进入 Podfile 文件所在目录，在终端中输入 pod instal。

# 其它

感谢以下第三方库及平台
*   [AFNetworking](https://github.com/AFNetworking/AFNetworking)
*   [MJRefresh](https://github.com/CoderMJLee/MJRefresh)
*   [SDWebImage](https://github.com/rs/SDWebImage)


