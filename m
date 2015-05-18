From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 6/8] qeth: BRIDGEPORT "sanity check"
Date: Mon, 18 May 2015 14:27:57 +0200
Message-ID: <1431952079-6847-7-git-send-email-ubraun@linux.vnet.ibm.com>
References: <1431952079-6847-1-git-send-email-ubraun@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <1431952079-6847-1-git-send-email-ubraun@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, ursula.braun@de.ibm.com, ubraun@linux.vnet.ibm.com, Eugene Crosser <Eugene.Crosser@ru.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Eugene Crosser <Eugene.Crosser@ru.ibm.com>

Forbid enabling IFF_PROMISC reflection to BRIDGEPORT when a role
is already assigned, and forbid direct manipulation of the role
when reflection mode is engaged.

Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_l2_sys.c | 16 ++++++++++++----
 1 file changed, 12 insertions(+), 4 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index a553fba..52673cd 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -86,7 +86,9 @@ static ssize_t qeth_bridge_port_role_store(struct device *dev,
 
 	mutex_lock(&card->conf_mutex);
 
-	if (qeth_card_hw_is_reachable(card)) {
+	if (card->options.sbp.reflect_promisc) /* Forbid direct manipulation */
+		rc = -EPERM;
+	else if (qeth_card_hw_is_reachable(card)) {
 		rc = qeth_bridgeport_setrole(card, role);
 		if (!rc)
 			card->options.sbp.role = role;
@@ -184,6 +186,7 @@ static ssize_t qeth_bridgeport_reflect_store(struct device *dev,
 {
 	struct qeth_card *card = dev_get_drvdata(dev);
 	int enable, primary;
+	int rc = 0;
 
 	if (!card)
 		return -EINVAL;
@@ -202,12 +205,17 @@ static ssize_t qeth_bridgeport_reflect_store(struct device *dev,
 
 	mutex_lock(&card->conf_mutex);
 
-	card->options.sbp.reflect_promisc = enable;
-	card->options.sbp.reflect_promisc_primary = primary;
+	if (card->options.sbp.role != QETH_SBP_ROLE_NONE)
+		rc = -EPERM;
+	else {
+		card->options.sbp.reflect_promisc = enable;
+		card->options.sbp.reflect_promisc_primary = primary;
+		rc = 0;
+	}
 
 	mutex_unlock(&card->conf_mutex);
 
-	return count;
+	return rc ? rc : count;
 }
 
 static DEVICE_ATTR(bridge_reflect_promisc, 0644,
-- 
2.3.7
