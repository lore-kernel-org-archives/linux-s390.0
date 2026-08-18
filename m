Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23FC83AAF43;
	Tue, 18 Aug 2026 14:50:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787064630; cv=none; b=UKaRoyjGNrFEmxSjR0utuMK9Y7GrHVLHwyYWju/6wGALBDVEcEgiPovElZFH/hFxgwxfzVgrcl7xEzNzNBunc6g496xf0/QvxPczWSmd+38Y4+uAXlFJkE5FJ6zEazv2oG4lhlTvj+NesEFOl2/BsRi/tNSGVUqRSaiOJx4+UeU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787064630; c=relaxed/simple;
	bh=ZWia27gK5Uu/rA6TzDzSSPKWN0bclHUCBb817crgoGA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=KgpH7Nzusv0c6Ax5068YDDWQx1IrjEUpC7tSG5rUkk+Vl333lJHnzsrnsto8B0F8jYuriHmFktrRW2VZEKpxd4EL8aUT8/FRPFQ0S1E+ulGcM1wzbOH21TjGNcYE/oZdF0WGl/FtCX3p75wD9Lf8H7Vqwp1qwy4Q4VcQ11pTUSs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=fLzk5d3h; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="fLzk5d3h"
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 67IE3arh542405;
	Tue, 18 Aug 2026 14:50:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=UBQVMEerwR6B6Lb2m
	WCr+ZIf4sr/j5+4uJyDzFTYLIY=; b=fLzk5d3h9isQomVDAC7VTCrCX0SUbjrST
	DAkN/rqW45iSzWHEOpHhEZ/5qjA3VE+xcPDdI1+32nSglA3zpCDpTbiVs09jcMHU
	d/0yxysOcmsi0Xd0APmWqa4Z4hvFol7+l5/3FTKyXjUCayYsFzJMZHxTFJwZd4qI
	euztiMIpoa2t3GsyUEX+0a6c0h5bPmbhjK8WS+kpPXzbuKNt3QuUhlT0Xprp60TZ
	ug9N3QMHP+DDmwR3vcI1lTd65is3KPFmsaNi7OFzQOYjwb0xWpO0X1QDi0V9pZHx
	Vs7+fuU2HvscltWk09qRmqgjtQx3aspkKn9rp6lkam3PaoBO8+siA==
Received: from ppma12.dal12v.mail.ibm.com (dc.9e.1632.ip4.static.sl-reverse.com [50.22.158.220])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4g2frt8btk-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:09 +0000 (GMT)
Received: from pps.filterd (ppma12.dal12v.mail.ibm.com [127.0.0.1])
	by ppma12.dal12v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 67IEfKdr005462;
	Tue, 18 Aug 2026 14:50:08 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma12.dal12v.mail.ibm.com (PPS) with ESMTPS id 4g32eq3w4f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 18 Aug 2026 14:50:08 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 67IEo5nI45154698
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 18 Aug 2026 14:50:05 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1574520043;
	Tue, 18 Aug 2026 14:50:05 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C25E62004B;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 18 Aug 2026 14:50:04 +0000 (GMT)
From: Jens Remus <jremus@linux.ibm.com>
To: linux-kernel@vger.kernel.org, linux-trace-kernel@vger.kernel.org,
        linux-s390@vger.kernel.org, x86@kernel.org,
        Steven Rostedt <rostedt@kernel.org>,
        Josh Poimboeuf <jpoimboe@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: Jens Remus <jremus@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Indu Bhagat <ibhagatgnu@gmail.com>, Thomas Gleixner <tglx@kernel.org>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "H. Peter Anvin" <hpa@zytor.com>, Namhyung Kim <namhyung@kernel.org>,
        Andrii Nakryiko <andrii@kernel.org>, Kees Cook <kees@kernel.org>,
        Sam James <sam@gentoo.org>
Subject: [RFC PATCH v1 24/25] unwind_user/eh_frame/s390: Enable eh_frame unwinding on s390
Date: Tue, 18 Aug 2026 16:49:53 +0200
Message-ID: <20260818144954.2320378-25-jremus@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260818144954.2320378-1-jremus@linux.ibm.com>
References: <20260818144954.2320378-1-jremus@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Reinject: loops=2 maxloops=12
X-Authority-Analysis: v=2.4 cv=OfaoyBTY c=1 sm=1 tr=0 ts=6a847122 cx=c_pps
 a=bLidbwmWQ0KltjZqbj+ezA==:117 a=bLidbwmWQ0KltjZqbj+ezA==:17
 a=Sv0fKeRqtYgA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=FmDO2REWYRq66Aip4RwA:9
X-Proofpoint-Spam-Info: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfX5wVjcZ0xyjdM
 Lzy7ax1kAVWP3PXDqlOSto11EEVdaGp2Li6i5BBDDZKKDxWjsGtJSKjMxmWhd1N5cvJMxxajgRo
 6ntVi8LspUC021Vw3bwtSNX9zL/21Pk=
