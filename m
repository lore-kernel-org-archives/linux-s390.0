Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2A92763BF;
	Mon,  3 Jun 2024 03:00:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.110
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717383632; cv=none; b=sbn59H+6ObI9Yczn/xUGAgsSHbymrUGoBfVmXx1asOHAaYD8vSOIk1Xu77hCocqDY842MjGP7uGgGva91qquW55Gyg9Bi0yimHqGpv417Sn5QcPHWpVI9HZnIbFNcqO5gfbscci0HrW7KBvdBgwFHqp/SThIDREeK4KuCcqGNVE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717383632; c=relaxed/simple;
	bh=WOnj/IcDSlueB+vGPyyHInzYUvdCXbpgHFU/T6yMTZ4=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=b4WydivLk3Whf6lEPSqKmCfhDjQEZE06yzt7i6adWIwd97aK8hOaUhfc0L+k4+Yyf01jM6pE6MFtzykoiDKSmrDvz6pRYnmwEy+/k7rp1eErjRcqAU/tFb4wlD6NXpCLqgk1oPUJUW8edof0yVgtBoL4FMzAvMe9lBi1TOWbiHE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=slv8mh6v; arc=none smtp.client-ip=115.124.30.110
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="slv8mh6v"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1717383626; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=MbSoVs/ilZxke123ltmytiq9A1aRCmuP5A2IBJuRxqQ=;
	b=slv8mh6v/bMnvShQGR4LVxAJOdvXUfsgDh+iFvehyneuyi3mNZ9flMom9i3MkJvv3tm97MJPrdeTojqo/73akA6J/5Cr9VGcISoHAYkTCqSaWgWWrmTiq/+WUUPHB2+W0FyJ2dYiGb9dusZ2NQEe9e9uKxWVCo1yc+1YmBblJQo=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R861e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067111;MF=guangguan.wang@linux.alibaba.com;NM=1;PH=DS;RN=13;SR=0;TI=SMTPD_---0W7gQbTd_1717383625;
Received: from localhost.localdomain(mailfrom:guangguan.wang@linux.alibaba.com fp:SMTPD_---0W7gQbTd_1717383625)
          by smtp.aliyun-inc.com;
          Mon, 03 Jun 2024 11:00:26 +0800
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
Subject: [PATCH net-next v2 0/2] net/smc: Change the upper boundary of SMC-R's snd_buf and rcv_buf to 512MB
Date: Mon,  3 Jun 2024 11:00:17 +0800
Message-Id: <20240603030019.91346-1-guangguan.wang@linux.alibaba.com>
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
whose default value is 4MB or 6MB, is much larger than SMC-R's upper
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

