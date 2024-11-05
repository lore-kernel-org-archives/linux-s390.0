Received: from out30-118.freemail.mail.aliyun.com (out30-118.freemail.mail.aliyun.com [115.124.30.118])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CF691D95A4;
	Tue,  5 Nov 2024 14:45:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.118
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730817905; cv=none; b=VQBHpfyAWG4HgiM72dbFAv93K7K8QXZHRv1a0qHA8aDuGiXS2oKcZwVjbXesplks/5NcP3S3Uz97R+ehGZ2XgAkYfe53EpJJxdPReDqcqjVtyvL31vCiRqEXTjD2S/+LnweHW3T+2tS76nsI2ogs7FN42aZ6SdltVAM6flZHtZ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730817905; c=relaxed/simple;
	bh=NBhv007oegK3QiD4ZEnOaHiTOAgukYUFeGfQIFPAJTw=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=oLmYWnjuZ6aG/RSOo8REdnIO16pSgiCliN71/gx3TFmcRolT77K22831Vw3t0hsDrhpW45DgEd+ANnoyTd3iZpIaa26jX/MhblWtAgynmWoNwLx8Vjky7FmKJ/BAX/CKKD8nxsrQjqYdqz43W5LP0VscnhXI58M1Z1VO6pi1lCc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=lDuEtyai; arc=none smtp.client-ip=115.124.30.118
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="lDuEtyai"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1730817898; h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
	bh=Bl8dUu38mV34PNYl4s6+f0+cpEYr9/tiFmLIhR9wbg0=;
	b=lDuEtyaiTy/8wxR2h1oLquUJX2hln9KhDn/v9kTC6K+cRFTKsiy0jFewkA/9dagMFMvzGn9u6yflI+sLy9yF6XFSTK4Nz4Qic03/ZnVHeW2y9cJs0ZRz39yacqCMoCYFYbq+iywLcYyKMaWr5o7Yd6eu/Fn3BlCBnYWuy6Hpqn4=
