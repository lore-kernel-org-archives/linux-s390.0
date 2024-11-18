Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F32219AA5D;
	Mon, 18 Nov 2024 13:21:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.255
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731936118; cv=none; b=I/tfLLVCUU/zaOth0nyP1zEbTDaIT9BaMKkeuZPPOh8vHfhqbEg96kwsDdx5G7Ad/OZM/1rIHJfkMT8ATX5lrK9krckjveShEyPkPxSknfu4hNX3UhrHup5KwtEYQ5Pi4JhR1lxq9Zk3OzRGxHjjEi7bm55Q/uDwW81c404SpO4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731936118; c=relaxed/simple;
	bh=DuTE9GMNEpOYJ5LGxvSMmmRvvYSAyu97FrMXLiXzUxY=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=rDgIeOK0OPQArqhzIyT16cBDSmubZ4NsetU9+hNfRJHAVS48yJBFaj2METaYl5u9x+ppzdBzltU2FqzDvIWxOPSNRoiotvFlHb0f+7Md1ROpsBW7bFVFcDn9XgvlzJYqC24tX2twztUeI6ErM6idY6FVnfA1JZEVnxxjMBYAu7c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.255
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.162.254])
	by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4XsSrh00GVz1V4bk;
	Mon, 18 Nov 2024 21:19:15 +0800 (CST)
Received: from kwepemf200001.china.huawei.com (unknown [7.202.181.227])
	by mail.maildlp.com (Postfix) with ESMTPS id BC0E5180105;
	Mon, 18 Nov 2024 21:21:51 +0800 (CST)
Received: from huawei.com (10.110.54.32) by kwepemf200001.china.huawei.com
 (7.202.181.227) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 18 Nov
 2024 21:21:50 +0800
From: liqiang <liqiang64@huawei.com>
To: <wenjia@linux.ibm.com>, <jaka@linux.ibm.com>, <alibuda@linux.alibaba.com>,
	<tonylu@linux.alibaba.com>, <guwen@linux.alibaba.com>,
	<dust.li@linux.alibaba.com>
CC: <linux-s390@vger.kernel.org>, <netdev@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <luanjianhai@huawei.com>,
	<zhangxuzhou4@huawei.com>, <dengguangxing@huawei.com>,
	<gaochao24@huawei.com>, <liqiang64@huawei.com>
Subject: [PATCH net-next 1/1] Separate locks for rmbs/sndbufs linked lists of different lengths
Date: Mon, 18 Nov 2024 21:21:47 +0800
Message-ID: <20241118132147.1614-2-liqiang64@huawei.com>
X-Mailer: git-send-email 2.23.0.windows.1
In-Reply-To: <20241118132147.1614-1-liqiang64@huawei.com>
References: <20241118132147.1614-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemf200001.china.huawei.com (7.202.181.227)

Originally, an lgr-range lock was used to protect the rmbs/sndbufs linked 
list array. This patch splits the lock into one lock for each linked list.
The advantage of this is to avoid parallel competition between unrelated 
linked lists, thereby improving such Performance in scenarios.

Due to the change in the scope of the lock protection, some codes that 
were originally within the lock scope have also been adapted.

