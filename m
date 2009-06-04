Return-Path: <linux-kernel-owner+w=401wt.eu-S1757446AbZFDQ0y@vger.kernel.org>
Message-Id: <20090604161906.562582550@de.ibm.com>
References: <20090604161847.513682672@de.ibm.com>
Date: Thu, 04 Jun 2009 18:19:16 +0200
From: Martin Schwidefsky <schwidefsky@de.ibm.com>
Subject: [patch 29/38] pm: netiucv power management callbacks.
Content-Disposition: inline; filename=pm_netiucv.patch
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-pm@lists.linux-foundation.org
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>, Ursula Braun <ursula.braun@de.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>
List-ID: <linux-s390.vger.kernel.org>

From: Ursula Braun <ursula.braun@de.ibm.com>

Patch establishes a dummy netiucv device to make sure iucv is notified
about suspend/resume even if netiucv is the only loaded iucv-exploting
module without any real net_device defined.

The PM freeze callback closes all open netiucv connections. Thus the
corresponding iucv path is removed.
The PM thaw/restore callback re-opens previously closed netiucv
connections.

Signed-off-by: Ursula Braun <ursula.braun@de.ibm.com>
Signed-off-by: Martin Schwidefsky <schwidefsky@de.ibm.com>
---
 drivers/s390/net/netiucv.c |  115 ++++++++++++++++++++++++++++++++++++++++++---
 1 file changed, 109 insertions(+), 6 deletions(-)

Index: linux-2.6/drivers/s390/net/netiucv.c
===================================================================
--- linux-2.6.orig/drivers/s390/net/netiucv.c
+++ linux-2.6/drivers/s390/net/netiucv.c
@@ -1,11 +1,15 @@
 /*
  * IUCV network driver
  *
- * Copyright 2001 IBM Deutschland Entwicklung GmbH, IBM Corporation
- * Author(s): Fritz Elfert (elfert@de.ibm.com, felfert@millenux.com)
+ * Copyright IBM Corp. 2001, 2009
  *
- * Sysfs integration and all bugs therein by Cornelia Huck
- * (cornelia.huck@de.ibm.com)
+ * Author(s):
+ *	Original netiucv driver:
+ *		Fritz Elfert (elfert@de.ibm.com, felfert@millenux.com)
+ *	Sysfs integration and all bugs therein:
+ *		Cornelia Huck (cornelia.huck@de.ibm.com)
+ *	PM functions:
+ *		Ursula Braun (ursula.braun@de.ibm.com)
  *
  * Documentation used:
  *  the source of the original IUCV driver by:
@@ -149,10 +153,27 @@ PRINT_##importance(header "%02x %02x %02
 
 #define PRINTK_HEADER " iucv: "       /* for debugging */
 
