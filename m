Received: from out30-113.freemail.mail.aliyun.com (out30-113.freemail.mail.aliyun.com [115.124.30.113])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CD07B36B06C;
	Wed, 18 Mar 2026 07:33:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=115.124.30.113
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773819222; cv=none; b=M2j5IhgT+3v8qxvhGNiQmilhRKx9FzEWlCsbp1GzImfj/wJ9Eg8dn1s5yn02qcIEAZh9IRzSHTuq/obODtTD6tvMjUgQG0nW0wsPKw+x4hexf91GFIJpUGmkB123ZCc/x/YQ77fNH7n9M9gwBVWXQxNlwk5nowNhdJW/wn/fRYs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773819222; c=relaxed/simple;
	bh=B3R+mdz9+srz/u/D7zxiXkUi1ulw4C3RXh7bRBZg6Uc=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version:Content-Type; b=R66gun9XMhy6By+1P7a5GdLP6GLIpVfXfFzRuq96eK/iA2EfT7o4C1ac/9ej/ts2lWsyiYUvcoCn1HYtINV06cxA0IcQhj7qS4AxfV48OBcReK5TV5Fp11zaLZ0C24EMnz2hvzRFTH1HdTz5BTZjz0TCZZ59X6+/+NcPjw9aHBM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com; spf=pass smtp.mailfrom=linux.alibaba.com; dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b=ev7K8/+z; arc=none smtp.client-ip=115.124.30.113
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.alibaba.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=linux.alibaba.com header.i=@linux.alibaba.com header.b="ev7K8/+z"
DKIM-Signature:v=1; a=rsa-sha256; c=relaxed/relaxed;
	d=linux.alibaba.com; s=default;
	t=1773819218; h=From:To:Subject:Date:Message-Id:MIME-Version:Content-Type;
	bh=xJ6Ve71kZ8TR367kXQcst/+kQqNvnuMsg/aXhEMf5ZQ=;
	b=ev7K8/+zsfum56q0zgR3lFVMbg56o4t5540bYwkTfqTgdupMw05Xf2F6DaHc8W6XZwr9zXjVZ0w4oZYcrEK0jpRtgXO4OhYsYpISGe4tM0qzQ1l338loLzpamF6O5A+yBHmn9uEaE6PPh9rX3ZKLFbTfLo+ytWtsp/eaEwbiKA8=
X-Alimail-AntiSpam:AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=maildocker-contentspam033037009110;MF=guwen@linux.alibaba.com;NM=1;PH=DS;RN=35;SR=0;TI=SMTPD_---0X.DXu3Y_1773819214;
Received: from localhost(mailfrom:guwen@linux.alibaba.com fp:SMTPD_---0X.DXu3Y_1773819214 cluster:ay36)
          by smtp.aliyun-inc.com;
          Wed, 18 Mar 2026 15:33:36 +0800
From: Wen Gu <guwen@linux.alibaba.com>
To: tglx@kernel.org,
	tglx@linutronix.de,
	richardcochran@gmail.com,
	andrew+netdev@lunn.ch,
	davem@davemloft.net,
	edumazet@google.com,
	kuba@kernel.org,
	pabeni@redhat.com,
	linux-kernel@vger.kernel.org,
	netdev@vger.kernel.org,
	jstultz@google.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	daniel.lezcano@kernel.org,
	sboyd@kernel.org
Cc: vladimir.oltean@nxp.com,
	wei.fang@nxp.com,
	xiaoning.wang@nxp.com,
	jonathan.lemon@gmail.com,
	vadim.fedorenko@linux.dev,
	yangbo.lu@nxp.com,
	svens@linux.ibm.com,
	dwmw2@infradead.org,
	nick.shi@broadcom.com,
	ajay.kaher@broadcom.com,
	alexey.makhalov@broadcom.com,
	bcm-kernel-feedback-list@broadcom.com,
	linux-fpga@vger.kernel.org,
	imx@lists.linux.dev,
	linux-s390@vger.kernel.org,
	dust.li@linux.alibaba.com,
	xuanzhuo@linux.alibaba.com,
	mani@kernel.org,
	imran.shaik@oss.qualcomm.com,
	taniya.das@oss.qualcomm.com
Subject: [PATCH 2/2] MAINTAINERS: update PTP maintainer entries after directory split
Date: Wed, 18 Mar 2026 15:33:30 +0800
Message-Id: <20260318073330.115808-3-guwen@linux.alibaba.com>
X-Mailer: git-send-email 2.32.0.3.g01195cf9f
In-Reply-To: <20260318073330.115808-1-guwen@linux.alibaba.com>
References: <20260318073330.115808-1-guwen@linux.alibaba.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

Update MAINTAINERS to match the new drivers/ptp/ directory layout after
splitting emulated and IEEE 1588 network-oriented drivers into
subdirectories.

