Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DFC0616F292;
	Tue, 28 May 2024 13:51:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904307; cv=none; b=nyG9Mhfu+TcLofpB7/7LEJ8WxD8ErbBMUgSihKQjufgGHLXZmRi4lCSzYODgBRA0maQ7L6UVx1cdstyOLPr9PuMZnK5reG+7xUokwpKObZuQCCjTUzGCLOqRbb3Iov8EmudfeNO54Rs0X2tFalWHNz75T/LqNlC+kTpeRlj7pgI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904307; c=relaxed/simple;
	bh=bVAtggiMjkZVTQ1NKTcH9oYwlHwQ8p20A1TJxneQkVE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=XTzJJV0l+2ZEZZV2q/rX3pheSCzas2BhjmHsrEc8Fq9PFujtf/X0HzJ5qifol4+pfin91PbI+caeuLSY6cJGgg5x/BZyLiRlgZyW/lpR4LPE7HhQVyHvePTN8dXQfuyrs15D6dJixCrGku/dii3lydbaSLH6fEPE3pyT4krjwXk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=BSoGHWTF; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="BSoGHWTF"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716904302; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=8Me7WULng0ZAO2ftQFBzA83nRWTMtnRkgCMFfiM9/lY=;
	b=BSoGHWTFqw+zZEFi9vrRjMaZRHKYdH8FYb5VOJjwHpF/OCSIeSklf6A9H60MaJVNJ3zZ8MhmETY6v3s/NRl7TxQgytU7ANddK4UbpL0wgjAcLIQpePE7D4eXFSnetSiH/PY+SnYb9hEY1iRMl7RuyurJ5h+fzTapETIqXuaEQKc=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033022160150;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7PmKgr_1716904301;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7PmKgr_1716904301)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 21:51:41 +0800
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
Subject: [PATCH net-next 2/2] net/smc: change SMCR_RMBE_SIZES from 5 to 15
Date: Tue, 28 May 2024 21:51:38 +0800
Message-Id: <20240528135138.99266-3-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
In-Reply-To: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
References: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

SMCR_RMBE_SIZES is the upper boundary of SMC-R's snd_buf and rcv_buf.
The maximum bytes of snd_buf and rcv_buf can be calculated by 2^SMCR_
RMBE_SIZES * 16KB. SMCR_RMBE_SIZES = 5 means the upper boundary is 512KB.
TCP's snd_buf and rcv_buf max size is configured by net.ipv4.tcp_w/rmem[2]
whose defalut value is 4MB or 6MB, is much larger than SMC-R's upper
boundary.

In some scenarios, such as Recommendation System, the communication
pattern is mainly large size send/recv, where the size of snd_buf and
rcv_buf greatly affects performance. Due to the upper boundary
disadvantage, SMC-R performs poor than TCP in those scenarios. So it
is time to enlarge the upper boundary size of SMC-R's snd_buf and rcv_buf,
so that the SMC-R's snd_buf and rcv_buf can be configured to larger size
for performance gain in such scenarios.

The SMC-R rcv_buf's size will be transferred to peer by the field
rmbe_size in clc accept and confirm message. The length of the field
rmbe_size is four bits, which means the maximum value of SMCR_RMBE_SIZES
is 15. In case of frequently adjusting the value of SMCR_RMBE_SIZES
in different scenarios, set the value of SMCR_RMBE_SIZES to the maximum
value 15, which means the upper boundary of SMC-R's snd_buf and rcv_buf
is 512MB. As the real memory usage is determined by the value of
net.smc.w/rmem, not by the upper boundary, set the value of SMCR_RMBE_SIZES
to the maximum value has no side affects.

Signed-off-by: Guangguan Wang <guangguan.wang@linux.alibaba.com>
Co-developed-by: Wen Gu <guwen@linux.alibaba.com>
Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 net/smc/smc_core.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/net/smc/smc_core.c b/net/smc/smc_core.c
index acca3b1a068f..3b95828d9976 100644
--- a/net/smc/smc_core.c
+++ b/net/smc/smc_core.c
@@ -2006,7 +2006,7 @@ int smc_conn_create(struct smc_sock *smc, struct smc_init_info *ini)
 }
 
 #define SMCD_DMBE_SIZES		6 /* 0 -> 16KB, 1 -> 32KB, .. 6 -> 1MB */
-#define SMCR_RMBE_SIZES		5 /* 0 -> 16KB, 1 -> 32KB, .. 5 -> 512KB */
+#define SMCR_RMBE_SIZES		15 /* 0 -> 16KB, 1 -> 32KB, .. 15 -> 512MB */
 
 /* convert the RMB size into the compressed notation (minimum 16K, see
  * SMCD/R_DMBE_SIZES.
-- 
2.24.3 (Apple Git-128)

