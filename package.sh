#!/bin/bash
# 修改默认系统参数  configure.sh
# 添加其它Luci插件  package.sh
# 插件 / 应用配置文件  configs/External.config

# git clone  https://github.com/bigbugcc/OpenwrtApp package/otherapp/OpenwrtApp
# git clone  https://github.com/destan19/OpenAppFilter package/otherapp/OpenAppFilter
git clone  https://github.com/zzsj0928/luci-app-pushbot package/otherapp/luci-app-pushbot

# Theme
# luci-theme-neobird
# git clone https://github.com/thinktip/luci-theme-neobird.git package/otherapp/luci-theme-neobird

# Mentohust
git clone https://github.com/KyleRicardo/MentoHUST-OpenWrt-ipk.git package/otherapp/mentohust

# UnblockNeteaseMusic
# git clone -b master  https://github.com/UnblockNeteaseMusic/luci-app-unblockneteasemusic.git package/unblockneteasemusic

# luci-app-msd_lite tailscale
git clone https://github.com/ximiTech/luci-app-msd_lite package/luci-app-msd_lite
git clone https://github.com/ximiTech/msd_lite package/msd_lite
# git clone https://github.com/selfcan/luci-app-tailscale.git package/luci-app-tailscale
