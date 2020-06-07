


-----

## **macOS Catalina & Mojave & High Sierra** 

[English](README.md) | 中文

## 目录

- [电脑配置](#电脑配置)
- [Clover版本的目前情况](#clover版本的目前情况)
- [OpenCore版本的目前情况](#opencore版本的目前情况)
- [安装](#安装)
  - [首次安装](#首次安装)
  - [构建](#构建)
  - [更新](#更新)
- [改善体验](#改善体验)
- [常见问题解答](#常见问题解答)
- [更新日志](#更新日志)
- [关于打赏](#关于打赏)
- [鸣谢](#鸣谢)
- [支持与讨论](#支持与讨论)


## 电脑配置

| 规格     | 详细信息                               |
| -------- | -------------------------------------- |
| 电脑型号 | 华硕 P8B75                             |
| 处理器   | 英特尔 E1230 v2 处理器                 |
| 内存     | 12GB 海盗船 DDR3 1600MHz               |
| 硬盘     | 西部数据 NVMe固态硬盘 512GB            |
| 独立显卡 | 英伟达 影驰 GTX670                     |
| 显示器   | LG  27寸 4K 显示器 3840x2160 (27 英寸) |
| 声卡     | 瑞昱 ALC887 (节点:1)                   |
| 网卡     | Realtek RTL8111                        |
|          |                                        |


## Clover版本的目前情况

- <b>HDMI 在macOS 10.15.5+上可能无法工作，见 [acidanthera/bugtracker#938](https://github.com/acidanthera/bugtracker/issues/938)</b>
- <b>有线网在macOS 10.15上可能无法工作，见 [#256](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/issues/256)</b>
- 如果升级到macOS 10.15，需要更新[USB无线网卡驱动](https://github.com/chris1111/Wireless-USB-Adapter/releases)
  - 如果不是macOS 10.15，也推荐更新上述驱动
- <b>独立显卡</b>无法工作，因为macOS不支持Optimus技术
  - 使用了 [SSDT-DDGPU](ACPI/SSDT-DDGPU.dsl) 来禁用它以节省电量
- <b>指纹传感器</b>无法工作
  - 使用了[SSDT-USB](ACPI/SSDT-USB.dsl)来禁用它以节省电量
- <b>英特尔蓝牙</b>可能会导致睡眠问题，并且不支持部分蓝牙设备
  - 阅读[蓝牙解决方案](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/wiki/蓝牙解决方案)
- <b>英特尔无线网卡 (英特尔 无线 8265)</b>需要额外操作来工作
  - 购买USB网卡或者支持的内置网卡
  - 使用 [itlwm](https://github.com/zxystd/itlwm) 和 [HeliPort](https://github.com/zxystd/HeliPort) 来驱动英特尔无线网卡
  - ~阅读[#330](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/issues/330)，里面提供了测试驱动~
- <b>瑞昱USB SD读卡器 (RTS5129)</b>无法工作
  - 使用了[SSDT-USB](ACPI/SSDT-USB.dsl)来禁用它以节省电量
- 其他都工作正常


## OpenCore版本的目前情况

- 和[Clover版本的目前情况](#clover版本的目前情况)小节基本一致
- 有限的主题
- <b>Windows的软件会丢失激活，因为OpenCore注入了不同的硬件UUID</b>
  - 我不确定这么做有没有用。根据[OpenCore官方文档](https://github.com/acidanthera/OpenCorePkg/blob/master/Docs/Configuration.pdf)，你可以尝试把原生固件UUID注入进 `/OC/config.plist` 的  `PlatformInfo - Generic - SystemUUID`
- 使用Clover后需要清理 NVRAM
  - 在OpenCore启动界面按下 `空格`，选中进入 `Clean NVRAM`


## 安装

### 首次安装

- 请参考详细的安装教程[【老司机引路】小米笔记本pro Win10+黑苹果macOS 10.13.6双系统](http://www.miui.com/thread-11363672-1-1.html)，视频教程[小米笔记本Pro(win10+Mojave10.14.3)双系统过程以及一些问题解答](http://www.bilibili.com/video/av42261432?share_medium=android&share_source=copy_link&bbid=bVk_DmoLaV48Wj4Pcw9zinfoc&ts=1555066114848)。
- 如果安装过程中触控板失效，请在安装前插上有线鼠标或者无线鼠标发射器。安装完成后打开 `终端.app` 并运行 `sudo kextcache -i /`，等待进程结束重启即可使用触控板。
- 完整的EFI附件请访问 [releases](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/releases) 页面。
 - 如果是日常使用，请不要克隆或者下载master分支。

 <img src="Docs/img/README_donot_Clone_or_Download.jpg" width="300px" alt="donot_clone_or_download">
 <img src="Docs/img/README_get_Release.jpg" width="300px" alt="get_release">

 ### 构建

 - 如果要构建最新测试版EFI，在终端输入以下命令：
 ```
 sh -c "$(curl -fsSL https://raw.githubusercontent.com/daliansky/XiaoMi-Pro-Hackintosh/master/makefile.sh)"
 ```
 - 或者在终端输入以下命令：
 ```
 git clone --depth=1 https://github.com/daliansky/XiaoMi-Pro-Hackintosh.git
 cd XiaoMi-Pro-Hackintosh
 ./makefile.sh
 ```

 ### 更新

- 完整替换 `BOOT` 和 `CLOVER`(或 `OC`)文件夹。首先删除他们，然后从[release 包里](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/releases)拷贝新的。
- 你也可以在终端输入以下命令来更新Clover EFI：

```bash
bash -c "$(curl -fsSL https://raw.githubusercontent.com/daliansky/XiaoMi-Pro-Hackintosh/master/install_cn.sh)"
```


## 改善体验

- 使用 [ALCPlugFix](ALCPlugFix) 来修复耳机重新插拔后无声
- 使用 [DVMT_and_0xE2_fix](BIOS/DVMT_and_0xE2_fix) 来把动态显存设为64mb并解锁CFG
- 使用 [xzhih](https://github.com/xzhih) 的 [one-key-hidpi](https://github.com/xzhih/one-key-hidpi) 来提升系统UI质量
  - 支持 1440x810 HiDPI 分辨率
  - 如果 macOS 版本高于 10.13.6，要开启更高 HiDPI 分辨率 (<1600x900)，请先使用 [DVMT_and_0xE2_fix](BIOS/DVMT_and_0xE2_fix) 来把动态显存设为64mb
- 使用 [one-key-cpufriend](one-key-cpufriend) 来提升CPU性能


## 常见问题解答

#### 我的触控板升级系统后无法使用。

你需要在每次更新系统后重建缓存。运行 `Kext Utility.app` 或者在 `终端.app` 输入 `sudo kextcache -i /`，然后重启。如果触控板还是失效，试试按下F9键。

#### 我无法用触控板按下并拖拽文件。

从 [VoodooI2C v2.4.1](https://github.com/alexandred/VoodooI2C/releases/tag/2.4.1) 开始，按下手势会被仿冒为用力点按，导致无法按下并拖拽文件。你可以在 `系统偏好设置 - 触控板` 里关闭 `用力点按` 或者在 `系统偏好设置 - 辅助功能 - 指针控制 - 触控板选项` 里开启 `三指拖移`。

#### 在升级过程中显示器黑屏并且机子无反应

如果显示器持续黑屏并且无反应超过五分钟，请强制重启电脑(长按电源键)并选择 `Boot macOS Install from ~` 启动项。

#### 我的设备被 `查找我的Mac` 锁住了，无法开机，怎么办？

如果是Clover用户，在Clover开机界面按下 `Fn+F11`。然后Clover会刷新 `nvram.plist` 并移除锁定信息。  
如果是OC用户，开机时按 `Esc` 键来进入引导菜单。然后按下 `空格` 键并选择 `Clean NVRAM`。

#### [Clover] 我开启了 `文件保险箱`，开机时找不到macOS启动项，怎么办？

一般情况下不推荐开启 `文件保险箱`。你可以在Clover开机界面时按下Fn + F3，然后选择下方小字含有 `FileVault` 的苹果图标。进入系统后关闭 `文件保险箱`。

#### [Clover] 我无法通过Clover进入Windows/Linux，但是可以通过按F12，然后选择系统进入。

很多人使用了新版 `AptioMemoryFix.efi` 后无法正常进入Windows/Linux系统。一个解决方案是先删除 `/CLOVER/drivers/UEFI/` 里的 `AptioMemoryFix.efi`，然后替换进[#93](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/issues/93)提供的旧版`AptioMemoryFix.efi`。

同时确保 `沙盒`(Sandbox) 和 `Hyper-V` 功能关闭。

#### [OC] 怎么跳过引导菜单并直接进入系统？

首先，在macOS系统里打开 `系统偏好设置 - 启动磁盘`，选择要直接进入的系统。  
然后，打开 `/EFI/OC/config.plist`，关闭`ShowPicker`。  
想切换系统的时候，开机时按 `Esc` 键来进入引导菜单。  

### 更多问题解答请前往[常见问题解答](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/wiki/常见问题解答)。


## 更新日志

详细更新日志请看[更新日志中文版](Changelog_CN.md)。


## 关于打赏

如果您认可我的工作，请通过打赏支持我后续的更新

| 微信                                                       | 支付宝                                               |
| ---------------------------------------------------------- | ---------------------------------------------------- |
| ![wechatpay_160](http://7.daliansky.net/wechatpay_160.jpg) | ![alipay_160](http://7.daliansky.net/alipay_160.jpg) |


## 鸣谢

- 感谢 [Acidanthera](https://github.com/acidanthera) 提供 [AppleALC](https://github.com/acidanthera/AppleALC)，[AppleSupportPkg](https://github.com/acidanthera/AppleSupportPkg)，[HibernationFixup](https://github.com/acidanthera/HibernationFixup)，[Lilu](https://github.com/acidanthera/Lilu)，[NVMeFix](https://github.com/acidanthera/NVMeFix)，[OpenCorePkg](https://github.com/acidanthera/OpenCorePkg)，[VirtualSMC](https://github.com/acidanthera/VirtualSMC)，[VoodooInput](https://github.com/acidanthera/VoodooInput)，[VoodooPS2](https://github.com/acidanthera/VoodooPS2) 和 [WhateverGreen](https://github.com/acidanthera/WhateverGreen)。
- 感谢 [apianti](https://sourceforge.net/u/apianti)，[blackosx](https://sourceforge.net/u/blackosx)，[blusseau](https://sourceforge.net/u/blusseau)，[dmazar](https://sourceforge.net/u/dmazar) 和 [slice2009](https://sourceforge.net/u/slice2009) 提供 [Clover](https://github.com/CloverHackyColor/CloverBootloader)。
- 感谢 [daliansky](https://github.com/daliansky) 提供 [OC-little](https://github.com/daliansky/OC-little)。
- 感谢 [FallenChromium](https://github.com/FallenChromium)，[jackxuechen](https://github.com/jackxuechen)，[Javmain](https://github.com/javmain)，[johnnync13](https://github.com/johnnync13)，[Menchen](https://github.com/Menchen)，[Pasi-Studio](https://github.com/Pasi-Studio)，[qeeqez](https://github.com/qeeqez) 和 [Bat.bat](https://github.com/williambj1) 的宝贵建议。
- 感谢 [hieplpvip](https://github.com/hieplpvip) 和 [syscl](https://github.com/syscl) 提供 DSDT 补丁样本。
- 感谢 [RehabMan](https://github.com/RehabMan) 提供 [EAPD-Codec-Commander](https://github.com/RehabMan/EAPD-Codec-Commander)，[EFICheckDisabler](https://github.com/RehabMan/hack-tools/tree/master/kexts/EFICheckDisabler.kext)，[OS-X-Clover-Laptop-Config](https://github.com/RehabMan/OS-X-Clover-Laptop-Config)，[OS-X-Null-Ethernet](https://github.com/RehabMan/OS-X-Null-Ethernet) 和 [SATA-unsupported](https://github.com/RehabMan/hack-tools/tree/master/kexts/SATA-unsupported.kext)。
- 感谢 [VoodooI2C](https://github.com/VoodooI2C) 提供 [VoodooI2C](https://github.com/VoodooI2C/VoodooI2C)。
- 感谢 [zxystd](https://github.com/zxystd) 提供 [IntelBluetoothFirmware](https://github.com/zxystd/IntelBluetoothFirmware)。

### 请前往[参考](https://github.com/daliansky/XiaoMi-Pro-Hackintosh/wiki/参考)来获取更多内容。


## 支持与讨论

* 其他项目维护的小米笔记本系列：
  * [小米游戏笔记本](https://github.com/johnnync13/XiaomiGaming) by [johnnync13](https://github.com/johnnync13)
  * [小米笔记本Air-12.5-6y30](https://github.com/johnnync13/EFI-Xiaomi-Notebook-air-12-5) by [johnnync13](https://github.com/johnnync13)
  * [小米笔记本Air-12.5-7y30](https://github.com/influenist/Mi-NB-Gaming-Laptop-MacOS) by [influenist](https://github.com/influenist)
  * [小米笔记本Air-13.3-第一代](https://github.com/johnnync13/Xiaomi-Notebook-Air-1Gen) by [johnnync13](https://github.com/johnnync13)
  * [小米笔记本Air-13.3-2018](https://github.com/johnnync13/Xiaomi-Mi-Air) by [johnnync13](https://github.com/johnnync13)

* tonymacx86.com:
  * [[Guide] Xiaomi Mi Notebook Pro High Sierra 10.13.6](https://www.tonymacx86.com/threads/guide-xiaomi-mi-notebook-pro-high-sierra-10-13-6.242724)

* QQ群:
  * 247451054 [小米PRO黑苹果高级群](http://shang.qq.com/wpa/qunwpa?idkey=6223ea12a7f7efe58d5972d241000dd59cbd0260db2fdede52836ca220f7f20e)
  * 137188006 [小米PRO黑苹果](http://shang.qq.com/wpa/qunwpa?idkey=c17e190b9466a73cf12e8caec36e87124fce9e231a895353ee817e9921fdd74e)
  * 689011732 [小米笔记本Pro黑苹果](http://shang.qq.com/wpa/qunwpa?idkey=dde06295030ea1692d6655564e392d86ad874bd0608afd7d408c347d1767981b)
