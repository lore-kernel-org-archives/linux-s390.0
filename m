Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=148.163.156.1
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792573041;
	b=ktgyPQ/AwIOww8krhPTnXpHb3uuQD7li29r3WofZTUYEoaTNEmZhQjEYblyBto1SNw4G
	 wzBRn+PLUBpyMb+AZLimp/TkL2n2NpHYHwhnXYrSTp/UbhdYFqPXs2Koy9JQfKS9bdCau
	 OjSun2HXjtJXKya2Kb02IuKqbwGTsTeBCr7WFVbpRxerSenYfI4get4ndMSIqNzbZvacI
	 3xUVsvfvZ1uCm39H7QEG9hByYMjqVKtQdwZeRpBqmvA3iwUCi2KsGcb+1uH81nsHDu7lE
	 ja+/UNN6jRaBq2vxXY6fyO337ZbZjVyzgBzAeLtOI1BpVjZAr1JbJ5t66yP442l3DkQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792573041;
	h=DMARC-Filter:Received:DKIM-Signature:Received:Received:Received:
	 Received:Received:Received:Received:From:To:Cc:Subject:Date:
	 Message-ID:X-Mailer:MIME-Version:Content-Transfer-Encoding:
	 X-TM-AS-GCONF:X-Proofpoint-GUID:X-Proofpoint-Spam-Info:
	 X-Proofpoint-Spam-Details-Enc:X-Proofpoint-ORIG-GUID:
	 X-Authority-Analysis:X-Proofpoint-Virus-Version:
	 X-Proofpoint-Spam-Details;
	bh=2WRYBbS0xdS267PyeQxw+u9yW4liFG56XU5wuDsPS6E=;
	b=zPbYaMVtrLwhtftcFliRmGmoXwIqMrK4lsflzOMY4FPOTB3Ru1k8JkgqLuBwCT7VF3AB
	 DR0PHfg0vPM1jdaVSXIYLk8U8Ux8YybrCPiJXr04vf8YeWGLcTWFD+vrdcQ9K+L2Fqxot
	 cZNzo/95yINVUG+F/pNEF2F/pgNGA2oim2Q/T2x9LJfSn6Cv2Mw9A2iI4r2zJd3hwHLiC
	 xArrpViVbvpt23fCMTNU63M3trvarsaOj2+M1rq1AiXhD/ZKWiN4lhEqHz1tx8FbQD19m
	 EIhhULygQyVjEb6HDHBI3vcwBVfnaldBaXHQ4M7AMfUXip3cSRFJLQ0tz1QGuN9ZxLQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dmarc=pass header.from=linux.ibm.com;
	spf=pass smtp.mailfrom=linux.ibm.com;
	dkim=pass header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hUWcX+SJ;
	arc=none smtp.remote-ip=148.163.156.1
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1) server-digest SHA256)
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 18CC7606A319;
	Wed, 21 Oct 2026 08:57:20 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.4.2 smtp.subspace.kernel.org 18CC7606A319
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=ibm.com header.i=@ibm.com header.a=rsa-sha256 header.s=pp1 header.b=hUWcX+SJ
Received: from pps.filterd (m0360083.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5iDu4470106;
	Wed, 21 Oct 2026 08:56:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:message-id:mime-version
	:subject:to; s=pp1; bh=2WRYBbS0xdS267PyeQxw+u9yW4liFG56XU5wuDsPS
	6E=; b=hUWcX+SJDG6ujm47mYn3dbLJOptywZnaPsTmLgUpVAJ882wkALX10w0Ps
	xAxZ3d2Vvm9qkp8OWp7BsVoU0C0OQy7pKArrvWmw1JKTmg6B87Yr+elE0qjCVTt0
	AkUJdxuVtY9iKaQzUalvhREZeSgKMcc9bTuwCHAU8pNGJsrIc0UC2k6BvXElWwcq
	aHkLLivuXjXvFAQRThLKsVRzSmPtXScfPOGV1MZgAVkifzE8xioB6xu6SKCmjCg9
	S3mMK+B8OYhBkt4f5sn2TNY6b4DyA5nhxEiVqoaQAPZVH3MO5f71Ru303BRv+jOD
	hcx7kNvjCUz6ybMo9lpCHJLezbUMg==
Received: from ppma21.wdc07v.mail.ibm.com (5b.69.3da9.ip4.static.sl-reverse.com [169.61.105.91])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4hdw58qy5m-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 08:56:51 +0000 (GMT)
Received: from pps.filterd (ppma21.wdc07v.mail.ibm.com [127.0.0.1])
	by ppma21.wdc07v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69L5o0iD2599113;
	Wed, 21 Oct 2026 08:56:50 GMT
Received: from smtprelay03.fra02v.mail.ibm.com ([9.218.2.224])
	by ppma21.wdc07v.mail.ibm.com (PPS) with ESMTPS id 4he7bs4brr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Oct 2026 08:56:50 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay03.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69L8ukJF47251872
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Wed, 21 Oct 2026 08:56:46 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 825872004E;
	Wed, 21 Oct 2026 08:56:43 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 38EC820063;
	Wed, 21 Oct 2026 08:56:43 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Wed, 21 Oct 2026 08:56:43 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Oleg Nesterov <oleg@redhat.com>,
        =?UTF-8?q?Michal=20Such=C3=A1nek?= <msuchanek@suse.de>,
        "Dmitry V . Levin" <ldv@strace.io>, Renzo Davoli <renzo@cs.unibo.it>,
        Thomas Gleixner <tglx@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH] s390/syscall: Set -ENOSYS return value before calling syscall_enter_from_user_mode_work()
