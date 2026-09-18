Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0867A4B66D2;
	Fri, 18 Sep 2026 08:49:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789721348; cv=none; b=c1OpOy6iPNw19dFw7hJX8MPS0ZRv/oMU+2eZcrVF0OJw8M98bV7XFcXe6YnSjtj77GV8OKJzE5drFp9cunHmApBuJtpd/UOb59KQ4MKgxGypw9gUqNH8Ejv8eOAH6tgi7n8Z95JqHGh1xhPDRzNHlNsv9iGVORta8bIDgeYlrxo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789721348; c=relaxed/simple;
	bh=k94WpIVXf8FC6jqN6M0KyFVg/F1d1nls+9qEw+hc94k=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RNwZNgVxneIIYIIh2Y530kmT8HEOLec9+5GY7OCC+bdEr+LrNCxN+al01DzKPPreX3SGRrzaus3IHuchYTmunenhTbJ3/0T11pHowSrUvQD4+R9C0bqFm6vnx2bYu5MfUlepMRFFhGil9+vVLmo0GtLb/pBcDG+MarXEKL4SkbQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=kQwmSq8O; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="kQwmSq8O"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 68I62FA0314809;
	Fri, 18 Sep 2026 08:48:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=n0nlVzD1ijBv0mwee
	jkUiKT6JxGRLsgCTfsO44Yt+lc=; b=kQwmSq8OHecg2OXHkrD0kHWeYXmwYWqld
	tMa558Sa1BJ3ybg9YXN+CMieZoDxSsI1NTypjB1VVn+6aJqwhO0yz1YwIXBRJyKw
	ajZ1w/dnG/tGRkFyuDR8IOg354Hq4Kkl129yYAWC96MImyp0hY3e4X057DJj0NMv
	LCsztHBiG8Va4cb9GX87w+KbH71hcfi0YsifMIC6W+OwRJwydPc9mIqtWlTueRy+
	/ssf1a8RuCJoTF56I0MlClZNBy+0iUg+PT3zvpXf0kxxrfdrYNMlsqkzpihVb7U1
	47xWQrvWhtksQc02nySkUP0Y6Ho2rdUpuG+/bK9EYqj72NudkVJ3Q==
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gmv5j6upe-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:50 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 68I653qU208414;
	Fri, 18 Sep 2026 08:48:49 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4gr5xa6ewh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 18 Sep 2026 08:48:49 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 68I8mjDJ40632640
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Fri, 18 Sep 2026 08:48:45 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5553E20040;
	Fri, 18 Sep 2026 08:48:45 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 19CB22004E;
	Fri, 18 Sep 2026 08:48:45 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Fri, 18 Sep 2026 08:48:45 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Mete Durlu <meted@linux.ibm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Juergen Christ <jchrist@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 12/12] s390/percpu: Rework to simplify percpu_entry() and percpu_exit()
Date: Fri, 18 Sep 2026 10:48:42 +0200
Message-ID: <20260918084842.2333237-13-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260918084842.2333237-1-hca@linux.ibm.com>
References: <20260918084842.2333237-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfXzqKpHehsv/ht
 FuErQ/r5js1ZLXJjhnpwe+2h6HcYpzAp2kFlW6Tk75t1DGHwn8X0TfflnC1NbCLR/ZgiEbCCwLq
 xLqWBd4x1qs1ConwIOfXTAmsypOLd4Z2ClzyCsB9SJNSqH7XIhRcIJVf2RCd1sPUrVRfu5Xbg49
 dpoRi5+/jQtGukVTzZOKLmPleP2noWb9MMfkGh9ihUG5odwQfd4vnGtRKAeKKJciE+wSHdd7Hul
 YL7tadU2dUMBTegVg5WEeGXs0LYLxxzal+RE0oVAFB9W2M/uC6bnv9xBphwA03FsGyMeXTVLQj3
 JxijzZ4mY3CRidOgm81y5nvBKZuEdg036fsKtWlLsiPY71TZHB41i5DAdL31lBM7g6dLDp0gulZ
 a9+2rWG9AefPo0JMBzDRFJ7ZLdYuqlPiqrRnP1FQMKOhQxg0qUy/RDzVjdAdSwBknuBHYz+OeHG
 KENYCOy7L7NuVbed7eg==
