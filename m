Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B5F163624C6;
	Tue, 27 Jan 2026 15:20:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1769527208; cv=none; b=n5jl0lEK0lG5GpBJGuD2FDwhfvtO6rPkdyBp12IQTWGDBvbxtKcSKskhqD8R1IG1Vf20VvbPGWXBDw8lfVMEZRWBomh7Ha0haB0D1IsC1zeW1oFTucFTfb+TDldvb7V5nRTGfU/n0Ofhm3k/bIaziu7CH5auOvwYnHXdZEOM1eM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1769527208; c=relaxed/simple;
	bh=b2bGG+y3Ob/xC2VR9bYaOdXuMWDMfK21pfp6Rp+pedo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Rfa6mGnYAo8fJQYmsljszyXGOsRidFwEGiuO29ZXdoMhRhrL8waaPz89wILkf162ZDZfu0cTX/3vO4euIx9n7ydstrnVMVYNc29JBNNXGO7xmm3xXa/pb3jUsgQTfV5c5Yy2gd78jn1wGNDJk0EL0y2A29nyba7vFE2vcvJehsk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=NiIS5Y++; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="NiIS5Y++"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 60R2WCfp017248;
	Tue, 27 Jan 2026 15:19:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=zuSMMM/EeZwSE8HD+
	lBguGbIw/zs0dqj2jDSiLuDvR4=; b=NiIS5Y++csbmXOX4FQ/doKDz62XYqQ63G
	7Sl9TD9/qJ6qnZ2hpUZ+p/mGzfF1cLfLXRv5h+Zm8pDEff5ljDCNhFH9KXuT8uoe
	9tks+QJrIbtHNayOmAmHVMS/dgDMB6dy/W1T5nprfN2kCYgh1aeCWvpxdskM5uHh
	m5o3Ju/uR9ZHOcVGTpcFnEMfqPPm9DQJmOb+WM6udONN00zDY6N0UsvBWApOEEoe
	ZwDus+lcr1oTthtHWXlkXtyhSwQQCXam1d6fljJ/r3Du5/8I/4T8vmGE3ZdMW3r7
	+BTTwWDj7Z6k0T48TfAwI66SYSvLd8vK4bK4C7e/d/PUcauQvGmnA==
