Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 459621DAC8A;
	Tue, 15 Oct 2024 08:47:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728982066; cv=none; b=uMrO1aKGiqXebgKhzwj1fmyizgXQicnSfHZGMFCoqB+IHcJ/9m5URxvgeRKSU/uhVawPg8HFbpBdHfojX7m8veAHJs8C8owf5x354o2im5qj4ElzW01EDiZSFi0nH02Mdvh7usgMg61yWjeZcPnTbpxHPHFdoagC9lyIILS0oOg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728982066; c=relaxed/simple;
	bh=0k/jNEZc9lfw3abXbvYAwbVUgS/oBQHM402EpxxJEL8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BkLc9z4LhVsDu3hRQK88MQC5Ne9qfoX3kjSRmxG5gVl4UpuoCjZNByiMsR4Ur9Y3uNybtztqDjKgmBkLx097dAiTTrh1vCZiKoQi3vbRjIxp8WIH7tsjxQPBZIo+jEfyuzinfT2YPWlpvOvhd1AupQb3EwJz9eoMuOiPW2VyIJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=BUWZ5s97; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="BUWZ5s97"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49F7LYBQ002175;
	Tue, 15 Oct 2024 08:47:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=xWzekMjwCNm9ExClS
	aAQzXmfQqt81BO5Jsxrhu4BjCI=; b=BUWZ5s97M6U/X1gmI3x9AHIfF3+PVlMME
	hcz0Xd/cPQ9+NtYBY0QqcdoIzrRLpLDQAE5DKRuLCAoEO5P6/Dvba8q2zN95NNap
	A9owXsoCrf2cEeDutb5EoCnvGY1uzBg/+9w+OqKiQyMWFqsguC/YZPAedQO7XfEA
	fc62DWgYqPShFfE90aMv2UTsa+KNENmXmuEfklR6XW1VM0KHktS1ANP4DWGGzXQ3
	2n6SQdmVLRpzRz/8pzUmIpLqPURFPSbQSASrz9EmcbYZEm2VZ+oIT3Ey9MQSwHGi
	dcyhNyUF7x6j65CG6vS4JRbH8VIB+6WDFkIxFN4XpzWxwE1WJpt9w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdk3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:41 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49F8leXt009539;
	Tue, 15 Oct 2024 08:47:40 GMT
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 429kwvrdk1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:40 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49F5PXB1004988;
	Tue, 15 Oct 2024 08:47:39 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4285nj2hye-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 15 Oct 2024 08:47:39 +0000
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49F8lauo52363596
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 15 Oct 2024 08:47:36 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 280A820049;
	Tue, 15 Oct 2024 08:47:36 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 0C4E720040;
	Tue, 15 Oct 2024 08:47:36 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 15 Oct 2024 08:47:36 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id D2C1AE0125; Tue, 15 Oct 2024 10:47:35 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>
Cc: linux-s390@vger.kernel.org, Yangbo Lu <yangbo.lu@nxp.com>,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org
Subject: [PATCH 3/3] s390/time: Add PtP driver
Date: Tue, 15 Oct 2024 10:47:25 +0200
Message-ID: <20241015084728.1833876-4-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241015084728.1833876-1-svens@linux.ibm.com>
References: <20241015084728.1833876-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: KYKLsliRxp5wU_vPfEXS8jjyMJrxOYtS
X-Proofpoint-ORIG-GUID: c9S9dQGmHPDo1CKg8Bw9E4uPNtELAI9k
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 spamscore=0
 clxscore=1015 phishscore=0 suspectscore=0 impostorscore=0 malwarescore=0
 mlxlogscore=999 lowpriorityscore=0 mlxscore=0 bulkscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410150056

Add a small PtP driver which allows user space to get
the values of the physical and tod clock. This allows
programs like chrony to use STP as clock source and
steer the kernel clock. The physical clock can be used
as a debugging aid to get the clock without any additional
offsets like STP steering or LPAR offset.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 MAINTAINERS                   |   6 ++
 arch/s390/include/asm/timex.h |   8 +++
 arch/s390/kernel/time.c       |   7 ++
 drivers/ptp/Kconfig           |  11 +++
 drivers/ptp/Makefile          |   1 +
 drivers/ptp/ptp_s390.c        | 127 ++++++++++++++++++++++++++++++++++
 6 files changed, 160 insertions(+)
 create mode 100644 drivers/ptp/ptp_s390.c

