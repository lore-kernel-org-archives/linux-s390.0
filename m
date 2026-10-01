Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CDE93F329E;
	Thu,  1 Oct 2026 10:32:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.156.1
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850784; cv=none; b=XUtyEHfRYuI9TIQMd9eqH32lSgJSJn+ZUrVJN5kNdMgKBf1sFxEzyW6Zw2LRDBXHNSDkXGuXiivUNL1w/Pcad3ZWpUiU1KO7OZwD844d2QpMRvKw/INqBASg/PPUyLg4MQ4jCD/idJPsqLBLcCuEHGK507GZ00Qel4VB1HiO2aA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850784; c=relaxed/simple;
	bh=qYg6MSAiCsXdWovz2sftUi6pyFxbLGt6LMDJY/Kjvog=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=QNrmT11lxYdX4alOT46OI/zQCK4FZgeN90e68lHgk5/Xigm6qQm2jXGPKUXylSziI/YlRMTujO5S6/v1/8WaLQ+SSTizn8Di+ob05DBoHYkOJlMAoTKuYUwtU8sNzJyu38SudzgITcmlI5rSIzDGqelYuSOltq9+XT0TXeyay4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=A9AKD9ys; arc=none smtp.client-ip=148.163.156.1
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="A9AKD9ys"
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175kaY1119503;
	Thu, 1 Oct 2026 10:32:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=bL6Grtl/s/xeUkD02
	jwJdd/ncsHtH0QxfU+GrMriR7A=; b=A9AKD9ysflk1Vd+u7XECGmrJKFYmHRGUX
	Upb0HLpXyfAje2k6RVMcPRrl3qldKQvdr4Ql5TCTHPoxt6lKmpRWsLTorU+1a/LA
	LWQkQ9b4RT7yimxIdFgNQJxfiSw7F1JSV3xoUbPQAw9aWex9yGQ8GydLeya/j1Lw
	t4MMsNmJRen4Cf7MYqps1Q/yaoKX1/iTWzRyJYULuyKSSXL57KM3mxtfy/xRXOo3
	17lOPkDLSBfmOUpiQJ2aPqBzUKcjYOkNbcmI1l0VM520uZxzXB51cNIba/cfcCrF
	E/nfuE4uTNAomowyv020nnRfHFC/F7RIKiXMeAR1/niqs4Je+bGYg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx5j5jrap-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172tm53460494;
	Thu, 1 Oct 2026 10:32:54 GMT
Received: from smtprelay01.fra02v.mail.ibm.com ([9.218.2.227])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0q4pexay-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:54 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay01.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWoZb39125396
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:50 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 7131020043;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2AD512004D;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:50 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Niklas Schnelle <schnelle@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Holger Dengler <dengler@linux.ibm.com>,
        Stefan Haberland <sth@linux.ibm.com>,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        Ilya Leoshkevich <iii@linux.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        Claudio Imbrenda <imbrenda@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH 08/32] s390/dis: Improve show_code() output
Date: Thu,  1 Oct 2026 12:32:23 +0200
Message-ID: <20261001103247.1989111-9-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261001103247.1989111-1-hca@linux.ibm.com>
References: <20261001103247.1989111-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXwcwSnkcCnXD5
 DIEYCTjFAUHGR2Md64TeQhFQyivfrMs6wrCIMISDbRqV02fIZXa8iPjVBCPR7oUMGFVWpOoq+3h
 SywLy45zERqiwffbTo+dm+6VvOGPlJw=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX8oFPPTl9ZmsB
 YkTIWooI8dNeLB+agm3us8WqOuKZNKdOTEzrs1LmDKVZHx5kAIDUSzW5SEdYe1X1pIGcNH2wSp3
 BwoW+J0OQqrw3tZQn1wskU/d0V1swbO89biS98dBaNIdkPRK5GzruTGyaaBGzpiwJubYkQi61P/
 yZyh2k9P4/d1QWD4yCAB6gNEY7OhC+xlC3vdpk/WeIrg9cSd7D7RCKNzygTYdh9Z9EFD/WnHXcy
 iLAFITRmIc7AZc3kN7hgyzXuinI9/X99BzAaDPXUDTd33/buVPzShSTa7lhH3IrGfbYfPwz4CbL
 Nn9nyq90Ctg+yZT/1XnMUa5xds5zBkFDnKtzZfa+XDSNQZ5hIpLZQwa5Y40G0ZkXsvHygQ8NmXT
 jWBleTJigA2JRj0pyGTyzqI90cjQnRRKEKig8tuIxmWfGaLpi81bdGkDde9s3zmeEc2GZ6RHG91
 87MoRV9BVjtf5YAzXMQ==
