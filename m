Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8EED620B204;
	Tue, 12 Nov 2024 09:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731403347; cv=none; b=kksZ6JRVDBj8jIIX4or4B0ekvr6uFKvWXD1VNnjrYsK14W+qER2ugbdiXvS6PyqzYscUkPqi+UT5hPZRGFMMi27WGXX+lhrpPk1YaWtxxBqs2mhm6iM8sy0IRxG+iPEOZ6gJFKfWuBuF+N8rCYEMelUk3VjZA0HWtI9uBEfdIXw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731403347; c=relaxed/simple;
	bh=wyzkOfKBkI8eONDpodoPyWUFD1azA2qAOWp+4varxPU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=NFc0IDxM6Hi7hLxOhNbRge5a6SPRZXYd0+2qz0vMevVmM+tW7THR+1eJDj4oxF9yzrOXHOKlJ+6V0y0EG0mkP5vrmFijDr4l6ruSgMSgF34grx2Kpcjvonmw/zUZ92R/9x+uUs7ddXdOtQCK0hzJAJz1b4hXY6xBx8hFgx4VtrU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XngqD54Stz1TB1Q;
	Tue, 12 Nov 2024 17:19:52 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 6A87118006C;
	Tue, 12 Nov 2024 17:22:20 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 12 Nov
 2024 17:22:18 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<dust.li@linux.alibaba.com>, <kuba@kernel.org>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next v3] net/smc: Optimize the search method of reused buf_desc
Date: Tue, 12 Nov 2024 17:22:16 +0800
Message-ID: <20241112092216.1439-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20241105031938.1319-1-liqiang64@huawei.com>
References: <20241105031938.1319-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 kwepemf200001.china.huawei.com (7.202.181.227)

We create a lock-less link list for the currently
idle reusable smc_buf_desc.

When the 'used' filed mark to 0, it is added to
the lock-less linked list.

When a new connection is established, a suitable
element is obtained directly, which eliminates the
need for traversal and search, and does not require
locking resource.

Through my testing, this patch can significantly improve 
the link establishment speed of SMC, especially in the 
multi-threaded short connection benchmark.

I tested the time-consuming comparison of this function
under multiple connections based on redis-benchmark
(test in smc loopback-ism mode):

The function 'smc_buf_get_slot' takes less time when a
new SMC link is established:
1. 5us->100ns (when there are 200 active links);
2. 30us->100ns (when there are 1000 active links).

Test data with wrk+nginx command:
On server:
smc_run nginx

On client:
smc_run wrk -t <2~64> -c 200 -H "Connection: close" http://127.0.0.1

Requests/sec
--------+---------------+---------------+
req/s   | without patch | apply patch   |
--------+---------------+---------------+
-t 2    |6924.18        |7456.54        |
--------+---------------+---------------+
-t 4    |8731.68        |9660.33        |
--------+---------------+---------------+
-t 8    |11363.22       |13802.08       |
--------+---------------+---------------+
-t 16   |12040.12       |18666.69       |
--------+---------------+---------------+
-t 32   |11460.82       |17017.28       |
--------+---------------+---------------+
-t 64   |11018.65       |14974.80       |
--------+---------------+---------------+

Transfer/sec
--------+---------------+---------------+
trans/s | without patch | apply patch   |
--------+---------------+---------------+
-t 2    |24.72MB        |26.62MB        |
--------+---------------+---------------+
-t 4    |31.18MB        |34.49MB        |
--------+---------------+---------------+
-t 8    |40.57MB        |49.28MB        |
--------+---------------+---------------+
-t 16   |42.99MB        |66.65MB        |
--------+---------------+---------------+
-t 32   |40.92MB        |60.76MB        |
--------+---------------+---------------+
-t 64   |39.34MB        |53.47MB        |
--------+---------------+---------------+

Test environment:
QEMU emulator version 1.5.3 @ Intel(R) Xeon(R) CPU E5-2680 v4 @ 2.40GHz

Signed-off-by: liqiang <liqiang64@huawei.com>
---
v3:
- Add lock protection to llist_del_first according to the module description.
- Restore the read-write lock with the used mark set.
v2: https://lore.kernel.org/all/20241105031938.1319-1-liqiang64@huawei.com/
- Correct the acquisition logic of a lock-less linked list.(Dust.Li)
- fix comment symbol '//' -> '/**/'.(Dust.Li)
v1: https://lore.kernel.org/all/20241101082342.1254-1-liqiang64@huawei.com/

 net/smc/smc_core.c | 65 +++++++++++++++++++++++++++++++++-------------
 net/smc/smc_core.h |  6 +++++
 2 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..238eb61ac653 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -16,6 +16,7 @@
 #include <linux/wait.h>
 #include <linux/reboot.h>
 #include <linux/mutex.h>
+#include <linux/llist.h>
 #include <linux/list.h>
 #include <linux/smc.h>
 #include <net/tcp.h>
@@ -906,9 +907,13 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	init_rwsem(&lgr->sndbufs_lock);
 	init_rwsem(&lgr->rmbs_lock);
 	rwlock_init(&lgr->conns_lock);
