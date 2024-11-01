Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50DC81527A7;
	Fri,  1 Nov 2024 08:23:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.187
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730449432; cv=none; b=alCRrxGWTSSEaH1cV3E+Y94gdpp09ERFw0xyh7qvKKUvtAZlFTgB7RDF5/jvSPK+9/qT7tZtbOQ3JhcS6ooXsKMAsJejjxIve1HhzR35mkiD9XokgSVme9cmMRnC1ZpKqV1YHfNAMmkuNJXB4y+qZ8IblfrMl++J9hilYdJzjus=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730449432; c=relaxed/simple;
	bh=pEoiSd5vw/jhcXi92KOT//+tkj3TAND88ofiNakYp4U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=rWxnLVEQcWr5DPNlkEoCj/oVIAZZ118UVVsnYcXCpHYH/xkxp/sZBFlHjE75ZzVotrtLMZGGqS+iIie8hN5doTaNiaJwAhsalScWwarN1PclKOMsbflOTdVOtF1W3qOA8M6bsLyM7zSEMDf+K4jQuTctRl+9+uikNcqdW+4T++8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.187
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.88.194])
	by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Xfv3c6szwzyV15;
	Fri,  1 Nov 2024 16:22:04 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id 20934140B08;
	Fri,  1 Nov 2024 16:23:46 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 1 Nov
 2024 16:23:44 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <kuba@kernel.org>, <dust.li@linux.alibaba.com>
Subject: [PATCH net-next] net/smc: Optimize the search method of reused buf_desc
Date: Fri, 1 Nov 2024 16:23:42 +0800
Message-ID: <20241101082342.1254-1-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 kwepemf200001.china.huawei.com (7.202.181.227)

We create a lock-less link list for the currently 
idle reusable smc_buf_desc.

When the 'used' filed mark to 0, it is added to 
the lock-less linked list. 

When a new connection is established, a suitable 
element is obtained directly, which eliminates the 
need for traversal and search, and does not require 
locking resource.

A lock-less linked list is a linked list that uses 
atomic operations to optimize the producer-consumer model.

I didn't find a suitable public benchmark, so I tested the 
time-consuming comparison of this function under multiple 
connections based on redis-benchmark (test in smc loopback-ism mode):

    1. On the current version:
        [x.832733] smc_buf_get_slot cost:602 ns, walk 10 buf_descs
        [x.832860] smc_buf_get_slot cost:329 ns, walk 12 buf_descs
        [x.832999] smc_buf_get_slot cost:479 ns, walk 17 buf_descs
        [x.833157] smc_buf_get_slot cost:679 ns, walk 13 buf_descs
        ...
        [x.045240] smc_buf_get_slot cost:5528 ns, walk 196 buf_descs
        [x.045389] smc_buf_get_slot cost:4721 ns, walk 197 buf_descs
        [x.045537] smc_buf_get_slot cost:4075 ns, walk 198 buf_descs
        [x.046010] smc_buf_get_slot cost:6476 ns, walk 199 buf_descs

    2. Apply this patch:
        [x.180857] smc_buf_get_slot_free cost:75 ns
        [x.181001] smc_buf_get_slot_free cost:147 ns
        [x.181128] smc_buf_get_slot_free cost:97 ns
        [x.181282] smc_buf_get_slot_free cost:132 ns
        [x.181451] smc_buf_get_slot_free cost:74 ns

It can be seen from the data that it takes about 5~6us to traverse 200 
times, and the time complexity of the lock-less linked algorithm is O(1).

And my test process is only single-threaded. If multiple threads 
establish SMC connections in parallel, locks will also become a 
bottleneck, and lock-less linked can solve this problem well.

SO I guess this patch should be beneficial in scenarios where a 
large number of short connections are parallel?


Signed-off-by: liqiang <liqiang64@huawei.com>
---
 net/smc/smc_core.c | 57 ++++++++++++++++++++++++++++++----------------
 net/smc/smc_core.h |  4 ++++
 2 files changed, 41 insertions(+), 20 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..85dbb366274a 100644
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
@@ -909,6 +910,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
+		init_llist_head(&lgr->rmbs_free[i]);
+		init_llist_head(&lgr->sndbufs_free[i]);
 	}
 	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
