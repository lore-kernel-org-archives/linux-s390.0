Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2265E305E19
	for <linux-s390@vger.kernel.org>; Thu,  9 Jul 2026 19:55:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783626958; cv=none; b=hyxPkv6oqKGLdHX5DnYpXDEERoRea3IwuYZVbIFpZ+yezH9LWyPdTilT2xzjGHPVSSgHZC9ji7d6J0wnxYw3kzc+DD7tLH3vxfnYnfsaUhZpJ8cLJEdTQZejCNS6DrXXPrbMw5CeQGxuHBk93r9NKTGKNnbB3Y5Nn+UC+ANODHA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783626958; c=relaxed/simple;
	bh=uvO+w6zI4dMTRVcjKhYbO9GoxQbEH+19KJAzbAmtAIU=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tHVXf4FHQNTXDEUIQKV0KeW0cfO/AQiT8BGUx5TCDT7O/KB7ooeGjGGb0JvSMJuterNS+KeLJ3e/HmV2vKYlwENFbYK9hXIaAXzQMPxqk5kCO99l8SSNI1ZANaTFgKlmML37k9j9UUC69yw569PcQjTDQvZ3mGr+Aicf/V9ofLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=K6thY8m8; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="K6thY8m8"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 669HmUST3004790
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:56 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=68Qz8xuHwib47NHza
	Qe/9KmAWer7Wl9dpdp9qDzDCiw=; b=K6thY8m8o+QHo9uBA9yoqSPiDnlJ/0m2g
	AUcvpC1WtkNBXkGjbWCGD3Ugri4GuGEEYxsRYCOkG1a1VIysl1w4I2pcFya/t9Xv
	UBfx+ntLkgi88Qtb81sfbneokCJ4/5RLr5+z19fCUcwluMuzBUB4l9oU+ZKbmCZG
	xkSWtjECIqmA5BcYJXws65k+YbtVdnXry0zyyeXltspcy5S30uI42O+zRDx86UHD
	VZ7W7iuavrMIXqxYrDwZclCM7NYG+1f3zjEp3qH88Y9X68hBfSDs/CZxJG+W84ai
	7RRMskzBjdUj9w5ZI5Ygm6DT95BW4d4VSayjJvI5qtqT/7jklgQwA==
Received: from ppma22.wdc07v.mail.ibm.com (5c.69.3da9.ip4.static.sl-reverse.com [169.61.105.92])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4f6qkntvfd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:55 +0000 (GMT)
Received: from pps.filterd (ppma22.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma22.wdc07v.mail.ibm.com (8.18.1.7/8.18.1.7) with ESMTP id 669Jngnp013191
	for <linux-s390@vger.kernel.org>; Thu, 9 Jul 2026 19:55:55 GMT
Received: from smtprelay06.fra02v.mail.ibm.com ([9.218.2.230])
	by ppma22.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4f7cvwexh2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT)
	for <linux-s390@vger.kernel.org>; Thu, 09 Jul 2026 19:55:55 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (smtpav06.fra02v.mail.ibm.com [10.20.54.105])
	by smtprelay06.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 669JtpJj23724378
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 9 Jul 2026 19:55:51 GMT
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id E36942004E;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from smtpav06.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id C57622004B;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav06.fra02v.mail.ibm.com (Postfix) with SMTP;
	Thu,  9 Jul 2026 19:55:50 +0000 (GMT)
Received: by tuxmaker.boeblingen.de.ibm.com (Postfix, from userid 55390)
	id AF2551616D1; Thu, 09 Jul 2026 21:55:50 +0200 (CEST)
From: Sven Schnelle <svens@linux.ibm.com>
To: Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>, borntraeger@linux.ibm.com,
        linux-s390@vger.kernel.org
Subject: [PATCH 1/2] s390/traps: Remove PIF_GUEST_FAULT
Date: Thu,  9 Jul 2026 21:54:59 +0200
Message-ID: <20260709195500.1241833-2-svens@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260709195500.1241833-1-svens@linux.ibm.com>
References: <20260709195500.1241833-1-svens@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-TM-AS-GCONF: 00
X-Authority-Analysis: v=2.4 cv=Q/XiJY2a c=1 sm=1 tr=0 ts=6a4ffccb cx=c_pps
 a=5BHTudwdYE3Te8bg5FgnPg==:117 a=5BHTudwdYE3Te8bg5FgnPg==:17
 a=RAioF0-LDSMA:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=Li7buMWJcGrP5eQk9wcA:9
