Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:29622 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725802AbgLGNNZ (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 7 Dec 2020 08:13:25 -0500
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 3/6] s390/qeth: use dev->groups for common sysfs attributes
Date: Mon,  7 Dec 2020 14:12:30 +0100
Message-Id: <20201207131233.90383-4-jwi@linux.ibm.com>
In-Reply-To: <20201207131233.90383-1-jwi@linux.ibm.com>
References: <20201207131233.90383-1-jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>
To: David Miller <davem@davemloft.net>, Jakub Kicinski <kuba@kernel.org>
Cc: linux-netdev <netdev@vger.kernel.org>, linux-s390 <linux-s390@vger.kernel.org>, Heiko Carstens <hca@linux.ibm.com>, Karsten Graul <kgraul@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>

All qeth devices have a minimum set of sysfs attributes, and non-OSN
devices share a group of additional attributes. Depending on whether
the device is forced to use a specific discipline, the device_type then
specifies further attributes.

Shift the common attributes into dev->groups, so that the device_type
only contains the discipline-specific attributes. This avoids exposing
the common attributes to the disciplines, and nicely cleans up our
sysfs code.

While replacing the qeth_l*_*_device_attributes() helpers, switch from
sysfs_*_groups() to the more generic device_*_groups().

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  6 ++---
 drivers/s390/net/qeth_core_main.c |  7 ++++--
 drivers/s390/net/qeth_core_sys.c  | 41 ++++++++++++++-----------------
 drivers/s390/net/qeth_l2.h        |  2 --
 drivers/s390/net/qeth_l2_main.c   |  4 +--
 drivers/s390/net/qeth_l2_sys.c    | 19 --------------
 drivers/s390/net/qeth_l3.h        |  2 --
 drivers/s390/net/qeth_l3_main.c   |  4 +--
 drivers/s390/net/qeth_l3_sys.c    | 21 ----------------
 9 files changed, 30 insertions(+), 76 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index 69b474f8735e..d150da95d073 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -1063,10 +1063,8 @@ extern const struct qeth_discipline qeth_l2_discipline;
 extern const struct qeth_discipline qeth_l3_discipline;
 extern const struct ethtool_ops qeth_ethtool_ops;
 extern const struct ethtool_ops qeth_osn_ethtool_ops;
-extern const struct attribute_group *qeth_generic_attr_groups[];
-extern const struct attribute_group *qeth_osn_attr_groups[];
-extern const struct attribute_group qeth_device_attr_group;
-extern const struct attribute_group qeth_device_blkt_group;
+extern const struct attribute_group *qeth_dev_groups[];
+extern const struct attribute_group *qeth_osn_dev_groups[];
 extern const struct device_type qeth_generic_devtype;
 
 const char *qeth_get_cardname_short(struct qeth_card *);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 8171b9d3a70e..05d0b16bd7d6 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -6375,13 +6375,11 @@ void qeth_core_free_discipline(struct qeth_card *card)
 
 const struct device_type qeth_generic_devtype = {
 	.name = "qeth_generic",
-	.groups = qeth_generic_attr_groups,
 };
 EXPORT_SYMBOL_GPL(qeth_generic_devtype);
 
 static const struct device_type qeth_osn_devtype = {
 	.name = "qeth_osn",
-	.groups = qeth_osn_attr_groups,
 };
 
 #define DBF_NAME_LEN	20
@@ -6561,6 +6559,11 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 	if (rc)
 		goto err_chp_desc;
 
