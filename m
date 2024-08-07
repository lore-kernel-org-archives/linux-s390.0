Received: from out30-98.freemail.mail.aliyun.com (out30-98.freemail.mail.aliyun.com [115.124.30.98])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFE5C144D29;
	Wed,  7 Aug 2024 07:59:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.98
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723017588; cv=none; b=Ndz1uSoU4+dGwchtMxwTvDAm4YfGWMGCoOytjC8izthl2Hv3vdY1w2q9BuQwFDhyOQjXs9S5IZ5OAH9Whf2D5ISk4JgYcDjsqVX8EFwytVEiTjNI/pHmy4Lvt/Qgu+cy7Pymvy7DvzFGtBmMaeSNfOdcxIK5pUR1h058vGMpROM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723017588; c=relaxed/simple;
	bh=zYzAtRiF4orYxRvBpY+VuFup2ncaBYONQVFwZPWHuas=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=mrka5x27Ncj2zUaXYj/mNUYy2pEG4wgJ5vGloJa/VfzcHAHux8An5Oj8cy7XVEzXf+p/k0Yowt3+QccFqle19Gb5+eWE56HOYsOqH2sR15KUXK69rOjAcdGkYXSdGgSNk2ghizGkIvkKHIObwJFcwSPoZ3xgsQTj6F067he1MCw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=RdzdZWBW; arc=none smtp.client-ip=115.124.30.98
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="RdzdZWBW"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1723017582; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=vvvjupWc4j10IBI8L7PaFxsixpLd56P6tlLAVeyw3XM=;
	b=RdzdZWBWpjYtOjCVWfmbi3HBHIszuwwt9j4z3fQ/IXcfPT/ydWzLG4rlK3a9AWU4UneHF0uPGkQesJIK7/IGr+mBz+AY/E25GolrERwd674sR7uo3RU5ufCa2VZC1lwnjYRR3LH+UOv4dn/8kwyWGV16CKVRh5xMqjQL3bVwaKQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R701e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037067109;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WCIDror_1723017579;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WCIDror_1723017579)
          by smtp.aliyun-inc.com;
          Wed, 07 Aug 2024 15:59:42 +0800
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
Subject: [PATCH net-next v2 0/2] net/smc: introduce ringbufs usage statistics
Date: Wed,  7 Aug 2024 15:59:37 +0800
Message-Id: <20240807075939.57882-1-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Currently, we have histograms that show the sizes of ringbufs that ever
used by SMC connections. However, they are always incremental and since
SMC allows the reuse of ringbufs, we cannot know the actual amount of
ringbufs being allocated or actively used.

So this patch set introduces statistics for the amount of ringbufs that
actually allocated by link group and actively used by connections of a
certain net namespace, so that we can react based on these memory usage
information, e.g. active fallback to TCP.

With appropriate adaptations of smc-tools, we can obtain these ringbufs
usage information:

$ smcr -d linkgroup
LG-ID    : 00000500
LG-Role  : SERV
LG-Type  : ASYML
VLAN     : 0
PNET-ID  :
Version  : 1
Conns    : 0
Sndbuf   : 12910592 B    <-
RMB      : 12910592 B    <-

or

$ smcr -d stats
[...]
RX Stats
  Data transmitted (Bytes)      869225943 (869.2M)
  Total requests                 18494479
  Buffer usage  (Bytes)          12910592 (12.31M)  <-
  [...]

TX Stats
  Data transmitted (Bytes)    12760884405 (12.76G)
  Total requests                 36988338
  Buffer usage  (Bytes)          12910592 (12.31M)  <-
  [...]
[...]

Wen Gu (2):
  net/smc: introduce statistics for allocated ringbufs of link group
  net/smc: introduce statistics for ringbufs usage of net namespace

 include/uapi/linux/smc.h |  6 ++++
 net/smc/smc_core.c       | 72 ++++++++++++++++++++++++++++++++++------
 net/smc/smc_core.h       |  2 ++
 net/smc/smc_stats.c      |  8 +++++
 net/smc/smc_stats.h      | 28 +++++++++++-----
 5 files changed, 96 insertions(+), 20 deletions(-)

-- 
2.32.0.3.g01195cf9f

