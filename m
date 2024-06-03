Received: from out30-101.freemail.mail.aliyun.com (out30-101.freemail.mail.aliyun.com [115.124.30.101])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DCED022094;
	Mon,  3 Jun 2024 03:00:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.101
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383638; cv=none; b=j9wE8ZPPjmGUkJsBnaY+sRBTMbYBD8DBDJeIcfTatX1BvEYr8cc5duonTTsuxrsbyb7SdyWeMldBugWg0dnV/ic02Xo11hn+O/lbnpULKtH++Oa0Uz4vdJSbwv7U/YACxORiiGESLw/5reXbRQz9z+eEmkE34xXjCCl9wJQ1QXo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383638; c=relaxed/simple;
	bh=BawHqwpXofuidHEmqHFcxPwnvzTtkFYocQ8WEg8HeOI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ov+fP/luGH5EazWMvbRQNYqbjanKpCDhjyqtlVLxNADKWX2hko8ngjSWCVwEHhNlRTto/Bj1QRdzknXTbZk1vmBG8pN2PzuvtfDauHAqebJF2SQn5HBJfdTPq3CUUD4MlvbEWgo/ZTRZgOOSQRXw3wE55f/0ZQuOwN2gJSy6IN4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YkrokYDI; arc=none smtp.client-ip=115.124.30.101
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YkrokYDI"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717383627; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=xDBiGtmUEsT7+M0SWdnNsuru+On4RVk8moCAN4HJcGA=;
	b=YkrokYDIgFKvn9pzqStmqlQVnQ/V46d3fmC49gqfFiBcBgcNMleTXuabqDg66x4JTmmlIaxnRmG60+yKMVeQMkrJ7KUuQAYe8V+xYBL1GWBMcAEK6UKZJY8s4lC65+3mr+FfH7mYFwUJZiPJTDTax8HKPXdfeA0e2iIkbMn5eUU=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R211e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7gQbUD_1717383626;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7gQbUD_1717383626)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 11:00:27 +0800
From: Guangguan Wang <guangguan.wang@linux.alibaba.com>
To: wenjia@linux.ibm.com,
	jaka@linux.ibm.com,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com
Cc: kgraul@linux.ibm.com,
	alibuda@linux.alibaba.com,
	tonylu@linux.alibaba.com,
	guwen@linux.alibaba.com,
	linux-s390@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Subject: [PATCH net-next v2 1/2] net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when CONFIG_ARCH_NO_SG_CHAIN is defined
Date: Mon,  3 Jun 2024 11:00:18 +0800
Message-Id: <20240603030019.91346-2-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
References: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SG_MAX_SINGLE_ALLOC is used to limit maximum number of entries that
will be allocated in one piece of scatterlist. When the entries of
scatterlist exceeds SG_MAX_SINGLE_ALLOC, sg chain will be used. From
commit 7c703e54cc71 ("arch: switch the default on ARCH_HAS_SG_CHAIN"),
we can know that the macro CONFIG_ARCH_NO_SG_CHAIN is used to identify
whether sg chain is supported. So, SMC-R's rmb buffer should be limited
by SG_MAX_SINGLE_ALLOC only when the macro CONFIG_ARCH_NO_SG_CHAIN is
defined.

Fixes: a3fe3d01bd0d ("net/smc: introduce sg-logic for RMBs")
Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index fafdb97adfad..acca3b1a068f 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2015,7 +2015,6 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
  */
 static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 {
-	const unsigned int max_scat = SG_MAX_SINGLE_ALLOC * PAGE_SIZE;
 	u8 compressed;
 
 	if (size <= SMC_BUF_MIN_SIZE)
@@ -2025,9 +2024,11 @@ static u8 smc_compress_bufsize(int size, bool is_smcd, bool is_rmb)
 	compressed = min_t(u8, ilog2(size) + 1,
 			   is_smcd ? SMCD_DMBE_SIZES : SMCR_RMBE_SIZES);
 
+#ifdef CONFIG_ARCH_NO_SG_CHAIN
 	if (!is_smcd && is_rmb)
 		/* RMBs are backed by & limited to max size of scatterlists */
-		compressed = min_t(u8, compressed, ilog2(max_scat >> 14));
+		compressed = min_t(u8, compressed, ilog2((SG_MAX_SINGLE_ALLOC * PAGE_SIZE) >> 14));
+#endif
 
 	return compressed;
 }
-- 
2.24.3 (Apple Git-128)

