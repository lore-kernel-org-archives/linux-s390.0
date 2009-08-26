From: frank.blaschka@de.ibm.com
Subject: [patch 5/5] [PATCH] qeth: display "undefined" value of sysfs-attribute "layer2"
Date: Wed, 26 Aug 2009 14:01:10 +0200
Message-ID: <20090826120136.512410000@de.ibm.com>
References: <20090826120105.727838000@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=612-qeth-layer2-attribute.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Ursula Braun <ursula.braun@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

If nothing has been written into the qeth sysfs-attribute layer2,
its value is "-1" meaning "not yet defined". But the value is
displayed as "1" meaning "layer2 selected". The patch changes the
reading of this "-1"-value to "-1" to make clear the layer2-attribute
has not yet been defined.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---

 drivers/s390/net/qeth_core_sys.c |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

Index: git_net-next/drivers/s390/net/qeth_core_sys.c
===================================================================
--- git_net-next.orig/drivers/s390/net/qeth_core_sys.c
+++ git_net-next/drivers/s390/net/qeth_core_sys.c
@@ -364,7 +364,7 @@ static ssize_t qeth_dev_layer2_show(stru
 	if (!card)
 		return -EINVAL;
 
-	return sprintf(buf, "%i\n", card->options.layer2 ? 1:0);
+	return sprintf(buf, "%i\n", card->options.layer2);
 }
 
 static ssize_t qeth_dev_layer2_store(struct device *dev,
