Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 173DE3CBE86;
	Thu,  6 Aug 2026 19:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786043112; cv=none; b=fzCJVMNtJ96MbvLlGIsURsUKuXPMVGiw4mQmqCLxi5BVdndmN5daYUXspYNQ9UxSX86Xk7OkXeWbkkcqr4uxnbJuava6M66OdYVurCXH6pfLI1Ti4U/Ck62c9EHQRbxKzKjSHQqq3Htnv25ED8FutEGF8I7U8uwyp6sj8vqcX14=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786043112; c=relaxed/simple;
	bh=XZTpSno9qn+kmE1Ssj5I/VVE4fJlnSLlQmoy41Aollc=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=mkyjjwr4e5ZPR/76MjpDODxxNchlzy19rucrQ8ZRB6PnbtEDkF3VkyytS0S6S7VY2IwYjqoah9n9AvNi/KXd0skbQCzSI+7i4NV72PELz4nPpyaNy3kB0NSZ319Om9afyFkT9FRU5e2SD65fI9nYKYjvEWxqwURs6Ko5sENksLY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=dvLHmAGD; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="dvLHmAGD"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 676II0OU3470381;
	Thu, 6 Aug 2026 19:05:07 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=IdwkwMLnnJbkveRAMqqFlE5/xaAjIBIr6UNRrEHLH
	j8=; b=dvLHmAGDjXXywbIuAyw9gbzhlx0NT+tqDxNqy9S3bZjFQafXYYilXhDXi
	vPq+gNN4r44Uo+W+fIlQbQ1TYoEVhnZSvvQPh9xOjfsPMGHTUo1GeRBdBhFM1q8v
	PDJ1Ty7CTppO/C78EvdgL9CkXPIFRIkWwC8zp7TKGCwnhmL/xbyoq586XjT2gTD5
	eC9LHmj9ou672LGB+vLBon8M6oVnfGeA3h7dy1nENecXIv+OYJUBO8DRK4OYA4kR
	mz5sU/nBEqqjGp/wCsjPwVLwi9wJsKa5LON5/s1fKjSpUXc4TmgUvME/+jLI3wfn
	ImNxaUNKXkFhBeIiEMd2qx/GRhUvQ==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4fvy008aws-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:05:06 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 676IuGRV024243;
	Thu, 6 Aug 2026 19:05:05 GMT
Received: from smtprelay04.fra02v.mail.ibm.com ([9.218.2.228])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4fswtyvc8k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 06 Aug 2026 19:05:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay04.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 676J517q29819592
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 6 Aug 2026 19:05:01 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id AE7BB20043;
	Thu,  6 Aug 2026 19:05:01 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3FED420040;
	Thu,  6 Aug 2026 19:05:01 +0000 (GMT)
Received: from li-d2cd37cc-2ca3-11b2-a85c-84ed3706e5a0.ibm.com (unknown [9.111.90.112])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  6 Aug 2026 19:05:01 +0000 (GMT)
From: Ilya Leoshkevich <iii@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Alexander Potapenko <glider@google.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, Ilya Leoshkevich <iii@linux.ibm.com>,
        Boqun Feng <boqun@kernel.org>, kernel test robot <lkp@intel.com>
Subject: [PATCH v2] s390/irqflags: Add out-of-line definitions of arch_local_irq_*() for KMSAN
Date: Thu,  6 Aug 2026 21:04:45 +0200
Message-ID: <20260806190500.3293578-1-iii@linux.ibm.com>
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
X-Proofpoint-Spam-Info: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfX4emD/V8saZoh
 2OltSjt1fhqbpd4W1tFQJs3nPVJFks7cJCyzigkvCLuxtJ7+jW32n6FSeFiKI9DmF2FHYKVZ0GL
 OJ4lT1Kwv8b21WGWWq1oXijbqA5vRl8=
X-Authority-Analysis: v=2.4 cv=VPTtWdPX c=1 sm=1 tr=0 ts=6a74dae2 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VwQbUJbxAAAA:8 a=QyXUC8HyAAAA:8 a=VnNF1IyMAAAA:8
 a=LUgok-RiZmQt-186wxYA:9