Received: from pps.reinject (localhost [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvfg1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:40 +0000 (GMT)
Received: from m0353725.ppops.net (m0353725.ppops.net [127.0.0.1])
	by pps.reinject (8.18.1.12/8.18.0.8) with ESMTP id 60RFJ807020641;
	Tue, 27 Jan 2026 15:19:39 GMT
Received: from ppma23.wdc07v.mail.ibm.com (5d.69.3da9.ip4.static.sl-reverse.com [169.61.105.93])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4bvmgfvffw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:39 +0000 (GMT)
Received: from pps.filterd (ppma23.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma23.wdc07v.mail.ibm.com (8.18.1.2/8.18.1.2) with ESMTP id 60RE0G5Y026319;
	Tue, 27 Jan 2026 15:19:38 GMT
Received: from smtprelay05.fra02v.mail.ibm.com ([9.218.2.225])
	by ppma23.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4bw9wk930w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 27 Jan 2026 15:19:38 +0000
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay05.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 60RFJY6I38404444
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 27 Jan 2026 15:19:34 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 4659C20040;
	Tue, 27 Jan 2026 15:19:34 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id EDEA120043;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 27 Jan 2026 15:19:33 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, bpf@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrii Nakryiko <andrii@kernel.org>,
        Indu Bhagat <indu.bhagat@oracle.com>,
        "Jose E. Marchesi" <jemarch@gnu.org>,
        Beau Belgrave <beaub@linux.microsoft.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Florian Weimer <fweimer@redhat.com>, Kees Cook <kees@kernel.org>,
        "Carlos O'Donell" <codonell@redhat.com>, Sam James <sam@gentoo.org>,
        Dylan Hatch <dylanbhatch@google.com>
Subject: [PATCH v4 09/12] s390/unwind_user/sframe: Enable sframe unwinding on s390
Date: Tue, 27 Jan 2026 16:19:22 +0100
Message-ID: <20260127151926.2805123-10-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20260127151926.2805123-1-jremus@linux.ibm.com>
References: <20260127151926.2805123-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Z4vh3XRA c=1 sm=1 tr=0 ts=6978d78c cx=c_pps
 a=3Bg1Hr4SwmMryq2xdFQyZA==:117 a=3Bg1Hr4SwmMryq2xdFQyZA==:17
 a=vUbySO9Y5rIA:10 a=VkNPw1HP01LnGYTKEx00:22 a=NEAV23lmAAAA:8 a=VwQbUJbxAAAA:8
 a=VnNF1IyMAAAA:8 a=Qa0OrbKoCXZI6_Y7VosA:9
X-Proofpoint-GUID: 41ZkWyJy5DOTfrmp9yY_s4B5B_xKQOQ1
X-Proofpoint-ORIG-GUID: APBUffS2QqOJ6PbV8kDq_c2HRtCw-WG9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwMTI3MDEyNSBTYWx0ZWRfX+52L1jFVfm9w
 hvtBq1fPeEY10p0X6BFOxWr4/k0DK8dsZTRg1YdkgOFMHvfO7y+ZiRecv1k0uZbWG0QDoh5dc/8
 Zd0DxPaklcM7hLLwcixzBzpSPnZt0IvVD+zrfFcOniVzA66JIFn6/bRqsqTs/ximm/R7wpxdLgE
 4W41/0kBHhUIYgW8giTk1Fvw/pWNrN0Pjpj/W05kktZ2zFvluW1aZR2V0XZe6uIdyuGtYQie3Bv
 FNA7p78t1bTFMTduAt2tAVql5j7qyYz8rU5VEScByyMcPMF9KgOCmpI4GMI8N/Jl7ZLlyItS8vW
 U1h1NtquHSehq2I40Zfpb5Ii/2Ke2LGbWxT0dmH1Droct85WK1qB5b4GWnobMwicXhvbzBb5L0B
 l1Q5pUC/nRcPUrFphlq53ZAAoFP26fyFcbmbkl+cWAx/PlucEyEMbveXewc6eXX499UPLLuepC4
 2gI0NaxeruQvnyyNsgA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1121,Hydra:6.1.51,FMLib:17.12.100.49
 definitions=2026-01-27_03,2026-01-27_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 malwarescore=0 phishscore=0 priorityscore=1501 bulkscore=0
 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.19.0-2601150000 definitions=main-2601270125

Add s390 support for unwinding of user space using SFrame.  This
leverages the previous commits to address the following s390
particularities:

- The CFA is defined as the value of the stack pointer (SP) at call
  site in the previous frame plus 160.  Therefore the SP unwinds as
  SP = CFA - 160.  Therefore use a SP value offset from CFA of -160.

- The return address (RA) is not saved on the stack at function entry.
  It is also not saved in the function prologue, when in leaf functions.
  Therefore the RA does not necessarily need to be unwound in the
  topmost frame.

- The frame pointer (FP) and/or return address (RA) may be saved in
  other registers when in leaf functions.  GCC effectively uses
  floating-point registers (FPR) for this purpose.  In SFrame V3 this
  is represented using flexible FDEs, where the CFA, FP, and RA recovery
  rules may specify a DWARF register number.

- To make use of the signed 8-bit SFrame data word size and effectively
  reduce the .sframe section size the SFrame CFA offset values are
  encoded as (CFA - 160) / 8.  This is because the lowest CFA offset
  value on s390 is by definition +160 (= value at function entry),
  which does not fit into a signed 8-bit SFrame data word / offset.
  Therefore the CFA offset values are stored adjusted by -160.
  Additionally they are scaled by the s390-specific DWARF data scaling
  factor of 8.  The s390x ELF ABI [1] guarantees that the CFA offset
  values are always aligned on an 8-byte boundary.

Add s390-specific SFrame format definitions.
Include <asm/unwind_user_sframe.h> after "sframe.h" to make those
s390-specific definitions available to architecture-specific unwind
user sframe code, particularly the s390-specific one.

[1]: s390x ELF ABI, https://github.com/IBM/s390x-abi/releases

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---

Notes (jremus):
    Changes in v4:
    - Fix __s390_get_dwarf_fpr() access of user FPR. (Heiko)
    - Use __s390_dwarf_fpr_to_fpr() helper instead of large switch/case
      block. (Heiko)
    - Use unsigned int for DWARF register numbers, as DWARF defines them
      as unsigned LEB128.
    - SFrame V3 support:
      - Remove now unused arch_sframe_init_reginfo().
      - Remove now unused SFRAME_V2_S390X_OFFSET_IS_REGNUM() and
        SFRAME_V2_S390X_OFFSET_DECODE_REGNUM() macros.
      - Rename SFRAME_V2_*() macros to SFRAME_V3_*().
      - Add architecture-specific defines SFRAME_REG_SP and SFRAME_REG_FP.
    
    Changes in RFC v3:
    - Adjust to rename of UNWIND_USER_LOC_NONE to UNWIND_USER_LOC_RETAIN.
    - Adjust s390-specific unwind_user_word_size() to changes in the
      x86-specific (see patch 4).
    
    Changes in RFC v2:
    - Provide unwind_user_word_size() to satisfy new unwind user need.  Note
      that support for COMPAT has not been implemented as s390 support for
      COMPAT is expected to be removed with v6.19:
      https://lore.kernel.org/all/20251201102713.22472A5b-hca@linux.ibm.com/
    - Adjust to changes in preceding patches in this series that enable
      support in unwind user (sframe) for s390 particularities.
    
    Alternatively the s390-specific definitions could also be added to the
    s390-specific unwind user sframe header.  The current implementation
    follows Binutils approach to have all SFrame format definitions in one
    central header file.

 arch/s390/Kconfig                          |  1 +
 arch/s390/include/asm/unwind_user.h        | 70 ++++++++++++++++++++++
 arch/s390/include/asm/unwind_user_sframe.h | 21 +++++++
 kernel/unwind/sframe.c                     |  2 +-
 kernel/unwind/sframe.h                     | 11 ++++
 5 files changed, 104 insertions(+), 1 deletion(-)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_sframe.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 0e5fad5f06ca..063f0c857600 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -250,6 +250,7 @@ config S390
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR if CC_HAS_STACKPROTECTOR_GLOBAL
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_SFRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select HOTPLUG_SMT
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
new file mode 100644
index 000000000000..941aa3f0f70f
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user.h
@@ -0,0 +1,70 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_H
+#define _ASM_S390_UNWIND_USER_H
+
+#include <linux/sched/task_stack.h>
+#include <linux/types.h>
+#include <asm/fpu.h>
+
+#ifdef CONFIG_UNWIND_USER
+
+static inline int unwind_user_word_size(struct pt_regs *regs)
+{
+	return 8;
+}
+
+static inline int arch_unwind_user_get_ra_reg(unsigned long *val)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	*val = regs->gprs[14];
+	return 0;
+}
+#define unwind_user_get_ra_reg arch_unwind_user_get_ra_reg
+
+static inline unsigned long __s390_dwarf_fpr_to_fpr(unsigned int regnum)
+{
+	unsigned int fpr;
+
+	/*
+	 * Convert from s390 DWARF floating-point register number (16..31)
+	 * to floating-point register number (0..15): left rotate the least
+	 * significant three bits and then return the least significant four
+	 * bits.
+	 */
+	fpr  = (regnum & 3) << 1;
+	fpr |= (regnum & 4) >> 2;
+	fpr |= (regnum & 8);
+	return fpr;
+}
+
+static inline unsigned long __s390_get_dwarf_fpr(unsigned int regnum)
+{
+	struct fpu *fpu = &current->thread.ufpu;
+
+	save_user_fpu_regs();
+	return fpu->vxrs[__s390_dwarf_fpr_to_fpr(regnum)].high;
+}
+
+static inline int arch_unwind_user_get_reg(unsigned long *val,
+					   unsigned int regnum)
+{
+	if (regnum <= 15) {
+		/* DWARF register numbers 0..15 */
+		struct pt_regs *regs = task_pt_regs(current);
+		*val = regs->gprs[regnum];
+		return 0;
+	} else if (regnum <= 31) {
+		/* DWARF register numbers 16..31 */
+		*val = __s390_get_dwarf_fpr(regnum);
+		return 0;
+	}
+
+	return -EINVAL;
+}
+#define unwind_user_get_reg arch_unwind_user_get_reg
+
+#endif /* CONFIG_UNWIND_USER */
+
+#include <asm-generic/unwind_user.h>
+
+#endif /* _ASM_S390_UNWIND_USER_H */
diff --git a/arch/s390/include/asm/unwind_user_sframe.h b/arch/s390/include/asm/unwind_user_sframe.h
new file mode 100644
index 000000000000..91eea28c8a48
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_sframe.h
@@ -0,0 +1,21 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_SFRAME_H
+#define _ASM_S390_UNWIND_USER_SFRAME_H
+
+#include <linux/unwind_user.h>
+#include <linux/types.h>
+
+#define SFRAME_SP_OFFSET SFRAME_S390X_SP_VAL_OFFSET
+
+#define SFRAME_REG_SP	15
+#define SFRAME_REG_FP	11	/* "preferred" FP register */
+
+static inline s32 arch_sframe_cfa_offset_decode(s32 offset)
+{
+	return SFRAME_V3_S390X_CFA_OFFSET_DECODE(offset);
+}
+#define sframe_cfa_offset_decode arch_sframe_cfa_offset_decode
+
+#include <asm-generic/unwind_user_sframe.h>
+
+#endif /* _ASM_S390_UNWIND_USER_SFRAME_H */
diff --git a/kernel/unwind/sframe.c b/kernel/unwind/sframe.c
index 5ac502f16bad..21283e3bda42 100644
--- a/kernel/unwind/sframe.c
+++ b/kernel/unwind/sframe.c
@@ -12,11 +12,11 @@
 #include <linux/mm.h>
 #include <linux/string_helpers.h>
 #include <linux/sframe.h>
-#include <asm/unwind_user_sframe.h>
 #include <linux/unwind_user_types.h>
 
 #include "sframe.h"
 #include "sframe_debug.h"
+#include <asm/unwind_user_sframe.h>
 
 struct sframe_fde_internal {
 	unsigned long	func_addr;
diff --git a/kernel/unwind/sframe.h b/kernel/unwind/sframe.h
index 5b6112945b6c..8a5322e95403 100644
--- a/kernel/unwind/sframe.h
+++ b/kernel/unwind/sframe.h
@@ -19,6 +19,7 @@
 #define SFRAME_ABI_AARCH64_ENDIAN_BIG		1
 #define SFRAME_ABI_AARCH64_ENDIAN_LITTLE	2
 #define SFRAME_ABI_AMD64_ENDIAN_LITTLE		3
+#define SFRAME_ABI_S390X_ENDIAN_BIG		4	/* s390 64-bit (s390x) */
 
 struct sframe_preamble {
 	u16	magic;
@@ -84,4 +85,14 @@ struct sframe_fda_v3 {
 #define SFRAME_V3_FLEX_FDE_CTLWORD_DEREF_P(data)	(((data) >> 1) & 0x1)
 #define SFRAME_V3_FLEX_FDE_CTLWORD_REG_P(data)		((data) & 0x1)
 
+/* s390 64-bit (s390x) */
+
+#define SFRAME_S390X_SP_VAL_OFFSET			(-160)
+
+#define SFRAME_S390X_CFA_OFFSET_ADJUSTMENT		SFRAME_S390X_SP_VAL_OFFSET
+#define SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR	8
+#define SFRAME_V3_S390X_CFA_OFFSET_DECODE(offset) \
+	(((offset) * SFRAME_S390X_CFA_OFFSET_ALIGNMENT_FACTOR) \
+	- SFRAME_S390X_CFA_OFFSET_ADJUSTMENT)
+
 #endif /* _SFRAME_H */
-- 
2.51.0

