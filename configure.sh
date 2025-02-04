#!/bin/bash
# Modify default system settings
# 修改默认系统参数  configure.sh
# 添加其它Luci插件  package.sh
# 插件 / 应用配置文件  configs/External.config

# 修改默认IP为192.168.10.1
# sed -i 's/192.168.1.1/10.0.0.1/g' package/base-files/files/bin/config_generate 

# Hello World
# echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default


# passwall
echo "src-git passwall_packages https://github.com/xiaorouji/openwrt-passwall-packages.git;main" >> feeds.conf.default
echo "src-git passwall2 https://github.com/xiaorouji/openwrt-passwall2.git;main" >> feeds.conf.default

# 替换默认主题
rm -rf package/lean/luci-theme-argon 
git clone -b 18.06 https://github.com/jerrykuku/luci-theme-argon.git  package/lean/luci-theme-argon

# Add feeds source
#echo 'src-git helloworld https://github.com/fw876/helloworld' >>feeds.conf.default
#echo 'src-git passwall https://github.com/xiaorouji/openwrt-passwall' >>feeds.conf.default
echo 'src-git kenzo https://github.com/kenzok8/openwrt-packages' >>feeds.conf.default
echo 'src-git small https://github.com/kenzok8/small' >>feeds.conf.default
echo 'src-git sundaqiang https://github.com/sundaqiang/openwrt-packages-backup' >>feeds.conf.default
#echo 'src-git kiddin9 https://github.com/kiddin9/openwrt-packages' >>feeds.conf.default


# Custom 
########### 更改大雕源码（可选）###########
# sed -i 's/KERNEL_PATCHVER:=5.15/KERNEL_PATCHVER:=6.1/g' target/linux/x86/Makefile


# 修改生成的固件名称include/image.mk
sed -i '/DTS_DIR:=$(LINUX_DIR)/a\BUILD_DATE_PREFIX:=$(shell date +%Y%m%d)' include/image.mk
sed -i '/IMG_PREFIX:=/s/^#\?/#/' include/image.mk
sed -i '/IMG_PREFIX_VERCODE:=/a\IMG_PREFIX:=wayos-$(BUILD_DATE_PREFIX)' include/image.mk 

# WAN LAN LAN LAN && NO V6
sed -i "/uci commit system/a uci commit network"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.lan.ifname='eth0 eth1 eth2 eth3'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.lan.dns='61.139.2.69 223.5.5.5'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.lan.gateway='10.1.12.1'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.wan.ifname='xeth0'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.wan6.ifname='xeth0'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set network.wan.proto='none'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci set dhcp.lan.ignore='1'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci delete network.wan6"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci delete network.lan.ip6assign"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit network/i uci delete network.globals.ula_prefix"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit system/a uci commit dhcp"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit dhcp/i uci delete dhcp.lan.ra"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit dhcp/i uci delete dhcp.lan.dhcpv6"  package/lean/default-settings/files/zzz-default-settings

# Modify default IP
#sed -i 's/192.168.1.1/192.168.50.5/g' package/base-files/files/bin/config_generate
#sed -i 's/255.255.0.0/255.255.255.0/g' package/base-files/files/bin/config_generate
sed -i 's/192.168.1.1/10.1.12.222/g' package/base-files/files/bin/config_generate

# DIAG
sed -i "/uci commit system/a uci commit diag"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit diag/i uci set luci.diag.dns='jd.com'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit diag/i uci set luci.diag.ping='jd.com'"  package/lean/default-settings/files/zzz-default-settings
sed -i "/uci commit diag/i uci set luci.diag.route='jd.com'"  package/lean/default-settings/files/zzz-default-settings

# 隐藏首页显示用户名(by:kokang)
# sed -i 's/name="luci_username" value="<%=duser%>"/name="luci_username"/g' feeds/luci/modules/luci-base/luasrc/view/sysauth.htm
# sed -i 's/name="luci_username" value="<%=duser%>"/name="luci_username"/g' feeds/kenzo/luci-theme-argone/luasrc/view/themes/argonne/sysauth.htm
# 移动光标至第一格(by:kokang)
# sed -i "s/'luci_password'/'luci_username'/g" feeds/luci/modules/luci-base/luasrc/view/sysauth.htm
# sed -i "s/'luci_password'/'luci_username'/g" feeds/kenzo/luci-theme-argonne/luasrc/view/themes/argone/sysauth.htm

