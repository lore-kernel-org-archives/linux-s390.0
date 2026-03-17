Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43E7B1A9FAF;
	Tue, 17 Mar 2026 19:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773777293; cv=none; b=ECqJcTgE/8lBQidCGUO4jrlmHBAN3y4ld7uWrT89lLTc6NhuqMv2U95q14cnNWgYN1TCHB3xcdtJZWRZJDEXQOtpGK+9EPuTVHKuBhlWY6+3x/DYycw1XYsDAcJF89rTQTJv3tK/rzzhj/sEHsATAkh9b2kn39N27BPHpdx+2Bw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773777293; c=relaxed/simple;
	bh=i1HDNOXvqfPKxyL08nXlqnJFBeHPM2KSJF6rzgUQu4Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dRfAC0vO7rMU+1Wj9Zhrm5JxBh4lyucEa8n6mW6DCLoyPtzvUeAQ8YwjxUSTPatj9O5DzpR3EBkB6fSnhvTynCbKsGe11Mk3UhGxyDOGyTozVQO9vErn4KRWixc0mqbYwqSiG9z5zBQjuFSm+eIhCi3AAWLuZ9camUkKSisCLDM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=XNH1UM5h; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="XNH1UM5h"
Received: from pps.filterd (m0356517.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 62H9wbiw1189478;
	Tue, 17 Mar 2026 19:54:43 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=SdN81pYnVwJKbtFS5
	YXLDPvFowmPzFIFZ/xCQ+0QJYk=; b=XNH1UM5hWM0NAqvMW9Rhhimu/J40bL80u
	eEKyBMYWHH27HzvigldS+YWXscFuRVTMUewHg0H06600l0RnoM4TSebEEXa9/ZEt
	+UTM0/qgFrw1wHl5ZGDvdQU507hu6GbP5gcr4ZZh9Q1c+gZlagJno+A9x67Nm9GK
	lXXjWbh82ctuQcik4zMoWRHNCobS9IdGHkukC+XoiHz2OiDJGZi0TzKxJokhKKCO
	jQW0u4utkm5gC2HFyuhN+voWKoQByenbfZbSpNb9Ef+dVjEiDL7fKRWRzPdSn6Fs
	nCj73YpG6M51Xmp5hLfH2iDEvf4taTK15iHdS0c/Z30+JcDdeWNFg==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4cx7vfgw77-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:43 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 62HGNOsa028496;
	Tue, 17 Mar 2026 19:54:42 GMT
Received: from smtprelay07.fra02v.mail.ibm.com ([9.218.2.229])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4cwmq1ak3t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Mar 2026 19:54:42 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay07.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 62HJsbJH48169374
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 17 Mar 2026 19:54:38 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id D46E820040;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id A43DF2004B;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 17 Mar 2026 19:54:37 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Juergen Christ <jchrist@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 3/9] s390/percpu: Infrastructure for more efficient this_cpu operations
Date: Tue, 17 Mar 2026 20:54:30 +0100
Message-ID: <20260317195436.2276810-4-hca@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260317195436.2276810-1-hca@linux.ibm.com>
References: <20260317195436.2276810-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-ORIG-GUID: wO3MFv0FNni6nAFSAux-KYVcDWHSsfiY
X-Authority-Analysis: v=2.4 cv=KajfcAYD c=1 sm=1 tr=0 ts=69b9b183 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=Yq5XynenixoA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=U7nrCbtTmkRpXpFmAIza:22 a=VnNF1IyMAAAA:8 a=WWXEMnX_Ls2LmYDc0GUA:9
 a=RwcZUMTHd8_6jkUI:21
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMzE3MDE3NCBTYWx0ZWRfXxgn9jLqmkoZ+
 e8SUX/76RK4U9vJ/+MYLKDBIuwARiu1I632USIgRQC+FCciEUW7D0jpnMnPcDgvw9lXd0VCGLRr
 AHVym4Ub1M0zWHA9PWkKQhyuaeTr2qYydstOe7PBBmGxFJNAu6KpNFNUtHt/f3sQL27pXwMzSBD
 6Dz3f+T5Yrr+vQ+QlxSv5I2rrBiBHK3eO4Kz3QIZnEF8W7vKF/Vg5Hvi8NXB+HWG2wofSyaPI5Q
 1p8nK/UjAVH9NmasztD5U8NGGUO4TZSunLDUxsOTtkQf6fgQNanOYuq4VVXG3jfeTkRA5sgRHig
 1MoLymUQkTbcDm21tw7WBOffvGfGZdN1V2dkz/iZ8kpfNVpKP/UrM223axGPtC4hWiJMCAEx3m0
 HUNHGz6PTYnHHLAmzsNGVz1eEG3IsEaIbeHFKR9gO8YlorML4JnHjGQAQUhkJlBi0mjB2erSUsX
 2k7ooPO+JcAXaav5InA==
