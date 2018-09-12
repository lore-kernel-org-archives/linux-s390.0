From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/4] s390/qeth: indicate error when netdev allocation fails
Date: Wed, 12 Sep 2018 15:31:32 +0200
Message-ID: <20180912133135.12335-2-jwi@linux.ibm.com>
References: <20180912133135.12335-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20180912133135.12335-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Bailing out on allocation error is nice, but we also need to tell the
ccwgroup core that creating the qeth groupdev failed.

Fixes: d3d1b205e89f ("s390/qeth: allocate netdevice early")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 49f64eb3eab0..6b24face21d5 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -5768,8 +5768,10 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	qeth_update_from_chp_desc(card);
 
 	card->dev = qeth_alloc_netdev(card);
-	if (!card->dev)
+	if (!card->dev) {
+		rc = -ENOMEM;
 		goto err_card;
+	}
 
 	qeth_determine_capabilities(card);
 	enforced_disc = qeth_enforce_discipline(card);
-- 
2.16.4