@@ -1183,6 +1186,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		/* memzero_explicit provides potential memory barrier semantics */
 		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
 		WRITE_ONCE(buf_desc->used, 0);
+		if (is_rmb)
+			llist_add(&buf_desc->llist, &lgr->rmbs_free[buf_desc->bufsiz_comp]);
+		else
+			llist_add(&buf_desc->llist, &lgr->sndbufs_free[buf_desc->bufsiz_comp]);
 	}
 }
 
@@ -1214,6 +1221,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 		} else {
 			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
+			llist_add(&conn->sndbuf_desc->llist,
+				  &lgr->sndbufs_free[conn->sndbuf_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, false, false, bufsize);
 	}
@@ -1225,6 +1234,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
 			bufsize += sizeof(struct smcd_cdc_msg);
 			memzero_explicit(conn->rmb_desc->cpu_addr, bufsize);
 			WRITE_ONCE(conn->rmb_desc->used, 0);
+			llist_add(&conn->rmb_desc->llist,
+				  &lgr->rmbs_free[conn->rmb_desc->bufsiz_comp]);
 		}
 		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
 	}
@@ -1413,13 +1424,20 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
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
+		// just invalid this list first, and then free the memory
+		// in the following loop
+		llist_del_all(buf_llist);
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
 			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
@@ -2087,24 +2105,19 @@ int smc_uncompress_bufsize(u8 compressed)
 	return (int)size;
 }
 
-/* try to reuse a sndbuf or rmb description slot for a certain
- * buffer size; if not available, return NULL
- */
-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
-					     struct rw_semaphore *lock,
-					     struct list_head *buf_list)
+/* use lock less list to save and find reuse buf desc */
+static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
 {
-	struct smc_buf_desc *buf_slot;
+	struct smc_buf_desc *buf_free;
+	struct llist_node *llnode;
 
-	down_read(lock);
-	list_for_each_entry(buf_slot, buf_list, list) {
-		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
-			up_read(lock);
-			return buf_slot;
-		}
-	}
-	up_read(lock);
-	return NULL;
+	if (llist_empty(buf_llist))
+		return NULL;
+	// lock-less link list don't need an lock
+	llnode = llist_del_first(buf_llist);
+	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
+	WRITE_ONCE(buf_free->used, 1);
+	return buf_free;
 }
 
 /* one of the conditions for announcing a receiver's current window size is
@@ -2409,6 +2422,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	struct smc_connection *conn = &smc->conn;
 	struct smc_link_group *lgr = conn->lgr;
 	struct list_head *buf_list;
+	struct llist_head *buf_llist;
 	int bufsize, bufsize_comp;
 	struct rw_semaphore *lock;	/* lock buffer list */
 	bool is_dgraded = false;
@@ -2424,15 +2438,17 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
 			lock = &lgr->rmbs_lock;
+			buf_llist = &lgr->rmbs_free[bufsize_comp];
 			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
 			lock = &lgr->sndbufs_lock;
+			buf_llist = &lgr->sndbufs_free[bufsize_comp];
 			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
 
 		/* check for reusable slot in the link group */
-		buf_desc = smc_buf_get_slot(bufsize_comp, lock, buf_list);
+		buf_desc = smc_buf_get_slot_free(buf_llist);
 		if (buf_desc) {
 			buf_desc->is_dma_need_sync = 0;
 			SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
@@ -2457,7 +2473,8 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
-		buf_desc->used = 1;
+		WRITE_ONCE(buf_desc->used, 1);
+		WRITE_ONCE(buf_desc->bufsiz_comp, bufsize_comp);
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd6503..076ee15f5c10 100644
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
@@ -278,8 +280,10 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
+	struct llist_head	sndbufs_free[SMC_RMBE_SIZES]; /* tx buffer free list */
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
+	struct llist_head	rmbs_free[SMC_RMBE_SIZES]; /* rx buffer free list */
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
 	u64			alloc_sndbufs;	/* stats of tx buffers */
 	u64			alloc_rmbs;	/* stats of rx buffers */
-- 
2.43.0

