Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:20332 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729022AbgGHPHC (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 8 Jul 2020 11:07:02 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net 4/5] net/smc: switch smcd_dev_list spinlock to mutex
Date: Wed,  8 Jul 2020 17:05:14 +0200
Message-Id: <20200708150515.44938-5-kgraul@linux.ibm.com>
In-Reply-To: <20200708150515.44938-1-kgraul@linux.ibm.com>
References: <20200708150515.44938-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

From: Ursula Braun <ubraun@linux.ibm.com>

The similar smc_ib_devices spinlock has been converted to a mutex.
Protecting the smcd_dev_list by a mutex is possible as well. This
patch converts the smcd_dev_list spinlock to a mutex.

Fixes: c6ba7c9ba43d ("net/smc: add base infrastructure for SMC-D and ISM")
Signed-off-by: Ursula Braun <ubraun@linux.ibm.com>
Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
---
 net/smc/smc_core.c |  8 ++++----
 net/smc/smc_ism.c  | 11 ++++++-----
 net/smc/smc_ism.h  |  3 ++-
 net/smc/smc_pnet.c | 16 ++++++++--------
 4 files changed, 20 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 8bf34d9f27e5..f69d205b3e11 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1971,11 +1971,11 @@ static void smc_core_going_away(void)
 	}
 	mutex_unlock(&smc_ib_devices.mutex);
 
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd, &smcd_dev_list.list, list) {
 		smcd->going_away = 1;
 	}
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 }
 
 /* Clean up all SMC link groups */
@@ -1987,10 +1987,10 @@ static void smc_lgrs_shutdown(void)
 
 	smc_smcr_terminate_all(NULL);
 
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd, &smcd_dev_list.list, list)
 		smc_smcd_terminate_all(smcd);
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 }
 
 static int smc_core_reboot_event(struct notifier_block *this,
diff --git a/net/smc/smc_ism.c b/net/smc/smc_ism.c
index 91f85fc09fb8..998c525de785 100644
--- a/net/smc/smc_ism.c
+++ b/net/smc/smc_ism.c
@@ -7,6 +7,7 @@
  */
 
 #include <linux/spinlock.h>
+#include <linux/mutex.h>
 #include <linux/slab.h>
 #include <asm/page.h>
 
@@ -17,7 +18,7 @@
 
 struct smcd_dev_list smcd_dev_list = {
 	.list = LIST_HEAD_INIT(smcd_dev_list.list),
-	.lock = __SPIN_LOCK_UNLOCKED(smcd_dev_list.lock)
+	.mutex = __MUTEX_INITIALIZER(smcd_dev_list.mutex)
 };
 
 /* Test if an ISM communication is possible. */
@@ -317,9 +318,9 @@ EXPORT_SYMBOL_GPL(smcd_alloc_dev);
 
 int smcd_register_dev(struct smcd_dev *smcd)
 {
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_add_tail(&smcd->list, &smcd_dev_list.list);
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 
 	pr_warn_ratelimited("smc: adding smcd device %s with pnetid %.16s%s\n",
 			    dev_name(&smcd->dev), smcd->pnetid,
@@ -333,9 +334,9 @@ void smcd_unregister_dev(struct smcd_dev *smcd)
 {
 	pr_warn_ratelimited("smc: removing smcd device %s\n",
 			    dev_name(&smcd->dev));
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_del_init(&smcd->list);
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 	smcd->going_away = 1;
 	smc_smcd_terminate_all(smcd);
 	flush_workqueue(smcd->event_wq);
diff --git a/net/smc/smc_ism.h b/net/smc/smc_ism.h
index 4da946cbfa29..81cc4537efd3 100644
--- a/net/smc/smc_ism.h
+++ b/net/smc/smc_ism.h
@@ -10,12 +10,13 @@
 #define SMCD_ISM_H
 
 #include <linux/uio.h>
+#include <linux/mutex.h>
 
 #include "smc.h"
 
 struct smcd_dev_list {	/* List of SMCD devices */
 	struct list_head list;
-	spinlock_t lock;	/* Protects list of devices */
+	struct mutex mutex;	/* Protects list of devices */
 };
 
 extern struct smcd_dev_list	smcd_dev_list; /* list of smcd devices */
diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
index d4aac31d39f5..30e5fac7034e 100644
--- a/net/smc/smc_pnet.c
+++ b/net/smc/smc_pnet.c
@@ -152,7 +152,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
 	}
 	mutex_unlock(&smc_ib_devices.mutex);
 	/* remove smcd devices */
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
 		if (smcd_dev->pnetid_by_user &&
 		    (!pnet_name ||
@@ -166,7 +166,7 @@ static int smc_pnet_remove_by_pnetid(struct net *net, char *pnet_name)
 			rc = 0;
 		}
 	}
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 	return rc;
 }
 
@@ -259,13 +259,13 @@ static bool smc_pnet_apply_smcd(struct smcd_dev *smcd_dev, char *pnet_name)
 	u8 pnet_null[SMC_MAX_PNETID_LEN] = {0};
 	bool applied = false;
 
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	if (smc_pnet_match(smcd_dev->pnetid, pnet_null)) {
 		memcpy(smcd_dev->pnetid, pnet_name, SMC_MAX_PNETID_LEN);
 		smcd_dev->pnetid_by_user = true;
 		applied = true;
 	}
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 	return applied;
 }
 
@@ -321,7 +321,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 {
 	struct smcd_dev *smcd_dev;
 
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(smcd_dev, &smcd_dev_list.list, list) {
 		if (!strncmp(dev_name(&smcd_dev->dev), smcd_name,
 			     IB_DEVICE_NAME_MAX - 1))
@@ -329,7 +329,7 @@ static struct smcd_dev *smc_pnet_find_smcd(char *smcd_name)
 	}
 	smcd_dev = NULL;
 out:
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 	return smcd_dev;
 }
 
@@ -925,7 +925,7 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 	    smc_pnet_find_ndev_pnetid_by_table(ndev, ndev_pnetid))
 		return; /* pnetid could not be determined */
 
-	spin_lock(&smcd_dev_list.lock);
+	mutex_lock(&smcd_dev_list.mutex);
 	list_for_each_entry(ismdev, &smcd_dev_list.list, list) {
 		if (smc_pnet_match(ismdev->pnetid, ndev_pnetid) &&
 		    !ismdev->going_away) {
@@ -933,7 +933,7 @@ static void smc_pnet_find_ism_by_pnetid(struct net_device *ndev,
 			break;
 		}
 	}
-	spin_unlock(&smcd_dev_list.lock);
+	mutex_unlock(&smcd_dev_list.mutex);
 }
 
 /* PNET table analysis for a given sock:
-- 
2.17.1