Date: Wed, 21 Oct 2026 10:56:43 +0200
Message-ID: <20261021085643.2442949-1-hca@linux.ibm.com>
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
X-Proofpoint-GUID: BCX7mmY4br-ch6zTlRAxvlpVfyTx4aKH
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX58iWXlEFHDyv
 VHr03tfPIi2rIFz1OjxfqWUs43KiZmxArqKmtKoAMjwE8xRt2eYgQdhPC8wNLTNR5n7ZQ0YhiN6
 jMzyh2DDu7gb/pWzKQK8zJDzq70Jz4o=
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDIxMDAzNCBTYWx0ZWRfX+btqU09yeQrW
 MFMA2L7zKma6RFeLDZN4GxJLiK8RFawI4ViPD7B56yDc+efNd7fS+ohN7kE2bPF+7oPEZ99SOHp
 sAxH2b/XVsFoL2O9/NVY+45kD6dRAAmOlGrl4UZTjyO2/JCjRDk30M67dRHBf/05do+CtrEdqyZ
 c/R6ufu/hf4HACcNpAG1TlzeRr/ZS8EOAt05WdlOMxqdu7adNHcBVnLls/W4f1mqm9GYP46BuDZ
 Mq7z0K3UuWTxTsjFhzWcRKY/rCDYKpKp/tM9wn6897diteMNYaoUJ43wKYNCwQgu5OasKZ97Ew6
 bTZSJrAXx5z/5IMj+zGruHVYN508eHdOuucIz6iHiNVH9DHKZxokn8hzUaA2xKIHPZPeSmvUZES
 VIlf+OvSjgbAxnNxD42rt54HYSM0VYHdIExYolOqJyP7HqqJwFELeQ+7GfpTFkGO/ucQ+jDKGcB
 mp4Wie+IFksAMd/DxnA==
X-Proofpoint-ORIG-GUID: BCX7mmY4br-ch6zTlRAxvlpVfyTx4aKH
X-Authority-Analysis: v=2.4 cv=Ob4NnRTY c=1 sm=1 tr=0 ts=6ad87e53 cx=c_pps
 a=GFwsV6G8L6GxiO2Y/PsHdQ==:117 a=GFwsV6G8L6GxiO2Y/PsHdQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=iQ6ETzBq9ecOQQE5vZCe:22 a=VwQbUJbxAAAA:8 a=VnNF1IyMAAAA:8
 a=v2iOTYU0Bx-b0S-PJLgA:9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-21_02,2026-10-19_02,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 adultscore=0 phishscore=0 spamscore=0 suspectscore=0
 lowpriorityscore=0 clxscore=1011 impostorscore=0 priorityscore=1501
 malwarescore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610190000
 definitions=main-2610210034

On s390 gpr2 contains both the system call return value and the system call
number. With [1] it is expected to set gpr2 to -ENOSYS before calling
syscall_enter_from_user_mode_work(), so that a skipped system call has a
defined default return value, and not the system call number like today.

