Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C4E5E438486;
	Thu,  6 Aug 2026 10:00:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786010451; cv=none; b=BBbCNSlneoxxlFBr4Th4YtMK7KL5a8INeJxYQN/z/ZTJAQ7Ez1mLKdxUrVLmhNP2xFaOMMO9iGpEWwnKFdz5Su9F+KklkXfuXBYApgtMnuvEVmthWo0PYRNa+Zn9nl7lBaJvGS1bi8rRLDCohCOs+VX2g84f/2manBn5k5xeAQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786010451; c=relaxed/simple;
	bh=02frsE3bK/jREiSGxqRPx34/pd5WcnwzR5vksdRnCkM=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=gUHWR6Sw1Rrbfzhr9p4TB0KpBTnS41uk5c/XvyZJ3FAkuSu4Z5tZSuXSFyBmjxqhUzBZCYNmHVUAwfyDMKIvkrKM5LuYK/rJWj/XmS2+nwQ4k6EUa/2XruS6RHlZYH6R55ack5CMWf4iFTYd7IIIMjKHXIEd63qveRK+BUtfKbo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=csCP719r; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="csCP719r"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 675NlfuL1092770;
	Thu, 6 Aug 2026 10:00:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=PbmH/m4PSp0Ajn4AVOxgMKp2hwgchNb3dkVFOQa0A
	AA=; b=csCP719rVs1NudK22blmeH3B+2L9I030ArV7AY3UX3tnEZHdTHOyEYk10
	VEf9dtUTUCzPvGRz688GglSo5QdBYwavtSuoMxoHC8AGmP9cP7eefmFGufxgX3P0
	4gnCvG1Me2akL+kg1J3dr8NReWCPLV5cOTqxBpODCQI3LQx1kk29OeT4AjfQ9zlK
	v4/LIu4t2yMEdse96ggB77SRUojSSOSHqcbSHCry7mY6eKeezTGYhUOVZDO50w0q
	+cL5HuQaRkhtX4gp2WoNMq9OHWkRWSxsHFcCWjOqx4KpOiQFEmKreOzIpIgkIX9C
	2dhOk3lBbZ314rVE+lexlL15hxzzA==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fs8h57jb5-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 10:00:47 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 6769uFHj027360;
	Thu, 6 Aug 2026 10:00:46 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4fsv4kapj7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 10:00:45 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676A0fQu38535582
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 10:00:41 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AB8BB20040;
	Thu,  6 Aug 2026 10:00:41 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3F5C82004D;
	Thu,  6 Aug 2026 10:00:41 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.87.144.71])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 10:00:41 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Boqun Feng <boqun@kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH] s390/irqflags: add out-of-line definitions of arch_local_irq_*() for KMSAN
Date: Thu,  6 Aug 2026 12:00:19 +0200
Message-ID: <20260806100038.3163298-1-iii@linux.ibm.com>
X-Mailer: git-send-email 2.55.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDA3NiBTYWx0ZWRfXzfN6hNkZStcQ
 nKY/72juSu+5vTprzC/VVLMVRC+VkT1HW/a2kMBEcbvpbNRElKges59+RHXtnXtRd+TT0hnMQn1
 VxzO8S6dKYnKQL/HwwAIQMKrNXpH/yo=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDA3NiBTYWx0ZWRfX8Ra1pLZdB6B3
 kfD8eRI+6XNusJD4ZRW1frrcJzJybV2Ic2q1IAQMqmeq75ZW9r9BX6WtjUGWtrxMv50otQMI1eu
 3Y7mrVvH6fu0r/8V3P3pxg93yDmKd3ZhMGUZ2B9IaI0sVf7WUKYeEQYtVUTuoCtvk76k1XdrHkZ
 FrLZ3mNwrvWQMi4+tvXFk3fWEP0Rw6WfNRLGA2aD+4CIuGgg04FGYLVwKrV+IFm5MQ533yO0b4U
 lJ0rXVdNe04kaYAmvIHL8FHGXjOGxP2AE73PscJBo1unsHq9cp8ZQfdd1tn8Epc4cYKqmtd80AG
 opIV3uGVi//XtxRt3QsIaCEHYWWjTUnl2bReXyYc6yuocQTpXDlbNrOK/TU+n/TnU57I3kxMb4R
 gb5MFBwLOH8hRRpfzgfCEMKipFstMPzqfH4dp0AVkEF7FwhwQesX9M5alw2tKXD4LG+z2gq/rSX
 M5dWI/Scj2ETESSYiwA==