X-Proofpoint-Spam-Info: AW1haW4tMjYwOTE4MDExNyBTYWx0ZWRfX6ktwnv/Zm6TX
 Dsnqa1Fg+Nz7SqA2ZxJXleVgkmWcXNo6tjGEvpWKofcna5tW8mM0Pf+A+toopgrH6LFgFZQ7V8W
 hbhLQB6VujLB0p76IznYyEDS0+Wx9gI=
X-Authority-Analysis: v=2.4 cv=Zsx4uN7G c=1 sm=1 tr=0 ts=6aacfaf2 cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=VdqzKS8jKosA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VwQbUJbxAAAA:8 a=7CQSdrXTAAAA:8 a=VnNF1IyMAAAA:8
 a=nX91KqSqHLHixs4I5UoA:9 a=ZBt6NyxRiIMNS_uD:21 a=a-qgeE7W1pNrGK8U0ZQC:22
X-Proofpoint-ORIG-GUID: xlEj-N6jmQueWAQf6G4cGDHZTRh3W871
X-Proofpoint-GUID: xlEj-N6jmQueWAQf6G4cGDHZTRh3W871
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-09-18_02,2026-09-16_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 malwarescore=0 impostorscore=0 clxscore=1015 priorityscore=1501
 lowpriorityscore=0 bulkscore=0 adultscore=0 phishscore=0 spamscore=0
 suspectscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2609180117

The percpu code section functionality uses a rather complex method to
figure out if the register, which contains the address of the current
cpu's percpu variable, needs to be adjusted.

If an interrupt happens within a percpu code section (indicated by a
lowcore field), the instruction at the interrupted location is
checked. If it is not a specific AG instruction, the register needs to
be updated. This mechanism needs to take kprobes into account, and
enforces a specific instruction ordering.

Mark Rutland provided with a different solution for arm64 [1] which
comes without such limitations, but requires to use one more
instruction, and two more registers. Given that this simplifies
percpu_entry() and percpu_exit() it seems to be worth to go that
route.

Change s390 to implement a similar approach. This requires to encode
three register numbers into the "percpu_register" field, which is used
to indicate if a percpu code section is executed.

The used mviy instruction can write only one byte, which allows to
encode only two register numbers. Use a register pair for the inline
assemblies, and only encode the even register number of the register
pair to work around this.

The generated code changes like this for e.g. a simple this_cpu_inc():

Old:

c0 20 00 00 00 00  larl    %r2,c6 <foo+0x6> <-- load address of percpu var
b9 04 00 32        lgr     %r3,%r2          <-- pointless copy of address
eb 03 03 c0 00 52  mviy    960,3            <-- start of percpu code section
                                                - gpr 3 contains percpu var address
e3 30 03 b8 00 08  ag      %r3,952          <-- add percpu offset
eb 01 30 00 00 7a  agsi    0(%r3),1         <-- atomic inc
eb 00 03 c0 00 52  mviy    960,0            <-- end of percpu code section

New:

c0 10 00 00 00 00  larl    %r1,c6 <foo+0x6> <-- load address of percpu var
eb 21 03 c0 00 52  mviy    960,33           <-- start of percpu code section
                                                33 == 0x21:
						- gpr 1 contains percpu var address
						- gpr 2 used for percpu offset
  					        - gpr 2+1 == 3 used for current cpu's percpu var address
e3 20 03 b8 00 04  lg      %r2,952          <-- load percpu offset
b9 e8 20 31        agrk    %r3,%r1,%r2      <-- generate current cpu's percpu var address
eb 01 30 00 00 7a  agsi    0(%r3),1         <-- atomic inc
eb 00 03 c0 00 52  mviy    960,0            <-- end of percpu code section

In the above "new" code example 33 (0x21) is used as indicator value to
mark that a percpu code section is executed. This value implies that
registers 2 and 3 will (only) hold the percpu offset and the current
cpu's percpu var address. Those registers will always be updated by the
percpu_exit() code to contain the percpu offset and percpu var address of
the current cpu.

Note that because of the pointless lgr instruction in the "old" code
example the two code sequences have identical size, and it looks like
only one more register is used. However this is because of suboptimal
gcc code generation.

[1] https://lore.kernel.org/all/20260908151741.394589-1-mark.rutland@arm.com/

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/entry-percpu.h |  71 ++-------
 arch/s390/include/asm/percpu.h       | 222 ++++++++++++++++++---------
 arch/s390/include/asm/ptrace.h       |   2 +-
 arch/s390/kernel/irq.c               |  10 +-
 arch/s390/kernel/nmi.c               |   4 +-
 arch/s390/kernel/traps.c             |   4 +-
 6 files changed, 173 insertions(+), 140 deletions(-)

