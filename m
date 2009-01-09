From: frank.blaschka@de.ibm.com
Subject: [patch 0/5] [resend]s390: net drivers convert to net_device_ops
Date: Fri, 09 Jan 2009 14:43:55 +0100
Message-ID: <20090109134355.784732000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here are the remaining (fixed) net_device_ops patches for s390
net drivers

lcs: convert to net_device_ops
ctcm: convert to net_device_ops
netiucv: convert to net_device_ops
claw: convert to net_device_ops
qeth: fix usage of netdev_ops

Thanks,
        Frank

-- 