+	if (IS_OSN(card))
+		gdev->dev.groups = qeth_osn_dev_groups;
+	else
+		gdev->dev.groups = qeth_dev_groups;
+
 	enforced_disc = qeth_enforce_discipline(card);
 	switch (enforced_disc) {
 	case QETH_DISCIPLINE_UNDETERMINED:
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 4441b3393eaf..a0f777f76f66 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -640,23 +640,17 @@ static struct attribute *qeth_blkt_device_attrs[] = {
 	&dev_attr_inter_jumbo.attr,
 	NULL,
 };
-const struct attribute_group qeth_device_blkt_group = {
+
+static const struct attribute_group qeth_dev_blkt_group = {
 	.name = "blkt",
 	.attrs = qeth_blkt_device_attrs,
 };
-EXPORT_SYMBOL_GPL(qeth_device_blkt_group);
 
-static struct attribute *qeth_device_attrs[] = {
-	&dev_attr_state.attr,
-	&dev_attr_chpid.attr,
-	&dev_attr_if_name.attr,
-	&dev_attr_card_type.attr,
+static struct attribute *qeth_dev_extended_attrs[] = {
 	&dev_attr_inbuf_size.attr,
 	&dev_attr_portno.attr,
 	&dev_attr_portname.attr,
 	&dev_attr_priority_queueing.attr,
-	&dev_attr_buffer_count.attr,
-	&dev_attr_recover.attr,
 	&dev_attr_performance_stats.attr,
 	&dev_attr_layer2.attr,
 	&dev_attr_isolation.attr,
@@ -664,18 +658,12 @@ static struct attribute *qeth_device_attrs[] = {
 	&dev_attr_switch_attrs.attr,
 	NULL,
 };
-const struct attribute_group qeth_device_attr_group = {
-	.attrs = qeth_device_attrs,
-};
-EXPORT_SYMBOL_GPL(qeth_device_attr_group);
 
-const struct attribute_group *qeth_generic_attr_groups[] = {
-	&qeth_device_attr_group,
-	&qeth_device_blkt_group,
-	NULL,
+static const struct attribute_group qeth_dev_extended_group = {
+	.attrs = qeth_dev_extended_attrs,
 };
 
-static struct attribute *qeth_osn_device_attrs[] = {
+static struct attribute *qeth_dev_attrs[] = {
 	&dev_attr_state.attr,
 	&dev_attr_chpid.attr,
 	&dev_attr_if_name.attr,
@@ -684,10 +672,19 @@ static struct attribute *qeth_osn_device_attrs[] = {
 	&dev_attr_recover.attr,
 	NULL,
 };
-static struct attribute_group qeth_osn_device_attr_group = {
-	.attrs = qeth_osn_device_attrs,
+
+static const struct attribute_group qeth_dev_group = {
+	.attrs = qeth_dev_attrs,
 };
-const struct attribute_group *qeth_osn_attr_groups[] = {
-	&qeth_osn_device_attr_group,
+
+const struct attribute_group *qeth_osn_dev_groups[] = {
+	&qeth_dev_group,
+	NULL,
+};
+
+const struct attribute_group *qeth_dev_groups[] = {
+	&qeth_dev_group,
+	&qeth_dev_extended_group,
+	&qeth_dev_blkt_group,
 	NULL,
 };
diff --git a/drivers/s390/net/qeth_l2.h b/drivers/s390/net/qeth_l2.h
index 296d73d84326..7c646e2fed7e 100644
--- a/drivers/s390/net/qeth_l2.h
+++ b/drivers/s390/net/qeth_l2.h
@@ -11,8 +11,6 @@
 
 extern const struct attribute_group *qeth_l2_attr_groups[];
 
-int qeth_l2_create_device_attributes(struct device *);
-void qeth_l2_remove_device_attributes(struct device *);
 int qeth_bridgeport_query_ports(struct qeth_card *card,
 				enum qeth_sbp_roles *role,
 				enum qeth_sbp_states *state);
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 393aef681e44..4ed0fb0705a5 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -2189,7 +2189,7 @@ static int qeth_l2_probe_device(struct ccwgroup_device *gdev)
 	mutex_init(&card->sbp_lock);
 
 	if (gdev->dev.type == &qeth_generic_devtype) {
-		rc = qeth_l2_create_device_attributes(&gdev->dev);
+		rc = device_add_groups(&gdev->dev, qeth_l2_attr_groups);
 		if (rc)
 			return rc;
 	}
@@ -2203,7 +2203,7 @@ static void qeth_l2_remove_device(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 
 	if (gdev->dev.type == &qeth_generic_devtype)
-		qeth_l2_remove_device_attributes(&gdev->dev);
+		device_remove_groups(&gdev->dev, qeth_l2_attr_groups);
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
 
diff --git a/drivers/s390/net/qeth_l2_sys.c b/drivers/s390/net/qeth_l2_sys.c
index 4ba3bc57263f..a617351fff57 100644
--- a/drivers/s390/net/qeth_l2_sys.c
+++ b/drivers/s390/net/qeth_l2_sys.c
@@ -376,26 +376,7 @@ static struct attribute_group qeth_l2_vnicc_attr_group = {
 	.name = "vnicc",
 };
 
-static const struct attribute_group *qeth_l2_only_attr_groups[] = {
-	&qeth_l2_bridgeport_attr_group,
-	&qeth_l2_vnicc_attr_group,
-	NULL,
-};
-
-int qeth_l2_create_device_attributes(struct device *dev)
-{
-	return sysfs_create_groups(&dev->kobj, qeth_l2_only_attr_groups);
-}
-
-void qeth_l2_remove_device_attributes(struct device *dev)
-{
-	sysfs_remove_groups(&dev->kobj, qeth_l2_only_attr_groups);
-}
-
 const struct attribute_group *qeth_l2_attr_groups[] = {
-	&qeth_device_attr_group,
-	&qeth_device_blkt_group,
-	/* l2 specific, see qeth_l2_only_attr_groups: */
 	&qeth_l2_bridgeport_attr_group,
 	&qeth_l2_vnicc_attr_group,
 	NULL,
diff --git a/drivers/s390/net/qeth_l3.h b/drivers/s390/net/qeth_l3.h
index acd130cfbab3..30c2b31d99f6 100644
--- a/drivers/s390/net/qeth_l3.h
+++ b/drivers/s390/net/qeth_l3.h
@@ -103,8 +103,6 @@ extern const struct attribute_group *qeth_l3_attr_groups[];
 
 int qeth_l3_ipaddr_to_string(enum qeth_prot_versions proto, const u8 *addr,
 			     char *buf);
-int qeth_l3_create_device_attributes(struct device *);
-void qeth_l3_remove_device_attributes(struct device *);
 int qeth_l3_setrouting_v4(struct qeth_card *);
 int qeth_l3_setrouting_v6(struct qeth_card *);
 int qeth_l3_add_ipato_entry(struct qeth_card *, struct qeth_ipato_entry *);
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 264b6c782382..d138ac432d01 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -1949,7 +1949,7 @@ static int qeth_l3_probe_device(struct ccwgroup_device *gdev)
 		return -ENOMEM;
 
 	if (gdev->dev.type == &qeth_generic_devtype) {
-		rc = qeth_l3_create_device_attributes(&gdev->dev);
+		rc = device_add_groups(&gdev->dev, qeth_l3_attr_groups);
 		if (rc) {
 			destroy_workqueue(card->cmd_wq);
 			return rc;
@@ -1965,7 +1965,7 @@ static void qeth_l3_remove_device(struct ccwgroup_device *cgdev)
 	struct qeth_card *card = dev_get_drvdata(&cgdev->dev);
 
 	if (cgdev->dev.type == &qeth_generic_devtype)
-		qeth_l3_remove_device_attributes(&cgdev->dev);
+		device_remove_groups(&cgdev->dev, qeth_l3_attr_groups);
 
 	qeth_set_allowed_threads(card, 0, 1);
 	wait_event(card->wait_q, qeth_threads_running(card, 0xffffffff) == 0);
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 997fbb7006a7..1082380b21f8 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -805,28 +805,7 @@ static const struct attribute_group qeth_device_rxip_group = {
 	.attrs = qeth_rxip_device_attrs,
 };
 
-static const struct attribute_group *qeth_l3_only_attr_groups[] = {
-	&qeth_l3_device_attr_group,
-	&qeth_device_ipato_group,
-	&qeth_device_vipa_group,
-	&qeth_device_rxip_group,
-	NULL,
-};
-
-int qeth_l3_create_device_attributes(struct device *dev)
-{
-	return sysfs_create_groups(&dev->kobj, qeth_l3_only_attr_groups);
-}
-
-void qeth_l3_remove_device_attributes(struct device *dev)
-{
-	sysfs_remove_groups(&dev->kobj, qeth_l3_only_attr_groups);
-}
-
 const struct attribute_group *qeth_l3_attr_groups[] = {
-	&qeth_device_attr_group,
-	&qeth_device_blkt_group,
-	/* l3 specific, see qeth_l3_only_attr_groups: */
 	&qeth_l3_device_attr_group,
 	&qeth_device_ipato_group,
 	&qeth_device_vipa_group,
-- 
2.17.1
