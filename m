Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D71B01B1411;
	Wed, 14 Aug 2024 13:08:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723640921; cv=none; b=iJX/UQQkHrBm2iRcdWiP3zbUbwCpJRBcUHv8IdQSJ0vYLzCKpijz64DrHWkEJm2HtPucISa2XN4TPTa3sX3QFt3OENMS46rqA0Fe9BfCd9FatJyIaD0DYAaLQz02RTHNivV5johkaR+jqX5qL2TiE96CJjNkFNo+eEsmHlGbLAs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723640921; c=relaxed/simple;
	bh=kWKd8CrYKBTyk20GGV4zux/CcDL6491pCynvEVZYIFg=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=K6PI8FaRvJYc4Tk90/x2EHAwacpk3D2k6vhzFTf+XG2h89TshSrfteQ9LMghy/8UrsFftKeUDghqSgGweNCnWn1Z/Jm0FyqYiYPs6V94eQg8SSc9zXaNemkle0J5GSmmEzspHeUyov+dyjFxXliVvAGOxYzTim2mNEb45SlIepM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=F7D5SdQ5; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="F7D5SdQ5"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723640911; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=nt6eG0Swc5PkMelV6cokhN8CS8OzVEToW3s4zfZxV48=;
	b=F7D5SdQ5QrsmfOz0B73tY1VAFhRzDXSQi52VZVoYL+VIbQz9T9fpKHXcoic2Z+7tJ9VxMuPy7dzAf1AusOzQl4t9Nj8Us/8zcWfBC0DTXDFKJGJhe5nGJ3zDnHt+ldGuL6xGACdt4kFZq8006h8S9BYi719MgxlXQ0GmbZfEE58=
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCtIYTL_1723640909)
          by smtp.aliyun-inc.com;
          Wed, 14 Aug 2024 21:08:30 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-kernel@vger.kernel.org,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org
Subject: [PATCH net-next v3 1/2] net/smc: introduce statistics for allocated ringbufs of link group
Date: Wed, 14 Aug 2024 21:08:26 +0800
Message-Id: <20240814130827.73321-2-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20240814130827.73321-1-guwen@linux.alibaba.com>
References: <20240814130827.73321-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently we have the statistics on sndbuf/RMB sizes of all connections
that have ever been on the link group, namely smc_stats_memsize. However
these statistics are incremental and since the ringbufs of link group
are allowed to be reused, we cannot know the actual allocated buffers
through these. So here introduces the statistic on actual allocated
ringbufs of the link group, it will be incremented when a new ringbuf is
added into buf_list and decremented when it is deleted from buf_list.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 include/uapi/linux/smc.h |  4 ++++
 net/smc/smc_core.c       | 46 ++++++++++++++++++++++++++++++++++++----
 net/smc/smc_core.h       |  2 ++
 3 files changed, 48 insertions(+), 4 deletions(-)

diff --git a/include/uapi/linux/smc.h b/include/uapi/linux/smc.h
index b531e3ef011a..9b74ef79070a 100644
--- a/include/uapi/linux/smc.h
+++ b/include/uapi/linux/smc.h
@@ -127,6 +127,8 @@ enum {
 	SMC_NLA_LGR_R_NET_COOKIE,	/* u64 */
 	SMC_NLA_LGR_R_PAD,		/* flag */
 	SMC_NLA_LGR_R_BUF_TYPE,		/* u8 */
+	SMC_NLA_LGR_R_SNDBUF_ALLOC,	/* uint */
+	SMC_NLA_LGR_R_RMB_ALLOC,	/* uint */
 	__SMC_NLA_LGR_R_MAX,
 	SMC_NLA_LGR_R_MAX = __SMC_NLA_LGR_R_MAX - 1
 };
@@ -162,6 +164,8 @@ enum {
 	SMC_NLA_LGR_D_V2_COMMON,	/* nest */
 	SMC_NLA_LGR_D_EXT_GID,		/* u64 */
 	SMC_NLA_LGR_D_PEER_EXT_GID,	/* u64 */
+	SMC_NLA_LGR_D_SNDBUF_ALLOC,	/* uint */
+	SMC_NLA_LGR_D_DMB_ALLOC,	/* uint */
 	__SMC_NLA_LGR_D_MAX,
 	SMC_NLA_LGR_D_MAX = __SMC_NLA_LGR_D_MAX - 1
 };
diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 71fb334d8234..8dcf1c7f1526 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -221,6 +221,35 @@ static void smc_lgr_unregister_conn(struct smc_connection *conn)
 	write_unlock_bh(&lgr->conns_lock);
 }
 
