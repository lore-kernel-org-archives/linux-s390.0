Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8A41195F17;
	Tue, 22 Oct 2024 09:25:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729589126; cv=none; b=PXfmOUs2t0/vV/44V31N0VIPJCZP3xnVFZkGBzyvIhUG/I/Akc592GASM4ZCuYnMSXa5rrAF2zBdCWK7ldliFOSaN2yEYwL18Yvy+a/Laadj647ohDAWk32LFYbFtBeoj7o2UNVCl71Zvc1tuwTJ8KFegei9f/EnqPT3z+C2DZ8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729589126; c=relaxed/simple;
	bh=hRpbYcn7E+v0sYraExI3HLcAkQ35ZW/WyYwzSK/mEEY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BVN7UHyjZfITQlOICUSTicXAi4ZvwM58XE+VTDb7RsF1AVdJD/Lnk0cwNhbyPA3Sh3tKaM9zZt+HHbrdj0DBihYS2xfnISJydlSFhvBtMt5rUN9tqpn7d2vUXw3oePhNn2OAhKeEhAUNq4nIQd4NWN8Al+bnnsZXONNn9886bec=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=SboWx647; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="SboWx647"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49M4MGGF008286;
	Tue, 22 Oct 2024 09:25:12 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=rj6qWvKSde7fyD4Ci
	v3wt4jf+y12ufRMYFf3M3LUNOg=; b=SboWx647cfZYhftj9hPG5/PJtCyn2a1CC
	XnCC5dCXXjGEHHOfHcJoO7b4Hfh2BnRMtuETjVTCR6CK9ZRT4iLt5kPT6VwkHZOY
	I2JlpiG9Zy5IWWKAdiFxqHNQw9imMXYYTlrsKNvt5xXa0F/YlFiJ7RJCkLEvwAQL
	AqR3JH/iqK4Dr1LQNMdRlHcYAe017We5MBart48oAmMhCqVNI1bfneQ9kMxB123f
	ltpsS9fbqGIOv4IutVowreis4Manb6UEiJSXAv64V2jBrjWAog5Jy6EZ/6FC7QPk
	ZPvJ+ZJ2qjDOWNLoe+XzIJH9r0LWN12MMuGkl7ceOqxAEKr2j8Blg==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfh1nb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:12 +0000 (GMT)
Received: from m0356516.ppops.net (m0356516.ppops.net [127.0.0.1])
	by pps.reinject (8.18.0.8/8.18.0.8) with ESMTP id 49M9PBxY029631;
	Tue, 22 Oct 2024 09:25:11 GMT
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 42e4xfh1n7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:11 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 49M52SHm009371;
	Tue, 22 Oct 2024 09:25:11 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 42cr3mthb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 22 Oct 2024 09:25:11 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 49M9P71f22479138
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 22 Oct 2024 09:25:07 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 17F0D20043;
	Tue, 22 Oct 2024 09:25:07 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E8C4F20040;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.152.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTPS;
	Tue, 22 Oct 2024 09:25:06 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id 821FDE074C; Tue, 22 Oct 2024 11:25:06 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Richard Cochran <richardcochran@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Ricardo B. Marliere" <ricardo@marliere.net>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
        netdev@vger.kernel.org
Subject: [PATCH net-next v3 2/2] s390/time: Add PtP driver
Date: Tue, 22 Oct 2024 11:24:58 +0200
Message-ID: <20241022092458.2793331-3-svens@linux.ibm.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20241022092458.2793331-1-svens@linux.ibm.com>
References: <20241022092458.2793331-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: qLzeOegIvkeMBSyrdNbB34A4AfUX1O-2
X-Proofpoint-ORIG-GUID: V3s0K2HOLIRGH0VuuxuOMD2WV7FWzItT
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1051,Hydra:6.0.680,FMLib:17.12.62.30
 definitions=2024-10-15_01,2024-10-11_01,2024-09-30_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 lowpriorityscore=0 priorityscore=1501 suspectscore=0 impostorscore=0
 clxscore=1015 bulkscore=0 malwarescore=0 spamscore=0 mlxscore=0
 adultscore=0 mlxlogscore=999 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2410220057

Add a small PtP driver which allows user space to get
the values of the physical and tod clock. This allows
programs like chrony to use STP as clock source and
steer the kernel clock. The physical clock can be used
as a debugging aid to get the clock without any additional
offsets like STP steering or LPAR offset.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com> 
Acked-by: Richard Cochran <richardcochran@gmail.com>
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
index 640901f2fbc3..642fd303ce01 100644
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
 
+static __always_inline u128 eitod_to_ns(u128 todval)
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
index 000000000000..6218983080f8
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
+	return ns_to_timespec64(eitod_to_ns(clk->eitod - TOD_UNIX_EPOCH));
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
+	.name		= "s390 STCKE Clock",
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
+	.name		= "s390 Physical Clock",
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
+MODULE_DESCRIPTION("s390 Physical/STCKE Clock PtP Driver");
+MODULE_LICENSE("GPL");
-- 
2.43.0