# REMOVE OPKG
sed -i "/exit 0/i sed -i \"\/kenzo\/d\" \/etc\/opkg\/distfeeds.conf"  package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i sed -i \"\/small\/d\" \/etc\/opkg\/distfeeds.conf"  package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i sed -i \"\/passwall\/d\" \/etc\/opkg\/distfeeds.conf"  package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i sed -i \"\/sundaqiang\/d\" \/etc\/opkg\/distfeeds.conf"  package/lean/default-settings/files/zzz-default-settings
sed -i "/exit 0/i sed -i \"\/kiddin9\/d\" \/etc\/opkg\/distfeeds.conf"  package/lean/default-settings/files/zzz-default-settings

# Modify system
sed -i 's/OpenWrt/Way/g' package/base-files/files/bin/config_generate
sed -i 's/UTC/CST-8/g' package/base-files/files/bin/config_generate
sed -i "/uci commit/a uci commit system"  package/base-files/files/bin/config_generate
sed -i "/uci commit/a uci commit luci"  package/base-files/files/bin/config_generate
sed -i "/uci commit system/i uci set system.@system[0].timezone=CST-8"  package/base-files/files/bin/config_generate
sed -i "/uci commit system/i uci set system.system.zonename=Asia/\Shanghai"  package/base-files/files/bin/config_generate
sed -i "/uci commit luci/i uci set luci.main.lang=zh_cn"  package/base-files/files/bin/config_generate

# Banner
# Refer https://github.com/unifreq/openwrt_packit/blob/master/public_funcs
#rm -rf package/base-files/files/etc/banner
# 插入信息到 banner
# 在 cat >> .config <<EOF 到 EOF 之间粘贴你的编译配置, 需注意缩进关系
cat >> files/banner <<EOF
-----------------------------------------------------
 PACKAGE:     $OMR_DIST
 VERSION:     $(git -C "$OMR_FEED" tag --sort=committerdate | tail -1)
 TARGET:      $OMR_TARGET
 ARCH:        $OMR_REAL_TARGET 
 BUILD REPO:  $(git config --get remote.origin.url)
 BUILD DATE:  $(date -u)
-----------------------------------------------------
EOF

mv -f files/banner package/base-files/files/etc/banner >/dev/null 2>&1
mkdir -p package/base-files/files/etc/profile.d/
mv -f assets/30-sysinfo.sh package/base-files/files/etc/profile.d/30-sysinfo.sh >/dev/null 2>&1

# UDPXY
# sed -i "/uci commit system/a uci commit udpxy"  package/lean/default-settings/files/zzz-default-settings
# sed -i "/uci commit udpxy/i uci set udpxy.@udpxy[0].mcsub_renew='55'"  package/lean/default-settings/files/zzz-default-settings

# Bash
# sed -i "s/\/bin\/ash/\/bin\/bash/" package/base-files/files/etc/passwd >/dev/null 2>&1
# sed -i "s/\/bin\/ash/\/bin\/bash/" package/base-files/files/usr/libexec/login.sh >/dev/null 2>&1

# SSH open to all
sed -i '/option Interface/s/^#\?/#/'  package/network/services/dropbear/files/dropbear.config

# Set DISTRIB_REVISION
sed -i "s/OpenWrt /Way Build $(TZ=UTC-8 date "+%Y.%m.%d") @ OpenWrt /g" package/lean/default-settings/files/zzz-default-settings

# OPKG
#sed -i 's#mirrors.cloud.tencent.com/lede#mirrors.tuna.tsinghua.edu.cn/openwrt#g' package/lean/default-settings/files/zzz-default-settings
#sed -i 's/x86_64/x86\/64/' /etc/opkg/distfeeds.conf