X-Proofpoint-GUID: uMP0Vgf9Oql_lUMIYDCH8MVvdSVCDRPv
X-Authority-Analysis: v=2.4 cv=RKcmjIi+ c=1 sm=1 tr=0 ts=6abe36d6 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VnNF1IyMAAAA:8 a=pYrMN8t5q59kfUwq7L8A:9
X-Proofpoint-ORIG-GUID: uMP0Vgf9Oql_lUMIYDCH8MVvdSVCDRPv
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 clxscore=1015 priorityscore=1501 spamscore=0 bulkscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 suspectscore=0 malwarescore=0 phishscore=0
 classifier=typeunknown authscore=0 authtc= authcc= route=outbound adjust=0
 reason=mlx scancount=1 engine=8.22.0-2609040000 definitions=main-2610010040

Replace the '>' and '*' instruction markers with explicit 'PSW >' and
'PGM >' markers which identify both the PSW address and the faulting
instruction.

Previously, '>' marked the PSW address, while '*' marked the preceding
instruction as a guess for the faulting instruction for suppressing
exceptions:

 Krnl Code:
            000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
           *000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
           >000003ff8dc7c004: a7280000     lhi     %r2,0
            000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)

Now 'PGM >' explicitly marks the faulting instruction without guessing
and 'PSW >' marks the PSW address:

 Krnl Code:
            000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
       PGM >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
       PSW >000003ff8dc7c004: a7280000     lhi     %r2,0
            000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)

For nullifying exceptions where both addresses are the same,
'PGM+PSW >' is printed instead:

 Krnl Code:
            000003ff8dc7bff8: e310f0080004 lg      %r1,8(%r15)
   PGM+PSW >000003ff8dc7bffe: e3a0e0000004 lg      %r10,0(%r14)
            000003ff8dc7c004: a7280000     lhi     %r2,0
            000003ff8dc7c008: eb9ff0900024 stmg    %r9,%r15,144(%r15)

show_code() may also be called in other contexts where pt_regs does not
originate from a program check (e.g. system calls). Introduce and set
PIF_PGM_CHECK to indicate when in program check context, and print the
PGM marker only in such a context.

Note that corner cases are not taken into account. Like before kprobes is
not considered, which means that the disassembly may contain unexpected
instructions, or that disassembly and/or instruction length count as well
as interruption do not match.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h |  4 ++++
 arch/s390/kernel/dis.c         | 16 +++++++++++-----
 arch/s390/kernel/early.c       |  1 +
 arch/s390/kernel/traps.c       |  4 +++-
 4 files changed, 19 insertions(+), 6 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index c844b8aa0fd9..3e56ef8c268b 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -18,12 +18,14 @@
 #define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
 #define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) */
 #define PIF_WARN_TRAP_SKIPPED		4	/* __WARN_trap() was skipped */
+#define PIF_PGM_CHECK			5	/* inside a program check */
 
 #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
 #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
 #define _PIF_SYSCALL_RET_SET		BIT(PIF_SYSCALL_RET_SET)
 #define _PIF_FTRACE_FULL_REGS		BIT(PIF_FTRACE_FULL_REGS)
 #define _PIF_WARN_TRAP_SKIPPED		BIT(PIF_WARN_TRAP_SKIPPED)
+#define _PIF_PGM_CHECK			BIT(PIF_PGM_CHECK)
 
 #define PSW32_MASK_PER		_AC(0x40000000, UL)
 #define PSW32_MASK_DAT		_AC(0x04000000, UL)
@@ -242,6 +244,8 @@ static inline void instruction_pointer_set(struct pt_regs *regs,
 	regs->psw.addr = val;
 }
 
