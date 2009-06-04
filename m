Return-Path: <linux-kernel-owner+w=401wt.eu-S1758863AbZFDQX1@vger.kernel.org>
Message-Id: <20090604161906.803008077@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:17 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 30/38] PM: af_iucv power management callbacks.
Content-Disposition: inline; filename=pm_afiucv.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Patch establishes a dummy afiucv-device to make sure af_iucv is
notified as iucv-bus device about suspend/resume.

The PM freeze callback severs all iucv pathes of connected af_iucv sockets.
The PM thaw/restore callback switches the state of all previously connected
sockets to IUCV_DISCONN.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 net/iucv/af_iucv.c |  147 +++++++++++++++++++++++++++++++++++++++++++++++++++--
 1 file changed, 144 insertions(+), 3 deletions(-)

Index: linux-2.6/net/iucv/af_iucv.c
===================================================================
--- linux-2.6.orig/net/iucv/af_iucv.c
+++ linux-2.6/net/iucv/af_iucv.c
@@ -1,11 +1,12 @@
 /*
- *  linux/net/iucv/af_iucv.c
- *
  *  IUCV protocol stack for Linux on zSeries
  *
- *  Copyright 2006 IBM Corporation
+ *  Copyright IBM Corp. 2006, 2009
  *
  *  Author(s):	Jennifer Hunt <jenhunt@us.ibm.com>
+ *		Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
+ *  PM functions:
+ *		Ursula Braun <ursula.braun@de.ibm.com>
  */
 
 #define KMSG_COMPONENT "af_iucv"
@@ -78,6 +79,122 @@ static inline void low_nmcpy(unsigned ch
        memcpy(&dst[8], src, 8);
 }
 
+static int afiucv_pm_prepare(struct device *dev)
+{
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "afiucv_pm_prepare\n");
+#endif
+	return 0;
+}
+
+static void afiucv_pm_complete(struct device *dev)
+{
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "afiucv_pm_complete\n");
+#endif
+	return;
+}
+
+/**
+ * afiucv_pm_freeze() - Freeze PM callback
+ * @dev:	AFIUCV dummy device
+ *
+ * Sever all established IUCV communication pathes
+ */
+static int afiucv_pm_freeze(struct device *dev)
+{
+	struct iucv_sock *iucv;
+	struct sock *sk;
+	struct hlist_node *node;
+	int err = 0;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "afiucv_pm_freeze\n");
+#endif
+	read_lock(&iucv_sk_list.lock);
+	sk_for_each(sk, node, &iucv_sk_list.head) {
+		iucv = iucv_sk(sk);
+		skb_queue_purge(&iucv->send_skb_q);
+		skb_queue_purge(&iucv->backlog_skb_q);
+		switch (sk->sk_state) {
+		case IUCV_SEVERED:
+		case IUCV_DISCONN:
+		case IUCV_CLOSING:
+		case IUCV_CONNECTED:
+			if (iucv->path) {
+				err = iucv_path_sever(iucv->path, NULL);
+				iucv_path_free(iucv->path);
+				iucv->path = NULL;
+			}
+			break;
+		case IUCV_OPEN:
+		case IUCV_BOUND:
+		case IUCV_LISTEN:
+		case IUCV_CLOSED:
+		default:
+			break;
+		}
+	}
+	read_unlock(&iucv_sk_list.lock);
+	return err;
+}
+
+/**
+ * afiucv_pm_restore_thaw() - Thaw and restore PM callback
+ * @dev:	AFIUCV dummy device
+ *
+ * socket clean up after freeze
+ */
+static int afiucv_pm_restore_thaw(struct device *dev)
+{
+	struct iucv_sock *iucv;
+	struct sock *sk;
+	struct hlist_node *node;
+
+#ifdef CONFIG_PM_DEBUG
+	printk(KERN_WARNING "afiucv_pm_restore_thaw\n");
+#endif
+	read_lock(&iucv_sk_list.lock);
+	sk_for_each(sk, node, &iucv_sk_list.head) {
+		iucv = iucv_sk(sk);
+		switch (sk->sk_state) {
+		case IUCV_CONNECTED:
+			sk->sk_err = EPIPE;
+			sk->sk_state = IUCV_DISCONN;
+			sk->sk_state_change(sk);
+			break;
+		case IUCV_DISCONN:
+		case IUCV_SEVERED:
+		case IUCV_CLOSING:
+		case IUCV_LISTEN:
+		case IUCV_BOUND:
+		case IUCV_OPEN:
+		default:
+			break;
+		}
+	}
+	read_unlock(&iucv_sk_list.lock);
+	return 0;
+}
+
+static struct dev_pm_ops afiucv_pm_ops = {
+	.prepare = afiucv_pm_prepare,
+	.complete = afiucv_pm_complete,
+	.freeze = afiucv_pm_freeze,
+	.thaw = afiucv_pm_restore_thaw,
+	.restore = afiucv_pm_restore_thaw,
+};
+
+static struct device_driver af_iucv_driver = {
+	.owner = THIS_MODULE,
+	.name = "afiucv",
+	.bus  = &iucv_bus,
+	.pm   = &afiucv_pm_ops,
+};
+
+/* dummy device used as trigger for PM functions */
+static struct device *af_iucv_dev;
+
 /* Timers */
 static void iucv_sock_timeout(unsigned long arg)
 {
@@ -1258,8 +1375,30 @@ static int __init afiucv_init(void)
 	err = sock_register(&iucv_sock_family_ops);
 	if (err)
 		goto out_proto;
+	/* establish dummy device */
+	err = driver_register(&af_iucv_driver);
+	if (err)
+		goto out_sock;
+	af_iucv_dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!af_iucv_dev) {
+		err = -ENOMEM;
+		goto out_driver;
+	}
+	dev_set_name(af_iucv_dev, "af_iucv");
+	af_iucv_dev->bus = &iucv_bus;
+	af_iucv_dev->parent = iucv_root;
+	af_iucv_dev->release = (void (*)(struct device *))kfree;
+	af_iucv_dev->driver = &af_iucv_driver;
+	err = device_register(af_iucv_dev);
+	if (err)
+		goto out_driver;
+
 	return 0;
 
+out_driver:
+	driver_unregister(&af_iucv_driver);
+out_sock:
+	sock_unregister(PF_IUCV);
 out_proto:
 	proto_unregister(&iucv_proto);
 out_iucv:
@@ -1270,6 +1409,8 @@ out:
 
 static void __exit afiucv_exit(void)
 {
+	device_unregister(af_iucv_dev);
+	driver_unregister(&af_iucv_driver);
 	sock_unregister(PF_IUCV);
 	proto_unregister(&iucv_proto);
 	iucv_unregister(&af_iucv_handler, 0);

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
