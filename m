Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A44C2624;
	Wed, 31 Jul 2024 09:31:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722418279; cv=none; b=mZkR0a5j9asi0RGz/ViGeM+4rCkjvmYJ8OjHJsWGPlz22kvWQiqxdljJwE7HljHAP9kFkI863US0nqI4Aao54Bfop51Q70de9WQSdk7SY8EjXwm2FEZnW0ahBQzHKvHmY70GAkDuPbTd+UM+7+wWToDs29yYXZKchxpTSac5+N8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722418279; c=relaxed/simple;
	bh=ghoHr4z7wPE9k0LsD8z5QZgvhN0fntj0YYHbmL7QCoI=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=P2nBnyZl5fO5cWyvDpxyJV6G9GFk9XsfL8qILGJ5AwS46d8laQXm9mRLVkqtt4jd0+SnA4+BKIdcWCUA4jEWtovEXerUK5Rlj16jAyea0lqZx2/ZIwnlBtS5JLIGViVTYdrRdValabkcJFeh62LTcB/y2dODoabMnJNv76z5Cgc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RO1CP0PN; arc=none smtp.client-ip=115.124.30.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RO1CP0PN"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722418268; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=eOqKJp+sr+RibTROOXL5TF+aIJr/bQzVFb2RskikFYs=;
	b=RO1CP0PNCPW5E3lbtnoUvNeLG/oshJvHx5jtgQlWrTCnCX5c3YlPp1WN0yEV6ly9s0LoY2Mug0r6thInkj9oxePSVfibf2FEzltK7z6O3k1KDgxSPOVuM3F75rSIDiqao5FiBUuCGfFqDuhk24h5RMac7TfzfeA8eM/c1UY9NMA=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033068173054;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WBizm0z_1722418262;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WBizm0z_1722418262)
          by smtp.aliyun-inc.com;
          Wed, 31 Jul 2024 17:31:07 +0800
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
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net] net/smc: delete buf_desc from buffer list under lock protection
Date: Wed, 31 Jul 2024 17:31:02 +0800
Message-Id: <20240731093102.130154-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The operations to link group buffer list should be protected by
sndbufs_lock or rmbs_lock. So fix it.

Fixes: 3e034725c0d8 ("net/smc: common functions for RMBs and send buffers")
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index 3b95828d9976..ecfea8c38da9 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -1368,18 +1368,24 @@ static void __smc_lgr_free_bufs(struct smc_link_group *lgr, bool is_rmb)
 {
 	struct smc_buf_desc *buf_desc, *bf_desc;
 	struct list_head *buf_list;
+	struct rw_semaphore *lock;
 	int i;
 
 	for (i = 0; i < SMC_RMBE_SIZES; i++) {
-		if (is_rmb)
+		if (is_rmb) {
 			buf_list = &lgr->rmbs[i];
-		else
+			lock = &lgr->rmbs_lock;
+		} else {
 			buf_list = &lgr->sndbufs[i];
+			lock = &lgr->sndbufs_lock;
+		}
+		down_write(lock);
 		list_for_each_entry_safe(buf_desc, bf_desc, buf_list,
 					 list) {
 			list_del(&buf_desc->list);
 			smc_buf_free(lgr, is_rmb, buf_desc);
 		}
+		up_write(lock);
 	}
 }
 
-- 
2.32.0.3.g01195cf9f

