Received: from mx0b-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com [148.163.158.5])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E21B521211;
	Tue, 13 Oct 2026 13:35:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.163.158.5
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791898507; cv=none; b=VamsRC92DOC90v0pYLygFL42oV8dzhXR1hcVXJhI5IMsTcwSLjDnt/DA2pBR2RCcTJpIlZVd6Gl8szg5VsC/3QWPsSfcZd4MCe0gJVFTQiCVH+hr2EY5vAeZtyZHPEHl2W73RybDYj5qzKcUNNMIMEqyQRv1hOc2+7XOOzOHqqY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791898507; c=relaxed/simple;
	bh=hoG58m2EVzJojWFOI5xYAbwE7CoyBK5mXjC85SbME48=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=RGW3ioU8F9fSgjP/0kT0WSg1H1GVdruedKTMZC8EKzvWH9fTVthL4bW6Php39JrOnyVKYUPeN9w9k/OvtiH5cJIplsTtTYoLHMud5pNEF9CINZmMEdu6t1ObmfnB2WfmIAqbf49y69NmjvTZAetQiTfls6j7TMneEeFNeeigQSU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com; spf=pass smtp.mailfrom=linux.ibm.com; dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b=MOZGfJL/; arc=none smtp.client-ip=148.163.158.5
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linux.ibm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=ibm.com header.i=@ibm.com header.b="MOZGfJL/"
Received: from pps.filterd (m0353725.ppops.net [127.0.0.1])
	by mx0a-001b2d01.pphosted.com (8.18.1.11/8.18.1.11) with ESMTP id 69D2EQhu725918;
	Tue, 13 Oct 2026 13:35:04 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=cc
	:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=pp1; bh=y6BqAZxApeAsVACQT
	nDSWUE0ODInqVA8SnSY2bEAGNg=; b=MOZGfJL/F3wE2fEEVjcOuhLt5dSXosadc
	4r/+yf7k6DIc2pW/Hjz+uotRcbJhoR7nwkwpB+4dqzZWqdZ7bPS4E0SoWPAZMQhL
	H3iiy40EyQHMRosYjRnnD0EUSPM2f3xYePP2bf22lUYPpYxbSxcJv1gFUF2Rm+fF
	xVbEuzrbgMo7NqFPWPVUwwNuGy2jRDI5K9yg7Lgzl4ftUi6NPnqLlYq0+K7cZYR8
	wAofTencHXqJ1UTUn7mzTGLsdQrhqJ0SPSnTtduuXjCx8v9O8jtRMILEjj2hRNVw
	+Xn1oEt46UvvxSwYxYyeZellvEkFkIk0lCtjmWv0AJxLuYz0PmsEg==