Received: from localhost(mailfrom:dust.li@linux.alibaba.com fp:SMTPD_---0WInGHW._1730817897 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 05 Nov 2024 22:44:58 +0800
Date: Tue, 5 Nov 2024 22:44:57 +0800
From: Dust Li <dust.li@linux.alibaba.com>
To: liqiang <liqiang64@huawei.com>, wenjia@linux.ibm.com,
	jaka@linux.ibm.com, alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com, guwen@linux.alibaba.com, kuba@kernel.org
Cc: linux-s390@vger.kernel.org, netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org, luanjianhai@huawei.com,
	zhangxuzhou4@huawei.com, dengguangxing@huawei.com,
	gaochao24@huawei.com
Subject: Re: [PATCH v2 net-next] net/smc: Optimize the search method of
 reused buf_desc
Message-ID: <20241105144457.GB89669@linux.alibaba.com>
Reply-To: dust.li@linux.alibaba.com
References: <20241101082342.1254-1-liqiang64@huawei.com>
 <20241105031938.1319-1-liqiang64@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241105031938.1319-1-liqiang64@huawei.com>

On 2024-11-05 11:19:38, liqiang wrote:
>We create a lock-less link list for the currently
>idle reusable smc_buf_desc.
>
>When the 'used' filed mark to 0, it is added to
>the lock-less linked list.
>
>When a new connection is established, a suitable
>element is obtained directly, which eliminates the
>need for traversal and search, and does not require
>locking resource.
>
>A lock-free linked list is a linked list that uses
>atomic operations to optimize the producer-consumer model.
>
>I tested the time-consuming comparison of this function
>under multiple connections based on redis-benchmark
>(test in smc loopback-ism mode):
>The function 'smc_buf_get_slot' takes less time when a
>new SMC link is established:
>1. 5us->100ns (when there are 200 active links);
>2. 30us->100ns (when there are 1000 active links).
>
>Test data with wrk+nginx command:
>On server:
>smc_run nginx
>
>On client:
>smc_run wrk -t <2~64> -c 200 -H "Connection: close" http://127.0.0.1
>
>Requests/sec
>--------+---------------+---------------+
>req/s   | without patch | apply patch   |
>--------+---------------+---------------+
>-t 2    |6924.18        |7456.54        |
>--------+---------------+---------------+
>-t 4    |8731.68        |9660.33        |
>--------+---------------+---------------+
>-t 8    |11363.22       |13802.08       |
>--------+---------------+---------------+
>-t 16   |12040.12       |18666.69       |
>--------+---------------+---------------+
>-t 32   |11460.82       |17017.28       |
>--------+---------------+---------------+
>-t 64   |11018.65       |14974.80       |
>--------+---------------+---------------+
>
>Transfer/sec
>--------+---------------+---------------+
>trans/s | without patch | apply patch   |
>--------+---------------+---------------+
>-t 2    |24.72MB        |26.62MB        |
>--------+---------------+---------------+
>-t 4    |31.18MB        |34.49MB        |
>--------+---------------+---------------+
>-t 8    |40.57MB        |49.28MB        |
>--------+---------------+---------------+
>-t 16   |42.99MB        |66.65MB        |
>--------+---------------+---------------+
>-t 32   |40.92MB        |60.76MB        |
>--------+---------------+---------------+
>-t 64   |39.34MB        |53.47MB        |
>--------+---------------+---------------+
>
>
>Signed-off-by: liqiang <liqiang64@huawei.com>
>---
>v2:
>- Correct the acquisition logic of a lock-less linked list.(Dust.Li)
>- fix comment symbol '//' -> '/**/'.(Dust.Li)
>v1: https://lore.kernel.org/all/20241101082342.1254-1-liqiang64@huawei.com/
>
> net/smc/smc_core.c | 58 ++++++++++++++++++++++++++++++----------------
> net/smc/smc_core.h |  4 ++++
> 2 files changed, 42 insertions(+), 20 deletions(-)
>
>diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
>index 500952c2e67b..6f26e70c7c4d 100644
>--- a/net/smc/smc_core.c
>+++ b/net/smc/smc_core.c
>@@ -16,6 +16,7 @@
> #include <linux/wait.h>
> #include <linux/reboot.h>
> #include <linux/mutex.h>
>+#include <linux/llist.h>
> #include <linux/list.h>
> #include <linux/smc.h>
> #include <net/tcp.h>
>@@ -909,6 +910,8 @@ static int smc_lgr_create(struct smc_sock *smc, struct smc_init_info *ini)
> 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
> 		INIT_LIST_HEAD(&lgr->sndbufs[i]);
> 		INIT_LIST_HEAD(&lgr->rmbs[i]);
>+		init_llist_head(&lgr->rmbs_free[i]);
>+		init_llist_head(&lgr->sndbufs_free[i]);
> 	}
> 	lgr->next_link_id = 0;
> 	smc_lgr_list.num += SMC_LGR_NUM_INCR;
>@@ -1183,6 +1186,10 @@ static void smcr_buf_unuse(struct smc_buf_desc *buf_desc, bool is_rmb,
> 		/* memzero_explicit provides potential memory barrier semantics */
> 		memzero_explicit(buf_desc->cpu_addr, buf_desc->len);
> 		WRITE_ONCE(buf_desc->used, 0);
>+		if (is_rmb)
>+			llist_add(&buf_desc->llist, &lgr->rmbs_free[buf_desc->bufsiz_comp]);
>+		else
>+			llist_add(&buf_desc->llist, &lgr->sndbufs_free[buf_desc->bufsiz_comp]);
> 	}
> }
> 
>@@ -1214,6 +1221,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
> 		} else {
> 			memzero_explicit(conn->sndbuf_desc->cpu_addr, bufsize);
> 			WRITE_ONCE(conn->sndbuf_desc->used, 0);
>+			llist_add(&conn->sndbuf_desc->llist,
>+				  &lgr->sndbufs_free[conn->sndbuf_desc->bufsiz_comp]);
> 		}
> 		SMC_STAT_RMB_SIZE(smc, is_smcd, false, false, bufsize);
> 	}
>@@ -1225,6 +1234,8 @@ static void smc_buf_unuse(struct smc_connection *conn,
> 			bufsize += sizeof(struct smcd_cdc_msg);
> 			memzero_explicit(conn->rmb_desc->cpu_addr, bufsize);
> 			WRITE_ONCE(conn->rmb_desc->used, 0);
>+			llist_add(&conn->rmb_desc->llist,
>+				  &lgr->rmbs_free[conn->rmb_desc->bufsiz_comp]);
> 		}
> 		SMC_STAT_RMB_SIZE(smc, is_smcd, true, false, bufsize);
> 	}
>@@ -1413,13 +1424,21 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
> {
> 	struct smc_buf_desc *buf_desc, *bf_desc;
> 	struct list_head *buf_list;
>+	struct llist_head *buf_llist;
> 	int i;
> 
> 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
>-		if (is_rmb)
>+		if (is_rmb) {
> 			buf_list = &lgr->rmbs[i];
>-		else
>+			buf_llist = &lgr->rmbs_free[i];
>+		} else {
> 			buf_list = &lgr->sndbufs[i];
>+			buf_llist = &lgr->sndbufs_free[i];
>+		}
>+		/* just invalid this list first, and then free the memory
>+		 * in the following loop
>+		 */
>+		llist_del_all(buf_llist);
> 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
> 					 list) {
> 			smc_lgr_buf_list_del(lgr, is_rmb, buf_desc);
>@@ -2087,24 +2106,19 @@ int smc_uncompress_bufsize(u8 compressed)
> 	return (int)size;
> }
> 
>-/* try to reuse a sndbuf or rmb description slot for a certain
>- * buffer size; if not available, return NULL
>- */
>-static struct smc_buf_desc *smc_buf_get_slot(int compressed_bufsize,
>-					     struct rw_semaphore *lock,
>-					     struct list_head *buf_list)
>+/* use lock less list to save and find reuse buf desc */
>+static struct smc_buf_desc *smc_buf_get_slot_free(struct llist_head *buf_llist)
> {
>-	struct smc_buf_desc *buf_slot;
>+	struct smc_buf_desc *buf_free;
>+	struct llist_node *llnode;
> 
>-	down_read(lock);
>-	list_for_each_entry(buf_slot, buf_list, list) {
>-		if (cmpxchg(&buf_slot->used, 0, 1) == 0) {
>-			up_read(lock);
>-			return buf_slot;
>-		}
>-	}
>-	up_read(lock);
>-	return NULL;
>+	/* lock-less link list don't need an lock */
>+	llnode = llist_del_first(buf_llist);
>+	if (!llnode)
>+		return NULL;
>+	buf_free = llist_entry(llnode, struct smc_buf_desc, llist);
>+	WRITE_ONCE(buf_free->used, 1);
>+	return buf_free;

Sorry for the late reply.

It looks this is not right here.

The rw_semaphore here is not used to protect against adding/deleting
the buf_list since we don't even add/remove elements on the buf_list.
The cmpxchg already makes sure only one will get an unused smc_buf_desc.

Removing the down_read()/up_read() would cause mapping/unmapping link
on the link group race agains the buf_slot alloc/free here. For exmaple
_smcr_buf_map_lgr() take the write lock of the rw_semaphore.

But I agree the lgr->rmbs_lock/sndbufs_lock should be improved. Would
you like digging into it and improve the usage of the lock here ?

Best regrads,
Dust