diff --git a/arch/s390/include/asm/entry-percpu.h b/arch/s390/include/asm/entry-percpu.h
index 89c9e44f6f83..92fdc9142f1d 100644
--- a/arch/s390/include/asm/entry-percpu.h
+++ b/arch/s390/include/asm/entry-percpu.h
@@ -2,79 +2,42 @@
 #ifndef ARCH_S390_ENTRY_PERCPU_H
 #define ARCH_S390_ENTRY_PERCPU_H
 
-#include <linux/kprobes.h>
+#include <linux/bitfield.h>
 #include <linux/percpu.h>
 #include <asm/lowcore.h>
 #include <asm/ptrace.h>
-#include <asm/asm-offsets.h>
 
 static __always_inline void percpu_entry(struct pt_regs *regs)
 {
 	struct lowcore *lc = get_lowcore();
 
-	if (user_mode(regs))
-		return;
 	regs->cpu = lc->cpu_nr;
 	regs->percpu_register = lc->percpu_register;
 	lc->percpu_register = 0;
 }
 
-static __always_inline bool percpu_code_check(struct pt_regs *regs)
-{
-	unsigned int insn, disp;
-	struct kprobe *p;
-
-	if (likely(user_mode(regs) || !regs->percpu_register))
-		return false;
-	/*
-	 * Within a percpu code section - check if the percpu base register
-	 * needs to be updated. This is the case if the PSW does not point to
-	 * the ADD instruction within the section.
-	 * - AG %rx,percpu_offset_in_lowcore(%r0,%r0)
-	 * which adds the percpu offset to the percpu base register.
-	 */
-	lockdep_assert_preemption_disabled();
-again:
-	insn = READ_ONCE(*(u16 *)psw_bits(regs->psw).ia);
-	if (unlikely(insn == BREAKPOINT_INSTRUCTION)) {
-		p = get_kprobe((void *)psw_bits(regs->psw).ia);
-		/*
-		 * If the kprobe is concurrently removed on a different CPU
-		 * it might not be found anymore. However text must have
-		 * been restored - try again.
-		 */
-		if (!p)
-			goto again;
-		insn = p->opcode;
-	}
-	if ((insn & 0xff0f) != 0xe300)
-		return true;
-	disp = LC_PERCPU_OFFSET;
-	if (machine_has_relocated_lowcore())
-		disp += LOWCORE_ALT_ADDRESS;
-	insn = (disp & 0xff000) >> 4 | (disp & 0x00fff) << 16 | 0x8;
-	if (*(u32 *)(psw_bits(regs->psw).ia + 2) != insn)
-		return true;
-	return false;
-}
-
-static __always_inline void percpu_exit(struct pt_regs *regs, bool needs_fixup)
+static __always_inline void percpu_exit(struct pt_regs *regs)
 {
+	unsigned char regval, regpcp, regoff, regptr;
 	struct lowcore *lc = get_lowcore();
-	unsigned char reg;
 
-	if (user_mode(regs))
+	if (!regs->percpu_register)
 		return;
-	reg = regs->percpu_register;
-	lc->percpu_register = reg;
-	if (likely(!needs_fixup))
-		return;
-	/* Check if process has been migrated to a different CPU. */
+	regval = regs->percpu_register;
+	lc->percpu_register = regval;
+	/* Migrated to a different CPU? */
 	if (regs->cpu == lc->cpu_nr)
 		return;
-	/* Fixup percpu base register */
-	regs->gprs[reg] -= __per_cpu_offset[regs->cpu];
-	regs->gprs[reg] += lc->percpu_offset;
+	regpcp = FIELD_GET(PCPU_REG_PCP, regval);
+	regoff = FIELD_GET(PCPU_REG_OFF, regval);
+	regptr = regoff + 1;
+	/*
+	 * Update register 'regoff' which contains the current CPU's percpu
+	 * offset, and recalculate and update current CPU's percpu variable
+	 * address contained in register 'regptr'.
+	 */
+	regs->gprs[regoff] = lc->percpu_offset;
+	regs->gprs[regptr] = regs->gprs[regpcp] + regs->gprs[regoff];
 }
 
 #endif