Signed-off-by: liqiang <liqiang64@huawei.com>
---
 net/smc/smc_core.c | 66 +++++++++++++++++++-------------------
 net/smc/smc_core.h |  9 +++---
 net/smc/smc_llc.c  | 79 +++++++++++++++++++++++++++++++++++++---------
 3 files changed, 103 insertions(+), 51 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 500952c2e67b..4c3b80e4cef0 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -228,11 +228,10 @@ static void smc_lgr_buf_list_add(struct smc_link_group *lgr,
 {
 	list_add(&buf_desc->list, buf_list);
 	if (is_rmb) {
-		lgr->alloc_rmbs += buf_desc->len;
-		lgr->alloc_rmbs +=
-			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+		atomic64_add(buf_desc->len, &lgr->alloc_rmbs);
+		atomic64_add(lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0, &lgr->alloc_rmbs);
 	} else {
-		lgr->alloc_sndbufs += buf_desc->len;
+		atomic64_add(buf_desc->len, &lgr->alloc_sndbufs);
 	}
 }
 
@@ -242,11 +241,10 @@ static void smc_lgr_buf_list_del(struct smc_link_group *lgr,
 {
 	list_del(&buf_desc->list);
 	if (is_rmb) {
-		lgr->alloc_rmbs -= buf_desc->len;
-		lgr->alloc_rmbs -=
-			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+		atomic64_sub(buf_desc->len, &lgr->alloc_rmbs);
+		atomic64_sub(lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0, &lgr->alloc_rmbs);
 	} else {
-		lgr->alloc_sndbufs -= buf_desc->len;
+		atomic64_sub(buf_desc->len, &lgr->alloc_sndbufs);
 	}
 }
 
@@ -392,9 +390,9 @@ static int smc_nl_fill_lgr(struct smc_link_group *lgr,
 	smc_target[SMC_MAX_PNETID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_R_PNETID, smc_target))
 		goto errattr;
-	if (nla_put_uint(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC, lgr->alloc_sndbufs))
+	if (nla_put_uint(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC, atomic64_read(&lgr->alloc_sndbufs)))
 		goto errattr;
-	if (nla_put_uint(skb, SMC_NLA_LGR_R_RMB_ALLOC, lgr->alloc_rmbs))
+	if (nla_put_uint(skb, SMC_NLA_LGR_R_RMB_ALLOC, atomic64_read(&lgr->alloc_rmbs)))
 		goto errattr;
 	if (lgr->smc_version > SMC_V1) {
 		v2_attrs = nla_nest_start(skb, SMC_NLA_LGR_R_V2_COMMON);
@@ -574,9 +572,9 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 		goto errattr;
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_CHID, smc_ism_get_chid(lgr->smcd)))
 		goto errattr;
-	if (nla_put_uint(skb, SMC_NLA_LGR_D_SNDBUF_ALLOC, lgr->alloc_sndbufs))
+	if (nla_put_uint(skb, SMC_NLA_LGR_D_SNDBUF_ALLOC, atomic64_read(&lgr->alloc_sndbufs)))
 		goto errattr;
-	if (nla_put_uint(skb, SMC_NLA_LGR_D_DMB_ALLOC, lgr->alloc_rmbs))
+	if (nla_put_uint(skb, SMC_NLA_LGR_D_DMB_ALLOC, atomic64_read(&lgr->alloc_rmbs)))
 		goto errattr;
 	memcpy(smc_pnet, lgr->smcd->pnetid, SMC_MAX_PNETID_LEN);
 	smc_pnet[SMC_MAX_PNETID_LEN] = 0;
@@ -903,13 +901,16 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
 	lgr->freeing = 0;
 	lgr->vlan_id = ini->vlan_id;
 	refcount_set(&lgr->refcnt, 1); /* set lgr refcnt to 1 */
-	init_rwsem(&lgr->sndbufs_lock);
-	init_rwsem(&lgr->rmbs_lock);
+
 	rwlock_init(&lgr->conns_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
 		INIT_LIST_HEAD(&lgr->rmbs[i]);
+		init_rwsem(&lgr->sndbufs_lock[i]);
+		init_rwsem(&lgr->rmbs_lock[i]);
 	}
+	atomic64_set(&lgr->alloc_rmbs, 0);
+	atomic64_set(&lgr->alloc_sndbufs, 0);
 	lgr->next_link_id = 0;
 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
 	memcpy(&lgr->id, (u8 *)&smc_lgr_list.num, SMC_LGR_ID_SIZE);
@@ -1172,8 +1173,8 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 
 	if (buf_desc->is_reg_err) {
 		/* buf registration failed, reuse not possible */
-		lock = is_rmb ? &lgr->rmbs_lock :
-				&lgr->sndbufs_lock;
+		lock = is_rmb ? &lgr->rmbs_lock[buf_desc->siz_comp] :
+				&lgr->sndbufs_lock[buf_desc->siz_comp];
 		down_write(lock);
 		smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
 		up_write(lock);
@@ -1303,16 +1304,16 @@ static void smcr_buf_unmap_lgr(struct smc_link *lnk)
 	int i;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		down_write(&lgr->rmbs_lock);
+		down_write(&lgr->rmbs_lock[i]);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list)
 			smcr_buf_unmap_link(buf_desc, true, lnk);
-		up_write(&lgr->rmbs_lock);
+		up_write(&lgr->rmbs_lock[i]);
 
-		down_write(&lgr->sndbufs_lock);
+		down_write(&lgr->sndbufs_lock[i]);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->sndbufs[i],
 					 list)
 			smcr_buf_unmap_link(buf_desc, false, lnk);
-		up_write(&lgr->sndbufs_lock);
+		up_write(&lgr->sndbufs_lock[i]);
 	}
 }
 