X-Proofpoint-ORIG-GUID: t969GpUOxH2B4O8CU6Lga0aJEVWoxjJS
X-Proofpoint-GUID: ACzoRyA9NjDCAF5P7nbbc5F86aZzQApp
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODA2MDE0NyBTYWx0ZWRfX4JAs382YYb30
 qHHyF/E4i4h2pTxYVps0JfUD2o8MMfZR8iVua57WpF6BXvRzKBp9wiyLcpjRoUbU5WCJ4pmZoH9
 0jmmzMlVitk5ypDaXdA+EO1k6AWeiMymnOcrymbsYL4JVHKktpN/1ceqDBVmI3PFOXsNe+E3eeP
 g1QerWfEddhMlQr6QzyFFsgykIdgFMY4gGR8CmxiFSwxqPOvyGMV5BOlKzCRl6dR0RbplVtPbRj
 OIrOCMI778L0HDbiJ6jOjsCqYa78+upbTsrWtDkSu6o9xPbNu5kLfawHqX3tJzsIKptGkW+G3vF
 IvtENwEzwHREa6GlualAHQ+dlj94RJ26S37sDqprqASZXimbInE+OHljEI/r36uoeqETkQ66Em4
 yFdHxmLE8lmZyaSgKTw5zbhftoAGKEnEmvaFqscpV9RZqEp+ZvMK7tlsv/ZHYC25DQsbPsge07a
 TaQ3Mwqjq1YM/J+yU6w==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-06_02,2026-08-06_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 lowpriorityscore=0 malwarescore=0 bulkscore=0 spamscore=0 clxscore=1015
 priorityscore=1501 phishscore=0 impostorscore=0 adultscore=0 suspectscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608060147

Inline KMSAN arch_local_irq_*() definitions run afoul of
-Wstatic-in-inline. Move them out-of-line. Make sure decompressor and
non-GPL modules see the out-of-line definitions.

Cc: Boqun Feng <boqun@kernel.org>
Reported-by: kernel test robot <lkp@intel.com>
Closes: https://lore.kernel.org/oe-kbuild-all/202607131219.euJHPSJ5-lkp@intel.com/
Suggested-by: Heiko Carstens <hca@linux.ibm.com>
Fixes: 1b301f5f28ba ("s390/irqflags: do not instrument arch_local_irq_*() with KMSAN")
Signed-off-by: Ilya Leoshkevich <iii@linux.ibm.com>
---

v1: https://lore.kernel.org/lkml/20260806101740.15764C97-hca@linux.ibm.com/
v1 -> v2: Fix style issues (Heiko).

 arch/s390/include/asm/irqflags.h | 20 +++++++++++++-------
 arch/s390/kernel/Makefile        |  1 +
 arch/s390/kernel/irqflags.c      | 28 ++++++++++++++++++++++++++++
 3 files changed, 42 insertions(+), 7 deletions(-)
 create mode 100644 arch/s390/kernel/irqflags.c

diff --git a/arch/s390/include/asm/irqflags.h b/arch/s390/include/asm/irqflags.h
index bcab456dfb803..6eb6de6a99f2d 100644
--- a/arch/s390/include/asm/irqflags.h
+++ b/arch/s390/include/asm/irqflags.h
@@ -37,18 +37,24 @@ static __always_inline void __arch_local_irq_ssm(unsigned long flags)
 	asm volatile("ssm   %0" : : "Q" (flags) : "memory");
 }
 
-#ifdef CONFIG_KMSAN
-#define arch_local_irq_attributes noinline notrace __no_sanitize_memory __maybe_unused
+#if defined(CONFIG_KMSAN) && !defined(__DECOMPRESSOR)
+unsigned long arch_local_save_flags(void);
+unsigned long arch_local_irq_save(void);
+void arch_local_irq_enable_external(void);
+void arch_local_irq_enable(void);
 #else
-#define arch_local_irq_attributes __always_inline
+#define arch_local_save_flags		__arch_local_save_flags
+#define arch_local_irq_save		__arch_local_irq_save
+#define arch_local_irq_enable_external	__arch_local_irq_enable_external
+#define arch_local_irq_enable		__arch_local_irq_enable
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
index 0000000000000..e192f59f8918c
--- /dev/null
+++ b/arch/s390/kernel/irqflags.c
@@ -0,0 +1,28 @@
+// SPDX-License-Identifier: GPL-2.0
+
+#include <linux/export.h>
+#include <asm/irqflags.h>
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