# 默认执行的UCI命令，可以修改下面的
#cat >files/etc/uci-defaults/change_ip << EOF
#uci set network.lan=interface
#uci set network.lan.device='br-lan'
#uci set network.lan.proto='static'
#uci set network.lan.ipaddr='10.10.10.1'
#uci set network.lan.netmask='255.255.255.0'
#uci set network.lan.ip6assign='60'
#uci commit
#EOF

# TTYD AS ROOT AND OPENPORT
sed -i "/uci commit system/a uci commit ttyd"  package/base-files/files/bin/config_generate
#sed -i "/uci commit ttyd/i uci set ttyd.@ttyd[0].command='/bin/login -f root'"  package/base-files/files/bin/config_generate
sed -i "/uci commit ttyd/i uci set ttyd.@ttyd[0].interface='@lan @wan'"  package/base-files/files/bin/config_generate


# FW
sed -i "/uci commit luci/a uci commit firewall"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web=rule"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web.target='ACCEPT'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web.src='wan'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web.proto='tcp'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web.name='HTTP'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.web.dest_port='80'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh=rule"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh.target='ACCEPT'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh.src='wan'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh.proto='tcp'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh.dest_port='22'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ssh.name='SSH'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd=rule"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.target='ACCEPT'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.src='wan'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.proto='tcp'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.dest_port='7681'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.name='TTYD'"  package/base-files/files/bin/config_generate
sed -i "/uci commit firewall/i uci set firewall.ttyd.enabled='0'"  package/base-files/files/bin/config_generate

# TTYD FW
#sed -i "/uci commit firewall/i uci set firewall.redirect=redirect"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.target='DNAT'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.src='wan'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.dest='lan'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.proto='tcp'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.src_dport='7681'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.dest_ip='10.0.0.1'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.dest_port='7681'"  package/base-files/files/bin/config_generate
#sed -i "/uci commit firewall/i uci set firewall.redirect.name='TTYD'"  package/base-files/files/bin/config_generate


# FW 2
#sed -i "/exit 0/i \/etc\/init.d\/firewall reload"  package/base-files/files/etc/rc.local
#sed -i "/\/etc\/init.d\/firewall reload/i uci commit firewall"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web=rule"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web.target='ACCEPT'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web.src='wan'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web.proto='tcp'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web.name='HTTP'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.web.dest_port='80'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh=rule"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh.target='ACCEPT'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh.src='wan'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh.proto='tcp'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh.dest_port='22'"  package/base-files/files/etc/rc.local
#sed -i "/uci commit firewall/i uci set firewall.ssh.name='SSH'"  package/base-files/files/etc/rc.local

# 修改DHCP
sed -i 's/100/11/g' package/network/services/dnsmasq/files/dhcp.conf
sed -i 's/150/250/g' package/network/services/dnsmasq/files/dhcp.conf

#修正连接数（by ベ七秒鱼ベ）
#sed -i '/customized in this file/a net.netfilter.nf_conntrack_max=165535' package/base-files/files/etc/sysctl.conf

# Set default theme to luci-theme-argon
#uci set luci.main.mediaurlbase='/luci-static/argon'

# Disable IPV6 ula prefix
#sed -i 's/^[^#].*option ula/#&/' /etc/config/network

# Password
# sed -i '/shadow/s/^#\?/# /' package/lean/default-settings/files/zzz-default-settings
sed -i '/shadow/d' package/lean/default-settings/files/zzz-default-settings
sed -i 's/root::0:0:99999:7:::/root:$1$P4yrmMQf$XRoELeUToXNeituE0pl22.:19131:0:99999:7:::/g' package/base-files/files/etc/shadow
sed -i 's/root:::0:99999:7:::/root:$1$P4yrmMQf$XRoELeUToXNeituE0pl22.:19131:0:99999:7:::/g' package/base-files/files/etc/shadow


# 设置密码为空
#sed -i "/CYXluq4wUazHjmCDBCqXF/d" package/lean/default-settings/files/zzz-default-settings
#sed -i 's/root:$1$V4UetPzk$CYXluq4wUazHjmCDBCqXF.:0:0:99999:7:::/root:$1$rOlqcfTl$sQ03k9uRqA\/xTm7pzAmSs1:19130:0:99999:7:::/g' package/lean/default-settings/files/zzz-default-settings 