@@ -2238,11 +2239,11 @@ int smcr_buf_map_lgr(struct smc_link *lnk)
 	int i, rc = 0;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		rc = _smcr_buf_map_lgr(lnk, &lgr->rmbs_lock,
+		rc = _smcr_buf_map_lgr(lnk, &lgr->rmbs_lock[i],
 				       &lgr->rmbs[i], true);
 		if (rc)
 			return rc;
-		rc = _smcr_buf_map_lgr(lnk, &lgr->sndbufs_lock,
+		rc = _smcr_buf_map_lgr(lnk, &lgr->sndbufs_lock[i],
 				       &lgr->sndbufs[i], false);
 		if (rc)
 			return rc;
@@ -2260,37 +2261,37 @@ int smcr_buf_reg_lgr(struct smc_link *lnk)
 	int i, rc = 0;
 
 	/* reg all RMBs for a new link */
-	down_write(&lgr->rmbs_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
+		down_write(&lgr->rmbs_lock[i]);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->rmbs[i], list) {
 			if (!buf_desc->used)
 				continue;
 			rc = smcr_link_reg_buf(lnk, buf_desc);
 			if (rc) {
-				up_write(&lgr->rmbs_lock);
+				up_write(&lgr->rmbs_lock[i]);
 				return rc;
 			}
 		}
+		up_write(&lgr->rmbs_lock[i]);
 	}
-	up_write(&lgr->rmbs_lock);
 
 	if (lgr->buf_type == SMCR_PHYS_CONT_BUFS)
 		return rc;
 
 	/* reg all vzalloced sndbufs for a new link */
-	down_write(&lgr->sndbufs_lock);
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
+		down_write(&lgr->sndbufs_lock[i]);
 		list_for_each_entry_safe(buf_desc, bf, &lgr->sndbufs[i], list) {
 			if (!buf_desc->used || !buf_desc->is_vm)
 				continue;
 			rc = smcr_link_reg_buf(lnk, buf_desc);
 			if (rc) {
-				up_write(&lgr->sndbufs_lock);
+				up_write(&lgr->sndbufs_lock[i]);
 				return rc;
 			}
 		}
+		up_write(&lgr->sndbufs_lock[i]);
 	}
-	up_write(&lgr->sndbufs_lock);
 	return rc;
 }
 
@@ -2423,10 +2424,10 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 	for (bufsize_comp = smc_compress_bufsize(bufsize, is_smcd, is_rmb);
 	     bufsize_comp >= 0; bufsize_comp--) {
 		if (is_rmb) {
-			lock = &lgr->rmbs_lock;
+			lock = &lgr->rmbs_lock[bufsize_comp];
 			buf_list = &lgr->rmbs[bufsize_comp];
 		} else {
-			lock = &lgr->sndbufs_lock;
+			lock = &lgr->sndbufs_lock[bufsize_comp];
 			buf_list = &lgr->sndbufs[bufsize_comp];
 		}
 		bufsize = smc_uncompress_bufsize(bufsize_comp);
@@ -2458,6 +2459,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		SMC_STAT_RMB_ALLOC(smc, is_smcd, is_rmb);
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, true, bufsize);
 		buf_desc->used = 1;
+		buf_desc->siz_comp = bufsize_comp;
 		down_write(lock);
 		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
