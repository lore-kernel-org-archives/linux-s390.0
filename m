Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.158.5
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793010602;
	b=HLXOqCfm83d6qgQfjg4z9ekNXk0xxfyL8ifXsOrTqh+BwqqXVTog3IjyuDQEcHIoO8g+
	 /FAc1/YbmCxm+ZpUj/Gi52uVaotR5KcQ8dBKOe8i1omMziTvq49Y4dq0GokI6KEdwABoE
	 J5CBABKH59rFxG8eA71UzC3OHG+MXUoAZvmg/kGaDZ94FfkXRmc3buiOUIXRR/bNLJxF1
	 EKNjc+JqMX9b8HzZ+sAnsBJsIBwAzxaiIFBIS4UuF/Q6KI0RdHcpbKBzjSGCcKFc4A8gU
	 t826PMF6FF555L06kB3QwBKL86cBK41Qz564/3eWVVin8VbaZC6pyHljOsJQ75k3gFQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793010602;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Authority-Analysis:X-Proofpoint-GUID:
	 X-Proofpoint-Spam-Info:X-Proofpoint-ORIG-GUID:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=6JXbCFCwjc9xBgnowhhTThLNsI/J24nPWtlQJ3rLlUs=;
	b=cfh5qjRYoKqium3DDzxgMTwzNSSzBluc8QDB3dF6QBa1gIkDPOGaEEeMQbi6icYp0UcR
	 pUlIpMezsSZLQ/G20LbcOnuiLjnjAC0oyLp2uBw9/iet9Dp55/zwyuZeg1dKKhADbOGCC
	 aNpFakimYL+QKTh9PHtPQqHC/LX9zn/0neXjhrBXNFu30Wnei0LXNXMwdpOntn7DwEXUp
	 333Os06GDa0CDnRsP/Mptoo18as0idiU8N1cKggfiQM1/q2Ldt+UmaGkmOsqlr/0Ta+uc
	 fFyv43FUSmrIKJlmriVGQMOgI2padmFa5w4tQPup5VUZFegyeN7wfJlfmRxgEMwjXGg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M8zUoGd3;
	arc=none smtp.remote-ip=148.163.158.5
Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2F3C606A31E;
	Mon, 26 Oct 2026 10:30:01 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org E2F3C606A31E
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=M8zUoGd3
Received: from pps.filterd (m0360072.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q2i5FT1978797;
	Mon, 26 Oct 2026 10:30:01 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=6JXbCFCwjc9xBgnowhhTThLNsI/J24nPWtlQJ3rLl
	Us=; b=M8zUoGd3Di76BhTOIZ60+RZMLOhLMlWNLHNEbWFYmCm7CKxelh2i2yMm1
	cSfYc5kUCut7XdYims69ngsfA34Mx0b9/VdvrWbxSMGnzSSOpgHUs8wJ43ZzcP99
	/3YLF50X3jBtOA0EQoHDDiUdfJ9J5PvC0tG2TM5v/Ts4HvjrZTBz3CHnkHUxbif6
	7YsjzULw28wOw5mpeebShX8STzbfaswP3DCTDl+QseE3DQssDkUyL5xXS82m05gS
	d116uLkfBfKAMibQsCa3JobcOzoyyRABFnzkT7PoCpgrVRhSjJjXB+wHyfVWtUQj
	VsD3124g08geSQYcI7JmmqPzC+OMw==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hgmav8x6j-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:30:00 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69Q7F6TL1822045;
	Mon, 26 Oct 2026 10:30:00 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4hh80jdb7f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 26 Oct 2026 10:30:00 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (smtpav07.fra02v.mail.ibm.com [10.20.54.106])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69QATqGX40174074
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Mon, 26 Oct 2026 10:29:52 GMT
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 3EB172004B;
	Mon, 26 Oct 2026 10:29:52 +0000 (GMT)
Received: from smtpav07.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2333620043;
	Mon, 26 Oct 2026 10:29:52 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav07.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Mon, 26 Oct 2026 10:29:52 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390: Use static call trampolines when kCFI is enabled
Date: Mon, 26 Oct 2026 11:29:51 +0100
Message-ID: <20261026102952.4153711-1-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=P8SvFSAu c=1 sm=1 tr=0 ts=6adf2ba8 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=RzCfie-kr_QcCd8fBx8p:22 a=VnNF1IyMAAAA:8 a=Paj0-Z-736eVyoMAdw0A:9
X-Proofpoint-GUID: 8VvyADv0BpM_H3fYzMtTedcr-mFhQLUg
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfXznL9VCYM5NW5
 nx0FGm3pEkdKj7JNAeYPIE5cA6whRwc9EC8tY2Q0+CmD05DWS0ItAP/+pbIoyQdq5qBK5DmkUdd
 9WdzDcZy75zuxirq8qGtRni5L/Rx9mM=
X-Proofpoint-ORIG-GUID: 8VvyADv0BpM_H3fYzMtTedcr-mFhQLUg
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDI2MDA0MCBTYWx0ZWRfX6Unq1l4VT5Pq
 MAnfdIHSefUqO+vK8xniLSCLoJZUs5a3sWWcHZFxo/0a0lsWZF3O9mYnJmeojWHNHTbw2n2O2E5
 bmhYwXKm/YcWrtMDesqXF9IxV8V2/f2gSF8tuGg7D1jvhvN0XivVjHveQaFFA6whnGhJlIMxEc8
 Sfp8zrEeSiAYguhDKBDY+yDpXkkDz3WV5bghh1wqb0FMUssSXOBYrk4CMU23qALR4bEN2Gi/Z3y
 pR7Qi/4O69PKK+TjXD8oT2PVoRBPjwM616XWlUX81tPkFNoykZvXEf/BG9Vd4fCUXdNVTHbZkmH
 4xxylqZE92nPDMDy7EEpP2l8S9rw0q10zLtAIpRHdQzfk0kg7BOotwDAPfg6u1sSf+9xV7tkIHk
 +tZNmw0YxsRbhe7XT57jsPxQUg/g0ArnDe9a0UID91aQH6ZYv0nI/+kAJrz+NMdSNv9nIYZPI21
 DnvRoFZhQtBjebxUoVA==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.138,FMLib:17.12.100.49
 definitions=2026-10-26_01,2026-10-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 impostorscore=0 adultscore=0 malwarescore=0 phishscore=0 spamscore=0
 clxscore=1015 bulkscore=0 suspectscore=0 priorityscore=1501
 lowpriorityscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610260040

Add support for the 'unoptimized' static call variety, which routes all
calls through a trampoline that performs a tail call to the chosen
function. Wire it up for use when kCFI is enabled to work around an
issue where the prototypes of default handlers such as
__static_call_nop() and __static_call_ret0() don't match the expected
prototype of the call site, resulting in kCFI false positives.

This is the s390 version of commit 54ac9ff8f119 ("arm64: Use static
call trampolines when kCFI is enabled").

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/Kconfig                   |  1 +
 arch/s390/include/asm/static_call.h | 39 +++++++++++++++++++++++++++++
 arch/s390/kernel/Makefile           |  1 +
 arch/s390/kernel/static_call.c      | 20 +++++++++++++++
 arch/s390/kernel/vmlinux.lds.S      |  1 +
 5 files changed, 62 insertions(+)
 create mode 100644 arch/s390/include/asm/static_call.h
 create mode 100644 arch/s390/kernel/static_call.c

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 10ada552d870..5d096a5eb48c 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -257,6 +257,7 @@ config S390
 	select HAVE_SETUP_PER_CPU_AREA
 	select HAVE_SOFTIRQ_ON_OWN_STACK
 	select HAVE_STACKPROTECTOR if CC_HAS_STACKPROTECTOR_GLOBAL
+	select HAVE_STATIC_CALL if CFI
 	select HAVE_SYSCALL_TRACEPOINTS
 	select HAVE_VIRT_CPU_ACCOUNTING
 	select HAVE_VIRT_CPU_ACCOUNTING_IDLE
diff --git a/arch/s390/include/asm/static_call.h b/arch/s390/include/asm/static_call.h
new file mode 100644
index 000000000000..6e196cd18240
--- /dev/null
+++ b/arch/s390/include/asm/static_call.h
@@ -0,0 +1,39 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _ASM_S390_STATIC_CALL_H
+#define _ASM_S390_STATIC_CALL_H
+
+#ifdef CC_USING_EXPOLINE
+#define __STATIC_CALL_BR_EX_R1						\
+	"557:	jg	__s390_indirect_jump_r1\n"			\
+	"	.pushsection .s390_indirect_branches,\"a\",@progbits\n"	\
+	"	.long	557b-.\n"					\
+	"	.popsection\n"
+#else
+#define __STATIC_CALL_BR_EX_R1	"	br	%r1\n"
+#endif
+
+#define __ARCH_DEFINE_STATIC_CALL_TRAMP(name, target)			\
+	asm("	.pushsection .static_call.text, \"ax\"\n"		\
+	    "	.balign	4\n"						\
+	    "	.globl	" name "\n"					\
+	    name ":\n"							\
+	    "	lgrl	%r1,1f\n"					\
+	    __STATIC_CALL_BR_EX_R1					\
+	    "	.type	" name ", @function\n"				\
+	    "	.size	" name ", . - " name "\n"			\
+	    "	.popsection\n"						\
+	    "	.pushsection .rodata, \"a\"\n"				\
+	    "	.balign	8\n"						\
+	    "1:	.quad	" target "\n"					\
+	    "	.popsection\n")
+
+#define ARCH_DEFINE_STATIC_CALL_TRAMP(name, func)			\
+	__ARCH_DEFINE_STATIC_CALL_TRAMP(STATIC_CALL_TRAMP_STR(name), #func)
+
+#define ARCH_DEFINE_STATIC_CALL_NULL_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
+
+#define ARCH_DEFINE_STATIC_CALL_RET0_TRAMP(name)			\
+	ARCH_DEFINE_STATIC_CALL_TRAMP(name, __static_call_return0)
+
+#endif /* _ASM_S390_STATIC_CALL_H */
diff --git a/arch/s390/kernel/Makefile b/arch/s390/kernel/Makefile
index f84b8fb41331..a8800319033d 100644
--- a/arch/s390/kernel/Makefile
+++ b/arch/s390/kernel/Makefile
@@ -70,6 +70,7 @@ obj-$(CONFIG_KEXEC_CORE)	+= machine_kexec.o relocate_kernel.o
 obj-$(CONFIG_VMCORE_INFO)	+= vmcore_info.o
 obj-$(CONFIG_UPROBES)		+= uprobes.o
 obj-$(CONFIG_JUMP_LABEL)	+= jump_label.o
+obj-$(CONFIG_HAVE_STATIC_CALL)	+= static_call.o
 obj-$(CONFIG_STACKPROTECTOR)	+= stackprotector.o
 obj-$(CONFIG_KEXEC_FILE)	+= machine_kexec_file.o kexec_image.o
 obj-$(CONFIG_KEXEC_FILE)	+= kexec_elf.o
diff --git a/arch/s390/kernel/static_call.c b/arch/s390/kernel/static_call.c
new file mode 100644
index 000000000000..e8e20e4f782f
--- /dev/null
+++ b/arch/s390/kernel/static_call.c
@@ -0,0 +1,20 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/static_call.h>
+#include <asm/uaccess.h>
+
+struct insn_ril {
+	u16	opc;
+	s32	ri2;
+} __packed;
+
+void arch_static_call_transform(void *site, void *tramp, void *func, bool tail)
+{
+	struct insn_ril *insn = tramp;
+	void *literal;
+
+	literal = tramp + insn->ri2 * 2;
+	if (!func)
+		func = __static_call_return0;
+	s390_kernel_write(literal, &func, sizeof(func));
+}
+EXPORT_SYMBOL_GPL(arch_static_call_transform);
diff --git a/arch/s390/kernel/vmlinux.lds.S b/arch/s390/kernel/vmlinux.lds.S
index 1f0e71c58eb9..b9d58441f669 100644
--- a/arch/s390/kernel/vmlinux.lds.S
+++ b/arch/s390/kernel/vmlinux.lds.S
@@ -48,6 +48,7 @@ SECTIONS
 		SCHED_TEXT
 		LOCK_TEXT
 		KPROBES_TEXT
+		STATIC_CALL_TEXT
 		IRQENTRY_TEXT
 		SOFTIRQENTRY_TEXT
 		FTRACE_HOTPATCH_TRAMPOLINES_TEXT
-- 
2.53.0

