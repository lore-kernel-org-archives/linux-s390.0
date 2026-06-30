Received: from out30-124.freemail.mail.aliyun.com (out30-124.freemail.mail.aliyun.com [115.124.30.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E30D326941;
	Tue, 30 Jun 2026 03:15:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782789352; cv=none; b=AJVMKXesxO9IDulFoCoBCwJbRPGSwWccakuVoamOyrpCLAKlZGcOMijvWTwTKzgwPVdrNCF91upprnKawVc+WZ/Nt5RI2ZWg41INRsro/FmAoCEXEJzojJGvgboyTTo4AOq1qVVCFhTGGH2Fpgg9qL8EsYH7wZ6NNE9+0puHkr8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782789352; c=relaxed/simple;
	bh=AIKXv+Kl0hZOONEsKqP1z8MkaKJ6kzNjiM5OcoM2VKE=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=psVQ/LgaeMVLAWCsid/Pz9AO70705hrMz89zOJe+xdgu8ERMmbIMu/i1X+xXU69fFl026ua8yyl+mCZG5R56jr2vXMs3nHmBRAy4SQTu54yPOUeMqt0Xr6AivFRFwGV30IJrU691aABMxPjuJb2q2yV45GYRhGNqXIt5kYwHJOw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=qDCpEkFZ; arc=none smtp.client-ip=115.124.30.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="qDCpEkFZ"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1782789334; h=From:To:Subject:Date:Message-Id:MIME-Version;
	bh=qEk8aex30hY5+ARIe4Q3anT+ToMN846Z3HzHKFtOHfs=;
	b=qDCpEkFZjflMy0qH//gE/xFgUhjCcM7KynsSHYVlhGHM2WcnczKZZif8iBJqdOyTPuF3tI7VRQZQTcaSL5uii5FBze0XMj6/9PYZUdwu9NX/er95PN0LimiHlVVj/u7hpz2wx9YBbuJhsCyxPZjPDW7ANvPsK2+STuVcrXXGTU0=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R521e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033032089153;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=19;SR=0;TI=SMTPD_---0X5zdNH4_1782789331;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X5zdNH4_1782789331 cluster:ay36)
          by smtp.aliyun-inc.com;
          Tue, 30 Jun 2026 11:15:32 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: richardcochran@gmail.com,
	dwmw2@infradead.org,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	netdev@vger.kernel.org,
	linux-kernel@vger.kernel.org
Cc: svens@linux.ibm.com,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-s390@vger.kernel.org,
	xuanzhuo@linux.alibaba.com,
	dust.li@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com
Subject: [PATCH v3 2/2] MAINTAINERS: update PTP maintainer entries after directory split
Date: Tue, 30 Jun 2026 11:15:19 +0800
Message-Id: <20260630031519.23072-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260630031519.23072-1-guwen@linux.alibaba.com>
References: <20260630031519.23072-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Update MAINTAINERS to match the new drivers/ptp/ directory layout after
moving emulated PTP clock drivers into a new subdirectory.

Adjust file patterns and per-driver entries to point to their new
locations, and add a dedicated MAINTAINERS entry for the emulated PTP
clock drivers.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 MAINTAINERS | 21 ++++++++++++++++-----
 1 file changed, 16 insertions(+), 5 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 15011f5752a9..909bc2bd4f6c 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18716,6 +18716,7 @@ X:	Documentation/devicetree/bindings/net/can/
 X:	Documentation/devicetree/bindings/net/wireless/
 X:	drivers/net/can/
 X:	drivers/net/wireless/
+X:	drivers/ptp/emulated/
 
 NETWORKING DRIVERS (WIRELESS)
 M:	Johannes Berg <johannes@sipsolutions.net>
@@ -21737,8 +21738,18 @@ F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
 F:	drivers/ptp/*
 F:	include/linux/ptp_cl*
+X:	drivers/ptp/emulated/
 K:	(?:\b|_)ptp(?:\b|_)
 
+PTP EMULATED CLOCK SUPPORT
+M:	David Woodhouse <dwmw2@infradead.org>
+R:	Wen Gu <guwen@linux.alibaba.com>
+R:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.infradead.org/linux-ptp.git
+F:	drivers/ptp/emulated/
+
 PTP MOCKUP CLOCK SUPPORT
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
 L:	netdev@vger.kernel.org
@@ -21755,10 +21766,10 @@ F:	net/ethtool/phc_vclocks.c
 
 PTP VMCLOCK SUPPORT
 M:	David Woodhouse <dwmw2@infradead.org>
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/amazon,vmclock.yaml
-F:	drivers/ptp/ptp_vmclock.c
+F:	drivers/ptp/emulated/ptp_vmclock.c
 F:	include/uapi/linux/vmclock-abi.h
 
 PTRACE SUPPORT
@@ -23875,7 +23886,7 @@ S390 PTP DRIVER
 M:	Sven Schnelle <svens@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-F:	drivers/ptp/ptp_s390.c
+F:	drivers/ptp/emulated/ptp_s390.c
 
 S390 SCM DRIVER
 M:	Vineeth Vijayan <vneethv@linux.ibm.com>
@@ -28858,9 +28869,9 @@ M:	Nick Shi <nick.shi@broadcom.com>
 R:	Ajay Kaher <ajay.kaher@broadcom.com>
 R:	Alexey Makhalov <alexey.makhalov@broadcom.com>
 R:	Broadcom internal kernel review list <bcm-kernel-feedback-list@broadcom.com>
-L:	netdev@vger.kernel.org
+L:	linux-kernel@vger.kernel.org
 S:	Supported
-F:	drivers/ptp/ptp_vmw.c
+F:	drivers/ptp/emulated/ptp_vmw.c
 
 VMWARE VMCI DRIVER
 M:	Bryan Tan <bryan-bt.tan@broadcom.com>
-- 
2.43.5