diff --git a/arch/s390/include/asm/percpu.h b/arch/s390/include/asm/percpu.h
index 46368131b932..ea9448009468 100644
--- a/arch/s390/include/asm/percpu.h
+++ b/arch/s390/include/asm/percpu.h
@@ -67,28 +67,31 @@
  * this. The idea is that this_cpu operations based on atomic instructions are
  * guarded with mviy instructions:
  *
- * - The first mviy instruction writes the register number, which contains the
- *   percpu address variable to lowcore. This also indicates that a percpu
- *   code section is executed.
+ * - The first mviy instruction writes the register number of the percpu address
+ *   variable and the even register number of a register pair (which encodes two
+ *   registers: the even register for the percpu offset and the odd register for
+ *   the percpu pointer) to lowcore. This also indicates that a percpu code
+ *   section is executed.
  *
- * - The first mviy instruction following the mviy instruction must be the ag
- *   instruction which adds the percpu offset to the percpu address register.
+ * - The mviy instruction is followed by the lg instruction which loads the
+ *   percpu offset into the even register of the pair and the agrk instruction
+ *   which adds the percpu offset and the percpu address into the odd register
+ *   of the pair (the percpu pointer register).
  *
  * - Afterwards the atomic percpu operation follows.
  *
  * - Then a second mviy instruction writes a zero to lowcore, which indicates
  *   the end of the percpu code section.
  *
- * - In case of an interrupt/exception/nmi the register number which was
- *   written to lowcore is copied to the exception frame (pt_regs), and a zero
- *   is written to lowcore.
+ * - In case of an interrupt/exception/nmi the encoded register numbers which
+ *   were written to lowcore are copied to the exception frame (pt_regs), and a
+ *   zero is written to lowcore.
  *
  * - On return to the previous context it is checked if a percpu code section
- *   was executed (saved register number not zero), and if the process was
- *   migrated to a different cpu. If the percpu offset was already added to
- *   the percpu address register (instruction address does _not_ point to the
- *   ag instruction) the content of the percpu address register is adjusted so
- *   it points to percpu variable of the new cpu.
+ *   was executed (saved register value not zero). The content of the percpu
+ *   offset register (even register of the pair) is reloaded with the current
+ *   cpu's percpu offset and the percpu pointer register (odd register of the
+ *   pair) is recalculated so it points to the percpu variable of the new cpu.
  *
  * Inline assemblies making use of this typically have a code sequence like:
  *
@@ -115,27 +118,45 @@
 #define UNDEF_GR_NUM								\
 	".purgem _GR_NUM\n"
 
