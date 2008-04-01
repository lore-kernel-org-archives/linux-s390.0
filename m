From: Ursula Braun <braunu@de.ibm.com>
Subject: [patch 0/3] iucv / af_iucv patches for net-2.6.26
Date: Tue, 01 Apr 2008 15:45:21 +0200
Message-ID: <20080401134521.169525000@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net, netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

-- 
Dave,

the following 3 patches are intended for 2.6.26.
They are built against git/davem/net-2.6.26.
They contain:
af_iucv: usage of newer non-deprecated __RW_LOCK_UNLOCKED macro
iucv:    get rid of in_atomic() use
iucv:    delay bus registration until core is ready

Regards, Ursula