Received: from ppma13.dal12v.mail.ibm.com (dd.9e.1632.ip4.static.sl-reverse.com [50.22.158.221])
	by mx0a-001b2d01.pphosted.com (PPS) with ESMTPS id 4h7dv0dxqn-1
	(version=TLSv1.3 cipher=TLS_AES_256_GCM_SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:35:04 +0000 (GMT)
Received: from pps.filterd (ppma13.dal12v.mail.ibm.com [127.0.0.1])
	by ppma13.dal12v.mail.ibm.com (8.18.1.11/8.18.1.11) with ESMTP id 69DCLl0S1440328;
	Tue, 13 Oct 2026 13:35:03 GMT
Received: from smtprelay02.fra02v.mail.ibm.com ([9.218.2.226])
	by ppma13.dal12v.mail.ibm.com (PPS) with ESMTPS id 4h81wg1vg2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 13 Oct 2026 13:35:03 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (smtpav01.fra02v.mail.ibm.com [10.20.54.100])
	by smtprelay02.fra02v.mail.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 69DDYs8M38994208
	(version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
	Tue, 13 Oct 2026 13:34:54 GMT
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 5641520040;
	Tue, 13 Oct 2026 13:34:54 +0000 (GMT)
Received: from smtpav01.fra02v.mail.ibm.com (unknown [127.0.0.1])
	by IMSVA (Postfix) with ESMTP id 2556A20063;
	Tue, 13 Oct 2026 13:34:54 +0000 (GMT)
Received: from tuxmaker.lnxne.boe (unknown [9.87.85.9])
	by smtpav01.fra02v.mail.ibm.com (Postfix) with ESMTP;
	Tue, 13 Oct 2026 13:34:54 +0000 (GMT)
From: Heiko Carstens <hca@linux.ibm.com>
To: Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org
Subject: [PATCH v2 2/2] s390/signal: Cleanup coding style
Date: Tue, 13 Oct 2026 15:34:53 +0200
Message-ID: <20261013133453.2288894-3-hca@linux.ibm.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20261013133453.2288894-1-hca@linux.ibm.com>
References: <20261013133453.2288894-1-hca@linux.ibm.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-TM-AS-GCONF: 00
X-Proofpoint-Spam-Details-Enc: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfX9FWlA8oCpmEI
 tda1nKxHiOJoh13MbzTucEuCDSzm9aFz8uQ6HwrHGos1rmLSUrjYzi2kK8BuoxucE1azG/6Q8vb
 WqUpoZWSEqafywOKB/lQTMOKPQyXe76NE46196BwI1+/5T7D2DiknK4PZBNaUpPNiMGvFKD5jIs
 omz0r6zMJCpEapFayNOMy9jtpdms7MP+38hIZuM0Xj3t09XYDpD2+lUzWn0yIXlSvxJl92m+38b
 y5NOPLxxLJj4OfvxF7EAVagIjBolkev6kTr77BYbswGrpK9EdYLvHFB6kPjvAqml1nSGbzL9dvD
 KFPQgAWaHK4VDsLx3/FC4yDQHc/TTewiYu1ewIQADVMsazLY6WhwXIPSYzVUnGKTelBPay7P5sm
 /0+dlK0DEntAC+nVC7N+QL8eLYsY/Ilfc0+9SEuPrlPuNhPzAQhqXA8LjQT4WlKW9QPvlbNA/CU
 XImL2uWtbhfpZMXFEpg==
X-Proofpoint-Spam-Info: AW1haW4tMjYxMDEzMDA1MiBTYWx0ZWRfXyYvug/2QtBQ9
 2eRyWgxiZeUhCHIM28me+Po4wZjy271B9yLRXcsEI9YpVSec1bfDQiHBxXCTHICO+nfE7JqxoGm
 Sg5v39Dhr7GKzXk3DK74RY3zUMCKTMQ=
X-Proofpoint-ORIG-GUID: L3qhcVpjr728T-WTgN985TD5qVwTrlaD
X-Authority-Analysis: v=2.4 cv=a6KlZkSF c=1 sm=1 tr=0 ts=6ace3388 cx=c_pps
 a=AfN7/Ok6k8XGzOShvHwTGQ==:117 a=AfN7/Ok6k8XGzOShvHwTGQ==:17
 a=660iZSQnnn4A:10 a=VkNPw1HP01LnGYTKEx00:22 a=RnoormkPH1_aCDwRdu11:22
 a=V8glGbnc2Ofi9Qvn3v5h:22 a=VnNF1IyMAAAA:8 a=5CldfXq2zIN-BKdXh0MA:9
X-Proofpoint-GUID: L3qhcVpjr728T-WTgN985TD5qVwTrlaD
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1176,Hydra:6.1.134,FMLib:17.12.100.49
 definitions=2026-10-13_01,2026-10-09_01,2025-10-01_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0
 bulkscore=0 malwarescore=0 spamscore=0 suspectscore=0 clxscore=1015
 phishscore=0 priorityscore=1501 lowpriorityscore=0 impostorscore=0
 adultscore=0 classifier=typeunknown authscore=0 authtc= authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.22.0-2610080000
 definitions=main-2610130052

Only whitespace, comment, indentation and other trivial changes to
adopt signal.c to current coding style.

No functional change.

Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
---
 arch/s390/kernel/signal.c | 224 +++++++++++++++-----------------------
 1 file changed, 90 insertions(+), 134 deletions(-)

diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index b59b0c49a1aa..deeef053758c 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -27,8 +27,8 @@
 #include <linux/personality.h>
 #include <linux/binfmts.h>
 #include <linux/syscalls.h>
-#include <asm/ucontext.h>
 #include <linux/uaccess.h>
+#include <asm/ucontext.h>
 #include <asm/vdso-symbols.h>
 #include <asm/access-regs.h>
 #include <asm/lowcore.h>
@@ -61,8 +61,7 @@
  * have a fixed position and moves if gprs_high or vxrs exist.
  * Future extensions will be added to _sigregs_ext.
  */
-struct sigframe
-{
+struct sigframe {
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
 	struct sigcontext sc;
 	_sigregs sregs;
@@ -96,22 +95,21 @@ struct sigframe
  *	-----------------------------------------
  * Future extensions will be added to _sigregs_ext.
  */
-struct rt_sigframe
-{
+struct rt_sigframe {
 	__u8 callee_used_stack[__SIGNAL_FRAMESIZE];
 	__u16 svc_insn;
 	struct siginfo info;
 	struct ucontext_extended uc;
 };
 
-/* Store registers needed to create the signal frame */
+/* Store registers needed to create the signal frame. */
 static void store_sigregs(void)
 {
 	save_access_regs(current->thread.acrs);
 	save_user_fpu_regs();
 }
 
-/* Load registers after signal return */
+/* Load registers after signal return. */
 static void load_sigregs(void)
 {
 	restore_access_regs(current->thread.acrs);
@@ -122,14 +120,14 @@ static int save_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
 	_sigregs user_sregs;
 
-	/* Copy a 'clean' PSW mask to the user to avoid leaking
-	   information about whether PER is currently on.  */
-	user_sregs.regs.psw.mask = PSW_USER_BITS |
-		(regs->psw.mask & (PSW_MASK_USER | PSW_MASK_RI));
+	/*
+	 * Copy a 'clean' PSW mask to the user to avoid leaking
+	 * information about whether PER is currently on.
+	 */
+	user_sregs.regs.psw.mask = PSW_USER_BITS | (regs->psw.mask & (PSW_MASK_USER | PSW_MASK_RI));
 	user_sregs.regs.psw.addr = regs->psw.addr;
 	memcpy(&user_sregs.regs.gprs, &regs->gprs, sizeof(sregs->regs.gprs));
-	memcpy(&user_sregs.regs.acrs, current->thread.acrs,
-	       sizeof(user_sregs.regs.acrs));
+	memcpy(&user_sregs.regs.acrs, current->thread.acrs, sizeof(user_sregs.regs.acrs));
 	fpregs_store(&user_sregs.fpregs, &current->thread.ufpu);
 	if (__copy_to_user(sregs, &user_sregs, sizeof(_sigregs)))
 		return -EFAULT;
@@ -140,44 +138,37 @@ static int restore_sigregs(struct pt_regs *regs, _sigregs __user *sregs)
 {
 	_sigregs user_sregs;
 
-	/* Always make any pending restarted system call return -EINTR */
+	/* Always make any pending restarted system call return -EINTR. */
 	current->restart_block.fn = do_no_restart_syscall;
-
 	if (__copy_from_user(&user_sregs, sregs, sizeof(user_sregs)))
 		return -EFAULT;
-
 	if (!is_ri_task(current) && (user_sregs.regs.psw.mask & PSW_MASK_RI))
 		return -EINVAL;
-
 	/* Use regs->psw.mask instead of PSW_USER_BITS to preserve PER bit. */
-	regs->psw.mask = (regs->psw.mask & ~(PSW_MASK_USER | PSW_MASK_RI)) |
-		(user_sregs.regs.psw.mask & (PSW_MASK_USER | PSW_MASK_RI));
+	regs->psw.mask &= ~(PSW_MASK_USER | PSW_MASK_RI);
+	regs->psw.mask |= user_sregs.regs.psw.mask & (PSW_MASK_USER | PSW_MASK_RI);
 	/* Check for invalid user address space control. */
 	if ((regs->psw.mask & PSW_MASK_ASC) == PSW_ASC_HOME)
-		regs->psw.mask = PSW_ASC_PRIMARY |
-			(regs->psw.mask & ~PSW_MASK_ASC);
-	/* Check for invalid amode */
+		regs->psw.mask = PSW_ASC_PRIMARY | (regs->psw.mask & ~PSW_MASK_ASC);
+	/* Check for invalid amode. */
 	if (regs->psw.mask & PSW_MASK_EA)
 		regs->psw.mask |= PSW_MASK_BA;
 	regs->psw.addr = user_sregs.regs.psw.addr;
 	memcpy(&regs->gprs, &user_sregs.regs.gprs, sizeof(sregs->regs.gprs));
-	memcpy(&current->thread.acrs, &user_sregs.regs.acrs,
-	       sizeof(current->thread.acrs));
-
+	memcpy(&current->thread.acrs, &user_sregs.regs.acrs, sizeof(current->thread.acrs));
 	fpregs_load(&user_sregs.fpregs, &current->thread.ufpu);
-
-	clear_pt_regs_flag(regs, PIF_SYSCALL); /* No longer in a system call */
+	/* No longer in a system call. */
+	clear_pt_regs_flag(regs, PIF_SYSCALL);
 	return 0;
 }
 
 /* Returns non-zero on fault. */
-static int save_sigregs_ext(struct pt_regs *regs,
-			    _sigregs_ext __user *sregs_ext)
+static int save_sigregs_ext(struct pt_regs *regs, _sigregs_ext __user *sregs_ext)
 {
 	__u64 vxrs[__NUM_VXRS_LOW];
 	int i;
 
-	/* Save vector registers to signal stack */
+	/* Save vector registers to signal stack. */
 	if (cpu_has_vx()) {
 		for (i = 0; i < __NUM_VXRS_LOW; i++)
 			vxrs[i] = current->thread.ufpu.vxrs[i].low;
@@ -191,13 +182,12 @@ static int save_sigregs_ext(struct pt_regs *regs,
 	return 0;
 }
 
-static int restore_sigregs_ext(struct pt_regs *regs,
-			       _sigregs_ext __user *sregs_ext)
+static int restore_sigregs_ext(struct pt_regs *regs, _sigregs_ext __user *sregs_ext)
 {
 	__u64 vxrs[__NUM_VXRS_LOW];
 	int i;
 
-	/* Restore vector registers from signal stack */
+	/* Restore vector registers from signal stack. */
 	if (cpu_has_vx()) {
 		if (__copy_from_user(vxrs, &sregs_ext->vxrs_low,
 				     sizeof(sregs_ext->vxrs_low)) ||
@@ -213,11 +203,12 @@ static int restore_sigregs_ext(struct pt_regs *regs,
 
 SYSCALL_DEFINE0(sigreturn)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-	struct sigframe __user *frame =
-		(struct sigframe __user *) regs->gprs[15];
+	struct sigframe __user *frame;
+	struct pt_regs *regs;
 	sigset_t set;
 
+	regs = task_pt_regs(current);
+	frame = (struct sigframe __user *)regs->gprs[15];
 	if (__copy_from_user(&set.sig, &frame->sc.oldmask, _SIGMASK_COPY_SIZE))
 		goto badframe;
 	set_current_blocked(&set);
@@ -235,11 +226,12 @@ SYSCALL_DEFINE0(sigreturn)
 
 SYSCALL_DEFINE0(rt_sigreturn)
 {
-	struct pt_regs *regs = task_pt_regs(current);
-	struct rt_sigframe __user *frame =
-		(struct rt_sigframe __user *)regs->gprs[15];
+	struct rt_sigframe __user *frame;
+	struct pt_regs *regs;
 	sigset_t set;
 
+	regs = task_pt_regs(current);
+	frame = (struct rt_sigframe __user *)regs->gprs[15];
 	if (__copy_from_user(&set.sig, &frame->uc.uc_sigmask, sizeof(set)))
 		goto badframe;
 	set_current_blocked(&set);
@@ -257,94 +249,76 @@ SYSCALL_DEFINE0(rt_sigreturn)
 	return 0;
 }
 
-/*
- * Determine which stack to use..
- */
-static inline void __user *
-get_sigframe(struct k_sigaction *ka, struct pt_regs * regs, size_t frame_size)
+/* Determine which stack to use. */
+static inline void __user *get_sigframe(struct k_sigaction *ka, struct pt_regs *regs, size_t frame_size)
 {
 	unsigned long sp;
 
-	/* Default to using normal stack */
+	/* Default to using normal stack. */
 	sp = regs->gprs[15];
-
 	/* Overflow on alternate signal stack gives SIGSEGV. */
 	if (on_sig_stack(sp) && !on_sig_stack((sp - frame_size) & -8UL))
-		return (void __user *) -1UL;
-
-	/* This is the X/Open sanctioned signal stack switching.  */
+		return (void __user *)-1UL;
+	/* This is the X/Open sanctioned signal stack switching. */
 	if (ka->sa.sa_flags & SA_ONSTACK) {
-		if (! sas_ss_flags(sp))
+		if (!sas_ss_flags(sp))
 			sp = current->sas_ss_sp + current->sas_ss_size;
 	}
-
-	return (void __user *)((sp - frame_size) & -8ul);
+	return (void __user *)((sp - frame_size) & -8UL);
 }
 
-static int setup_frame(int sig, struct k_sigaction *ka,
-		       sigset_t *set, struct pt_regs * regs)
+static int setup_frame(int sig, struct k_sigaction *ka, sigset_t *set, struct pt_regs *regs)
 {
 	struct sigframe __user *frame;
-	struct sigcontext sc;
 	unsigned long restorer;
+	struct sigcontext sc;
 	size_t frame_size;
 
 	frame_size = sizeof(*frame) - sizeof(frame->sregs_ext);
 	if (cpu_has_vx())
 		frame_size += sizeof(frame->sregs_ext);
 	frame = get_sigframe(ka, regs, frame_size);
-	if (frame == (void __user *) -1UL)
+	if (frame == (void __user *)-1UL)
 		return -EFAULT;
-
 	/* Set up backchain. */
-	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
+	if (__put_user(regs->gprs[15], (addr_t __user *)frame))
 		return -EFAULT;
-
-	/* Create struct sigcontext on the signal stack */
+	/* Create struct sigcontext on the signal stack. */
 	memcpy(&sc.oldmask, &set->sig, _SIGMASK_COPY_SIZE);
-	sc.sregs = (_sigregs __user __force *) &frame->sregs;
+	sc.sregs = (_sigregs __user __force *)&frame->sregs;
 	if (__copy_to_user(&frame->sc, &sc, sizeof(frame->sc)))
 		return -EFAULT;
-
-	/* Store registers needed to create the signal frame */
+	/* Store registers needed to create the signal frame. */
 	store_sigregs();
-
-	/* Create _sigregs on the signal stack */
+	/* Create _sigregs on the signal stack. */
 	if (save_sigregs(regs, &frame->sregs))
 		return -EFAULT;
-
-	/* Place signal number on stack to allow backtrace from handler.  */
-	if (__put_user(regs->gprs[2], (int __user *) &frame->signo))
+	/* Place signal number on stack to allow backtrace from handler. */
+	if (__put_user(regs->gprs[2], (int __user *)&frame->signo))
 		return -EFAULT;
-
-	/* Create _sigregs_ext on the signal stack */
+	/* Create _sigregs_ext on the signal stack. */
 	if (save_sigregs_ext(regs, &frame->sregs_ext))
 		return -EFAULT;
-
-	/* Set up to return from userspace.  If provided, use a stub
-	   already in userspace.  */
+	/*
+	 * Set up to return from userspace. If provided, use a stub
+	 * already in userspace.
+	 */
 	if (ka->sa.sa_flags & SA_RESTORER)
-		restorer = (unsigned long) ka->sa.sa_restorer;
+		restorer = (unsigned long)ka->sa.sa_restorer;
 	else
 		restorer = VDSO_SYMBOL(current, sigreturn);
-
-	/* Set up registers for signal handler */
+	/* Set up registers for signal handler. */
 	regs->gprs[14] = restorer;
-	regs->gprs[15] = (unsigned long) frame;
+	regs->gprs[15] = (unsigned long)frame;
 	/* Force default amode and default user address space control. */
-	regs->psw.mask = PSW_MASK_EA | PSW_MASK_BA |
-		(PSW_USER_BITS & PSW_MASK_ASC) |
-		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (unsigned long) ka->sa.sa_handler;
-
+	regs->psw.mask &= ~PSW_MASK_ASC;
+	regs->psw.mask |= (PSW_USER_BITS & PSW_MASK_ASC) | PSW_MASK_EA | PSW_MASK_BA;
+	regs->psw.addr = (unsigned long)ka->sa.sa_handler;
 	regs->gprs[2] = sig;
-	regs->gprs[3] = (unsigned long) &frame->sc;
-
-	/* We forgot to include these in the sigcontext.
-	   To avoid breaking binary compatibility, they are passed as args. */
-	if (sig == SIGSEGV || sig == SIGBUS || sig == SIGILL ||
-	    sig == SIGTRAP || sig == SIGFPE) {
-		/* set extra registers only for synchronous signals */
+	regs->gprs[3] = (unsigned long)&frame->sc;
+	/* Missing in sigcontext. Keep binary compatibility by passing as args. */
+	if (sig == SIGSEGV || sig == SIGBUS || sig == SIGILL || sig == SIGTRAP || sig == SIGFPE) {
+		/* Set extra registers only for synchronous signals. */
 		regs->gprs[4] = regs->int_code & 127;
 		regs->gprs[5] = regs->int_parm_long;
 		regs->gprs[6] = current->thread.last_break;
@@ -352,8 +326,7 @@ static int setup_frame(int sig, struct k_sigaction *ka,
 	return 0;
 }
 
-static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
-			  struct pt_regs *regs)
+static int setup_rt_frame(struct ksignal *ksig, sigset_t *set, struct pt_regs *regs)
 {
 	struct rt_sigframe __user *frame;
 	unsigned long uc_flags, restorer;
@@ -366,27 +339,24 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 		uc_flags |= UC_VXRS;
 	}
 	frame = get_sigframe(&ksig->ka, regs, frame_size);
-	if (frame == (void __user *) -1UL)
+	if (frame == (void __user *)-1UL)
 		return -EFAULT;
-
 	/* Set up backchain. */
-	if (__put_user(regs->gprs[15], (addr_t __user *) frame))
+	if (__put_user(regs->gprs[15], (addr_t __user *)frame))
 		return -EFAULT;
-
-	/* Set up to return from userspace.  If provided, use a stub
-	   already in userspace.  */
+	/*
+	 * Set up to return from userspace. If provided, use a stub
+	 * already in userspace.
+	 */
 	if (ksig->ka.sa.sa_flags & SA_RESTORER)
-		restorer = (unsigned long) ksig->ka.sa.sa_restorer;
+		restorer = (unsigned long)ksig->ka.sa.sa_restorer;
 	else
 		restorer = VDSO_SYMBOL(current, rt_sigreturn);
-
-	/* Create siginfo on the signal stack */
+	/* Create siginfo on the signal stack. */
 	if (copy_siginfo_to_user(&frame->info, &ksig->info))
 		return -EFAULT;
-
-	/* Store registers needed to create the signal frame */
+	/* Store registers needed to create the signal frame. */
 	store_sigregs();
-
 	/* Create ucontext on the signal stack. */
 	if (__put_user(uc_flags, &frame->uc.uc_flags) ||
 	    __put_user(NULL, &frame->uc.uc_link) ||
@@ -395,34 +365,29 @@ static int setup_rt_frame(struct ksignal *ksig, sigset_t *set,
 	    __copy_to_user(&frame->uc.uc_sigmask, set, sizeof(*set)) ||
 	    save_sigregs_ext(regs, &frame->uc.uc_mcontext_ext))
 		return -EFAULT;
-
-	/* Set up registers for signal handler */
+	/* Set up registers for signal handler. */
 	regs->gprs[14] = restorer;
-	regs->gprs[15] = (unsigned long) frame;
+	regs->gprs[15] = (unsigned long)frame;
 	/* Force default amode and default user address space control. */
-	regs->psw.mask = PSW_MASK_EA | PSW_MASK_BA |
-		(PSW_USER_BITS & PSW_MASK_ASC) |
-		(regs->psw.mask & ~PSW_MASK_ASC);
-	regs->psw.addr = (unsigned long) ksig->ka.sa.sa_handler;
-
+	regs->psw.mask &= ~PSW_MASK_ASC;
+	regs->psw.mask |= (PSW_USER_BITS & PSW_MASK_ASC) | PSW_MASK_EA | PSW_MASK_BA;
+	regs->psw.addr = (unsigned long)ksig->ka.sa.sa_handler;
 	regs->gprs[2] = ksig->sig;
-	regs->gprs[3] = (unsigned long) &frame->info;
-	regs->gprs[4] = (unsigned long) &frame->uc;
+	regs->gprs[3] = (unsigned long)&frame->info;
+	regs->gprs[4] = (unsigned long)&frame->uc;
 	regs->gprs[5] = current->thread.last_break;
 	return 0;
 }
 
-static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
-			  struct pt_regs *regs)
+static void handle_signal(struct ksignal *ksig, sigset_t *oldset, struct pt_regs *regs)
 {
 	int ret;
 
-	/* Set up the stack frame */
+	/* Set up the stack frame. */
 	if (ksig->ka.sa.sa_flags & SA_SIGINFO)
 		ret = setup_rt_frame(ksig, oldset, regs);
 	else
 		ret = setup_frame(ksig->sig, &ksig->ka, oldset, regs);
-
 	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLE_STEP));
 }
 
@@ -435,22 +400,19 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
  * the kernel can handle, and then we build all the user-level signal handling
  * stack-frames in one go after that.
  */
-
 void arch_do_signal_or_restart(struct pt_regs *regs)
 {
-	struct ksignal ksig;
 	sigset_t *oldset = sigmask_to_save();
+	struct ksignal ksig;
 
 	/*
 	 * Get signal to deliver. When running under ptrace, at this point
 	 * the debugger may change all our registers, including the system
 	 * call information.
 	 */
-	current->thread.system_call =
-		test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
-
+	current->thread.system_call = test_pt_regs_flag(regs, PIF_SYSCALL) ? regs->int_code : 0;
 	if (get_signal(&ksig)) {
-		/* Whee!  Actually deliver the signal.  */
+		/* Whee! Actually deliver the signal. */
 		if (current->thread.system_call) {
 			regs->int_code = current->thread.system_call;
 			/* Check for system call restarting. */
@@ -467,13 +429,11 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 				fallthrough;
 			case -ERESTARTNOINTR:
 				regs->gprs[2] = regs->orig_gpr2;
-				regs->psw.addr =
-					__rewind_psw(regs->psw,
-						     regs->int_code >> 16);
+				regs->psw.addr = __rewind_psw(regs->psw, regs->int_code >> 16);
 				break;
 			}
 		}
-		/* No longer in a system call */
+		/* No longer in a system call. */
 		clear_pt_regs_flag(regs, PIF_SYSCALL);
 		if (!(current->restart_block.arch_data & 1)) {
 			regs->psw.addr = current->restart_block.arch_data;
@@ -484,14 +444,13 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		handle_signal(&ksig, oldset, regs);
 		return;
 	}
-
-	/* No handlers present - check for system call restart */
+	/* No handlers present - check for system call restart. */
 	clear_pt_regs_flag(regs, PIF_SYSCALL);
 	if (current->thread.system_call) {
 		regs->int_code = current->thread.system_call;
 		switch (regs->gprs[2]) {
 		case -ERESTART_RESTARTBLOCK:
-			/* Restart with sys_restart_syscall */
+			/* Restart with sys_restart_syscall. */
 			regs->gprs[2] = regs->orig_gpr2;
 			current->restart_block.arch_data = regs->psw.addr;
 			regs->psw.addr = VDSO_SYMBOL(current, restart_syscall);
@@ -508,9 +467,6 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 			break;
 		}
 	}
-
-	/*
-	 * If there's no signal to deliver, we just put the saved sigmask back.
-	 */
+	/* If there's no signal to deliver, put the saved sigmask back. */
 	restore_saved_sigmask();
 }
-- 
2.53.0

