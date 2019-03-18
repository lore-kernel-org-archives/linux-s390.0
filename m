Return-Path: <SRS0=pZ4W=RV=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 1/3] s390/qeth: don't erase configuration while probing
Date: Mon, 18 Mar 2019 16:40:54 +0100
In-Reply-To: <20190318154056.4231-1-jwi@linux.ibm.com>
References: <20190318154056.4231-1-jwi@linux.ibm.com>
Message-Id: <20190318154056.4231-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The HW trap and VNICC configuration is exposed via sysfs, and may have
already been modified when qeth_l?_probe_device() attempts to initialize
them. So (1) initialize the VNICC values a little earlier, and (2) don't
bother about the HW trap mode, it was already initialized before.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l2_main.c | 4 ++--
 drivers/s390/net/qeth_l3_main.c | 1 -
 2 files changed, 2 insertions(+), 3 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8efb2e8ff8f4..3bfdd8545776 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -645,6 +645,8 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc;
 
+	qeth_l2_vnicc_set_defaults(card);
+
 	if (gdev->dev.type == &qeth_generic_devtype) {
 		rc = qeth_l2_create_device_attributes(&gdev->dev);
 		if (rc)
@@ -652,8 +654,6 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	}
 
 	hash_init(card->mac_htable);
-	card->info.hwtrap = 0;
-	qeth_l2_vnicc_set_defaults(card);
 	return 0;
 }
 
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 7e68d9d16859..2f002843b16e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2260,7 +2260,6 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	}
 	hash_init(card->ip_htable);
 	hash_init(card->ip_mc_htable);
-	card->info.hwtrap = 0;
 	return 0;
 }
 
-- 
2.16.4
