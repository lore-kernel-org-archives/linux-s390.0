Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Joe Perches <joe@perches.com>
Subject: [PATCH 12/18] drivers: s390: Move static and inline before return type
Date: Wed,  5 Jul 2017 13:02:21 -0700
Message-Id: <3f980cd89084ae09716353aba3171e4b3815e690.1499284835.git.joe@perches.com>
In-Reply-To: <cover.1499284835.git.joe@perches.com>
References: <cover.1499284835.git.joe@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, Julian Wiedmann <jwi@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>
Cc: Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

Make the code like the rest of the kernel.

Signed-off-by: Joe Perches <joe@perches.com>
---
 drivers/s390/net/ctcm_main.c    | 2 +-
 drivers/s390/net/qeth_l3_main.c | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/ctcm_main.c b/drivers/s390/net/ctcm_main.c
index 1563b1458e44..2ade6131a89f 100644
--- a/drivers/s390/net/ctcm_main.c
+++ b/drivers/s390/net/ctcm_main.c
@@ -1115,7 +1115,7 @@ static const struct net_device_ops ctcm_mpc_netdev_ops = {
 	.ndo_start_xmit		= ctcmpc_tx,
 };
 
-void static ctcm_dev_setup(struct net_device *dev)
+static void ctcm_dev_setup(struct net_device *dev)
 {
 	dev->type = ARPHRD_SLIP;
 	dev->tx_queue_len = 100;
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 3062cde33a3d..8975cd321390 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2408,7 +2408,7 @@ static int qeth_l3_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 	return rc;
 }
 
-int inline qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
+inline int qeth_l3_get_cast_type(struct qeth_card *card, struct sk_buff *skb)
 {
 	int cast_type = RTN_UNSPEC;
 	struct neighbour *n = NULL;
-- 
2.10.0.rc2.1.g053435c