To make that work and stay compatible with existing ptrace users, replace
PIF_SYSCALL_RET_SET with PIF_SYSCALL_ENTRY. PIF_SYSCALL_ENTRY is set before
syscall_enter_from_user_mode_work() is called and indicates that reads and
writes to gpr2 via PTRACE_PEEKUSR, PTRACE_POKEUSR, PTRACE_GETREGSET, and
PTRACE_SETREGSET are redirected to regs->int_code, which contains the
system call number. gpr2, which contains the system call return value, can
only be changed via syscall_set_return_value() (e.g. seccomp).

After syscall_enter_from_user_mode_work() returns, PIF_SYSCALL_ENTRY is
cleared and the code behaves as before.

PIF_SYSCALL_RET_SET was introduced with [2]. The flag was set by
syscall_set_return_value() and allowed seccomp to skip syscalls
and inject a return value despite the gpr2 aliasing.

Kernel seccomp and ptrace selftests, as well as strace selftests, show no
difference with and without this change.

[1] 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
[2] 56e62a737028 ("s390: convert to generic entry")

Fixes: 05c033db7e9a ("entry, treewide: Make syscall_enter_from_user_mode[_work]() indicate syscall execution")
Cc: stable@vger.kernel.org
Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/include/asm/ptrace.h  |  4 ++--
 arch/s390/include/asm/syscall.h |  1 -
 arch/s390/kernel/ptrace.c       | 28 +++++++++++++++++++++++-----
 arch/s390/kernel/syscall.c      | 19 +++++++++----------
 4 files changed, 34 insertions(+), 18 deletions(-)

diff --git a/arch/s390/include/asm/ptrace.h b/arch/s390/include/asm/ptrace.h
index 3e56ef8c268b..d8f3a2dbe689 100644
--- a/arch/s390/include/asm/ptrace.h
+++ b/arch/s390/include/asm/ptrace.h
@@ -15,14 +15,14 @@
 
 #define PIF_SYSCALL			0	/* inside a system call */
 #define PIF_PSW_ADDR_ADJUSTED		1	/* psw address has been adjusted */
-#define PIF_SYSCALL_RET_SET		2	/* return value was set via ptrace */
+#define PIF_SYSCALL_ENTRY		2	/* ptrace gpr2 access redirected to syscall nr */
 #define PIF_FTRACE_FULL_REGS		3	/* all register contents valid (ftrace) */
 #define PIF_WARN_TRAP_SKIPPED		4	/* __WARN_trap() was skipped */
 #define PIF_PGM_CHECK			5	/* inside a program check */
 
 #define _PIF_SYSCALL			BIT(PIF_SYSCALL)
 #define _PIF_ADDR_PSW_ADJUSTED		BIT(PIF_PSW_ADDR_ADJUSTED)
-#define _PIF_SYSCALL_RET_SET		BIT(PIF_SYSCALL_RET_SET)
+#define _PIF_SYSCALL_ENTRY		BIT(PIF_SYSCALL_ENTRY)
 #define _PIF_FTRACE_FULL_REGS		BIT(PIF_FTRACE_FULL_REGS)
 #define _PIF_WARN_TRAP_SKIPPED		BIT(PIF_WARN_TRAP_SKIPPED)
 #define _PIF_PGM_CHECK			BIT(PIF_PGM_CHECK)
