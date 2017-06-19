From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/4] s390/qeth: use diag26c to get MAC address on L2
Date: Mon, 19 Jun 2017 13:22:25 +0200
Message-ID: <20170619112225.30471-5-jwi@linux.vnet.ibm.com>
References: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20170619112225.30471-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

When a s390 guest runs on a z/VM host that's part of a SSI cluster,
it can be migrated to a different host. In this case, the MAC address
it originally obtained on the old host may be re-assigned to a new
guest. This would result in address conflicts between the two guests.

When running as z/VM guest, use the diag26c MAC Service to obtain
a hypervisor-managed MAC address. The MAC Service is SSI-aware, and
won't re-assign the address after the guest is migrated to a new host.

This patch adds support for the z/VM MAC Service on L2 devices.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Acked-by: Ursula Braun <ubraun@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  1 +
 drivers/s390/net/qeth_core_main.c | 61 +++++++++++++++++++++++++++++++++++++++
 drivers/s390/net/qeth_l2_main.c   | 16 ++++++++--
 3 files changed, 76 insertions(+), 2 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 0efc54a4d82f..7a0ffc71b25d 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -986,6 +986,7 @@ struct qeth_cmd_buffer *qeth_get_setassparms_cmd(struct qeth_card *,
 int qeth_set_features(struct net_device *, netdev_features_t);
 int qeth_recover_features(struct net_device *);
 netdev_features_t qeth_fix_features(struct net_device *, netdev_features_t);
+int qeth_vm_request_mac(struct qeth_card *card);
 
 /* exports for OSN */
 int qeth_osn_assist(struct net_device *, void *, int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 13a55f1dee7a..1d062f086744 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -27,6 +27,9 @@
 #include <asm/io.h>
 #include <asm/sysinfo.h>
 #include <asm/compat.h>
+#include <asm/diag.h>
+#include <asm/cio.h>
+#include <asm/ccwdev.h>
 
 #include "qeth_core.h"
 
@@ -4773,6 +4776,64 @@ static int qeth_query_card_info(struct qeth_card *card,
 					(void *)carrier_info);
 }
 
+/**
+ * qeth_vm_request_mac() - Request a hypervisor-managed MAC address
+ * @card: pointer to a qeth_card
+ *
+ * Returns
+ *	0, if a MAC address has been set for the card's netdevice
+ *	a return code, for various error conditions
+ */
+int qeth_vm_request_mac(struct qeth_card *card)
+{
+	struct diag26c_mac_req *request;
+	struct diag26c_mac_resp *response;
+	struct ccw_dev_id id;
+	int rc;
+
+	QETH_DBF_TEXT(SETUP, 2, "vmreqmac");
+
+	if (!card->dev)
+		return -ENODEV;
+
+	request = kzalloc(sizeof(*request), GFP_KERNEL | GFP_DMA);
+	response = kzalloc(sizeof(*response), GFP_KERNEL | GFP_DMA);
+	if (!request || !response) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ccw_device_get_id(CARD_DDEV(card), &id);
+	request->resp_buf_len = sizeof(*response);
+	request->resp_version = DIAG26C_VERSION2;
+	request->op_code = DIAG26C_GET_MAC;
+	request->devno = id.devno;
+
+	rc = diag26c(request, response, DIAG26C_MAC_SERVICES);
+	if (rc)
+		goto out;
+
+	if ((request->resp_buf_len < sizeof(*response)) ||
+	    (response->version != request->resp_version)) {
+		rc = -EIO;
+		QETH_DBF_TEXT(SETUP, 2, "badresp");
+		QETH_DBF_HEX(SETUP, 2, &request->resp_buf_len,
+			     sizeof(request->resp_buf_len));
+	} else if (!is_valid_ether_addr(response->mac)) {
+		rc = -EINVAL;
+		QETH_DBF_TEXT(SETUP, 2, "badmac");
+		QETH_DBF_HEX(SETUP, 2, response->mac, ETH_ALEN);
+	} else {
+		ether_addr_copy(card->dev->dev_addr, response->mac);
+	}
+
+out:
+	kfree(response);
+	kfree(request);
+	return rc;
+}
+EXPORT_SYMBOL_GPL(qeth_vm_request_mac);
+
 static inline int qeth_get_qdio_q_format(struct qeth_card *card)
 {
 	if (card->info.type == QETH_CARD_TYPE_IQD)
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 9e7f12aba55e..ad110abfdd47 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -21,6 +21,7 @@
 #include <linux/hash.h>
 #include <linux/hashtable.h>
 #include <linux/string.h>
+#include <asm/setup.h>
 #include "qeth_core.h"
 #include "qeth_l2.h"
 
@@ -505,9 +506,19 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 	int rc = 0;
 	char vendor_pre[] = {0x02, 0x00, 0x00};
 
-	QETH_DBF_TEXT(SETUP, 2, "doL2init");
+	QETH_DBF_TEXT(SETUP, 2, "l2reqmac");
 	QETH_DBF_TEXT_(SETUP, 2, "doL2%s", CARD_BUS_ID(card));
 
+	if (MACHINE_IS_VM) {
+		rc = qeth_vm_request_mac(card);
+		if (!rc)
+			goto out;
+		QETH_DBF_MESSAGE(2, "z/VM MAC Service failed on device %s: x%x\n",
+				 CARD_BUS_ID(card), rc);
+		QETH_DBF_TEXT_(SETUP, 2, "err%04x", rc);
+		/* fall back to alternative mechanism: */
+	}
+
 	if (qeth_is_supported(card, IPA_SETADAPTERPARMS)) {
 		rc = qeth_query_setadapterparms(card);
 		if (rc) {
@@ -528,11 +539,12 @@ static int qeth_l2_request_initial_mac(struct qeth_card *card)
 			QETH_DBF_TEXT_(SETUP, 2, "1err%04x", rc);
 			return rc;
 		}
-		QETH_DBF_HEX(SETUP, 2, card->dev->dev_addr, OSA_ADDR_LEN);
 	} else {
 		eth_random_addr(card->dev->dev_addr);
 		memcpy(card->dev->dev_addr, vendor_pre, 3);
 	}
+out:
+	QETH_DBF_HEX(SETUP, 2, card->dev->dev_addr, card->dev->addr_len);
 	return 0;
 }
 
-- 
2.11.2