+static void smc_lgr_buf_list_add(struct smc_link_group *lgr,
+				 bool is_rmb,
+				 struct list_head *buf_list,
+				 struct smc_buf_desc *buf_desc)
+{
+	list_add(&buf_desc->list, buf_list);
+	if (is_rmb) {
+		lgr->alloc_rmbs += buf_desc->len;
+		lgr->alloc_rmbs +=
+			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+	} else {
+		lgr->alloc_sndbufs += buf_desc->len;
+	}
+}
+
+static void smc_lgr_buf_list_del(struct smc_link_group *lgr,
+				 bool is_rmb,
+				 struct smc_buf_desc *buf_desc)
+{
+	list_del(&buf_desc->list);
+	if (is_rmb) {
+		lgr->alloc_rmbs -= buf_desc->len;
+		lgr->alloc_rmbs -=
+			lgr->is_smcd ? sizeof(struct smcd_cdc_msg) : 0;
+	} else {
+		lgr->alloc_sndbufs -= buf_desc->len;
+	}
+}
+
 int smc_nl_get_sys_info(struct sk_buff *skb, struct netlink_callback *cb)
 {
 	struct smc_nl_dmp_ctx *cb_ctx = smc_nl_dmp_ctx(cb);
@@ -363,6 +392,10 @@ static int smc_nl_fill_lgr(struct smc_link_group *lgr,
 	smc_target[SMC_MAX_PNETID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_R_PNETID, smc_target))
 		goto errattr;
+	if (nla_put_uint(skb, SMC_NLA_LGR_R_SNDBUF_ALLOC, lgr->alloc_sndbufs))
+		goto errattr;
+	if (nla_put_uint(skb, SMC_NLA_LGR_R_RMB_ALLOC, lgr->alloc_rmbs))
+		goto errattr;
 	if (lgr->smc_version > SMC_V1) {
 		v2_attrs = nla_nest_start(skb, SMC_NLA_LGR_R_V2_COMMON);
 		if (!v2_attrs)
@@ -541,6 +574,10 @@ static int smc_nl_fill_smcd_lgr(struct smc_link_group *lgr,
 		goto errattr;
 	if (nla_put_u32(skb, SMC_NLA_LGR_D_CHID, smc_ism_get_chid(lgr->smcd)))
 		goto errattr;
+	if (nla_put_uint(skb, SMC_NLA_LGR_D_SNDBUF_ALLOC, lgr->alloc_sndbufs))
+		goto errattr;
+	if (nla_put_uint(skb, SMC_NLA_LGR_D_DMB_ALLOC, lgr->alloc_rmbs))
+		goto errattr;
 	memcpy(smc_pnet, lgr->smcd->pnetid, SMC_MAX_PNETID_LEN);
 	smc_pnet[SMC_MAX_PNETID_LEN] = 0;
 	if (nla_put_string(skb, SMC_NLA_LGR_D_PNETID, smc_pnet))
@@ -1138,7 +1175,7 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
 		lock = is_rmb ? &lgr->rmbs_lock :
 				&lgr->sndbufs_lock;
 		down_write(lock);
-		list_del(&buf_desc->list);
+		smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
 		up_write(lock);
 
 		smc_buf_free(lgr, is_rmb, buf_desc);
@@ -1377,7 +1414,7 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 			buf_list = &lgr->sndbufs[i];
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
-			list_del(&buf_desc->list);
+			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
 			smc_buf_free(lgr, is_rmb, buf_desc);
 		}
 	}
@@ -2414,7 +2451,7 @@ static int __smc_buf_create(struct smc_sock *smc, bool is_smcd, bool is_rmb)
 		SMC_STAT_RMB_SIZE(smc, is_smcd, is_rmb, bufsize);
 		buf_desc->used = 1;
 		down_write(lock);
-		list_add(&buf_desc->list, buf_list);
+		smc_lgr_buf_list_add(lgr, is_rmb, buf_list, buf_desc);
 		up_write(lock);
 		break; /* found */
 	}
@@ -2496,7 +2533,8 @@ int smc_buf_create(struct smc_sock *smc, bool is_smcd)
 	rc = __smc_buf_create(smc, is_smcd, true);
 	if (rc && smc->conn.sndbuf_desc) {
 		down_write(&smc->conn.lgr->sndbufs_lock);
-		list_del(&smc->conn.sndbuf_desc->list);
+		smc_lgr_buf_list_del(smc->conn.lgr, false,
+				     smc->conn.sndbuf_desc);
 		up_write(&smc->conn.lgr->sndbufs_lock);
 		smc_buf_free(smc->conn.lgr, false, smc->conn.sndbuf_desc);
 		smc->conn.sndbuf_desc = NULL;
diff --git a/net/smc/smc_core.h b/net/smc/smc_core.h
index d93cf51dbd7c..0db4e5f79ac4 100644
--- a/net/smc/smc_core.h
+++ b/net/smc/smc_core.h
@@ -281,6 +281,8 @@ struct smc_link_group {
 	struct rw_semaphore	sndbufs_lock;	/* protects tx buffers */
 	struct list_head	rmbs[SMC_RMBE_SIZES];	/* rx buffers */
 	struct rw_semaphore	rmbs_lock;	/* protects rx buffers */
+	u64			alloc_sndbufs;	/* stats of tx buffers */
+	u64			alloc_rmbs;	/* stats of rx buffers */
 
 	u8			id[SMC_LGR_ID_SIZE];	/* unique lgr id */
 	struct delayed_work	free_work;	/* delayed freeing of an lgr */
-- 
2.32.0.3.g01195cf9f

