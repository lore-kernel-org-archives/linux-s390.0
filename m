From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net-next 4/4] s390/qeth: support early setup for z/VM NICs
Date: Wed, 27 Dec 2017 17:44:31 +0100
Message-ID: <20171227164431.17118-5-jwi@linux.vnet.ibm.com>
References: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171227164431.17118-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The transport mode that a z/VM NIC is configured in, must match the
hypervisor-internal network which the NIC is coupled to.

To get this right automatically, have qeth issue a diag26c hypervisor call
that provides all sorts of information for a specific VNIC.
With z/VM update VM65918, this also includes the VNIC's required
transport mode.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 86 +++++++++++++++++++++++++++++++++++----
 1 file changed, 77 insertions(+), 9 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index bdc28330800e..6abd3bc285e4 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -36,6 +36,7 @@
 #include <asm/diag.h>
 #include <asm/cio.h>
 #include <asm/ccwdev.h>
+#include <asm/cpcmd.h>
 
 #include "qeth_core.h"
 
@@ -1715,23 +1716,87 @@ static void qeth_configure_unitaddr(struct qeth_card *card, char *prcd)
 			       (prcd[0x11] == _ascebc['M']));
 }
 
+static enum qeth_discipline_id qeth_vm_detect_layer(struct qeth_card *card)
+{
+	enum qeth_discipline_id disc = QETH_DISCIPLINE_UNDETERMINED;
+	struct diag26c_vnic_resp *response = NULL;
+	struct diag26c_vnic_req *request = NULL;
+	struct ccw_dev_id id;
+	char userid[80];
+	int rc = 0;
+
+	QETH_DBF_TEXT(SETUP, 2, "vmlayer");
+
+	cpcmd("QUERY USERID", userid, sizeof(userid), &rc);
+	if (rc)
+		goto out;
+
+	request = kzalloc(sizeof(*request), GFP_KERNEL | GFP_DMA);
+	response = kzalloc(sizeof(*response), GFP_KERNEL | GFP_DMA);
+	if (!request || !response) {
+		rc = -ENOMEM;
+		goto out;
+	}
+
+	ccw_device_get_id(CARD_RDEV(card), &id);
+	request->resp_buf_len = sizeof(*response);
+	request->resp_version = DIAG26C_VERSION6_VM65918;
+	request->req_format = DIAG26C_VNIC_INFO;
+	ASCEBC(userid, 8);
+	memcpy(&request->sys_name, userid, 8);
+	request->devno = id.devno;
+
+	QETH_DBF_HEX(CTRL, 2, request, sizeof(*request));
+	rc = diag26c(request, response, DIAG26C_PORT_VNIC);
+	QETH_DBF_HEX(CTRL, 2, request, sizeof(*request));
+	if (rc)
+		goto out;
+	QETH_DBF_HEX(CTRL, 2, response, sizeof(*response));
+
+	if (request->resp_buf_len < sizeof(*response) ||
+	    response->version != request->resp_version) {
+		rc = -EIO;
+		goto out;
+	}
+
+	if (response->protocol == VNIC_INFO_PROT_L2)
+		disc = QETH_DISCIPLINE_LAYER2;
+	else if (response->protocol == VNIC_INFO_PROT_L3)
+		disc = QETH_DISCIPLINE_LAYER3;
+
+out:
+	kfree(response);
+	kfree(request);
+	if (rc)
+		QETH_DBF_TEXT_(SETUP, 2, "err%x", rc);
+	return disc;
+}
+
 /* Determine whether the device requires a specific layer discipline */
 static enum qeth_discipline_id qeth_enforce_discipline(struct qeth_card *card)
 {
+	enum qeth_discipline_id disc = QETH_DISCIPLINE_UNDETERMINED;
+
 	if (card->info.type == QETH_CARD_TYPE_OSM ||
-	    card->info.type == QETH_CARD_TYPE_OSN) {
+	    card->info.type == QETH_CARD_TYPE_OSN)
+		disc = QETH_DISCIPLINE_LAYER2;
+	else if (card->info.guestlan)
+		disc = (card->info.type == QETH_CARD_TYPE_IQD) ?
+				QETH_DISCIPLINE_LAYER3 :
+				qeth_vm_detect_layer(card);
+
+	switch (disc) {
+	case QETH_DISCIPLINE_LAYER2:
 		QETH_DBF_TEXT(SETUP, 3, "force l2");
-		return QETH_DISCIPLINE_LAYER2;
-	}
-
-	/* virtual HiperSocket is L3 only: */
-	if (card->info.guestlan && card->info.type == QETH_CARD_TYPE_IQD) {
+		break;
+	case QETH_DISCIPLINE_LAYER3:
 		QETH_DBF_TEXT(SETUP, 3, "force l3");
-		return QETH_DISCIPLINE_LAYER3;
+		break;
+	default:
+		QETH_DBF_TEXT(SETUP, 3, "force no");
 	}
 
-	QETH_DBF_TEXT(SETUP, 3, "force no");
-	return QETH_DISCIPLINE_UNDETERMINED;
+	return disc;
 }
 
 static void qeth_configure_blkt_default(struct qeth_card *card, char *prcd)
@@ -4786,9 +4851,12 @@ int qeth_vm_request_mac(struct qeth_card *card)
 	request->op_code = DIAG26C_GET_MAC;
 	request->devno = id.devno;
 
+	QETH_DBF_HEX(CTRL, 2, request, sizeof(*request));
 	rc = diag26c(request, response, DIAG26C_MAC_SERVICES);
+	QETH_DBF_HEX(CTRL, 2, request, sizeof(*request));
 	if (rc)
 		goto out;
+	QETH_DBF_HEX(CTRL, 2, response, sizeof(*response));
 
 	if (request->resp_buf_len < sizeof(*response) ||
 	    response->version != request->resp_version) {
-- 
2.13.5
