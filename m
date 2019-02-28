Return-Path: <SRS0=ar10=RD=vger.kernel.org=netdev-owner@kernel.org>
From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 1/9] s390/qeth: remove RECOVER state
Date: Thu, 28 Feb 2019 18:59:36 +0100
In-Reply-To: <20190228175944.24718-1-jwi@linux.ibm.com>
References: <20190228175944.24718-1-jwi@linux.ibm.com>
Message-Id: <20190228175944.24718-2-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

The offline code uses a specific RECOVER state to indicate that the
interface should be brought up when a qeth device is set online again.

Rather than having a specific card-state for this, just put it in an
internal flag bit and set the state to DOWN. When working with the
card's state transitions, this reduces the complexity quite a bit.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  2 +-
 drivers/s390/net/qeth_core_main.c |  6 ++----
 drivers/s390/net/qeth_core_sys.c  | 14 ++++----------
 drivers/s390/net/qeth_l2_main.c   | 19 +++++++------------
 drivers/s390/net/qeth_l3_main.c   | 19 +++++++------------
 drivers/s390/net/qeth_l3_sys.c    | 12 ++++--------
 6 files changed, 25 insertions(+), 47 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index c0c46be0b251..79de890010c7 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -553,7 +553,6 @@ enum qeth_card_states {
 	CARD_STATE_HARDSETUP,
 	CARD_STATE_SOFTSETUP,
 	CARD_STATE_UP,
-	CARD_STATE_RECOVER,
 };
 
 /**
@@ -665,6 +664,7 @@ struct qeth_card_info {
 	unsigned short chpid;
 	__u16 func_level;
 	char mcl_level[QETH_MCL_LENGTH + 1];
+	u8 open_when_online:1;
 	int guestlan;
 	int mac_bits;
 	enum qeth_card_types type;
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 4708df39f129..a69e31e9bdf1 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -265,8 +265,7 @@ int qeth_realloc_buffer_pool(struct qeth_card *card, int bufcnt)
 {
 	QETH_CARD_TEXT(card, 2, "realcbp");
 
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER))
+	if (card->state != CARD_STATE_DOWN)
 		return -EPERM;
 
 	/* TODO: steel/add buffers from/to a running card's buffer pool (?) */
@@ -3479,8 +3478,7 @@ int qeth_configure_cq(struct qeth_card *card, enum qeth_cq cq)
 			goto out;
 		}
 