X-Proofpoint-GUID: IgMRSTd4jJA23VIoVhSwaq_Zm3bcp6WG
X-Proofpoint-ORIG-GUID: a7c6cSCLn8_yDAVAlxdP3rutPXgUXNHD
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwODE4MDEwNyBTYWx0ZWRfXzMyUJrO2E1W+
 UYWKkXpaX66boNbxMAkgjmYKyZu4yA+ZPrr7nDT29A18CdgOOAmXC6bIUP/TUv6VFADZn4sqyZu
 G2s9ZVgNYqhC3Qm7oy85PvAXCDvXT8M21X6HRhivzmScoxoK/Wb6xci+CufWtuiBBJ0q6qDu4fy
 LZqgzxh2936fz1aP2aSOLcjSSkhrrjPjg5NDX7AxYBigETiWhhhACFpqiUqKcjSu2VqUJvQq+Sw
 9EVFp9mjT9v5rnaQAeNyG7e3lPx+SXBn1Vvmd1vw+bcKnqsTu9graPpQCplgGaTdW2L7KJ0TQof
 Q7BhVzRroYVamuxv05qGy4gbRqSo+GBvMVXZPdZSa0NuQaqd3E1tXDlucXdwE92FtKEVIc3VTft
 7D3eCFUR2xvzABqcpArrqhrIzSeiY2/GoHXVLye1uf0/HyxrX2qeB9BeUaKD42D4ePmvEP0MO4I
 TBappzOV5viuwLnsYqQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-08-18_02,2026-08-18_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 adultscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 malwarescore=0 bulkscore=0 phishscore=0 priorityscore=1501 spamscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2608180107

The unwind user eh_frame implementation works well with GCC and Clang
generated code on s390.  Enable it.

Signed-off-by: Jens Remus <jremus@linux.ibm.com>
---
 arch/s390/Kconfig                            |  1 +
 arch/s390/include/asm/unwind_user.h          | 71 ++++++++++++++++++++
 arch/s390/include/asm/unwind_user_eh_frame.h | 24 +++++++
 3 files changed, 96 insertions(+)
 create mode 100644 arch/s390/include/asm/unwind_user.h
 create mode 100644 arch/s390/include/asm/unwind_user_eh_frame.h

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 84404e6778d5..fa229ac92d5a 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -251,6 +251,7 @@ config S390
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR if CC_HAS_STACKPROTECTOR_GLOBAL
 	select HAVE_SYSCALL_TRACEPOINTS
+	select HAVE_UNWIND_USER_EH_FRAME
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
 	select HOTPLUG_SMT
diff --git a/arch/s390/include/asm/unwind_user.h b/arch/s390/include/asm/unwind_user.h
new file mode 100644
index 000000000000..41ff0b477626
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user.h
@@ -0,0 +1,71 @@
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
+static inline int unwind_user_get_ra_reg(unsigned long *val)
+{
+	struct pt_regs *regs = task_pt_regs(current);
+	*val = regs->gprs[14];
+	return 0;
+}
+#define unwind_user_get_ra_reg unwind_user_get_ra_reg
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
+static inline int unwind_user_get_reg(unsigned long *val, unsigned int regnum)
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
+	pr_debug("%s (%d): %s(%u): unsupported register number\n",
+		 current->comm, current->pid, __func__, regnum);
+	return -EINVAL;
+}
+#define unwind_user_get_reg unwind_user_get_reg
+
+#endif /* CONFIG_UNWIND_USER */
+
+#include <asm-generic/unwind_user.h>
+
+#endif /* _ASM_S390_UNWIND_USER_H */
diff --git a/arch/s390/include/asm/unwind_user_eh_frame.h b/arch/s390/include/asm/unwind_user_eh_frame.h
new file mode 100644
index 000000000000..842d9f7c3d80
--- /dev/null
+++ b/arch/s390/include/asm/unwind_user_eh_frame.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_UNWIND_USER_EH_FRAME_H
+#define _ASM_S390_UNWIND_USER_EH_FRAME_H
+
+#define EH_FRAME_REG_SP	15	/* designated stack pointer register */
+#define EH_FRAME_REG_FP	11	/* "preferred" frame pointer register */
+#define EH_FRAME_REG_RA	14	/* designaged return address register */
+
+/* Instructions must be 2-byte aligned */
+#define EH_FRAME_MAX_CODE_ALIGN 2
+
+/* CFA is defined as SP at call site + 160, so that SP = CFA - 160 */
+#define EH_FRAME_SP_VAL_OFFSET -160
+
+/* SP may be saved on the stack or in a register */
+static inline bool eh_frame_reject_sp_rule(void)
+{
+	return false;
+}
+#define eh_frame_reject_sp_rule eh_frame_reject_sp_rule
+
+#include <asm-generic/unwind_user_eh_frame.h>
+
+#endif /* _ASM_S390_UNWIND_USER_EH_FRAME_H */
-- 
2.53.0