X-Proofpoint-GUID: Q5LBSqaHlcn0CGDza6nsP5dsx8dmXgc7
X-Proofpoint-ORIG-GUID: Q5LBSqaHlcn0CGDza6nsP5dsx8dmXgc7
X-Proofpoint-Spam-Info: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfX8aXj874BP0WF
 9eNvw7j+H2XKb80GsROgWnPKu2grvlJ2sipbYOM4TWf5DL76yOZksN0l6kum4I0bak8D3bCUzOt
 sS1C0iwd6cQJCaQ5irxh54qhYRhrZOM=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYwNzA5MDE5NyBTYWx0ZWRfXxArV2awHtBZk
 EozIGi4DrlQGg8AUEq4PWYcg2hf10AR9WQmOakimqD0sdp+WsoGSnAHQCd4f2sZVcbShA31OLpL
 NJPN30SauXC6/j0cvux+vC7YNHCWjz+ni153cqRrfGz4CooCFX3guYBwHsYN2wPcdPL3RdEP2XD
 OTDI4MYJJveLRZLqvdtg7w7HpkjM8idoUYfdZde6dCOryr8k0Xhh2jH/dPO7J9c6QDa3mM6VI4f
 EO5Z3cz8zHBsar4qWp0cBEfu3WNjNqww0qcjzMS2JLhdpGqhd4PfrmQtEHLa8tuiMCxztZEbbd8
 j23XpGWwbw7W3aFMfDBlpfebTnGX4nYEVFGNXwYEpJbL2qVgfRzjHljyvCEOHJAIq3uAIO5xcmb
 Jk5PjsBqujE4BNruTItnRQ+e8TFZFqyrDJq9YA4n7HB5s/eeIVUb/WBti6nDJacOaxMJJ25A7mR
 mIvRZKautx4mI1s0ipQ==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1143,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-07-09_04,2026-07-09_04,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 adultscore=0 impostorscore=0 spamscore=0 phishscore=0 priorityscore=1501
 bulkscore=0 clxscore=1015 lowpriorityscore=0 suspectscore=0 malwarescore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2606150000 definitions=main-2607090197

PIF_GUEST_FAULT is only used to pass information whether a fault was
caused when executing SIE or when executing host code. Instead of
using ptregs for this, just pass the flag directly as argument to
__do_pgm_check(). This also saves the time required to read the flag
from ptregs, although this likely isn't much as it is already in the
data cache.

Signed-off-by: Sven Schnelle <svens@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h | 4 +---
 arch/s390/kernel/entry.S       | 7 ++++---
 arch/s390/kernel/entry.h       | 7 ++++++-
 arch/s390/kernel/traps.c       | 4 ++--
 4 files changed, 13 insertions(+), 9 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrac=
e.h
index 495e310c3d6d..6411e3584283 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -16,13 +16,11 @@
 #define PIF_SYSCALL			0	/* inside a system call */
 #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
 #define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
-#define PIF_GUEST_FAULT			3	/* indicates program check in sie64a */
-#define PIF_FTRACE_FULL_REGS		4	/* all register contents valid (ftrace) =
*/
+#define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) =
*/
=20
 #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
 #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
 #define _PIF_SYSCALL_RET_SET		BIT(PIF_SYSCALL_RET_SET)
-#define _PIF_GUEST_FAULT		BIT(PIF_GUEST_FAULT)
 #define _PIF_FTRACE_FULL_REGS		BIT(PIF_FTRACE_FULL_REGS)
=20
 #define PSW32_MASK_PER		_AC(0x40000000, UL)
diff --git a/arch/s390/kernel/entry.S b/arch/s390/kernel/entry.S
index 79a45efae23d..d70eef7a0b29 100644
--- a/arch/s390/kernel/entry.S
+++ b/arch/s390/kernel/entry.S
@@ -31,6 +31,7 @@
 #include <asm/nospec-insn.h>
 #include <asm/lowcore.h>
 #include <asm/machine.h>
+#include "entry.h"
=20
 _LPP_OFFSET	=3D __LC_LPP