diff --git a/arch/s390/include/asm/syscall.h b/arch/s390/include/asm/syscall.h
index 5f310caad1fc..47f66202977f 100644
--- a/arch/s390/include/asm/syscall.h
+++ b/arch/s390/include/asm/syscall.h
@@ -59,7 +59,6 @@ static inline void syscall_set_return_value(struct task_struct *task,
 					    struct pt_regs *regs,
 					    int error, long val)
 {
-	set_pt_regs_flag(regs, PIF_SYSCALL_RET_SET);
 	regs->gprs[2] = error ? error : val;
 }
 
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index d8d5e843859c..a3ae881bbff6 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -204,15 +204,24 @@ static unsigned long __peek_user(struct task_struct *child, addr_t addr)
 	addr_t offset, tmp;
 
 	if (addr < offsetof(struct user, regs.acrs)) {
-		/*
-		 * psw and gprs are stored on the stack
-		 */
-		tmp = *(addr_t *)((addr_t) &task_pt_regs(child)->psw + addr);
+		struct pt_regs *regs = task_pt_regs(child);
+
+		/* psw and gprs are on the stack. */
+		tmp = *(addr_t *)((addr_t)&regs->psw + addr);
 		if (addr == offsetof(struct user, regs.psw.mask)) {
 			/* Return a clean psw mask. */
 			tmp &= PSW_MASK_USER | PSW_MASK_RI;
 			tmp |= PSW_USER_BITS;
 		}
+		/*
+		 * During system call entry gpr2 contains the return
+		 * value. Redirect reads of gpr2 to int_code so that
+		 * readers see the system call number.
+		 */
+		if (addr == offsetof(struct user, regs.gprs[2])) {
+			if (test_pt_regs_flag(regs, PIF_SYSCALL_ENTRY))
+				tmp = syscall_get_nr(child, regs);
+		}
 
 	} else if (addr < offsetof(struct user, regs.orig_gpr2)) {
 		/*
@@ -347,8 +356,17 @@ static int __poke_user(struct task_struct *child, addr_t addr, addr_t data)
 		}
 
 		if (addr == offsetof(struct user, regs.gprs[2])) {
-			if (test_pt_regs_flag(regs, PIF_SYSCALL))
+			if (test_pt_regs_flag(regs, PIF_SYSCALL_ENTRY)) {
+				/*
+				 * System call entry path: only change system
+				 * call number in int_code, but leave gpr2
+				 * alone, which contains the return value.
+				 */
 				syscall_set_nr(child, regs, data);
+				return 0;
+			} else if (test_pt_regs_flag(regs, PIF_SYSCALL)) {
+				syscall_set_nr(child, regs, data);
+			}
 		}
 		*(addr_t *)((addr_t) &regs->psw + addr) = data;
 	} else if (addr < offsetof(struct user, regs.orig_gpr2)) {
diff --git a/arch/s390/kernel/syscall.c b/arch/s390/kernel/syscall.c
index bcc0b76bd868..923df3a6dc0d 100644
--- a/arch/s390/kernel/syscall.c
+++ b/arch/s390/kernel/syscall.c
@@ -117,24 +117,23 @@ void noinstr __do_syscall(struct pt_regs *regs, unsigned long flags)
 		regs->int_code &= ~0xffffUL;
 		regs->int_code |= nr;
 	}
-	regs->gprs[2] = nr;
 	if (nr == __NR_restart_syscall && !(current->restart_block.arch_data & 1)) {
 		regs->psw.addr = current->restart_block.arch_data;
 		current->restart_block.arch_data = 1;
 	}
 
-	permit = syscall_enter_from_user_mode_work(regs, &nr);
-
 	/*
-	 * In the s390 ptrace ABI, both the syscall number and the return value
-	 * use gpr2. However, userspace puts the syscall number either in the
-	 * svc instruction itself, or uses gpr1. To make at least skipping syscalls
-	 * work, the ptrace code sets PIF_SYSCALL_RET_SET, which is checked here
-	 * and if set, the syscall will be skipped.
+	 * gpr2 is the return value register. Set it to -ENOSYS so that a
+	 * skipped system call gets a defined default return value.
+	 * Set PIF_SYSCALL_ENTRY so that ptrace reads and writes to gpr2
+	 * are redirected to the system call number in int_code.
 	 */
-	if (unlikely(test_and_clear_pt_regs_flag(regs, PIF_SYSCALL_RET_SET) || !permit))
+	syscall_set_return_value(current, regs, -ENOSYS, 0);
+	set_pt_regs_flag(regs, PIF_SYSCALL_ENTRY);
+	permit = syscall_enter_from_user_mode_work(regs, &nr);
+	clear_pt_regs_flag(regs, PIF_SYSCALL_ENTRY);
+	if (unlikely(!permit))
 		goto out;
-	regs->gprs[2] = -ENOSYS;
 	if (likely(nr < NR_syscalls)) {
 		nr = array_index_nospec(nr, NR_syscalls);
 		regs->gprs[2] = sys_call_table[nr](regs);
-- 
2.53.0

