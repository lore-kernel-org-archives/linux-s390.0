From: frank.blaschka@de.ibm.com
Subject: [patch 3/9] [PATCH] qeth: add owner to ccw driver
Date: Thu, 12 May 2011 07:43:21 +0200
Message-ID: <20110512054415.651601073@de.ibm.com>
References: <20110512054318.241733700@de.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
Content-Disposition: inline; filename=602-qeth-add-ccw-driver-owner.diff
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Sebastian Ott <sebott@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Sebastian Ott <sebott@linux.vnet.ibm.com>

Fill in the owner of qeth's ccw device driver.

Signed-off-by: Sebastian Ott <sebott@linux.vnet.ibm.com>
Signed-off-by: Frank Blaschka <frank.blaschka@de.ibm.com>
---


 drivers/s390/net/qeth_core_main.c |    1 +
 1 file changed, 1 insertion(+)
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -4041,6 +4041,7 @@ MODULE_DEVICE_TABLE(ccw, qeth_ids);
 
 static struct ccw_driver qeth_ccw_driver = {
 	.driver = {
+		.owner = THIS_MODULE,
 		.name = "qeth",
 	},
 	.ids = qeth_ids,