+/* dummy device to make sure netiucv_pm functions are called */
+static struct device *netiucv_dev;
+
+static int netiucv_pm_prepare(struct device *);
+static void netiucv_pm_complete(struct device *);
+static int netiucv_pm_freeze(struct device *);
+static int netiucv_pm_restore_thaw(struct device *);
+
+static struct dev_pm_ops netiucv_pm_ops = {
+	.prepare = netiucv_pm_prepare,
+	.complete = netiucv_pm_complete,
+	.freeze = netiucv_pm_freeze,
+	.thaw = netiucv_pm_restore_thaw,
+	.restore = netiucv_pm_restore_thaw,
+};
+
 static struct device_driver netiucv_driver = {
 	.owner = THIS_MODULE,
 	.name = "netiucv",
 	.bus  = &iucv_bus,
+	.pm = &netiucv_pm_ops,
 };
 
 static int netiucv_callback_connreq(struct iucv_path *,
@@ -233,6 +254,7 @@ struct netiucv_priv {
 	fsm_instance            *fsm;
         struct iucv_connection  *conn;
 	struct device           *dev;
+	int			 pm_state;
 };
 
 /**
@@ -1265,6 +1287,72 @@ static int netiucv_close(struct net_devi
 	return 0;
 }
 
+static int netiucv_pm_prepare(struct device *dev)
+{
+	IUCV_DBF_TEXT(trace, 3, __func__);
+	return 0;
+}
+
+static void netiucv_pm_complete(struct device *dev)
+{
+	IUCV_DBF_TEXT(trace, 3, __func__);
+	return;
+}
+
+/**
+ * netiucv_pm_freeze() - Freeze PM callback
+ * @dev:	netiucv device
+ *
+ * close open netiucv interfaces
+ */
+static int netiucv_pm_freeze(struct device *dev)
+{
+	struct netiucv_priv *priv = dev->driver_data;
+	struct net_device *ndev = NULL;
+	int rc = 0;
+
+	IUCV_DBF_TEXT(trace, 3, __func__);
+	if (priv && priv->conn)
+		ndev = priv->conn->netdev;
+	if (!ndev)
+		goto out;
+	netif_device_detach(ndev);
+	priv->pm_state = fsm_getstate(priv->fsm);
+	rc = netiucv_close(ndev);
+out:
+	return rc;
+}
+
+/**
+ * netiucv_pm_restore_thaw() - Thaw and restore PM callback
+ * @dev:	netiucv device
+ *
+ * re-open netiucv interfaces closed during freeze
+ */
+static int netiucv_pm_restore_thaw(struct device *dev)
+{
+	struct netiucv_priv *priv = dev->driver_data;
+	struct net_device *ndev = NULL;
+	int rc = 0;
+
+	IUCV_DBF_TEXT(trace, 3, __func__);
+	if (priv && priv->conn)
+		ndev = priv->conn->netdev;
+	if (!ndev)
+		goto out;
+	switch (priv->pm_state) {
+	case DEV_STATE_RUNNING:
+	case DEV_STATE_STARTWAIT:
+		rc = netiucv_open(ndev);
+		break;
+	default:
+		break;
+	}
+	netif_device_attach(ndev);
+out:
+	return rc;
+}
+
 /**
  * Start transmission of a packet.
  * Called from generic network device layer.
@@ -1731,7 +1819,6 @@ static int netiucv_register_device(struc
 	struct device *dev = kzalloc(sizeof(struct device), GFP_KERNEL);
 	int ret;
 
-
 	IUCV_DBF_TEXT(trace, 3, __func__);
 
 	if (dev) {
@@ -2100,6 +2187,7 @@ static void __exit netiucv_exit(void)
 		netiucv_unregister_device(dev);
 	}
 
+	device_unregister(netiucv_dev);
 	driver_unregister(&netiucv_driver);
 	iucv_unregister(&netiucv_handler, 1);
 	iucv_unregister_dbf_views();
@@ -2125,10 +2213,25 @@ static int __init netiucv_init(void)
 		IUCV_DBF_TEXT_(setup, 2, "ret %d from driver_register\n", rc);
 		goto out_iucv;
 	}
-
+	/* establish dummy device */
+	netiucv_dev = kzalloc(sizeof(struct device), GFP_KERNEL);
+	if (!netiucv_dev) {
+		rc = -ENOMEM;
+		goto out_driver;
+	}
+	dev_set_name(netiucv_dev, "netiucv");
+	netiucv_dev->bus = &iucv_bus;
+	netiucv_dev->parent = iucv_root;
+	netiucv_dev->release = (void (*)(struct device *))kfree;
+	netiucv_dev->driver = &netiucv_driver;
+	rc = device_register(netiucv_dev);
+	if (rc)
+		goto out_driver;
 	netiucv_banner();
 	return rc;
 
+out_driver:
+	driver_unregister(&netiucv_driver);
 out_iucv:
 	iucv_unregister(&netiucv_handler, 1);
 out_dbf:

-- 
blue skies,
   Martin.

"Reality continues to ruin my life." - Calvin.