X-Authority-Analysis: v=2.4 cv=SI1ykuvH c=1 sm=1 tr=0 ts=6a745b4f cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=LUgok-RiZmQt-186wxYA:9
X-Proofpoint-ORIG-GUID: m2B6TR8sdzqy-dxB6XCgKrHLM2xstfwp
X-Proofpoint-GUID: FooCUMO5RRKFwMn-UvsPyhaUh2iPRvvb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-05_06,2026-08-05_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 bulkscore=0 suspectscore=0 impostorscore=0 spamscore=0
 phishscore=0 priorityscore=1501 lowpriorityscore=0 adultscore=0
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2606150000
 definitions=main-2608060076

Inline KMSAN arch_local_irq_*() definitions run afoul of
-Wstatic-in-inline. Move them out-of-line. Decompressor is not
instrumented, so make sure it keeps using inline definitions.
Make sure non-GPL modules see the out-of-line definitions.

Cc: Boqun Feng <boqun@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*() with KMSAN")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---
 arch/s390/include/asm/irqflags.h | 20 +++++++++++++-------
 arch/s390/kernel/Makefile        |  1 +
 arch/s390/kernel/irqflags.c      | 27 +++++++++++++++++++++++++++
 3 files changed, 41 insertions(+), 7 deletions(-)
 create mode 100644 arch/s390/kernel/irqflags.c

diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
index bcab456dfb803..44d158f7831e6 100644
--- a/arch/s390/include/asm/irqflags.h
+++ b/arch/s390/include/asm/irqflags.h
@@ -37,18 +37,24 @@ static __always_inline void __arch_local_irq_ssm(unsigned long flags)
 	asm volatile("ssm   %0" : : "Q" (flags) : "memory");
 }
 
-#ifdef CONFIG_KMSAN
-#define arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
+#if defined(CONFIG_KMSAN) && !defined(__DECOMPRESSOR)
+extern unsigned long arch_local_save_flags(void);
+extern unsigned long arch_local_irq_save(void);
+extern void arch_local_irq_enable_external(void);
+extern void arch_local_irq_enable(void);
 #else
-#define arch_local_irq_attributes __always_inline
+#define arch_local_save_flags __arch_local_save_flags
+#define arch_local_irq_save __arch_local_irq_save
+#define arch_local_irq_enable_external __arch_local_irq_enable_external
+#define arch_local_irq_enable __arch_local_irq_enable
 #endif
 
-static arch_local_irq_attributes unsigned long arch_local_save_flags(void)
+static __always_inline unsigned long __arch_local_save_flags(void)
 {
 	return __arch_local_irq_stnsm(0xff);
 }
 
-static arch_local_irq_attributes unsigned long arch_local_irq_save(void)
+static __always_inline unsigned long __arch_local_irq_save(void)
 {
 	return __arch_local_irq_stnsm(0xfc);
 }
@@ -58,12 +64,12 @@ static __always_inline void arch_local_irq_disable(void)
 	arch_local_irq_save();
 }
 
-static arch_local_irq_attributes void arch_local_irq_enable_external(void)
+static __always_inline void __arch_local_irq_enable_external(void)
 {
 	__arch_local_irq_stosm(0x01);
 }
 
-static arch_local_irq_attributes void arch_local_irq_enable(void)
+static __always_inline void __arch_local_irq_enable(void)
 {
 	__arch_local_irq_stosm(0x03);
 }
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index 6c88476d79a31..14ef03cb2f72a 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_STACKPROTECTOR)	+= stackprotector.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
 obj-$(CONFIG_CERT_STORE)	+= cert_store.o
+obj-$(CONFIG_KMSAN)		+= irqflags.o
 
 obj-$(CONFIG_PERF_EVENTS)	+= perf_event.o
 obj-$(CONFIG_PERF_EVENTS)	+= perf_cpum_cf.o perf_cpum_sf.o
diff --git a/arch/s390/kernel/irqflags.c b/arch/s390/kernel/irqflags.c
new file mode 100644
index 0000000000000..98299c4758c6e
--- /dev/null
+++ b/arch/s390/kernel/irqflags.c
@@ -0,0 +1,27 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <asm/irqflags.h>
+#include <linux/export.h>
+
+noinstr unsigned long arch_local_save_flags(void)
+{
+	return __arch_local_save_flags();
+}
+EXPORT_SYMBOL(arch_local_save_flags);
+
+noinstr unsigned long arch_local_irq_save(void)
+{
+	return __arch_local_irq_save();
+}
+EXPORT_SYMBOL(arch_local_irq_save);
+
+noinstr void arch_local_irq_enable_external(void)
+{
+	__arch_local_irq_enable_external();
+}
+EXPORT_SYMBOL(arch_local_irq_enable_external);
+
+noinstr void arch_local_irq_enable(void)
+{
+	__arch_local_irq_enable();
+}
+EXPORT_SYMBOL(arch_local_irq_enable);
-- 
2.55.0

