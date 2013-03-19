From: frank.blaschka@de.ibm.com
Subject: [patch 1/3] qeth: delay feature trace
Date: Tue, 19 Mar 2013 07:04:42 +0100
Message-ID: <20130319060454.760259160@de.ibm.com>
References: <20130319060441.956271217@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=600-qeth-delay-trace.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Stefan Raspl <raspl@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Stefan Raspl <raspl@linux.vnet.ibm.com>

Delay tracing of the card features until the optional commands have been
enabled.

Signed-off-by: Stefan Raspl <raspl@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <blaschka@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_l3_main.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -3348,7 +3348,6 @@ static int __qeth_l3_set_online(struct c
 		rc = -ENODEV;
 		goto out_remove;
 	}
-	qeth_trace_features(card);
 
 	if (!card->dev && qeth_l3_setup_netdev(card)) {
 		rc = -ENODEV;
@@ -3425,6 +3424,7 @@ contin:
 		qeth_l3_set_multicast_list(card->dev);
 		rtnl_unlock();
 	}
+	qeth_trace_features(card);
 	/* let user_space know that device is online */
 	kobject_uevent(&gdev->dev.kobj, KOBJ_CHANGE);
 	mutex_unlock(&card->conf_mutex);
