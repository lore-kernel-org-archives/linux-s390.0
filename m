Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4CFF316F291;
	Tue, 28 May 2024 13:51:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716904307; cv=none; b=Wue/9EHC6OZdeDvEaubGYBm+HOy4woUd3jhb5xIgFc2wroBzLCQWWi79LbHK8P7djvqY2dfh+yPomQ4bJ6q5LQiM91V0MDtnmJebhk6G1m6P8N01LHW/DXlVRszgXnn5w40tvMTHp+nWBYVCHGgemTOduHSd7OLuTVcBcFVd5LQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716904307; c=relaxed/simple;
	bh=GNzER6L7ElxxakGvY68xyEAEqNGZrd7YPgg3Kd3uzx0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=Do2QiDt67rHFI7KEqKVrraFnMkKyed+IJn13sElF85RRBJksEvMlZVG/ncUW8AoODnv4dg9XIe2flbYoRas5ef9UTtRiDh37HtKvB5pguSK39tQNUuXbr3j1DycFsEzUO2e5pzk8ggK0oRbTkCEqdEdYB6gV5TO3tV9Zhdz0yRo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=O3wwstS+; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="O3wwstS+"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1716904301; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vY7+iAI1WEm3baRaKxv3Iubq1X+fo0lH3fPVRRSyBjg=;
	b=O3wwstS+CDxQ9k++nN2XAVd1KpRTvGTO6I2TqbAMi1XSgqa7tyDBJJroV6SF8PQfzA1fZJ332WpSwOlfrsJc2qIRXr1WOmZw2PLeff15UDBQJg+N6WMz652SGkYdYxIvxhgp3u2PgHXN9G7ZH4PMabHEQy8Jjenh+z3Yoz8cgkY=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067112;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7PmKgL_1716904299;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7PmKgL_1716904299)
          by smtp.aliyun-inc.com;
          Tue, 28 May 2024 21:51:40 +0800
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
Subject: [PATCH net-next 0/2] Change the upper boundary of SMC-R's snd_buf and rcv_buf to 512MB
Date: Tue, 28 May 2024 21:51:36 +0800
Message-Id: <20240528135138.99266-1-guangguan.wang@linux.alibaba.com>
X-Mailer: git-send-email 2.24.3 (Apple Git-128)
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

Guangguan Wang (2):
  net/smc: set rmb's SG_MAX_SINGLE_ALLOC limitation only when
    CONFIG_ARCH_NO_SG_CHAIN is defined
  net/smc: change SMCR_RMBE_SIZES from 5 to 15

 net/smc/smc_core.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.24.3 (Apple Git-128)

