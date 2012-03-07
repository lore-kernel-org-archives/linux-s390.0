From: frank.blaschka@de.ibm.com
Subject: [patch 0/7] s390: network driver fixes for net-next
Date: Wed, 07 Mar 2012 13:06:22 +0100
Message-ID: <20120307120622.922387262@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Hi Dave,

here is a couple of s390 network driver fixes for net-next

shortlog:

Ursula Braun (4)
af_iucv: handle netdev events
af_iucv: add shutdown for HS transport
ctcm: make ctcmpc debugging compilable
qeth: meaningful return code for set_mac_address

Frank Blaschka (1)
qeth: synchronize discipline module loading

Belinda Thompson(1)
ctcm: use correct idal word list for ctcmpc

Klaus-Dieter Wacker (1)
lcs: Return zero from ccwgroup devs set_offline function

Thanks,
        Frank
