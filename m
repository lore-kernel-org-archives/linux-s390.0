From: Julian Wiedmann <jwi@linux.vnet.ibm.com>
Subject: [PATCH net 1/4] s390/qeth: apply takeover changes when mode is toggled
Date: Wed, 13 Dec 2017 18:56:29 +0100
Message-ID: <20171213175632.100561-2-jwi@linux.vnet.ibm.com>
References: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20171213175632.100561-1-jwi@linux.vnet.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.vnet.ibm.com>, Ursula Braun <ubraun@linux.vnet.ibm.com>, Julian Wiedmann <jwi@linux.vnet.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Just as for an explicit enable/disable, toggling the takeover mode also
requires that the IP addresses get updated. Otherwise all IPs that were
added to the table before the mode-toggle, get registered with the old
settings.

Signed-off-by: Julian Wiedmann <jwi@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c |  2 +-
 drivers/s390/net/qeth_l3_sys.c    | 35 +++++++++++++++++------------------
 3 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 15015a24f8ad..51c618d9fefe 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -565,7 +565,7 @@ enum qeth_cq {
 };
 
 struct qeth_ipato {
-	int enabled;
+	bool enabled;
 	int invert4;
 	int invert6;
 	struct list_head entries;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 430e3214f7e2..8d18675e60e2 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -1480,7 +1480,7 @@ static int qeth_setup_card(struct qeth_card *card)
 	qeth_set_intial_options(card);
 	/* IP address takeover */
 	INIT_LIST_HEAD(&card->ipato.entries);
-	card->ipato.enabled = 0;
+	card->ipato.enabled = false;
 	card->ipato.invert4 = 0;
 	card->ipato.invert6 = 0;
 	/* init QDIO stuff */
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index bd12fdf678be..198717f71b3d 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -372,6 +372,7 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 	struct qeth_card *card = dev_get_drvdata(dev);
 	struct qeth_ipaddr *addr;
 	int i, rc = 0;
+	bool enable;
 
 	if (!card)
 		return -EINVAL;
@@ -384,25 +385,23 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 	}
 
 	if (sysfs_streq(buf, "toggle")) {
-		card->ipato.enabled = (card->ipato.enabled)? 0 : 1;
-	} else if (sysfs_streq(buf, "1")) {
-		card->ipato.enabled = 1;
-		hash_for_each(card->ip_htable, i, addr, hnode) {
-				if ((addr->type == QETH_IP_TYPE_NORMAL) &&
-				qeth_l3_is_addr_covered_by_ipato(card, addr))
-					addr->set_flags |=
-					QETH_IPA_SETIP_TAKEOVER_FLAG;
-			}
-	} else if (sysfs_streq(buf, "0")) {
-		card->ipato.enabled = 0;
-		hash_for_each(card->ip_htable, i, addr, hnode) {
-			if (addr->set_flags &
-			QETH_IPA_SETIP_TAKEOVER_FLAG)
-				addr->set_flags &=
-				~QETH_IPA_SETIP_TAKEOVER_FLAG;
-			}
-	} else
+		enable = !card->ipato.enabled;
+	} else if (kstrtobool(buf, &enable)) {
 		rc = -EINVAL;
+		goto out;
+	}
+
+	if (card->ipato.enabled == enable)
+		goto out;
+	card->ipato.enabled = enable;
+
+	hash_for_each(card->ip_htable, i, addr, hnode) {
+		if (!enable)
+			addr->set_flags &= ~QETH_IPA_SETIP_TAKEOVER_FLAG;
+		else if (addr->type == QETH_IP_TYPE_NORMAL &&
+			 qeth_l3_is_addr_covered_by_ipato(card, addr))
+			addr->set_flags |= QETH_IPA_SETIP_TAKEOVER_FLAG;
+	}
 out:
 	mutex_unlock(&card->conf_mutex);
 	return rc ? rc : count;
-- 
2.13.5
