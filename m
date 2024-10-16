Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9229F208D63;
	Wed, 16 Oct 2024 11:50:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729079446; cv=none; b=FXoj85TfywNAX82fHG0B2R31QtDsPYgivJt3HT5lMCtltcF6DXcGEcT9wpRrRqwYlIU969syN6M0wY7LeXpyD257K9gRbFxqkTYd7Z7QrMMmNQ/DR3YM0PwXmEScmRhaZAHD9anwfbNDWvT/yOx+U00L5SPhSDj0qG5u2MCg0nw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729079446; c=relaxed/simple;
	bh=BpcDxguG1kyZrIUYu9sMUBbxsSIAAl8slgS/HEh3s1o=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JOiYhRJbFpwMt/933KzEBetY1XYsNlnExKFcCrKx5gFvQgL1cJ2eTtuKxe2f7OJecu3XBwmk7Hngowwv7LOWbq8U9sBzBfYVdv62UuEkhkYWO50qGD5bjWa5J65JlIrh74OlcNITy6e3eCTzn4rASRsehgMCQOtNCwAmfiOAmqQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=lE+V6xbH; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="lE+V6xbH"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GBOpCE021493;
	Wed, 16 Oct 2024 11:50:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=iJ4UY9FpOq9pTrd1b
	6T+JLWjRK/duZu+nG30MxfuWl0=; b=lE+V6xbHSSO3bWyIJBD6j8Q3JKGzW21dJ
	qoJmDzODo/AimQ8ndI+doUeMQhvffYDooRzW8psyxwW1ybYQ3BDJqgAzSumUHhDY
	eutMEjHmkmyO/Jdbq4xJz2IXjnN0HHR1cxtzmLJrI/jqE3rMiCHDaaHxgh3zVnQq
	4zESjCYBLAb/+eB/hqynuX44z6syiVU5mp5KaYuRHtj9b7K+B+TwNx7NhJVPtWfb
	Bsm76B2ADWebRCLt09fhzFN4COrD1TIeQf5Pixqs9nAFtXNHOSrjFz1lgU2Oqfz5
	QdUhSWLRb10iHb4H979Hc9tMLMX46Ap4x7MN1JSdsc1QgQz7X8W5w==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ack5r3r1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:39 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49GBodgd020816;
	Wed, 16 Oct 2024 11:50:39 GMT
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42ack5r3qx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:39 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49G9bOXw006671;
	Wed, 16 Oct 2024 11:50:38 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4283es1cxr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 16 Oct 2024 11:50:38 +0000
Received: from smtpav03.fra02v.mail.ibm.com (smtpav03.fra02v.mail.ibm.com [10.20.54.102])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49GBoZ7j47776008
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 16 Oct 2024 11:50:35 GMT
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id F27F82004D;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: from smtpav03.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D1CE92004B;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav03.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Wed, 16 Oct 2024 11:50:34 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 94BD1E06B7; Wed, 16 Oct 2024 13:50:34 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        "Ricardo B. Marliere" <ricardo@marliere.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH 2/2] s390/time: Add PtP driver
Date: Wed, 16 Oct 2024 13:50:30 +0200
Message-ID: <20241016115030.2653675-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20241016115030.2653675-1-svens@linux.ibm.com>
References: <20241016115030.2653675-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: HHA55mj7pDZJBIGnVZvlRfGikv-pwLJ6
X-Proofpoint-GUID: V3tA7AGEdlCZdvqjN-01w1_SHp6pOmbK
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 impostorscore=0 adultscore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 phishscore=0 bulkscore=0 suspectscore=0 mlxscore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410160073

Add a small PtP driver which allows user space to get
the values of the physical and tod clock. This allows
programs like chrony to use STP as clock source and
steer the kernel clock. The physical clock can be used
as a debugging aid to get the clock without any additional
offsets like STP steering or LPAR offset.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 MAINTAINERS                   |   6 ++
 arch/s390/include/asm/stp.h   |   1 +
 arch/s390/include/asm/timex.h |   6 ++
 arch/s390/kernel/time.c       |   6 ++
 drivers/ptp/Kconfig           |  11 +++
 drivers/ptp/Makefile          |   1 +
 drivers/ptp/ptp_s390.c        | 129 ++++++++++++++++++++++++++++++++++
 7 files changed, 160 insertions(+)
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
diff --git a/arch/s390/include/asm/stp.h b/arch/s390/include/asm/stp.h
index 4d74d7e33340..827cb208de86 100644
--- a/arch/s390/include/asm/stp.h
+++ b/arch/s390/include/asm/stp.h
@@ -94,5 +94,6 @@ struct stp_stzi {
 int stp_sync_check(void);
 int stp_island_check(void);
 void stp_queue_work(void);
+bool stp_enabled(void);
 
 #endif /* __S390_STP_H */
diff --git a/arch/s390/include/asm/timex.h b/arch/s390/include/asm/timex.h
index 640901f2fbc3..e97e80b10067 100644
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
@@ -250,6 +251,11 @@ static __always_inline unsigned long tod_to_ns(unsigned long todval)
 	return ((todval >> 9) * 125) + (((todval & 0x1ff) * 125) >> 9);
 }
 
+static __always_inline unsigned long eitod_to_ns(u128 todval)
+{
+	return (todval * 125) >> 9;
+}
+
 /**
  * tod_after - compare two 64 bit TOD values
  * @a: first 64 bit TOD timestamp
diff --git a/arch/s390/kernel/time.c b/arch/s390/kernel/time.c
index 4214901c3ab0..cc60b16a7dd0 100644
--- a/arch/s390/kernel/time.c
+++ b/arch/s390/kernel/time.c
@@ -469,6 +469,12 @@ static void __init stp_reset(void)
 	}
 }
 
+bool stp_enabled(void)
+{
+	return test_bit(CLOCK_SYNC_HAS_STP, &clock_sync_flags) && stp_online;
+}
+EXPORT_SYMBOL(stp_enabled);
+
 static void stp_timeout(struct timer_list *unused)
 {
 	queue_work(time_sync_wq, &stp_work);
diff --git a/drivers/ptp/Kconfig b/drivers/ptp/Kconfig
index 604541dcb320..8aaca40cab08 100644
--- a/drivers/ptp/Kconfig
+++ b/drivers/ptp/Kconfig
@@ -224,4 +224,15 @@ config PTP_DFL_TOD
 	  To compile this driver as a module, choose M here: the module
 	  will be called ptp_dfl_tod.
 
+config PTP_S390
+	tristate "S390 PTP driver"
+	depends on PTP_1588_CLOCK
+	depends on S390
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
index 000000000000..9b59860ccb06
--- /dev/null
+++ b/drivers/ptp/ptp_s390.c
@@ -0,0 +1,129 @@
+// SPDX-License-Identifier: GPL-2.0-or-later
+/*
+ * s390 PTP clock driver
+ *
+ */
+
+#include "ptp_private.h"
+#include <linux/time.h>
+#include <asm/stp.h>
+
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
+	return ns_to_timespec64(eitod_to_ns(clk->eitod) - TOD_UNIX_EPOCH);
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
+	store_tod_clock_ext(&tod);
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
+	store_tod_clock_ext(&clk);
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
+	.name		= "IBM s390 STCKE Clock",
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
+	.name		= "IBM s390 Physical Clock",
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
+MODULE_DESCRIPTION("S390 Physical/STCKE Clock PtP Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

