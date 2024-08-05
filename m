Received: from out30-97.freemail.mail.aliyun.com (out30-97.freemail.mail.aliyun.com [115.124.30.97])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8E28B1DFE8;
	Mon,  5 Aug 2024 09:06:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.97
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722848766; cv=none; b=BLx6ebj/vUoyk8Qz+8vMFeeDor7w6jKTYiY7MyUM1z4mnm+qIis8U3v53jE7w8EAllB2EZKTPZvsPUop/TFQUX5skJiVY+ldJt2H7UOLXDROhN+Lgw0su+AC9tbVderzhGHC/01So9QLp2tW/W0tUhuKHX5aznPsXqBKrbbRluA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722848766; c=relaxed/simple;
	bh=UjUNnSnuhq1i3plO75J6ZOvlnSdKzQCxWc0rvjizHT0=;
	h=From:To:Cc:Subject:Date:Message-Id:MIME-Version; b=draNu190o7CleYhmOISEIKLzjkWZuYDfXgoU+fFAeSaMMNXE+yfaEkdNu8WbTLObOpjrUaG2Oj6QloZfrAKLvL15etpREexulpG1uQuxFknTtgcAUTpIqEjF8bURWgLDfZ4sw1LBZvTNlaKogRi+GGsgtWBa1vz2ovmNC4w3Mrk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=YZTePQKP; arc=none smtp.client-ip=115.124.30.97
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="YZTePQKP"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1722848753; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=OgtDprRTlhmPa7DDh18wiT26pOtXY6p5+I1N0L3iDZY=;
	b=YZTePQKPajwPEONGQDVLiMXB60iKU7kUYZbxPoFNw5060SPUraGWqabsJYzCshyJIwGBIdU+UAsaB2QPWNz+2KPrROoCbe6JCVPEm8+7KUjsoAd2hJSJRIt2REX2vGjBMeE5LC5+Ry4SYyzgeP8c/aLrU0sqvMkWSifJ6hqPtIQ=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R741e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032014031;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=12;SR=0;TI=SMTPD_---0WC7LR3l_1722848751;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0WC7LR3l_1722848751)
          by smtp.aliyun-inc.com;
          Mon, 05 Aug 2024 17:05:52 +0800
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
Subject: [PATCH net-next 0/2] net/smc: introduce ringbufs usage statistics
Date: Mon,  5 Aug 2024 17:05:49 +0800
Message-Id: <20240805090551.80786-1-guwen@linux.alibaba.com>
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
 net/smc/smc_core.c       | 74 ++++++++++++++++++++++++++++++++++------
 net/smc/smc_core.h       |  2 ++
 net/smc/smc_stats.c      |  8 +++++
 net/smc/smc_stats.h      | 27 ++++++++++-----
 5 files changed, 97 insertions(+), 20 deletions(-)

-- 
2.32.0.3.g01195cf9f

