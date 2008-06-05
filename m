From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/3] iucv / af_iucv patches for net-2.6.26
Date: Thu, 05 Jun 2008 11:08:37 +0200
Message-ID: <20080605090837.212105000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

the following 3 small patches are intended for 2.6.26.
They are built against git/davem/net-2.6.26
They contain:
iucv:    remove WARNING              (from Heiko Carstens)
iucv:    cpu hotplug fix             (from Heiko Carstens)
af_iucv: exploit message class field (from Ursula Braun)

Regards, Ursula
