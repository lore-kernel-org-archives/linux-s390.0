From: Julian Wiedmann <jwi@linux.ibm.com>
Subject: [PATCH net-next 4/8] s390/qeth: remove card list
Date: Thu,  8 Nov 2018 15:06:18 +0100
Message-ID: <20181108140622.35244-5-jwi@linux.ibm.com>
References: <20181108140622.35244-1-jwi@linux.ibm.com>
Return-path: <netdev-owner@vger.kernel.org>
In-Reply-To: <20181108140622.35244-1-jwi@linux.ibm.com>
Sender: netdev-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/netdev/>
List-Post: <mailto:netdev@vger.kernel.org>
To: David Miller <davem@davemloft.net>
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Stefan Raspl <raspl@linux.ibm.com>, Ursula Braun <ubraun@linux.ibm.com>, Julian Wiedmann <jwi@linux.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

Re-implement the card-by-RDEV lookup by using device model concepts, and
remove the now redundant list of all qeth card instances in the system.

Signed-off-by: Julian Wiedmann <jwi@linux.ibm.com>
---
 drivers/s390/net/qeth_core.h      |  8 +-------
 drivers/s390/net/qeth_core_main.c | 25 +++++++++++++++----------
 drivers/s390/net/qeth_l2_main.c   | 35 ++++++++---------------------------
 3 files changed, 24 insertions(+), 44 deletions(-)