Adjust file patterns and per-driver entries to point to their new
locations, and add a dedicated MAINTAINERS entry for the emulated PTP
clock drivers.

Signed-off-by: Wen Gu <guwen@linux.alibaba.com>
---
 MAINTAINERS | 38 ++++++++++++++++++++++++++------------
 1 file changed, 26 insertions(+), 12 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 5d477fd592db..1df4fed77284 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10250,7 +10250,7 @@ F:	Documentation/devicetree/bindings/ptp/fsl,ptp.yaml
 F:	drivers/net/ethernet/freescale/dpaa2/dpaa2-ptp*
 F:	drivers/net/ethernet/freescale/dpaa2/dprtc*
 F:	drivers/net/ethernet/freescale/enetc/enetc_ptp.c
-F:	drivers/ptp/ptp_qoriq.c
+F:	drivers/ptp/ieee1588/ptp_qoriq.c
 F:	include/linux/fsl/ptp_qoriq.h
 
 FREESCALE QUAD SPI DRIVER
@@ -13129,7 +13129,7 @@ INTEL PTP DFL ToD DRIVER
 L:	linux-fpga@vger.kernel.org
 L:	netdev@vger.kernel.org
 S:	Orphan
-F:	drivers/ptp/ptp_dfl_tod.c
+F:	drivers/ptp/ieee1588/ptp_dfl_tod.c
 
 INTEL QUADRATURE ENCODER PERIPHERAL DRIVER
 M:	Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
@@ -18309,7 +18309,10 @@ F:	Documentation/devicetree/bindings/net/
 F:	Documentation/networking/net_cachelines/net_device.rst
 F:	drivers/connector/
 F:	drivers/net/
-F:	drivers/ptp/
+F:	drivers/ptp/Kconfig
+F:	drivers/ptp/Makefile
+F:	drivers/ptp/ieee1588/
+F:	drivers/ptp/ptp*
 F:	drivers/s390/net/
 F:	include/dt-bindings/net/
 F:	include/linux/cn_proc.h
@@ -19092,7 +19095,7 @@ L:	imx@lists.linux.dev
 L:	netdev@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/ptp/nxp,ptp-netc.yaml
-F:	drivers/ptp/ptp_netc.c
+F:	drivers/ptp/ieee1588/ptp_netc.c
 
 NXP PF5300/PF5301/PF5302 PMIC REGULATOR DEVICE DRIVER
 M:	Woodrow Douglass <wdouglass@carnegierobotics.com>
@@ -19802,7 +19805,7 @@ OPENCOMPUTE PTP CLOCK DRIVER
 M:	Vadim Fedorenko <vadim.fedorenko@linux.dev>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/ptp/ptp_ocp.c
+F:	drivers/ptp/ieee1588/ptp_ocp.c
 
 OPENCORES I2C BUS DRIVER
 M:	Peter Korsgaard <peter@korsgaard.com>
@@ -21238,15 +21241,26 @@ W:	http://linuxptp.sourceforge.net/
 F:	Documentation/ABI/testing/sysfs-ptp
 F:	Documentation/driver-api/ptp.rst
 F:	drivers/net/phy/dp83640*
-F:	drivers/ptp/*
+F:	drivers/ptp/Kconfig
+F:	drivers/ptp/Makefile
+F:	drivers/ptp/ieee1588/
+F:	drivers/ptp/ptp*
 F:	include/linux/ptp_cl*
 K:	(?:\b|_)ptp(?:\b|_)
 
+PTP EMULATED CLOCK SUPPORT
+M:	Wen Gu <guwen@linux.alibaba.com>
+M:	Xuan Zhuo <xuanzhuo@linux.alibaba.com>
+L:	linux-kernel@vger.kernel.org
+S:	Maintained
+T:	git git://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git timers/core
+F:	drivers/ptp/emulated/
+
 PTP MOCKUP CLOCK SUPPORT
 M:	Vladimir Oltean <vladimir.oltean@nxp.com>
 L:	netdev@vger.kernel.org
 S:	Maintained
-F:	drivers/ptp/ptp_mock.c
+F:	drivers/ptp/ieee1588/ptp_mock.c
 F:	include/linux/ptp_mock.h
 
 PTP VIRTUAL CLOCK SUPPORT
@@ -21258,10 +21272,10 @@ F:	net/ethtool/phc_vclocks.c
 
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
@@ -23320,7 +23334,7 @@ S390 PTP DRIVER
 M:	Sven Schnelle <svens@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
 S:	Supported
-F:	drivers/ptp/ptp_s390.c
+F:	drivers/ptp/emulated/ptp_s390.c
 
 S390 SCM DRIVER
 M:	Vineeth Vijayan <vneethv@linux.ibm.com>
@@ -28216,9 +28230,9 @@ M:	Nick Shi <nick.shi@broadcom.com>
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

