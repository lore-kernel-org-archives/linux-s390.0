Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDEDC3F3265;
	Thu,  1 Oct 2026 10:32:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790850781; cv=none; b=UEByzEGV90fYvfnA8YAa3oh3NWB2VTaNDOVRjVQ99TYnITQQdQrPrap7qf2ozYhxkig0RunLDJgYnI4jqf703RemWFHa0K4P2OWbEgnWuBrIXdNo6HkxC0VXqEipMzRL3GOIxdS4pPrw9Di94UBdJBJlZKvE813FjNdnBblQOyE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790850781; c=relaxed/simple;
	bh=WsSLXJPAYhy6nar03r6QeXnMz5IevqWON9nIdN9YJ9A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DQbDhbaB6uIncbmEem19XUb3qvmmu9CCjDz8nSFOY+koiAdPWyVNAIfkHegVZ5devCNHc6uqVI7AzAzNKRpvgIILFwRWDBmbnrYGzrgepuh8UaKFAI3PuULm05fTQpr/YpxNQvsbi53LVnyudNVDZxrOISaSQAT2m5tRi0oFwkQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=GEJKPTjI; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="GEJKPTjI"
Received: from pps.filterd (m0356516.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69175R3r907233;
	Thu, 1 Oct 2026 10:32:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=Gb5V+cQo99KzV+TNC
	KyvFp8cJyRVJ7r2eQrf/RZImkg=; b=GEJKPTjIWvvbxAD1flpZbB/wAnzWYYzqu
	u5JOD6LsmhZi0vq4Yp6gOeNXDACY+k37vmZrQA4Wxv6j91V/VvOfJ4ADcbwCzIwB
	11hsrKb8A2oSbrdYEmW3rX//xJvlu5KKvudry5KDMOeyEz5HKqGB/AtehNc1nG5X
	NDtYTZdk3CHg9Z4SIIzu8Kci26sq7yKe8of/hntPNYpzTXTTI/Wpx5tjIldVNix8
	ikZ3moeAZGa0yR9cgQegIT+/CNKmCEDWDYHIJZjs5MXi8zniPTgZVO98ECTYAcmV
	Bdx7NiE1+ERFCvRBWFXBG8eOVcZNJ3s/czbm53fnRJL5ZJy3JEMnw==
Received: from ppma11.dal12v.mail.ibm.com (db.9e.1632.ip4.static.sl-reverse.com [50.22.158.219])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4gx3fkhsph-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:53 +0000 (GMT)
Received: from pps.filterd (ppma11.dal12v.mail.ibm.com [127.0.0.1])
	by ppma11.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69172UxE557924;
	Thu, 1 Oct 2026 10:32:53 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma11.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h0j23r4cv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 01 Oct 2026 10:32:52 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (smtpav05.fra02v.mail.ibm.com [10.20.54.104])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 691AWnmB31523082
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Thu, 1 Oct 2026 10:32:49 GMT
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 569F320043;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from smtpav05.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 1A75C2004B;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
Received: from tuxmaker.boeblingen.de.ibm.com (unknown [9.87.85.9])
	by smtpav05.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Thu,  1 Oct 2026 10:32:49 +0000 (GMT)
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
Subject: [PATCH 04/32] s390/bug: Indicate modified PSW in disassembly
Date: Thu,  1 Oct 2026 12:32:19 +0200
Message-ID: <20261001103247.1989111-5-hca@linux.ibm.com>
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
X-Proofpoint-ORIG-GUID: NlK-_NGD_rfP32zJrqfLPyFmGQkDQq-G
X-Proofpoint-GUID: NlK-_NGD_rfP32zJrqfLPyFmGQkDQq-G
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfXxKd2gl9LKFqy
 Nu9A14+2tFvnEDdMxEZIY4b3y8JM4uIpjnYviz6VcVg4jVH/h3io6ZGp5eD5aMGbFny7B55AUKa
 3IM8rtwsVyRW4pAp16TjLDklcywQSCY=
X-Authority-Analysis: v=2.4 cv=Vv62kO2n c=1 sm=1 tr=0 ts=6abe36d5 cx=c_pps
 a=aDMHemPKRhS1OARIsFnwRA==:117 a=aDMHemPKRhS1OARIsFnwRA==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=Y2IxJ9c9Rs8Kov3niI8_:22 a=VnNF1IyMAAAA:8 a=3Taggf1IUoLlSaO_q3sA:9
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDAxMDA0MCBTYWx0ZWRfX99gawp1WwgA/
 EUGLmepL7sZWIJJtpmzQ/WeAJrWFEPMZulcv66rgG/Hg1JKk2HS/0OwxYp2Z4HxroCwPfgGiGtT
 tBQJMwvBeR97HkX9HZs3Sea/8v7HqBE35AIlEexrBgL9iylnO9A8m/FvejxG7HJRqKPyOyyo/Gz
 emof5UStLDRsEqLyJmm3ynnq/5zEdx/K32gEAfN3eBBCa5MQBPvqNOHs743zcIlaGsKs5/xW3wQ
 qliwFHvj4QXOmzNbO0tGYCbXlNbn+hp09m6ziZAKEpKwLUDmQ8uEkcNHLIIgTLsY2YCL5NYvD7X
 J714O+i3dVqNtjvjhMmj4Hk7qeFOAfg1HeTdEKbeRvJ6qYXakP317vGMtFPxoHnESzSbGFfByJg
 yTeYyjUhjyriNMoxp+AWoJqPCsoAHBNAgVx7cstoil8onCgtZwbiR4XUu1S0z9SjdeZEedWk2CE
 YOGD27ObauMvuQjqxCg==
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-01_03,2026-09-21_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 suspectscore=0 spamscore=0 phishscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 clxscore=1015 lowpriorityscore=0
 impostorscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2609040000
 definitions=main-2610010040

With [1] the PSW address is set to the return address of the calling
__WARN_trap() function in order to provide a more useful disassembly of
the caller rather than the helper itself.

However, since regs->psw.addr is modified, regs->int_code has nothing to
do with the exception. In order to make that more obvious change the
disassembler output.

Introduce a new PIF_WARN_TRAP_SKIPPED pt_regs flag and set it whenever
__WARN_trap() is skipped. In the disassembler output print a "WARN RET"
prefix to make it obvious that the PSW points to the return address of
the warning trap function.

Also do not print the interruption code and instruction length code for
this case, since they have nothing to do with the modified PSW.

Example output:

Krnl Code:
           000003ffe185bc1c: e3f0ff98ff71 lay     %r15,-104(%r15)
           000003ffe185bc22: e3e0f0980024 stg     %r14,152(%r15)
           000003ffe185bc28: c0e5ff45ed94 brasl   %r14,000003ffe0119750
 WARN RET >000003ffe185bc2e: c0e5ffa052b9 brasl   %r14,000003ffe0c661a0
           000003ffe185bc34: c020fffe86d6 larl    %r2,000003ffe182c9e0
           000003ffe185bc3a: e548f0a80006 mvghi   168(%r15),6
           000003ffe185bc40: e548f0a00005 mvghi   160(%r15),5
           000003ffe185bc46: a7690004     lghi    %r6,4

[1] 79996065cfa2 ("s390/bug: Skip __WARN_trap() in call traces")

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h |  2 ++
 arch/s390/kernel/dis.c         | 23 ++++++++++-------------
 arch/s390/kernel/dumpstack.c   |  7 +++++--
 arch/s390/kernel/early.c       |  9 +++++++--
 arch/s390/kernel/traps.c       |  1 +
 5 files changed, 25 insertions(+), 17 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 6411e3584283..c844b8aa0fd9 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -17,11 +17,13 @@
 #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
 #define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
 #define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) */
+#define PIF_WARN_TRAP_SKIPPED		4	/* __WARN_trap() was skipped */
 
 #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
 #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
 #define _PIF_SYSCALL_RET_SET		BIT(PIF_SYSCALL_RET_SET)
 #define _PIF_FTRACE_FULL_REGS		BIT(PIF_FTRACE_FULL_REGS)
+#define _PIF_WARN_TRAP_SKIPPED		BIT(PIF_WARN_TRAP_SKIPPED)
 
 #define PSW32_MASK_PER		_AC(0x40000000, UL)
 #define PSW32_MASK_DAT		_AC(0x04000000, UL)
diff --git a/arch/s390/kernel/dis.c b/arch/s390/kernel/dis.c
index 1cec93895b3a..5a1a24d211c3 100644
--- a/arch/s390/kernel/dis.c
+++ b/arch/s390/kernel/dis.c
@@ -540,34 +540,31 @@ void show_code(struct pt_regs *regs)
 		start += 2;
 	}
 	/* Decode the instructions. */