@@ -2540,10 +2542,10 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	/* create rmb */
 	rc = __smc_buf_create(smc, is_smcd, true);
 	if (rc && smc->conn.sndbuf_desc) {
-		down_write(&smc->conn.lgr->sndbufs_lock);
+		down_write(&smc->conn.lgr->sndbufs_lock[smc->conn.sndbuf_desc->siz_comp]);
 		smc_lgr_buf_list_del(smc->conn.lgr, false,
 				     smc->conn.sndbuf_desc);
-		up_write(&smc->conn.lgr->sndbufs_lock);
+		up_write(&smc->conn.lgr->sndbufs_lock[smc->conn.sndbuf_desc->siz_comp]);
 		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
 		smc->conn.sndbuf_desc = NULL;
 	}
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index 69b54ecd6503..acf1b4f82997 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -192,6 +192,7 @@ struct smc_buf_desc {
 	struct page		*pages;
 	int			len;		/* length of buffer */
 	u32			used;		/* currently used / unused */
+	int			siz_comp;
 	union {
 		struct { /* SMC-R */
 			struct sg_table	sgt[SMC_LINKS_PER_LGR_MAX];
@@ -278,11 +279,11 @@ struct smc_link_group {
 	unsigned short		vlan_id;	/* vlan id of link group */
 
 	struct list_head	sndbufs[SMC_RMBE_SIZES];/* tx buffers */
-	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
+	struct rw_semaphore	sndbufs_lock[SMC_RMBE_SIZES];	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
-	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
-	u64			alloc_sndbufs;	/* stats of tx buffers */
-	u64			alloc_rmbs;	/* stats of rx buffers */
+	struct rw_semaphore	rmbs_lock[SMC_RMBE_SIZES];	/* protects rx buffers */
+	atomic64_t			alloc_sndbufs;	/* stats of tx buffers */
+	atomic64_t			alloc_rmbs;	/* stats of rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
diff --git a/net/smc/smc_llc.c b/net/smc/smc_llc.c
index 018ce8133b02..94cb96182836 100644
--- a/net/smc/smc_llc.c
+++ b/net/smc/smc_llc.c
@@ -559,6 +559,42 @@ static int smc_llc_send_delete_rkey(struct smc_link *link,
 	return rc;
 }
 
+enum {
+	SMC_LLC_INTURN_LOCK_INIT,
+	SMC_LLC_INTURN_LOCK_INCR,
+	SMC_LLC_INTURN_LOCK_OVER,
+};
+
+/*
+ * Use different locks for different rmbs/sendbufs. When traversing processing,
+ * only the currently traversed linked list is locked at the same time.
+ */
+static void smc_llc_lock_in_turn(struct rw_semaphore *lock, int *buf_lst, int type)
+{
+	switch (type) {
+	/* set to 0 */
+	case SMC_LLC_INTURN_LOCK_INIT:
+		*buf_lst = 0;
+		down_write(&lock[*buf_lst]);
+		break;
+	/* Release previous lock and lock next */
+	case SMC_LLC_INTURN_LOCK_INCR:
+		up_write(&lock[*buf_lst]);
+		*buf_lst += 1;
+		if (*buf_lst >= SMC_RMBE_SIZES)
+			break;
+		down_write(&lock[*buf_lst]);
+		break;
+	case SMC_LLC_INTURN_LOCK_OVER:
+		if (*buf_lst < 0 || *buf_lst >= SMC_RMBE_SIZES)
+			break;
+		up_write(&lock[*buf_lst]);
+		break;
+	default:
+		break;
+	}
+}
+
 /* return first buffer from any of the next buf lists */
 static struct smc_buf_desc *_smc_llc_get_next_rmb(struct smc_link_group *lgr,
 						  int *buf_lst)
@@ -570,7 +606,7 @@ static struct smc_buf_desc *_smc_llc_get_next_rmb(struct smc_link_group *lgr,
 						   struct smc_buf_desc, list);
 		if (buf_pos)
 			return buf_pos;
-		(*buf_lst)++;
+		smc_llc_lock_in_turn(lgr->rmbs_lock, buf_lst, SMC_LLC_INTURN_LOCK_INCR);
 	}
 	return NULL;
 }
@@ -586,7 +622,7 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
 		return _smc_llc_get_next_rmb(lgr, buf_lst);
 
 	if (list_is_last(&buf_pos->list, &lgr->rmbs[*buf_lst])) {
-		(*buf_lst)++;
+		smc_llc_lock_in_turn(lgr->rmbs_lock, buf_lst, SMC_LLC_INTURN_LOCK_INCR);
 		return _smc_llc_get_next_rmb(lgr, buf_lst);
 	}
 	buf_next = list_next_entry(buf_pos, list);
@@ -596,10 +632,26 @@ static struct smc_buf_desc *smc_llc_get_next_rmb(struct smc_link_group *lgr,
 static struct smc_buf_desc *smc_llc_get_first_rmb(struct smc_link_group *lgr,
 						  int *buf_lst)
 {
-	*buf_lst = 0;
+	smc_llc_lock_in_turn(lgr->rmbs_lock, buf_lst, SMC_LLC_INTURN_LOCK_INIT);
 	return smc_llc_get_next_rmb(lgr, buf_lst, NULL);
 }
 
+static inline void smc_llc_bufs_wrlock_all(struct rw_semaphore *lock, int nums)
+{
+	int i = 0;
+
+	for (; i < nums; i++)
+		down_write(&lock[i]);
+}
+
+static inline void smc_llc_bufs_wrunlock_all(struct rw_semaphore *lock, int nums)
+{
+	int i = 0;
+
+	for (; i < nums; i++)
+		up_write(&lock[i]);
+}
+
 static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 			       struct smc_link *link, struct smc_link *link_new)
 {
@@ -608,18 +660,17 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 	int prim_lnk_idx, lnk_idx, i;
 	struct smc_buf_desc *rmb;
 	int len = sizeof(*ext);
-	int buf_lst;
+	int buf_lst = -1;
 
 	ext->v2_direct = !lgr->uses_gateway;
 	memcpy(ext->client_target_gid, link_new->gid, SMC_GID_SIZE);
 
 	prim_lnk_idx = link->link_idx;
 	lnk_idx = link_new->link_idx;
-	down_write(&lgr->rmbs_lock);
+	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	ext->num_rkeys = lgr->conns_num;
 	if (!ext->num_rkeys)
 		goto out;
-	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	for (i = 0; i < ext->num_rkeys; i++) {
 		while (buf_pos && !(buf_pos)->used)
 			buf_pos = smc_llc_get_next_rmb(lgr, &buf_lst, buf_pos);
@@ -635,7 +686,7 @@ static int smc_llc_fill_ext_v2(struct smc_llc_msg_add_link_v2_ext *ext,
 	}
 	len += i * sizeof(ext->rt[0]);
 out:
-	up_write(&lgr->rmbs_lock);
+	smc_llc_lock_in_turn(lgr->rmbs_lock, &buf_lst, SMC_LLC_INTURN_LOCK_OVER);
 	return len;
 }
 
@@ -892,13 +943,12 @@ static int smc_llc_cli_rkey_exchange(struct smc_link *link,
 	u8 max, num_rkeys_send, num_rkeys_recv;
 	struct smc_llc_qentry *qentry;
 	struct smc_buf_desc *buf_pos;
-	int buf_lst;
+	int buf_lst = -1;
 	int rc = 0;
 	int i;
 
-	down_write(&lgr->rmbs_lock);
-	num_rkeys_send = lgr->conns_num;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
+	num_rkeys_send = lgr->conns_num;
 	do {
 		qentry = smc_llc_wait(lgr, NULL, SMC_LLC_WAIT_TIME,
 				      SMC_LLC_ADD_LINK_CONT);
@@ -923,7 +973,7 @@ static int smc_llc_cli_rkey_exchange(struct smc_link *link,
 			break;
 	} while (num_rkeys_send || num_rkeys_recv);
 
-	up_write(&lgr->rmbs_lock);
+	smc_llc_lock_in_turn(lgr->rmbs_lock, &buf_lst, SMC_LLC_INTURN_LOCK_OVER);
 	return rc;
 }
 
@@ -1006,14 +1056,14 @@ static void smc_llc_save_add_link_rkeys(struct smc_link *link,
 	ext = (struct smc_llc_msg_add_link_v2_ext *)((u8 *)lgr->wr_rx_buf_v2 +
 						     SMC_WR_TX_SIZE);
 	max = min_t(u8, ext->num_rkeys, SMC_LLC_RKEYS_PER_MSG_V2);
-	down_write(&lgr->rmbs_lock);
+	smc_llc_bufs_wrlock_all(lgr->rmbs_lock, SMC_RMBE_SIZES);
 	for (i = 0; i < max; i++) {
 		smc_rtoken_set(lgr, link->link_idx, link_new->link_idx,
 			       ext->rt[i].rmb_key,
 			       ext->rt[i].rmb_vaddr_new,
 			       ext->rt[i].rmb_key_new);
 	}
-	up_write(&lgr->rmbs_lock);
+	smc_llc_bufs_wrunlock_all(lgr->rmbs_lock, SMC_RMBE_SIZES);
 }
 
 static void smc_llc_save_add_link_info(struct smc_link *link,
@@ -1328,7 +1378,6 @@ static int smc_llc_srv_rkey_exchange(struct smc_link *link,
 	int rc = 0;
 	int i;
 
-	down_write(&lgr->rmbs_lock);
 	num_rkeys_send = lgr->conns_num;
 	buf_pos = smc_llc_get_first_rmb(lgr, &buf_lst);
 	do {
@@ -1353,7 +1402,7 @@ static int smc_llc_srv_rkey_exchange(struct smc_link *link,
 		smc_llc_flow_qentry_del(&lgr->llc_flow_lcl);
 	} while (num_rkeys_send || num_rkeys_recv);
 out:
-	up_write(&lgr->rmbs_lock);
+	smc_llc_lock_in_turn(lgr->rmbs_lock, &buf_lst, SMC_LLC_INTURN_LOCK_OVER);
 	return rc;
 }
 
-- 
2.43.0

