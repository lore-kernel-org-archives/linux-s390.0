From: Ursula Braun <ursula.braun@de.ibm.com>
Subject: [patch 0/2] s390: lcs and claw patches for linux-2.6.29-rc2
Date: Tue, 20 Jan 2009 17:14:31 +0100
Message-ID: <20090120161431.149552000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: jeff@garzik.org, netdev@vger.kernel.org, linux-s390@vger.kernel.org
Cc: schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

-- 
Jeff,

here are 2 patches for s390 network device drivers.
The patches apply to linux-2.6.29-rc2.

Heiko Carstens (1)
lcs:  fix compilation for !CONFIG_IP_MULTICAST

Andy Richter (1)
claw: convert claw printk messages to dev_xxx / pr_xxx macros

Thanks and kind regards,
Ursula Braun
