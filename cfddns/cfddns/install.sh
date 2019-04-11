#!/bin/sh
export KSROOT=/koolshare
source $KSROOT/scripts/base.sh

find /koolshare/init.d/ -name "*cfddns*" | xargs rm -rf

cp -rf /tmp/cfddns/scripts/* /koolshare/scripts/
cp -rf /tmp/cfddns/webs/* /koolshare/webs/
cp -rf /tmp/cfddns/res/* /koolshare/res/
cp -rf /tmp/cfddns/uninstall.sh /koolshare/scripts/uninstall_cfddns.sh
if [ "`nvram get model`" == "GT-AC5300" ] || [ -n "`nvram get extendno | grep koolshare`" -a "`nvram get productid`" == "RT-AC86U" ];then
	cp -rf /tmp/cfddns/GT-AC5300/webs/* /koolshare/webs/
fi
rm -rf /tmp/cfddns* >/dev/null 2>&1
chmod +x /koolshare/scripts/cfddns*.sh
chmod +x /koolshare/scripts/uninstall_cfddns.sh
[ ! -L "/koolshare/init.d/S99cfddns.sh" ] && ln -sf /koolshare/scripts/cfddns_config.sh /koolshare/init.d/S99cfddns.sh

#离线安装用
dbus set cfddns_version="1.0"
dbus set softcenter_module_cfddns_version="1.0"
dbus set softcenter_module_cfddns_description="CloudFlare DDNS"
dbus set softcenter_module_cfddns_install="1"
dbus set softcenter_module_cfddns_name="cfddns"
dbus set softcenter_module_cfddns_title="CloudFlare DDNS"

