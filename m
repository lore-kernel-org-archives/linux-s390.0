Return-Path: <SRS0=pZ4W=RV=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net 2/3] s390/qeth: fix race when initializing the IP address table
Date: Mon, 18 Mar 2019 16:40:55 +0100
In-Reply-To: <20190318154056.4231-1-jwi@linux.ibm.com>
References: <20190318154056.4231-1-jwi@linux.ibm.com>
Message-Id: <20190318154056.4231-3-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The ucast IP table is utilized by some of the L3-specific sysfs attributes
that qeth_l3_create_device_attributes() provides. So initialize the table
_before_ registering the attributes.

Fixes: ebccc7397e4a ("s390/qeth: add missing hash table initializations")
Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 2f002843b16e..d805e72edb58 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2253,12 +2253,14 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc;
 
+	hash_init(card->ip_htable);
+
 	if (gdev->dev.type == &qeth_generic_devtype) {
 		rc = qeth_l3_create_device_attributes(&gdev->dev);
 		if (rc)
 			return rc;
 	}
-	hash_init(card->ip_htable);
+
 	hash_init(card->ip_mc_htable);
 	return 0;
 }
-- 
2.16.4