+#define PCPU_REG_PCP_SHIFT		0
+#define PCPU_REG_PCP			GENMASK(3, 0)
+#define PCPU_REG_OFF_SHIFT		4
+#define PCPU_REG_OFF			GENMASK(7, 4)
+
 #define __PCPU_MVIY(lcreg, imm)							\
 	ALTERNATIVE("	mviy	" lcreg			"(%%r0)," imm "\n",	\
 		    "	mviy	" lcreg "+" LC_ALT_ADDR "(%%r0)," imm "\n",	\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
-#define __PCPU_AG(reg, lcoff)							\
-	ALTERNATIVE("	ag	" reg ", " lcoff		 "(%%r0)\n",	\
-		    "	ag	" reg ", " lcoff "+" LC_ALT_ADDR "(%%r0)\n",	\
+#define __PCPU_MVIY_REGS(lcreg, regpcp, regoff)					\
+	DEFINE_GR_NUM								\
+	"_GR_NUM .Lregpcp, " regpcp "\n"					\
+	"_GR_NUM .Lregoff, " regoff "\n"					\
+	UNDEF_GR_NUM								\
+	".if .Lregpcp == .Lregoff\n"						\
+	"	.error \"Registers must not be identical\"\n"			\
+	".endif\n"								\
+	".set .Lregval, ((.Lregpcp << " __stringify(PCPU_REG_PCP_SHIFT) ") |"	\
+	"		 (.Lregoff << " __stringify(PCPU_REG_OFF_SHIFT) "))\n"	\
+	__PCPU_MVIY(lcreg, ".Lregval")
+
+#define __PCPU_LG(regoff, lcoff)						\
+	ALTERNATIVE("lg	" regoff ", " lcoff		    "(%%r0)\n",		\
+		    "lg	" regoff ", " lcoff "+" LC_ALT_ADDR "(%%r0)\n",		\
 		    ALT_FEATURE(MFEATURE_LOWCORE))
 
-#define __PCPU_BEGIN(lcreg, lcoff, reg)						\
-	DEFINE_GR_NUM								\
-	"_GR_NUM .Lreg, " reg "\n"						\
-	UNDEF_GR_NUM								\
-	__PCPU_MVIY(lcreg, ".Lreg")						\
-	__PCPU_AG(reg, lcoff)
+#define __PCPU_AGRK(regptr, regpcp, regoff)					\
+	"	agrk	" regptr "," regpcp "," regoff "\n"
+
+#define __PCPU_BEGIN(lcreg, lcoff, regpcp, regoff, regptr)			\
+	__PCPU_MVIY_REGS(lcreg, regpcp, regoff)					\
+	__PCPU_LG(regoff, lcoff)						\
+	__PCPU_AGRK(regptr, regpcp, regoff)
 
 #define __PCPU_END(lcreg)							\
 	__PCPU_MVIY(lcreg, "0")
 
-#ifndef MARCH_HAS_Z196_FEATURES
+#if !defined(MARCH_HAS_Z196_FEATURES) || !defined(CONFIG_CC_HAS_ASM_M_FORMAT_FLAG)
 
 #define this_cpu_add_4(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
 #define this_cpu_add_8(pcp, val)	arch_this_cpu_to_op_simple(pcp, val, +)
@@ -146,11 +167,12 @@
 #define this_cpu_or_4(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
 #define this_cpu_or_8(pcp, val)		arch_this_cpu_to_op_simple(pcp, val, |)
 
-#else /* MARCH_HAS_Z196_FEATURES */
+#else /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
 
 #define arch_this_cpu_add(pcp, val, op1, op2, szcast)				\
 do {										\
 	typedef typeof(pcp) pcp_op_T__;						\
+	union register_pair pair__;						\
 	pcp_op_T__ val__ = (val);						\
 	pcp_op_T__ old__, *ptr__;						\
 										\
@@ -158,25 +180,27 @@ do {										\
 	if (__builtin_constant_p(val__) &&					\
 	    ((szcast)val__ > -129) && ((szcast)val__ < 128)) {			\
 		asm volatile(							\
-			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-			op2 "   0(%[ptr__]),%[val__]\n"				\
+			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+				      "%[pair__]","%M[pair__]")			\
+			op2 "   0(%M[pair__]),%[val__]\n"			\
 			__PCPU_END("%[lcreg]")					\
-			: [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+			: [pair__] "=&d" (pair__), "+m" (*ptr__),		\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
-			: [val__] "i" ((szcast)val__),				\
+			: [val__] "i" ((szcast)val__), [ptr__] "d" (ptr__),	\
 			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
 			: "cc");						\
 	} else {								\
 		asm volatile(							\
-			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-			op1 "   %[old__],%[val__],0(%[ptr__])\n"		\
+			__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+				     "%[pair__]","%M[pair__]")			\
+			op1 "   %[old__],%[val__],0(%M[pair__])\n"		\
 			__PCPU_END("%[lcreg]")					\
-			: [old__] "=&d" (old__),				\
-			  [ptr__] "+&a" (ptr__),  "+m" (*ptr__),		\
+			: [old__] "=&d" (old__), [pair__] "=&d" (pair__),	\
+			  "+m" (*ptr__),					\
 			  "=m" (((struct lowcore *)0)->percpu_register)		\
-			: [val__] "d" (val__),					\
+			: [val__] "d" (val__), [ptr__] "d" (ptr__),		\
 			  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 			  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 			  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -190,18 +214,20 @@ do {										\
 #define arch_this_cpu_add_return(pcp, val, op)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__; 				\
+	union register_pair pair__;					\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		op "	%[old__],%[val__],0(%[ptr__])\n"		\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%M[pair__]")			\
+		op "	%[old__],%[val__],0(%M[pair__])\n"		\
 		__PCPU_END("%[lcreg]")					\
-		: [old__] "=&d" (old__),				\
-		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		: [old__] "=&d" (old__), [pair__] "=&d" (pair__),	\
+		  "+m" (*ptr__),					\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [val__] "d" (val__),					\
+		: [val__] "d" (val__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -215,18 +241,20 @@ do {										\
 #define arch_this_cpu_to_op(pcp, val, op)				\
 do {									\
 	typedef typeof(pcp) pcp_op_T__; 				\
+	union register_pair pair__;					\
 	pcp_op_T__ val__ = (val);					\
 	pcp_op_T__ old__, *ptr__;					\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		op "    %[old__],%[val__],0(%[ptr__])\n"		\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%M[pair__]")			\
+		op "    %[old__],%[val__],0(%M[pair__])\n"		\
 		__PCPU_END("%[lcreg]")					\
-		: [old__] "=&d" (old__),				\
-		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		: [old__] "=&d" (old__), [pair__] "=&d" (pair__),	\
+		  "+m" (*ptr__),					\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [val__] "d" (val__),					\
+		: [val__] "d" (val__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -238,22 +266,23 @@ do {									\
 #define this_cpu_or_4(pcp, val)		arch_this_cpu_to_op(pcp, val, "lao")
 #define this_cpu_or_8(pcp, val)		arch_this_cpu_to_op(pcp, val, "laog")
 
-#endif /* MARCH_HAS_Z196_FEATURES */
-
 #define arch_this_cpu_read(pcp, op)					\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
+	union register_pair pair__;					\
 	unsigned long res__;						\
 	pcp_op_T__ *ptr__;						\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		op "	%[res__],0(%[ptr__])\n"				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			      "%[pair__]","%M[pair__]")			\
+		op "	%[res__],0(%M[pair__])\n"			\
 		__PCPU_END("%[lcreg]")					\
-		: [res__] "=&d" (res__), [ptr__] "+&a" (ptr__),		\
+		: [res__] "=&d" (res__), [pair__] "=&d" (pair__),	\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [lcreg] "i" (LC_PERCPU_REGISTER),			\
+		: [ptr__] "d" (ptr__),					\
+		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (*ptr__),						\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -269,16 +298,18 @@ do {									\
 #define arch_this_cpu_write(pcp, val, op)				\
 do {									\
 	typedef typeof(pcp) pcp_op_T__;					\
+	union register_pair pair__;					\
 	pcp_op_T__ *ptr__, val__ = (val);				\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		op "    %[val__],0(%[ptr__])\n"				\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			      "%[pair__]","%M[pair__]")			\
+		op "    %[val__],0(%M[pair__])\n"			\
 		__PCPU_END("%[lcreg]")					\
-		: [ptr__] "+&a" (ptr__), "=m" (*ptr__),			\
+		: [pair__] "=&d" (pair__), "=m" (*ptr__),		\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [val__] "d" (val__),					\
+		: [val__] "d" (val__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -290,6 +321,8 @@ do {									\
 #define this_cpu_write_4(pcp, val) arch_this_cpu_write(pcp, val, "st")
 #define this_cpu_write_8(pcp, val) arch_this_cpu_write(pcp, val, "stg")
 
+#endif /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #define arch_this_cpu_cmpxchg_simple(pcp, oval, nval)			\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
@@ -302,21 +335,33 @@ do {									\
 	ret__;								\
 })
 
+#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+
+#if !defined(MARCH_HAS_Z196_FEATURES) || !defined(CONFIG_CC_HAS_ASM_M_FORMAT_FLAG)
+
+#define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+#define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
+
+#else /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #define arch_this_cpu_cmpxchg(pcp, oval, nval, op)			\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ old__ = (oval), new__ = (nval);			\
+	union register_pair pair__;					\
 	pcp_op_T__ *ptr__;						\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		op "	%[old__],%[new__],0(%[ptr__])\n"		\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%M[pair__]")			\
+		op "	%[old__],%[new__],0(%M[pair__])\n"		\
 		__PCPU_END("%[lcreg]")					\
-		: [old__] "+&d" (old__),				\
-		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		: [old__] "+&d" (old__), [pair__] "=&d" (pair__),	\
+		  "+m" (*ptr__),					\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [new__] "d" (new__),					\
+		: [new__] "d" (new__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -324,28 +369,45 @@ do {									\
 	old__;								\
 })
 
-#define this_cpu_cmpxchg_1(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
-#define this_cpu_cmpxchg_2(pcp, oval, nval) arch_this_cpu_cmpxchg_simple(pcp, oval, nval)
 #define this_cpu_cmpxchg_4(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval, "cs")
 #define this_cpu_cmpxchg_8(pcp, oval, nval) arch_this_cpu_cmpxchg(pcp, oval, nval, "csg")
 
+#endif /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #define this_cpu_cmpxchg64(pcp, o, n)	this_cpu_cmpxchg_8(pcp, o, n)
 
+#if !defined(MARCH_HAS_Z196_FEATURES) || !defined(CONFIG_CC_HAS_ASM_M_FORMAT_FLAG)
+
+#define this_cpu_cmpxchg128(pcp, oval, nval)				\
+({									\
+	u128 *ptr__, ret__;						\
+									\
+	preempt_disable_notrace();					\
+	ptr__ = raw_cpu_ptr(&(pcp));					\
+	ret__ = arch_cmpxchg128(ptr__, oval, nval);			\
+	preempt_enable_notrace();					\
+	ret__;								\
+})
+
+#else /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #define this_cpu_cmpxchg128(pcp, oval, nval)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
 	u128 old__ = (oval), new__ = (nval);				\
+	union register_pair pair__;					\
 	pcp_op_T__ *ptr__;						\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		"	cdsg	%[old__],%[new__],0(%[ptr__])\n"	\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%M[pair__]")			\
+		"	cdsg	%[old__],%[new__],0(%M[pair__])\n"	\
 		__PCPU_END("%[lcreg]")					\
-		: [old__] "+&d" (old__), [ptr__] "+&a" (ptr__),		\
+		: [old__] "+&d" (old__), [pair__] "=&d" (pair__),	\
 		  "+m" (*ptr__),					\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [new__] "d" (new__),					\
+		: [new__] "d" (new__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -353,6 +415,8 @@ do {									\
 	old__;								\
 })
 
+#endif /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #define arch_this_cpu_xchg_simple(pcp, nval)				\
 ({									\
 	typeof(pcp) *ptr__;						\
@@ -364,23 +428,35 @@ do {									\
 	ret__;								\
 })
 
-#define arch_this_cpu_xchg(pcp, nval, ldop, csop)			\
+#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+
+#if !defined(MARCH_HAS_Z196_FEATURES) || !defined(CONFIG_CC_HAS_ASM_M_FORMAT_FLAG)
+
+#define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+#define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
+
+#else /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
+#define arch_this_cpu_xchg(pcp, nval, lop, cop)				\
 ({									\
 	typedef typeof(pcp) pcp_op_T__;					\
 	pcp_op_T__ old__, new__ = (nval);				\
+	union register_pair pair__;					\
 	pcp_op_T__ *ptr__;						\
 									\
 	ptr__ = PERCPU_PTR(&(pcp));					\
 	asm_inline volatile(						\
-		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]")		\
-		"	" ldop "	%[old__],0(%[ptr__])\n"		\
-		"0:	" csop "	%[old__],%[new__],0(%[ptr__])\n"\
+		__PCPU_BEGIN("%[lcreg]","%[lcoff]","%[ptr__]",		\
+			     "%[pair__]","%M[pair__]")			\
+		"	" lop "	%[old__],0(%M[pair__])\n"		\
+		"0:	" cop "	%[old__],%[new__],0(%M[pair__])\n"	\
 		"	jnz	0b\n"					\
 		__PCPU_END("%[lcreg]")					\
-		: [old__] "=&d" (old__),				\
-		  [ptr__] "+&a" (ptr__), "+m" (*ptr__),			\
+		: [old__] "=&d" (old__), [pair__] "=&d" (pair__),	\
+		  "+m" (*ptr__),					\
 		  "=m" (((struct lowcore *)0)->percpu_register)		\
-		: [new__] "d" (new__),					\
+		: [new__] "d" (new__), [ptr__] "d" (ptr__),		\
 		  [lcreg] "i" (LC_PERCPU_REGISTER),			\
 		  [lcoff] "i" (LC_PERCPU_OFFSET),			\
 		  "m" (((struct lowcore *)0)->percpu_offset)		\
@@ -388,11 +464,11 @@ do {									\
 	old__;								\
 })
 
-#define this_cpu_xchg_1(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
-#define this_cpu_xchg_2(pcp, nval) arch_this_cpu_xchg_simple(pcp, nval)
 #define this_cpu_xchg_4(pcp, nval) arch_this_cpu_xchg(pcp, nval, "l",  "cs")
 #define this_cpu_xchg_8(pcp, nval) arch_this_cpu_xchg(pcp, nval, "lg", "csg")
 
+#endif /* MARCH_HAS_Z196_FEATURES || CONFIG_CC_HAS_ASM_M_FORMAT_FLAG */
+
 #include <asm-generic/percpu.h>
 
 #endif /* __ARCH_S390_PERCPU__ */
diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 6411e3584283..5102d851b84b 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -132,7 +132,7 @@ struct pt_regs {
 	};
 	unsigned long flags;
 	unsigned long last_break;
-	unsigned int cpu;
+	unsigned int cpu
 	unsigned char percpu_register;
 };
 
diff --git a/arch/s390/kernel/irq.c b/arch/s390/kernel/irq.c
index c923496aa7b4..8f21bea349a6 100644
--- a/arch/s390/kernel/irq.c
+++ b/arch/s390/kernel/irq.c
@@ -144,9 +144,9 @@ static int irq_pending(struct pt_regs *regs)
 
 void noinstr do_io_irq(struct pt_regs *regs)
 {
-	bool from_idle, percpu_needs_fixup;
 	struct pt_regs *old_regs;
 	irqentry_state_t state;
+	bool from_idle;
 
 	percpu_entry(regs);
 	state = irqentry_enter(regs);
@@ -174,21 +174,20 @@ void noinstr do_io_irq(struct pt_regs *regs)
 			do_irq_async(regs, IO_INTERRUPT);
 	} while (machine_is_lpar() && irq_pending(regs));
 
-	percpu_needs_fixup = percpu_code_check(regs);
 	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
 
 	if (from_idle)
 		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
-	percpu_exit(regs, percpu_needs_fixup);
+	percpu_exit(regs);
 }
 
 void noinstr do_ext_irq(struct pt_regs *regs)
 {
-	bool from_idle, percpu_needs_fixup;
 	struct pt_regs *old_regs;
 	irqentry_state_t state;
+	bool from_idle;
 
 	percpu_entry(regs);
 	state = irqentry_enter(regs);
@@ -214,14 +213,13 @@ void noinstr do_ext_irq(struct pt_regs *regs)
 
 	do_irq_async(regs, EXT_INTERRUPT);
 
-	percpu_needs_fixup = percpu_code_check(regs);
 	irq_exit_rcu();
 	set_irq_regs(old_regs);
 	irqentry_exit(regs, state);
 
 	if (from_idle)
 		regs->psw.mask &= ~(PSW_MASK_EXT | PSW_MASK_IO | PSW_MASK_WAIT);
-	percpu_exit(regs, percpu_needs_fixup);
+	percpu_exit(regs);
 }
 
 static void show_msi_interrupt(struct seq_file *p, int irq)
diff --git a/arch/s390/kernel/nmi.c b/arch/s390/kernel/nmi.c
index 17297a8b63d9..56a15edc65d7 100644
--- a/arch/s390/kernel/nmi.c
+++ b/arch/s390/kernel/nmi.c
@@ -361,7 +361,6 @@ NOKPROBE_SYMBOL(s390_backup_mcck_info);
  */
 void notrace s390_do_machine_check(struct pt_regs *regs)
 {
-	bool percpu_needs_fixup;
 	static int ipd_count;
 	static DEFINE_SPINLOCK(ipd_lock);
 	static unsigned long long last_ipd;
@@ -495,9 +494,8 @@ void notrace s390_do_machine_check(struct pt_regs *regs)
 	if (mcck_pending)
 		schedule_mcck_handler();
 
-	percpu_needs_fixup = percpu_code_check(regs);
 	irqentry_nmi_exit(regs, irq_state);
-	percpu_exit(regs, percpu_needs_fixup);
+	percpu_exit(regs);
 }
 NOKPROBE_SYMBOL(s390_do_machine_check);
 
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b6ba4465f59d..dd051046170b 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -338,7 +338,6 @@ static void (*pgm_check_table[128])(struct pt_regs *regs);
 void noinstr __do_pgm_check(struct pt_regs *regs, unsigned long flags)
 {
 	struct lowcore *lc = get_lowcore();
-	bool percpu_needs_fixup;
 	irqentry_state_t state;
 	struct pgm_stat *stat;
 	unsigned int trapnr;
@@ -400,9 +399,8 @@ void noinstr __do_pgm_check(struct pt_regs *regs, unsigned long flags)
 		pgm_check_table[trapnr](regs);
 out:
 	local_irq_disable();
-	percpu_needs_fixup = percpu_code_check(regs);
 	irqentry_exit(regs, state);
-	percpu_exit(regs, percpu_needs_fixup);
+	percpu_exit(regs);
 }
 
 static int pgm_check_stat_show(struct seq_file *p, void *v)
-- 
2.53.0

