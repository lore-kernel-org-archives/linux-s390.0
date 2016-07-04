From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net 0/1] qeth: important fix to avoid panic on oops
Date: Mon,  4 Jul 2016 14:07:15 +0200
Message-ID: <1467634036-49548-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, stable@vger.kernel.org, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, utz.bacher@de.ibm.com
List-ID: <linux-s390.vger.kernel.org>

Dave,

here is an important qeth patch built for the net-tree fixing a qeth crash.

Thanks, Ursula

Ursula Braun (1):
  Subject: [PATCH] qeth: delete napi struct when removing a qeth device

 drivers/s390/net/qeth_l2_main.c | 1 +
 drivers/s390/net/qeth_l3_main.c | 1 +
 2 files changed, 2 insertions(+)

-- 
2.6.6