-	ptr = buffer;
-	ptr += sprintf(ptr, "%s Code:", mode);
+	printk("%s Code:\n", mode);
 	hops = 0;
 	while (start < end && hops < 8) {
+		ptr = buffer;
 		opsize = insn_length(code[start]);
-		if  (start + opsize == 32)
-			*ptr++ = '*';
+		if (start == 32 && test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
+			ptr += sprintf(ptr, " WARN RET >");
+		else if (start + opsize == 32 && !test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
+			ptr += sprintf(ptr, "          *");
 		else if (start == 32)
-			*ptr++ = '>';
+			ptr += sprintf(ptr, "          >");
 		else
-			*ptr++ = ' ';
+			ptr += sprintf(ptr, "           ");
 		addr = pswaddr + start - 32;
 		ptr += sprintf(ptr, "%px: ", (void *)addr);
 		if (start + opsize >= end)
 			break;
 		for (i = 0; i < opsize; i++)
 			ptr += sprintf(ptr, "%02x", code[start + i]);
-		*ptr++ = '\t';
-		if (i < 6)
-			*ptr++ = '\t';
+		ptr += sprintf(ptr, "%*s", 13 - 2 * opsize, " ");
 		ptr += print_insn(ptr, code + start, addr);
 		start += opsize;
-		pr_cont("%s", buffer);
-		ptr = buffer;
-		ptr += sprintf(ptr, "\n          ");
+		pr_cont("%s\n", buffer);
 		hops++;
 	}
-	pr_cont("\n");
 }
 
 void print_fn_code(unsigned char *code, unsigned long len)
diff --git a/arch/s390/kernel/dumpstack.c b/arch/s390/kernel/dumpstack.c
index f9d52e05e01e..4ec08264b3ef 100644
--- a/arch/s390/kernel/dumpstack.c
+++ b/arch/s390/kernel/dumpstack.c
@@ -203,8 +203,11 @@ void __noreturn die(struct pt_regs *regs, const char *str)
 	console_verbose();
 	spin_lock_irq(&die_lock);
 	bust_spinlocks(1);
-	printk("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
-	       regs->int_code >> 17, ++die_counter);
+	if (test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
+		printk("%s: [#%d]", str, ++die_counter);
+	else
+		printk("%s: %04x ilc:%d [#%d]", str, regs->int_code & 0xffff,
+		       regs->int_code >> 17, ++die_counter);
 	pr_cont("SMP ");
 	if (debug_pagealloc_enabled())
 		pr_cont("DEBUG_PAGEALLOC");
diff --git a/arch/s390/kernel/early.c b/arch/s390/kernel/early.c
index b8e3c065fbec..d875b3b304be 100644
--- a/arch/s390/kernel/early.c
+++ b/arch/s390/kernel/early.c
@@ -167,6 +167,7 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
 
 		if (regs->monitor_code == MONCODE_BUG_ARG) {
 			regs->psw.addr = regs->gprs[14];
+			set_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED);
 			btt = report_bug_entry((struct bug_entry *)regs->gprs[2], regs);
 		} else {
 			ip = __rewind_psw(regs->psw, regs->int_code >> 16);
@@ -183,8 +184,12 @@ void __init __do_early_pgm_check(struct pt_regs *regs)
 	 * some basic information in case it is too early for printk().
 	 */
 	register_early_console();
-	early_printk("PANIC: early exception %04x PSW: %016lx %016lx\n",
-		     regs->int_code & 0xffff, regs->psw.mask, regs->psw.addr);
+	if (test_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED))
+		early_printk("PANIC: early exception PSW: %016lx %016lx\n",
+			     regs->psw.mask, regs->psw.addr);
+	else
+		early_printk("PANIC: early exception %04x PSW: %016lx %016lx\n",
+			     regs->int_code & 0xffff, regs->psw.mask, regs->psw.addr);
 	show_regs(regs);
 	disabled_wait();
 }
diff --git a/arch/s390/kernel/traps.c b/arch/s390/kernel/traps.c
index b6ba4465f59d..bfcab4592299 100644
--- a/arch/s390/kernel/traps.c
+++ b/arch/s390/kernel/traps.c
@@ -267,6 +267,7 @@ static void monitor_event_exception(struct pt_regs *regs)
 		return;
 	if (regs->monitor_code == MONCODE_BUG_ARG) {
 		regs->psw.addr = regs->gprs[14];
+		set_pt_regs_flag(regs, PIF_WARN_TRAP_SKIPPED);
 		btt = report_bug_entry((struct bug_entry *)regs->gprs[2], regs);
 	} else {
 		btt = report_bug(regs->psw.addr - (regs->int_code >> 16), regs);
-- 
2.53.0