-		if (card->state != CARD_STATE_DOWN &&
-		    card->state != CARD_STATE_RECOVER) {
+		if (card->state != CARD_STATE_DOWN) {
 			rc = -1;
 			goto out;
 		}
diff --git a/drivers/s390/net/qeth_core_sys.c b/drivers/s390/net/qeth_core_sys.c
index 8b223cc2c19b..e24d204b780a 100644
--- a/drivers/s390/net/qeth_core_sys.c
+++ b/drivers/s390/net/qeth_core_sys.c
@@ -34,8 +34,6 @@ static ssize_t qeth_dev_state_show(struct device *dev,
 		return sprintf(buf, "UP (LAN %s)\n",
 			       netif_carrier_ok(card->dev) ? "ONLINE" :
 							     "OFFLINE");
-	case CARD_STATE_RECOVER:
-		return sprintf(buf, "RECOVER\n");
 	default:
 		return sprintf(buf, "UNKNOWN\n");
 	}
@@ -126,8 +124,7 @@ static ssize_t qeth_dev_portno_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
@@ -202,8 +199,7 @@ static ssize_t qeth_dev_prioqing_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
@@ -285,8 +281,7 @@ static ssize_t qeth_dev_bufcnt_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
@@ -634,8 +629,7 @@ static ssize_t qeth_dev_blkt_store(struct qeth_card *card,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 2c9714215775..f621656f9ea7 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -807,7 +807,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	struct net_device *dev = card->dev;
 	int rc = 0;
-	enum qeth_card_states recover_flag;
 	bool carrier_ok;
 
 	mutex_lock(&card->discipline_mutex);
@@ -815,7 +814,6 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	QETH_DBF_TEXT(SETUP, 2, "setonlin");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
-	recover_flag = card->state;
 	rc = qeth_core_hardsetup_card(card, &carrier_ok);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "2err%04x", rc);
@@ -881,7 +879,8 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
-		if (recover_flag == CARD_STATE_RECOVER) {
+		if (card->info.open_when_online) {
+			card->info.open_when_online = 0;
 			if (recovery_mode && !IS_OSN(card)) {
 				if (!qeth_l2_validate_addr(dev)) {
 					qeth_open(dev);
@@ -905,10 +904,8 @@ static int __qeth_l2_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
 	qdio_free(CARD_DDEV(card));
-	if (recover_flag == CARD_STATE_RECOVER)
-		card->state = CARD_STATE_RECOVER;
-	else
-		card->state = CARD_STATE_DOWN;
+	card->state = CARD_STATE_DOWN;
+
 	mutex_unlock(&card->conf_mutex);
 	mutex_unlock(&card->discipline_mutex);
 	return rc;
@@ -924,7 +921,6 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 {
 	struct qeth_card *card = dev_get_drvdata(&cgdev->dev);
 	int rc = 0, rc2 = 0, rc3 = 0;
-	enum qeth_card_states recover_flag;
 
 	mutex_lock(&card->discipline_mutex);
 	mutex_lock(&card->conf_mutex);
@@ -932,11 +928,11 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
 	rtnl_lock();
+	card->info.open_when_online = card->dev->flags & IFF_UP;
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
 		card->info.hwtrap = 1;
@@ -950,8 +946,7 @@ static int __qeth_l2_set_offline(struct ccwgroup_device *cgdev,
 	if (rc)
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 	qdio_free(CARD_DDEV(card));
-	if (recover_flag == CARD_STATE_UP)
-		card->state = CARD_STATE_RECOVER;
+
 	/* let user_space know that device is offline */
 	kobject_uevent(&cgdev->dev.kobj, KOBJ_CHANGE);
 	mutex_unlock(&card->conf_mutex);
@@ -1024,7 +1019,7 @@ static int qeth_l2_pm_resume(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc = 0;
 
-	if (card->state == CARD_STATE_RECOVER) {
+	if (card->info.open_when_online) {
 		rc = __qeth_l2_set_online(card->gdev, 1);
 		if (rc) {
 			rtnl_lock();
diff --git a/drivers/s390/net/qeth_l3_main.c b/drivers/s390/net/qeth_l3_main.c
index 07c3149e228c..fe6b9a82f69e 100644
--- a/drivers/s390/net/qeth_l3_main.c
+++ b/drivers/s390/net/qeth_l3_main.c
@@ -2304,7 +2304,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	struct net_device *dev = card->dev;
 	int rc = 0;
-	enum qeth_card_states recover_flag;
 	bool carrier_ok;
 
 	mutex_lock(&card->discipline_mutex);
@@ -2312,7 +2311,6 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	QETH_DBF_TEXT(SETUP, 2, "setonlin");
 	QETH_DBF_HEX(SETUP, 2, &card, sizeof(void *));
 
-	recover_flag = card->state;
 	rc = qeth_core_hardsetup_card(card, &carrier_ok);
 	if (rc) {
 		QETH_DBF_TEXT_(SETUP, 2, "2err%04x", rc);
@@ -2375,7 +2373,8 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 		netif_device_attach(dev);
 		qeth_enable_hw_features(dev);
 
-		if (recover_flag == CARD_STATE_RECOVER) {
+		if (card->info.open_when_online) {
+			card->info.open_when_online = 0;
 			if (recovery_mode) {
 				qeth_open(dev);
 				qeth_l3_set_rx_mode(dev);
@@ -2397,10 +2396,8 @@ static int __qeth_l3_set_online(struct ccwgroup_device *gdev, int recovery_mode)
 	ccw_device_set_offline(CARD_WDEV(card));
 	ccw_device_set_offline(CARD_RDEV(card));
 	qdio_free(CARD_DDEV(card));
-	if (recover_flag == CARD_STATE_RECOVER)
-		card->state = CARD_STATE_RECOVER;
-	else
-		card->state = CARD_STATE_DOWN;
+	card->state = CARD_STATE_DOWN;
+
 	mutex_unlock(&card->conf_mutex);
 	mutex_unlock(&card->discipline_mutex);
 	return rc;
@@ -2416,7 +2413,6 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 {
 	struct qeth_card *card = dev_get_drvdata(&cgdev->dev);
 	int rc = 0, rc2 = 0, rc3 = 0;
-	enum qeth_card_states recover_flag;
 
 	mutex_lock(&card->discipline_mutex);
 	mutex_lock(&card->conf_mutex);
@@ -2424,11 +2420,11 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	QETH_DBF_HEX(SETUP, 3, &card, sizeof(void *));
 
 	rtnl_lock();
+	card->info.open_when_online = card->dev->flags & IFF_UP;
 	netif_device_detach(card->dev);
 	netif_carrier_off(card->dev);
 	rtnl_unlock();
 
-	recover_flag = card->state;
 	if ((!recovery_mode && card->info.hwtrap) || card->info.hwtrap == 2) {
 		qeth_hw_trap(card, QETH_DIAGS_TRAP_DISARM);
 		card->info.hwtrap = 1;
@@ -2447,8 +2443,7 @@ static int __qeth_l3_set_offline(struct ccwgroup_device *cgdev,
 	if (rc)
 		QETH_DBF_TEXT_(SETUP, 2, "1err%d", rc);
 	qdio_free(CARD_DDEV(card));
-	if (recover_flag == CARD_STATE_UP)
-		card->state = CARD_STATE_RECOVER;
+
 	/* let user_space know that device is offline */
 	kobject_uevent(&cgdev->dev.kobj, KOBJ_CHANGE);
 	mutex_unlock(&card->conf_mutex);
@@ -2511,7 +2506,7 @@ static int qeth_l3_pm_resume(struct ccwgroup_device *gdev)
 	struct qeth_card *card = dev_get_drvdata(&gdev->dev);
 	int rc = 0;
 
-	if (card->state == CARD_STATE_RECOVER) {
+	if (card->info.open_when_online) {
 		rc = __qeth_l3_set_online(card->gdev, 1);
 		if (rc) {
 			rtnl_lock();
diff --git a/drivers/s390/net/qeth_l3_sys.c b/drivers/s390/net/qeth_l3_sys.c
index 45ac6d8705c6..cff518b0f904 100644
--- a/drivers/s390/net/qeth_l3_sys.c
+++ b/drivers/s390/net/qeth_l3_sys.c
@@ -167,8 +167,7 @@ static ssize_t qeth_l3_dev_fake_broadcast_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
@@ -213,8 +212,7 @@ static ssize_t qeth_l3_dev_sniffer_store(struct device *dev,
 		return -EPERM;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
@@ -280,8 +278,7 @@ static ssize_t qeth_l3_dev_hsuid_store(struct device *dev,
 
 	if (card->info.type != QETH_CARD_TYPE_IQD)
 		return -EPERM;
-	if (card->state != CARD_STATE_DOWN &&
-	    card->state != CARD_STATE_RECOVER)
+	if (card->state != CARD_STATE_DOWN)
 		return -EPERM;
 	if (card->options.sniffer)
 		return -EPERM;
@@ -356,8 +353,7 @@ static ssize_t qeth_l3_dev_ipato_enable_store(struct device *dev,
 		return -EINVAL;
 
 	mutex_lock(&card->conf_mutex);
-	if ((card->state != CARD_STATE_DOWN) &&
-	    (card->state != CARD_STATE_RECOVER)) {
+	if (card->state != CARD_STATE_DOWN) {
 		rc = -EPERM;
 		goto out;
 	}
-- 
2.16.4