diff --git a/MAINTAINERS b/MAINTAINERS
index 7ad507f49324..94793c935e86 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20328,6 +20328,12 @@ F:	Documentation/arch/s390/pci.rst
 F:	arch/s390/pci/
 F:	drivers/pci/hotplug/s390_pci_hpc.c
 
+S390 PTP DRIVER
+M:	Sven Schnelle <svens@linux.ibm.com>
+L:	linux-s390@vger.kernel.org
+S:	Supported
+F:	drivers/ptp/ptp_s390.c
+
 S390 SCM DRIVER
 M:	Vineeth Vijayan <vneethv@linux.ibm.com>
 L:	linux-s390@vger.kernel.org
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 640901f2fbc3..4fc88a1493f0 100644
--- a/arch/s390/include/asm/timex.h
+++ b/arch/s390/include/asm/timex.h
@@ -93,6 +93,7 @@ extern unsigned char ptff_function_mask[16];
 #define PTFF_QAF	0x00	/* query available functions */
 #define PTFF_QTO	0x01	/* query tod offset */
 #define PTFF_QSI	0x02	/* query steering information */
+#define PTFF_QPT	0x03	/* query physical clock */
 #define PTFF_QUI	0x04	/* query UTC information */
 #define PTFF_ATO	0x40	/* adjust tod offset */
 #define PTFF_STO	0x41	/* set tod offset */
@@ -250,6 +251,12 @@ static __always_inline unsigned long tod_to_ns(unsigned long todval)
 	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
 }
 