X-Proofpoint-GUID: wO3MFv0FNni6nAFSAux-KYVcDWHSsfiY
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-03-17_04,2026-03-17_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 spamscore=0 malwarescore=0 clxscore=1015
 impostorscore=0 bulkscore=0 lowpriorityscore=0 priorityscore=1501
 phishscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2603050001
 definitions=main-2603170174

With the intended removal of PREEMPT_NONE this_cpu operations based on
atomic instructions, guarded with preempt_disable()/preempt_enable() pairs
become more expensive: the preempt_disable() / preempt_enable() pairs are
not optimized away anymore during compile time.

In particular the conditional call to preempt_schedule_notrace() after
preempt_enable() adds additional code and register pressure.

E.g. this simple C code sequence

DEFINE_PER_CPU(long, foo);
long bar(long a) { return this_cpu_add_return(foo, a); }

generates this code:

  11a976:       eb af f0 68 00 24       stmg    %r10,%r15,104(%r15)
  11a97c:       b9 04 00 ef             lgr     %r14,%r15
  11a980:       b9 04 00 b2             lgr     %r11,%r2
  11a984:       e3 f0 ff c8 ff 71       lay     %r15,-56(%r15)
  11a98a:       e3 e0 f0 98 00 24       stg     %r14,152(%r15)
  11a990:       eb 01 03 a8 00 6a       asi     936,1            <- __preempt_count_add(1)
  11a996:       c0 10 00 d2 ac b5       larl    %r1,1b70300      <- address of percpu var
  11a9a0:       e3 10 23 b8 00 08       ag      %r1,952          <- add percpu offset
  11a9a6:       eb ab 10 00 00 e8       laag    %r10,%r11,0(%r1) <- atomic op
  11a9ac:       eb ff 03 a8 00 6e       alsi    936,-1           <- __preempt_count_dec_and_test()
  11a9b2:       a7 54 00 05             jnhe    11a9bc <bar+0x4c>
  11a9b6:       c0 e5 00 76 d1 bd       brasl   %r14,ff4d30 <preempt_schedule_notrace>
  11a9bc:       b9 e8 b0 2a             agrk    %r2,%r10,%r11
  11a9c0:       eb af f0 a0 00 04       lmg     %r10,%r15,160(%r15)
  11a9c6        07 fe                   br      %r14

Even though the above example is more or less the worst case, since the
branch to preempt_schedule_notrace() requires a stackframe, which
otherwise wouldn't be necessary, there is also the conditional jnhe branch
instruction.

Get rid of the conditional branch with the following code sequence:

  11a8e6:       c0 30 00 d0 c5 0d       larl    %r3,1b33300
  11a8ec:       b9 04 00 43             lgr     %r4,%r3
  11a8f0:       eb 00 43 c0 00 52       mviy    960,4
  11a8f6:       e3 40 03 b8 00 08       ag      %r4,952
  11a8fc:       eb 52 40 00 00 e8       laag    %r5,%r2,0(%r4)
  11a902:       eb 00 03 c0 00 52       mviy    960,0
  11a908:       b9 08 00 25             agr     %r2,%r5
  11a90c        07 fe                   br      %r14

The general idea is that this_cpu operations based on atomic instructions
are guarded with mvyi instructions:

- The first mvyi instruction writes the register number, which contains
  the percpu address variable to lowcore. This also indicates that a
  percpu code section is executed.

- The first instruction following the mvyi instruction must be the ag
  instruction which adds the percpu offset to the percpu address register.

- Afterwards the atomic percpu operation follows.

- Then a second mvyi instruction writes a zero to lowcore, which indicates
  the end of the percpu code section.

- In case of an interrupt/exception/nmi the register number which was
  written to lowcore is copied to the exception frame (pt_regs), and a zero
  is written to lowcore.

- On return to the previous context it is checked if a percpu code section
  was executed (saved register number not zero), and if the process was
  migrated to a different cpu. If the percpu offset was already added to
  the percpu address register (instruction address does _not_ point to the
  ag instruction) the content of the percpu address register is adjusted so
  it points to percpu variable of the new cpu.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/entry-percpu.h | 54 ++++++++++++++++++++++++++++
 arch/s390/include/asm/lowcore.h      |  3 +-
 arch/s390/include/asm/percpu.h       | 54 ++++++++++++++++++++++++++++
 arch/s390/include/asm/ptrace.h       |  2 ++
 arch/s390/kernel/irq.c               |  5 +++
 arch/s390/kernel/nmi.c               |  3 ++
 arch/s390/kernel/traps.c             |  3 ++
 7 files changed, 123 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/asm/entry-percpu.h

