From: Ursula Braun <ubraun@linux.vnet.ibm.com>
Subject: [PATCH net-next 3/8] qeth: remove locks from sysfs _show
Date: Mon, 18 May 2015 14:27:54 +0200
Message-ID: <1431952079-6847-4-git-send-email-ubraun@linux.vnet.ibm.com>
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

Locking is probably unnecessary in this case, and the rest of the
qeth sysfs code does not use locks in the *_show() functions.
Remove locks from the layer2 *_show() functions in which they where
accidentally introduced.

Signed-off-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
---
 drivers/s390/net/qeth_l2_sys.c | 8 --------
 1 file changed, 8 deletions(-)

diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 59e3aa5..6504d48 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -23,8 +23,6 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	mutex_lock(&card->conf_mutex);
-
 	if (qeth_card_hw_is_reachable(card) &&
 					card->options.sbp.supported_funcs)
 		rc = qeth_bridgeport_query_ports(card,
@@ -59,8 +57,6 @@ static ssize_t qeth_bridge_port_role_state_show(struct device *dev,
 			rc = sprintf(buf, "%s\n", word);
 	}
 
-	mutex_unlock(&card->conf_mutex);
-
 	return rc;
 }
 
@@ -123,12 +119,8 @@ static ssize_t qeth_bridgeport_hostnotification_show(struct device *dev,
 	if (!card)
 		return -EINVAL;
 
-	mutex_lock(&card->conf_mutex);
-
 	enabled = card->options.sbp.hostnotification;
 
-	mutex_unlock(&card->conf_mutex);
-
 	return sprintf(buf, "%d\n", enabled);
 }
 
-- 
2.3.7