+static __always_inline unsigned long eitod_to_ns(union tod_clock *clk)
+{
+	clk->eitod -= TOD_UNIX_EPOCH;
+	return ((clk->eitod >> 9) * 125) + (((clk->eitod & 0x1ff) * 125) >> 9);
+}
+
 /**
  * tod_after - compare two 64 bit TOD values
  * @a: first 64 bit TOD timestamp
@@ -278,4 +285,5 @@ static inline int tod_after_eq(unsigned long a, unsigned long b)
 	return a >= b;
 }
 
+bool stp_enabled(void);
 #endif
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 4214901c3ab0..47b20235953c 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -469,6 +469,13 @@ static void __init stp_reset(void)
 	}
 }
 
+bool stp_enabled(void)
+{
+	return test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags) &&
+		stp_online;
+}
+EXPORT_SYMBOL(stp_enabled);
+
 static void stp_timeout(struct timer_list *unused)
 {
 	queue_work(time_sync_wq, &stp_work);
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 604541dcb320..907330413ef8 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -224,4 +224,15 @@ config PTP_DFL_TOD
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_dfl_tod.
 
+config PTP_S390
+	tristate "S390 PTP driver"
+	depends on PTP_1588_CLOCK
+	default y
+	help
+	  This driver adds support for S390 time steering via the PtP
+	  interface. This works by adding a in-kernel clock delta value,
+	  which is always added to time values used in the kernel. The PtP
+	  driver provides the raw clock value without the delta to
+	  userspace. That way userspace programs like chrony could steer
+	  the kernel clock.
 endmenu
diff --git a/drivers/ptp/Makefile b/drivers/ptp/Makefile
index 68bf02078053..4dd9f35eb0cf 100644
--- a/drivers/ptp/Makefile
+++ b/drivers/ptp/Makefile
@@ -21,3 +21,4 @@ obj-$(CONFIG_PTP_1588_CLOCK_MOCK)	+= ptp_mock.o
 obj-$(CONFIG_PTP_1588_CLOCK_VMW)	+= ptp_vmw.o
 obj-$(CONFIG_PTP_1588_CLOCK_OCP)	+= ptp_ocp.o
 obj-$(CONFIG_PTP_DFL_TOD)		+= ptp_dfl_tod.o
+obj-$(CONFIG_PTP_S390)			+= ptp_s390.o
diff --git a/drivers/ptp/ptp_s390.c b/drivers/ptp/ptp_s390.c
new file mode 100644
index 000000000000..4edccebcf2b5
--- /dev/null
+++ b/drivers/ptp/ptp_s390.c
@@ -0,0 +1,126 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * s390 PTP clock driver
+ *
+ */
+
+#include "ptp_private.h"
+#include <linux/time.h>
+static struct ptp_clock *ptp_stcke_clock, *ptp_qpt_clock;
+
+static int ptp_s390_adjfine(struct ptp_clock_info *ptp, long scaled_ppm)
+{
+	return -EOPNOTSUPP;
+}
+
+static int ptp_s390_adjtime(struct ptp_clock_info *ptp, s64 delta)
+{
+	return -EOPNOTSUPP;
+}
+
+static struct timespec64 eitod_to_timespec64(union tod_clock *clk)
+{
+	return ns_to_timespec64(eitod_to_ns(clk));
+}
+
+static struct timespec64 tod_to_timespec64(unsigned long tod)
+{
+	return ns_to_timespec64(tod_to_ns(tod - TOD_UNIX_EPOCH));
+}
+
+static int ptp_s390_stcke_gettime(struct ptp_clock_info *ptp,
+				  struct timespec64 *ts)
+{
+	union tod_clock tod;
+
+	if (!stp_enabled())
+		return -EOPNOTSUPP;
+
+	store_tod_clock_ext_cc(&tod);
+	*ts = eitod_to_timespec64(&tod);
+	return 0;
+}
+
+static int ptp_s390_qpt_gettime(struct ptp_clock_info *ptp,
+				struct timespec64 *ts)
+{
+	unsigned long tod;
+
+	ptff(&tod, sizeof(tod), PTFF_QPT);
+	*ts = tod_to_timespec64(tod);
+	return 0;
+}
+
+static int ptp_s390_settime(struct ptp_clock_info *ptp,
+			    const struct timespec64 *ts)
+{
+	return -EOPNOTSUPP;
+}
+
+static int s390_arch_ptp_get_crosststamp(ktime_t *device_time,
+					 struct system_counterval_t *system_counter,
+					 void *ctx)
+{
+	union tod_clock clk;
+
+	store_tod_clock_ext_cc(&clk);
+	*device_time = ns_to_ktime(tod_to_ns(clk.tod - TOD_UNIX_EPOCH));
+	system_counter->cycles = clk.tod;
+	system_counter->cs_id = CSID_S390_TOD;
+	return 0;
+}
+
+static int ptp_s390_getcrosststamp(struct ptp_clock_info *ptp,
+				   struct system_device_crosststamp *xtstamp)
+{
+	if (!stp_enabled())
+		return -EOPNOTSUPP;
+	return get_device_system_crosststamp(s390_arch_ptp_get_crosststamp, NULL, NULL, xtstamp);
+}
+
+static struct ptp_clock_info ptp_s390_stcke_info = {
+	.owner		= THIS_MODULE,
+	.name		= "IBM Z STCKE Clock",
+	.max_adj	= 0,
+	.adjfine	= ptp_s390_adjfine,
+	.adjtime	= ptp_s390_adjtime,
+	.gettime64	= ptp_s390_stcke_gettime,
+	.settime64	= ptp_s390_settime,
+	.getcrosststamp = ptp_s390_getcrosststamp,
+};
+
+static struct ptp_clock_info ptp_s390_qpt_info = {
+	.owner		= THIS_MODULE,
+	.name		= "IBM Z Physical Clock",
+	.max_adj	= 0,
+	.adjfine	= ptp_s390_adjfine,
+	.adjtime	= ptp_s390_adjtime,
+	.gettime64	= ptp_s390_qpt_gettime,
+	.settime64	= ptp_s390_settime,
+};
+
+static __init int ptp_s390_init(void)
+{
+	ptp_stcke_clock = ptp_clock_register(&ptp_s390_stcke_info, NULL);
+	if (IS_ERR(ptp_stcke_clock))
+		return PTR_ERR(ptp_stcke_clock);
+
+	ptp_qpt_clock = ptp_clock_register(&ptp_s390_qpt_info, NULL);
+	if (IS_ERR(ptp_qpt_clock)) {
+		ptp_clock_unregister(ptp_stcke_clock);
+		return PTR_ERR(ptp_qpt_clock);
+	}
+	return 0;
+}
+
+static __exit void ptp_s390_exit(void)
+{
+	ptp_clock_unregister(ptp_qpt_clock);
+	ptp_clock_unregister(ptp_stcke_clock);
+}
+
+module_init(ptp_s390_init);
+module_exit(ptp_s390_exit);
+
+MODULE_AUTHOR("Sven Schnelle <svens@linux.ibm.com>");
+MODULE_LICENSE("GPL");
-- 
2.43.0