diff --git a/arch/s390/include/asm/entry-percpu.h b/arch/s390/include/asm/entry-percpu.h
new file mode 100644
index 000000000000..eba795ec0ea0
--- /dev/null
+++ b/arch/s390/include/asm/entry-percpu.h
@@ -0,0 +1,54 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef ARCH_S390_ENTRY_PERCPU_H
+#define ARCH_S390_ENTRY_PERCPU_H
+
+#include <linux/percpu.h>
+#include <asm/lowcore.h>
+#include <asm/ptrace.h>
+#include <asm/asm-offsets.h>
+
+static __always_inline void percpu_entry(struct pt_regs *regs)
+{
+	struct lowcore *lc = get_lowcore();
+
+	if (user_mode(regs))
+		return;
+	regs->cpu = lc->cpu_nr;
+	regs->percpu_register = lc->percpu_register;
+	lc->percpu_register = 0;
+}
+
+static __always_inline void percpu_exit(struct pt_regs *regs)
+{
+	struct lowcore *lc = get_lowcore();
+	unsigned int insn, disp;
+	unsigned char reg;
+
+	reg = regs->percpu_register;
+	if (!reg)
+		return;
+	lc->percpu_register = reg;
+	if (regs->cpu == lc->cpu_nr)
+		return;
+	/*
+	 * Within a percpu code section and process has been migrated to
+	 * a different CPU. Check if the percpu base register needs to be
+	 * updated. This is the case if the PSW does not point to the ADD
+	 * instruction within the section
+	 * - AG %rx,percpu_offset_in_lowcore(%r0,%r0)
+	 * which adds the percpu offset to the percpu base register.
+	 */
+	if ((*(u16 *)psw_bits(regs->psw).ia & 0xff0f) != 0xe300)
+		return;
+	disp = offsetof(struct lowcore, percpu_offset);
+	if (machine_has_relocated_lowcore())
+		disp += LOWCORE_ALT_ADDRESS;
+	insn = (disp & 0xff000) >> 4 | (disp & 0x00fff) << 16 | 0x8;
+	if (*(u32 *)(psw_bits(regs->psw).ia + 2) != insn)
+		return;
+	/* Fixup percpu base register */
+	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
+	regs->gprs[reg] += lc->percpu_offset;
+}
+
+#endif
diff --git a/arch/s390/include/asm/lowcore.h b/arch/s390/include/asm/lowcore.h
index 50ffe75adeb4..cd1ddfdb5d35 100644
--- a/arch/s390/include/asm/lowcore.h
+++ b/arch/s390/include/asm/lowcore.h
@@ -165,7 +165,8 @@ struct lowcore {
 	__u32	spinlock_index;			/* 0x03b0 */
 	__u8	pad_0x03b4[0x03b8-0x03b4];	/* 0x03b4 */
 	__u64	percpu_offset;			/* 0x03b8 */
-	__u8	pad_0x03c0[0x0400-0x03c0];	/* 0x03c0 */
+	__u8	percpu_register;		/* 0x03c0 */
+	__u8	pad_0x03c1[0x0400-0x03c1];	/* 0x03c1 */
 
 	__u32	return_lpswe;			/* 0x0400 */
 	__u32	return_mcck_lpswe;		/* 0x0404 */
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index b18a96f3a334..05eb91428b42 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -60,6 +60,60 @@
 #define this_cpu_or_1(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
 #define this_cpu_or_2(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
 
+/*
+ * Macros to be used for percpu code section based on atomic instructions.
+ *
+ * Avoid the need to use preempt_disable() / preempt_disable() pairs and the
+ * conditional preempt_schedule_notrace() function calls which come with
+ * this. The idea is that this_cpu operations based on atomic instructions are
+ * guarded with mvyi instructions:
+ *
+ * - The first mvyi instruction writes the register number, which contains the
+ *   percpu address variable to lowcore. This also indicates that a percpu
+ *   code section is executed.
+ *
+ * - The first mvyi instruction following the mvyi instruction must be the ag
+ *   instruction which adds the percpu offset to the percpu address register.
+ *
+ * - Afterwards the atomic percpu operation follows.
+ *
+ * - Then a second mvyi instruction writes a zero to lowcore, which indicates
+ *   the end of the percpu code section.
+ *
+ * - In case of an interrupt/exception/nmi the register number which was
+ *   written to lowcore is copied to the exception frame (pt_regs), and a zero
+ *   is written to lowcore.
+ *
+ * - On return to the previous context it is checked if a percpu code section
+ *   was executed (saved register number not zero), and if the process was
+ *   migrated to a different cpu. If the percpu offset was already added to
+ *   the percpu address register (instruction address does _not_ point to the
+ *   ag instruction) the content of the percpu address register is adjusted so
+ *   it points to percpu variable of the new cpu.
+ *
+ * Inline assemblies making use of this typically have a code sequence like:
+ *
+ *   MVIY_PERCPU(...) <- start of percpu code section
+ *   AG_ALT(...)      <- add percpu offset; must be the second instruction
+ *   atomic_op	      <- atomic op
+ *   MVIY_ALT(...)    <- end of percpu code section
+ */
+
+#define MVIY_PERCPU(disp, dispalt, base)				\
+	ALTERNATIVE("	mviy	" disp	  "(" base " ),0\n",		\
+		    "	mviy	" dispalt "(" base " ),0\n",		\
+		    ALT_PERCPU(0))
+
+#define MVIY_ALT(disp, dispalt, base)					\
+	ALTERNATIVE("	mviy	" disp	  "(" base " ),0\n",		\
+		    "	mviy	" dispalt "(" base " ),0\n",		\
+		    ALT_FEATURE(MFEATURE_LOWCORE))
+
+#define AG_ALT(disp, dispalt, reg)					\
+	ALTERNATIVE("	ag	" reg ", " disp    "(%%r0)\n",		\
+		    "	ag	" reg ", " dispalt "(%%r0)\n",		\
+		    ALT_FEATURE(MFEATURE_LOWCORE))
+
 #ifndef MARCH_HAS_Z196_FEATURES
 
 #define this_cpu_add_4(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index aaceb1d9110a..495e310c3d6d 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -134,6 +134,8 @@ struct pt_regs {
 	};
 	unsigned long flags;
 	unsigned long last_break;