+unsigned long get_trap_ip(struct pt_regs *regs);
+
 int regs_query_register_offset(const char *name);
 const char *regs_query_register_name(unsigned int offset);
 
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 5a1a24d211c3..ece0b1e46ad4 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -503,7 +503,8 @@ static int copy_from_regs(struct pt_regs *regs, void *dst, void *src, int len)
 void show_code(struct pt_regs *regs)
 {
 	char *mode = user_mode(regs) ? "User" : "Krnl";
-	unsigned long addr, pswaddr;
+	unsigned long addr, pswaddr, trapaddr;
+	bool pgm_check;
 	unsigned char code[64];
 	char buffer[128], *ptr;
 	int start, end, opsize, hops, i;
@@ -511,6 +512,9 @@ void show_code(struct pt_regs *regs)
 	pswaddr = regs->psw.addr;
 	if (test_pt_regs_flag(regs, PIF_PSW_ADDR_ADJUSTED))
 		pswaddr = __forward_psw(regs->psw, regs->int_code >> 16);
+	pgm_check = test_pt_regs_flag(regs, PIF_PGM_CHECK);
+	if (pgm_check)
+		trapaddr = get_trap_ip(regs);
 	/* Get a snapshot of the 64 bytes surrounding the fault address. */
 	for (start = 32; start && pswaddr >= 34 - start; start -= 2) {
 		addr = pswaddr - 34 + start;
@@ -545,15 +549,17 @@ void show_code(struct pt_regs *regs)
 	while (start < end && hops < 8) {
 		ptr = buffer;
 		opsize = insn_length(code[start]);
+		addr = pswaddr + start - 32;
 		if (start == 32 && test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
 			ptr += sprintf(ptr, " WARN RET >");
-		else if (start + opsize == 32 && !test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
-			ptr += sprintf(ptr, "          *");
+		else if (pgm_check && addr == trapaddr && start == 32)
+			ptr += sprintf(ptr, "  PGM+PSW >");
+		else if (pgm_check && addr == trapaddr)
+			ptr += sprintf(ptr, "      PGM >");
 		else if (start == 32)
-			ptr += sprintf(ptr, "          >");
+			ptr += sprintf(ptr, "      PSW >");
 		else
 			ptr += sprintf(ptr, "           ");
-		addr = pswaddr + start - 32;
 		ptr += sprintf(ptr, "%px: ", (void *)addr);
 		if (start + opsize >= end)
 			break;
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index d875b3b304be..a603e034fa82 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -159,6 +159,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
 	regs->int_parm_long = lc->trans_exc_code;
 	regs->last_break = lc->pgm_last_break;
 	regs->monitor_code = lc->monitor_code;
+	set_pt_regs_flag(regs, PIF_PGM_CHECK);
 
 	/* Monitor Event? Might be a warning */
 	if ((regs->int_code & PGM_INT_CODE_MASK) == 0x40) {
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index 5e63032a56db..a0937b4a6cf3 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -42,7 +42,7 @@ struct pgm_stat {
 
 static DEFINE_PER_CPU_SHARED_ALIGNED(struct pgm_stat, pgm_stat);
 
-static inline unsigned long get_trap_ip(struct pt_regs *regs)
+unsigned long get_trap_ip(struct pt_regs *regs)
 {
 	static const unsigned long nullified[2] = { PGM_CHECKS_NULLIFIED };
 	psw_t psw = regs->psw;
@@ -56,6 +56,7 @@ static inline unsigned long get_trap_ip(struct pt_regs *regs)
 	psw.addr = __rewind_psw(psw, regs->int_code >> 16);
 	return psw.addr;
 }
+NOKPROBE_SYMBOL(get_trap_ip);
 
 #ifdef CONFIG_GENERIC_BUG
 int is_valid_bugaddr(unsigned long addr)
@@ -354,6 +355,7 @@ void noinstr __do_pgm_check(struct pt_regs *regs, unsigned long flags)
 	regs->int_code = lc->pgm_int_code;
 	regs->int_parm_long = teid.val;
 	regs->monitor_code = lc->monitor_code;
+	set_pt_regs_flag(regs, PIF_PGM_CHECK);
 
 	trapnr = regs->int_code & PGM_INT_CODE_MASK;
 	stat = this_cpu_ptr(&pgm_stat);
-- 
2.53.0

