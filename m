Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:33916 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726476AbgD2PLk (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 29 Apr 2020 11:11:40 -0400
From: Karsten Graul <kgraul@linux.ibm.com>
Subject: [PATCH net-next 12/13] net/smc: use mutex instead of rwlock_t to protect buffers
Date: Wed, 29 Apr 2020 17:10:48 +0200
Message-Id: <20200429151049.49979-13-kgraul@linux.ibm.com>
In-Reply-To: <20200429151049.49979-1-kgraul@linux.ibm.com>
References: <20200429151049.49979-1-kgraul@linux.ibm.com>
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: davem@davemloft.net
Cc: netdev@vger.kernel.org, linux-s390@vger.kernel.org, heiko.carstens@de.ibm.com, raspl@linux.ibm.com, ubraun@linux.ibm.com

The locks for sndbufs and rmbs are never used from atomic context. Using
a mutex for these locks will allow to nest locks with other mutexes.

Signed-off-by: Karsten Graul <kgraul@linux.ibm.com>
Reviewed-by: Ursula Braun <ubraun@linux.ibm.com>
---
 net/smc/smc_core.c | 22 +++++++++++-----------
 net/smc/smc_core.h |  4 ++--
 2 files changed, 13 insertions(+), 13 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index a1463da14614..8a43d2948493 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -385,8 +385,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->freefast = 0;
 	lgr->freeing = 0;
 	lgr->vlan_id = ini->vlan_id;
-	rwlock_init(&lgr->sndbufs_lock);
-	rwlock_init(&lgr->rmbs_lock);
+	mutex_init(&lgr->sndbufs_lock);
+	mutex_init(&lgr->rmbs_lock);
 	rwlock_init(&lgr->conns_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
@@ -456,9 +456,9 @@ static void smcr_buf_unuse(struct smc_buf_desc *rmb_desc,
 	}
 	if (rmb_desc->is_reg_err) {
 		/* buf registration failed, reuse not possible */
-		write_lock_bh(&lgr->rmbs_lock);
+		mutex_lock(&lgr->rmbs_lock);
 		list_del(&rmb_desc->list);
-		write_unlock_bh(&lgr->rmbs_lock);
+		mutex_unlock(&lgr->rmbs_lock);
 
 		smc_buf_free(lgr, true, rmb_desc);
 	} else {
@@ -1059,19 +1059,19 @@ int smc_uncompress_bufsize(u8 compressed)
  * buffer size; if not available, return NULL
  */
 static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     rwlock_t *lock,
+					     struct mutex *lock,
 					     struct list_head *buf_list)
 {
 	struct smc_buf_desc *buf_slot;
 
-	read_lock_bh(lock);
+	mutex_lock(lock);
 	list_for_each_entry(buf_slot, buf_list, list) {
 		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			read_unlock_bh(lock);
+			mutex_unlock(lock);
 			return buf_slot;
 		}
 	}
-	read_unlock_bh(lock);
+	mutex_unlock(lock);
 	return NULL;
 }
 
@@ -1220,8 +1220,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
 	int bufsize, bufsize_short;
+	struct mutex *lock;	/* lock buffer list */
 	int sk_buf_size;
-	rwlock_t *lock;
 
 	if (is_rmb)
 		/* use socket recv buffer size (w/o overhead) as start value */
@@ -1262,9 +1262,9 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 			continue;
 
 		buf_desc->used = 1;
-		write_lock_bh(lock);
+		mutex_lock(lock);
 		list_add(&buf_desc->list, buf_list);
-		write_unlock_bh(lock);
+		mutex_unlock(lock);
 		break; /* found */
 	}
 
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d785656b3489..379ced490c49 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -205,9 +205,9 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
-	rwlock_t		sndbufs_lock;	/* protects tx buffers */
+	struct mutex		sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
-	rwlock_t		rmbs_lock;	/* protects rx buffers */
+	struct mutex		rmbs_lock;	/* protects rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
-- 
2.17.1