+	unsigned int cpu;
+	unsigned char percpu_register;
 };
 
 /*
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index d10a17e6531d..4843d87aa44d 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -33,6 +33,7 @@
 #include <asm/softirq_stack.h>
 #include <asm/vtime.h>
 #include <asm/asm.h>
+#include <asm/entry-percpu.h>
 #include "entry.h"
 
 DEFINE_PER_CPU_SHARED_ALIGNED(struct irq_stat, irq_stat);
@@ -146,6 +147,7 @@ void noinstr do_io_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	bool from_idle;
 
+	percpu_entry(regs);
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
 	if (from_idle)
 		update_timer_idle();
@@ -177,6 +179,7 @@ void noinstr do_io_irq(struct pt_regs *regs)
 
 	if (from_idle)
 		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
+	percpu_exit(regs);
 }
 
 void noinstr do_ext_irq(struct pt_regs *regs)
@@ -185,6 +188,7 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 	struct pt_regs *old_regs = set_irq_regs(regs);
 	bool from_idle;
 
+	percpu_entry(regs);
 	from_idle = test_and_clear_cpu_flag(CIF_ENABLED_WAIT);
 	if (from_idle)
 		update_timer_idle();
@@ -212,6 +216,7 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 
 	if (from_idle)
 		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
+	percpu_exit(regs);
 }
 
 static void show_msi_interrupt(struct seq_file *p, int irq)
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index a55abbf65333..20fd319a3a8e 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -22,6 +22,7 @@
 #include <linux/module.h>
 #include <linux/sched/signal.h>
 #include <linux/kvm_host.h>
+#include <asm/entry-percpu.h>
 #include <asm/lowcore.h>
 #include <asm/ctlreg.h>
 #include <asm/fpu.h>
@@ -374,6 +375,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 	unsigned long mcck_dam_code;
 	int mcck_pending = 0;
 
+	percpu_entry(regs);
 	irq_state = irqentry_nmi_enter(regs);
 
 	if (user_mode(regs))
@@ -496,6 +498,7 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 		schedule_mcck_handler();
 
 	irqentry_nmi_exit(regs, irq_state);
+	percpu_exit(regs);
 }
 NOKPROBE_SYMBOL(s390_do_machine_check);
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 1b5c6fc431cc..095937c2ca72 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -24,6 +24,7 @@
 #include <linux/entry-common.h>
 #include <linux/kmsan.h>
 #include <linux/bug.h>
+#include <asm/entry-percpu.h>
 #include <asm/asm-extable.h>
 #include <asm/irqflags.h>
 #include <asm/ptrace.h>
@@ -349,6 +350,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 		current->thread.gmap_int_code = regs->int_code & 0xffff;
 		return;
 	}
+	percpu_entry(regs);
 	state = irqentry_enter(regs);
 	if (user_mode(regs)) {
 		update_timer_sys();
@@ -386,6 +388,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 out:
 	local_irq_disable();
 	irqentry_exit(regs, state);
+	percpu_exit(regs);
 }
 
 /*
-- 
2.51.0