=20
@@ -321,7 +322,7 @@ SYM_CODE_START(pgm_check_handler)
 	jz	1f
 	BPENTER	__SF_SIE_FLAGS(%r15),_TIF_ISOLATE_BP_GUEST
 	SIEEXIT __SF_SIE_CONTROL(%r15),%r13
-	lghi	%r10,_PIF_GUEST_FAULT
+	lghi	%r10,PGM_FLAG_GUEST_FAULT
 #endif
 1:	tmhh	%r8,0x4000		# PER bit set in old PSW ?
 	jnz	2f			# -> enabled, can't be a double fault
@@ -332,7 +333,7 @@ SYM_CODE_START(pgm_check_handler)
 	CHECK_VMAP_STACK __LC_SAVE_AREA,%r13,4f
 3:	lg	%r15,__LC_KERNEL_STACK(%r13)
 4:	la	%r11,STACK_FRAME_OVERHEAD(%r15)
-	stg	%r10,__PT_FLAGS(%r11)
+	xc	__PT_FLAGS(8,%r11),__PT_FLAGS(%r11)
 	xc	__SF_BACKCHAIN(8,%r15),__SF_BACKCHAIN(%r15)
 	stmg	%r0,%r7,__PT_R0(%r11)
 	mvc	__PT_R8(64,%r11),__LC_SAVE_AREA(%r13)
@@ -341,13 +342,13 @@ SYM_CODE_START(pgm_check_handler)
 	# clear user controlled registers to prevent speculative use
 	xgr	%r0,%r0
 	xgr	%r1,%r1
-	xgr	%r3,%r3
 	xgr	%r4,%r4
 	xgr	%r5,%r5
 	xgr	%r6,%r6
 	xgr	%r7,%r7
 	xgr	%r12,%r12
 	lgr	%r2,%r11
+	lgr	%r3,%r10
 	brasl	%r14,__do_pgm_check
 	tmhh	%r8,0x0001		# returning to user space?
 	jno	.Lpgm_exit_kernel
diff --git a/arch/s390/kernel/entry.h b/arch/s390/kernel/entry.h
index fb67b4abe68c..d18a9a63f6b8 100644
--- a/arch/s390/kernel/entry.h
+++ b/arch/s390/kernel/entry.h
@@ -2,6 +2,10 @@
 #ifndef _ENTRY_H
 #define _ENTRY_H
=20
+#define PGM_FLAG_GUEST_FAULT	1
+
+#ifndef __ASSEMBLER__
+
 #include <linux/percpu.h>
 #include <linux/types.h>
 #include <linux/signal.h>
@@ -21,7 +25,7 @@ void early_pgm_check_handler(void);
=20
 struct task_struct *__switch_to_asm(struct task_struct *prev, struct tas=
k_struct *next);
 void __ret_from_fork(struct task_struct *prev, struct pt_regs *regs);
-void __do_pgm_check(struct pt_regs *regs);
+void __do_pgm_check(struct pt_regs *regs, unsigned long flags);
 void __do_syscall(struct pt_regs *regs, int per_trap);
 void __do_early_pgm_check(struct pt_regs *regs);
=20
@@ -70,4 +74,5 @@ extern struct exception_table_entry _stop_amode31_ex_ta=
ble[];
 #define __amode31_ref __section(".amode31.refs")
 extern long _start_amode31_refs[], _end_amode31_refs[];
=20
+#endif /* __ASSEMBLER__ */
 #endif /* _ENTRY_H */
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 564403496a7c..a5c259dd4295 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -327,7 +327,7 @@ void __init trap_init(void)
=20
 static void (*pgm_check_table[128])(struct pt_regs *regs);
=20
-void noinstr __do_pgm_check(struct pt_regs *regs)
+void noinstr __do_pgm_check(struct pt_regs *regs, unsigned long flags)
 {
 	struct lowcore *lc =3D get_lowcore();
 	bool percpu_needs_fixup;
@@ -346,7 +346,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs)
 	 * the fault number in current->thread.gmap_int_code. KVM will be
 	 * able to use this information to handle the fault.
 	 */
-	if (test_pt_regs_flag(regs, PIF_GUEST_FAULT)) {
+	if (flags & PGM_FLAG_GUEST_FAULT) {
 		current->thread.gmap_teid.val =3D regs->int_parm_long;
 		current->thread.gmap_int_code =3D regs->int_code & 0xffff;
 		return;
--=20
2.53.0