+	spin_lock_init(&lgr->sndbufs_free_lock);
+	spin_lock_init(&lgr->rmbs_free_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
+		init_llist_head(&lgr->rmbs_free[i]);
+		init_llist_head(&lgr->sndbufs_free[i]);
 	}
 	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
@@ -1183,6 +1188,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		/* memzero_explicit provides potential memory barrier semantics */
 		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
 		WRITE_ONCE(buf_desc->used, 0);
+		if (is_rmb)
+			llist_add(&buf_desc->llist, &lgr->rmbs_free[buf_desc->bufsiz_comp]);
+		else
+			llist_add(&buf_desc->llist, &lgr->sndbufs_free[buf_desc->bufsiz_comp]);
 	}
 }
 
@@ -1214,6 +1223,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		} else {
 			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
+			llist_add(&conn->sndbuf_desc->llist,
+				  &lgr->sndbufs_free[conn->sndbuf_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, false, false, bufsize);
 	}
@@ -1225,6 +1236,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 			bufsize += sizeof(struct smcd_cdc_msg);
 			memzero_explicit(conn->rmb_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->rmb_desc->used, 0);
+			llist_add(&conn->rmb_desc->llist,
+				  &lgr->rmbs_free[conn->rmb_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
 	}
@@ -1413,13 +1426,21 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 {
 	struct smc_buf_desc *buf_desc, *bf_desc;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int i;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		if (is_rmb)
+		if (is_rmb) {
 			buf_list = &lgr->rmbs[i];
-		else
+			buf_llist = &lgr->rmbs_free[i];
+		} else {
 			buf_list = &lgr->sndbufs[i];
+			buf_llist = &lgr->sndbufs_free[i];
+		}
+		/* just invalid this list first, and then free the memory
+		 * in the following loop
+		 */
+		llist_del_all(buf_llist);
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
 			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
@@ -2087,24 +2108,25 @@ int smc_uncompress_bufsize(u8 compressed)
 	return (int)size;
 }
 
-/* try to reuse a sndbuf or rmb description slot for a certain
- * buffer size; if not available, return NULL
- */
-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct rw_semaphore *lock,
-					     struct list_head *buf_list)
+/* use lock less list to save and find reuse buf desc */
+static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist,
+						  spinlock_t *llock, struct rw_semaphore *lock)
 {
-	struct smc_buf_desc *buf_slot;
+	struct smc_buf_desc *buf_free;
+	struct llist_node *llnode;
+
+	/* lock-less link list don't need an lock */
+	spin_lock(llock);
+	llnode = llist_del_first(buf_llist);
+	spin_unlock(llock);
+	if (!llnode)
+		return NULL;
+	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
 
 	down_read(lock);
-	list_for_each_entry(buf_slot, buf_list, list) {
-		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			up_read(lock);
-			return buf_slot;
-		}
-	}
+	WRITE_ONCE(buf_free->used, 1);
 	up_read(lock);
-	return NULL;
+	return buf_free;
 }
 
 /* one of the conditions for announcing a receiver's current window size is
@@ -2409,8 +2431,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int bufsize, bufsize_comp;
 	struct rw_semaphore *lock;	/* lock buffer list */
+	spinlock_t *llock;
 	bool is_dgraded = false;
 
 	if (is_rmb)
@@ -2424,15 +2448,19 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
+			llock = &lgr->rmbs_free_lock;
+			buf_llist = &lgr->rmbs_free[bufsize_comp];
 			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
 			lock = &lgr->sndbufs_lock;
+			llock = &lgr->sndbufs_free_lock;
+			buf_llist = &lgr->sndbufs_free[bufsize_comp];
 			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
+		buf_desc = smc_buf_get_slot_free(buf_llist, llock, lock);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
@@ -2457,7 +2485,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
-		buf_desc->used = 1;
+		WRITE_ONCE(buf_desc->used, 1);
+		WRITE_ONCE(buf_desc->bufsiz_comp, bufsize_comp);
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd6503..2f45a21796ae 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -188,10 +188,12 @@ struct smc_link {
 /* tx/rx buffer list element for sndbufs list and rmbs list of a lgr */
 struct smc_buf_desc {
 	struct list_head	list;
+	struct llist_node	llist;
 	void			*cpu_addr;	/* virtual address of buffer */
 	struct page		*pages;
 	int			len;		/* length of buffer */
 	u32			used;		/* currently used / unused */
+	int			bufsiz_comp;
 	union {
 		struct { /* SMC-R */
 			struct sg_table	sgt[SMC_LINKS_PER_LGR_MAX];
@@ -278,8 +280,12 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
+	struct llist_head	sndbufs_free[SMC_RMBE_SIZES]; /* tx buffer free list */
+	spinlock_t		sndbufs_free_lock;
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
+	struct llist_head	rmbs_free[SMC_RMBE_SIZES]; /* rx buffer free list */
+	spinlock_t		rmbs_free_lock;
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
 	u64			alloc_sndbufs;	/* stats of tx buffers */
 	u64			alloc_rmbs;	/* stats of rx buffers */
-- 
2.43.0