diff --git a/drivers/s390/net/qeth_core.h b/drivers/s390/net/qeth_core.h
index afe3662a4ad5..0ee026947f20 100644
--- a/drivers/s390/net/qeth_core.h
+++ b/drivers/s390/net/qeth_core.h
@@ -774,7 +774,6 @@ struct qeth_switch_info {
 #define QETH_NAPI_WEIGHT NAPI_POLL_WEIGHT
 
 struct qeth_card {
-	struct list_head list;
 	enum qeth_card_states state;
 	spinlock_t lock;
 	struct ccwgroup_device *gdev;
@@ -826,11 +825,6 @@ struct qeth_card {
 	struct work_struct close_dev_work;
 };
 
-struct qeth_card_list_struct {
-	struct list_head list;
-	rwlock_t rwlock;
-};
-
 struct qeth_trap_id {
 	__u16 lparnr;
 	char vmname[8];
@@ -977,11 +971,11 @@ int qeth_core_load_discipline(struct qeth_card *, enum qeth_discipline_id);
 void qeth_core_free_discipline(struct qeth_card *);
 
 /* exports for qeth discipline device drivers */
-extern struct qeth_card_list_struct qeth_core_card_list;
 extern struct kmem_cache *qeth_core_header_cache;
 extern struct qeth_dbf_info qeth_dbf[QETH_DBF_INFOS];
 
 struct net_device *qeth_clone_netdev(struct net_device *orig);
+struct qeth_card *qeth_get_card_by_busid(char *bus_id);
 void qeth_set_recovery_task(struct qeth_card *);
 void qeth_clear_recovery_task(struct qeth_card *);
 void qeth_set_allowed_threads(struct qeth_card *, unsigned long , int);
diff --git a/drivers/s390/net/qeth_core_main.c b/drivers/s390/net/qeth_core_main.c
index 2568ddc1bbc3..508bad2dbd0b 100644
--- a/drivers/s390/net/qeth_core_main.c
+++ b/drivers/s390/net/qeth_core_main.c
@@ -54,8 +54,6 @@ struct qeth_dbf_info qeth_dbf[QETH_DBF_INFOS] = {
 };
 EXPORT_SYMBOL_GPL(qeth_dbf);
 
-struct qeth_card_list_struct qeth_core_card_list;
-EXPORT_SYMBOL_GPL(qeth_core_card_list);
 struct kmem_cache *qeth_core_header_cache;
 EXPORT_SYMBOL_GPL(qeth_core_header_cache);
 static struct kmem_cache *qeth_qdio_outbuf_cache;
@@ -5806,9 +5804,6 @@ static int qeth_core_probe_device(struct ccwgroup_device *gdev)
 		break;
 	}
 
-	write_lock_irq(&qeth_core_card_list.rwlock);
-	list_add_tail(&card->list, &qeth_core_card_list.list);
-	write_unlock_irq(&qeth_core_card_list.rwlock);
 	return 0;
 
 err_disc:
@@ -5833,9 +5828,6 @@ static void qeth_core_remove_device(struct ccwgroup_device *gdev)
 		qeth_core_free_discipline(card);
 	}
 
-	write_lock_irq(&qeth_core_card_list.rwlock);
-	list_del(&card->list);
-	write_unlock_irq(&qeth_core_card_list.rwlock);
 	free_netdev(card->dev);
 	qeth_core_free_card(card);
 	put_device(&gdev->dev);
@@ -5950,6 +5942,21 @@ static struct ccwgroup_driver qeth_core_ccwgroup_driver = {
 	.restore = qeth_core_restore,
 };
 
+struct qeth_card *qeth_get_card_by_busid(char *bus_id)
+{
+	struct ccwgroup_device *gdev;
+	struct qeth_card *card;
+
+	gdev = get_ccwgroupdev_by_busid(&qeth_core_ccwgroup_driver, bus_id);
+	if (!gdev)
+		return NULL;
+
+	card = dev_get_drvdata(&gdev->dev);
+	put_device(&gdev->dev);
+	return card;
+}
+EXPORT_SYMBOL_GPL(qeth_get_card_by_busid);
+
 int qeth_do_ioctl(struct net_device *dev, struct ifreq *rq, int cmd)
 {
 	struct qeth_card *card = dev->ml_priv;
@@ -6688,8 +6695,6 @@ static int __init qeth_core_init(void)
 	int rc;
 
 	pr_info("loading core functions\n");
-	INIT_LIST_HEAD(&qeth_core_card_list.list);
-	rwlock_init(&qeth_core_card_list.rwlock);
 
 	qeth_wq = create_singlethread_workqueue("qeth_wq");
 	if (!qeth_wq) {
diff --git a/drivers/s390/net/qeth_l2_main.c b/drivers/s390/net/qeth_l2_main.c
index 8d3601891c62..2836231c1c5d 100644
--- a/drivers/s390/net/qeth_l2_main.c
+++ b/drivers/s390/net/qeth_l2_main.c
@@ -36,28 +36,6 @@ static void qeth_l2_vnicc_init(struct qeth_card *card);
 static bool qeth_l2_vnicc_recover_timeout(struct qeth_card *card, u32 vnicc,
 					  u32 *timeout);
 
-static struct net_device *qeth_l2_netdev_by_devno(unsigned char *read_dev_no)
-{
-	struct qeth_card *card;
-	struct net_device *ndev;
-	__u16 temp_dev_no;
-	unsigned long flags;
-	struct ccw_dev_id read_devid;
-
-	ndev = NULL;
-	memcpy(&temp_dev_no, read_dev_no, 2);
-	read_lock_irqsave(&qeth_core_card_list.rwlock, flags);
-	list_for_each_entry(card, &qeth_core_card_list.list, list) {
-		ccw_device_get_id(CARD_RDEV(card), &read_devid);
-		if (read_devid.devno == temp_dev_no) {
-			ndev = card->dev;
-			break;
-		}
-	}
-	read_unlock_irqrestore(&qeth_core_card_list.rwlock, flags);
-	return ndev;
-}
-
 static int qeth_setdelmac_makerc(struct qeth_card *card, int retcode)
 {
 	int rc;
@@ -1286,13 +1264,16 @@ int qeth_osn_register(unsigned char *read_dev_no, struct net_device **dev,
 		  int (*data_cb)(struct sk_buff *))
 {
 	struct qeth_card *card;
+	char bus_id[16];
+	u16 devno;
 
-	*dev = qeth_l2_netdev_by_devno(read_dev_no);
-	if (*dev == NULL)
-		return -ENODEV;
-	card = (*dev)->ml_priv;
-	if (!card)
+	memcpy(&devno, read_dev_no, 2);
+	sprintf(bus_id, "0.0.%04x", devno);
+	card = qeth_get_card_by_busid(bus_id);
+	if (!card || !IS_OSN(card))
 		return -ENODEV;
+	*dev = card->dev;
+
 	QETH_CARD_TEXT(card, 2, "osnreg");
 	if ((assist_cb == NULL) || (data_cb == NULL))
 		return -EINVAL;
-- 
2.16.4
