From: Lakhvich Dmitriy <Ldmitriy@ru.ibm.com>
Date: Wed, 22 Jun 2016 16:07:27 +0000
Subject: [PATCH] qeth: autodetect layer2/3 of z/VM VSWITCH/GUESTLAN
Message-Id: <1466611647-4065-2-git-send-email-Ldmitriy@ru.ibm.com>
To: linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

From: Lakhvich Dmitriy <LDmitriy@ru.ibm.com>

If the NIC belongs to a z/VM VSWITCH/GUESTLAN, detect in which layer
the VSWITCH/GUESTLAN is configured with CP command, and enforce this
layer on the net device.

Signed-off-by: Lakhvich Dmitriy <ldmitriy@ru.ibm.com>
Reviewed-by: Eugene Crosser <Eugene.Crosser@ru.ibm.com>
Reviewed-by: Ursula Braun <ursula.braun@de.ibm.com>
Reviewed-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
---
 drivers/s390/net/qeth_core_main.c | 104 +++++++++++++++++++++++++++++++++++---
 drivers/s390/net/qeth_core_sys.c  |   6 +++
 2 files changed, 102 insertions(+), 8 deletions(-)

diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 10b3a59..72799df 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -27,6 +27,7 @@
 #include <asm/io.h>
 #include <asm/sysinfo.h>
 #include <asm/compat.h>
+#include <asm/cpcmd.h>
 
 #include "qeth_core.h"
 
@@ -1724,6 +1725,87 @@ static void qeth_configure_unitaddr(struct qeth_card *card, char *prcd)
 			       (prcd[0x11] == _ascebc['M']));
 }
 
+/* Define which line discipline is enforced by the underlying hardware,
+* or not enforced.
+*/
+enum qeth_disc_enforcement {
+	ENFORCE_NONE = -1,
+	ENFORCE_L2 = QETH_DISCIPLINE_LAYER2,
+	ENFORCE_L3 = QETH_DISCIPLINE_LAYER3,
+};
+
+enum qeth_disc_enforcement
+qeth_detect_enforced_discipline(struct qeth_card *card)
+{
+	char cmd[128];
+	char response[200];
+	char *vswitch_or_lan, *ownerid, *vswitch_name;
+	char *token_stop;
+	char *is_ethernet;
+	struct ccw_dev_id id;
+	int is_guestlan = 0;
+	enum qeth_disc_enforcement rc = ENFORCE_NONE;
+
+	if (card->info.type == QETH_CARD_TYPE_IQD)
+		return ENFORCE_L3;
+
+	memset(cmd, 0, sizeof(cmd));
+	ccw_device_get_id(CARD_RDEV(card), &id);
+	snprintf(cmd, sizeof(cmd),
+		    "QUERY VIRTUAL NIC %04x", id.devno);
+
+	memset(response, 0, sizeof(response));
+	cpcmd(cmd, response,
+		   sizeof(response) - 1, NULL);
+
+	/* Response format:
+	 * Adapter xxxx.Pxx Type: QDIO      Name: Name      Devices: 3
+	 * MAC: xx-xx-xx-xx-xx-xx         VSWITCH: OWNER VSWITCHNAME
+	 */
+	vswitch_or_lan = strstr(response, "VSWITCH:");
+	if (!vswitch_or_lan) {
+		vswitch_or_lan = strstr(response, "LAN:");
+		if (!vswitch_or_lan)
+			goto out;
+		is_guestlan = 1;
+	}
+
+	ownerid = skip_spaces(strchr(vswitch_or_lan, ' '));
+	if (!ownerid)
+		goto out;
+
+	vswitch_name = strim(strchr(ownerid, ' '));
+	if (!vswitch_name)
+		goto out;
+
+	/* Attempt to parse correctly the situation
+	* when cp output format changed and some information
+	* is added after the name of lan/vswitch.
+	*/
+	token_stop = strchr(vswitch_name, '\n');
+	if (token_stop)
+		*token_stop = '\0';
+
+	if (!*vswitch_name)
+		goto out;
+
+	memset(cmd, 0, sizeof(cmd));
+	snprintf(cmd, sizeof(cmd), "QUERY %s %s",
+		 is_guestlan ? "LAN" : "VSWITCH", vswitch_name);
+
+	memset(response, 0, sizeof(response));
+	cpcmd(cmd, response,
+		   sizeof(response) - 1, NULL);
+	is_ethernet = strstr(response, "ETHERNET");
+	if (is_ethernet)
+		rc = ENFORCE_L2;
+	else
+		rc = ENFORCE_L3;
+
+out:
+	return rc;
+}
+
 static void qeth_configure_blkt_default(struct qeth_card *card, char *prcd)
 {
 	QETH_DBF_TEXT(SETUP, 2, "cfgblkt");
@@ -5543,6 +5625,7 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card;
 	struct device *dev;
 	int rc;
+	enum qeth_disc_enforcement enforced;
 	unsigned long flags;
 	char dbf_name[DBF_NAME_LEN];
 
@@ -5590,31 +5673,36 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		goto err_card;
 	}
 
+	qeth_determine_capabilities(card);
+
 	if (card->info.type == QETH_CARD_TYPE_OSN)
 		gdev->dev.type = &qeth_osn_devtype;
 	else
 		gdev->dev.type = &qeth_generic_devtype;
 
-	switch (card->info.type) {
-	case QETH_CARD_TYPE_OSN:
-	case QETH_CARD_TYPE_OSM:
+	if ((card->info.type == QETH_CARD_TYPE_OSN) ||
+	    (card->info.type == QETH_CARD_TYPE_OSM)) {
 		rc = qeth_core_load_discipline(card, QETH_DISCIPLINE_LAYER2);
 		if (rc)
 			goto err_card;
+
 		rc = card->discipline->setup(card->gdev);
 		if (rc)
 			goto err_disc;
-	case QETH_CARD_TYPE_OSD:
-	case QETH_CARD_TYPE_OSX:
-	default:
-		break;
+
+	} else if (card->info.guestlan) {
+		enforced = qeth_detect_enforced_discipline(card);
+		if (enforced != ENFORCE_NONE) {
+			rc = qeth_core_load_discipline(card, enforced);
+			if (rc)
+				goto err_card;
+		}
 	}
 
 	write_lock_irqsave(&qeth_core_card_list.rwlock, flags);
 	list_add_tail(&card->list, &qeth_core_card_list.list);
 	write_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
 
-	qeth_determine_capabilities(card);
 	return 0;
 
 err_disc:
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 75b29fd2..31cde3f 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -411,6 +411,12 @@ static ssize_t qeth_dev_layer2_store(struct device *dev,
 		goto out;
 	}
 
+	if (card->info.guestlan &&
+	    card->options.layer2 != -1) {
+		rc = -EOPNOTSUPP;
+		goto out;
+	}
+
 	if (card->options.layer2 == newdis)
 		goto out;
 	else {
-- 
2.5.0
