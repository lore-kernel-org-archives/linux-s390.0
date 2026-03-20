Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B4BF38E5F7;
	Fri, 20 Mar 2026 10:41:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003276; cv=none; b=dOZLerrqGMqMy884U4acrc9dE4AuTPr4AsJZIedS8ck7F7hBgy0RFfPvv7e7bCf3JK0HDtH0pvM+6kYsU4/FNphlyqtN25lwI8GwXvlsj/cnhSfoKKRpo8kvX9WGbg7wAKgl8t24VhhlRebQVk4YZa41b5UZWXapV5xc9RISIss=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003276; c=relaxed/simple;
	bh=73ahRz1Fz7U16vUCmobH9Jf4VbRXY+7dc+vDFyNydkg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WJqjzYO8wX+cPuRyMLqhLOuDSAILISZTTceWBqCtc1IB0wsuvQ9jwO+wx+OYIboqZItlIUoFDcCUcyTMOeGUa4BUfJ/+eqIbCjYz4+iy9jDPgJ7hk+yD8a4e9tzJ3LqJpbjJUDP7QAdoo8tgVZ48yDW8YhxTvXdBRqEXd6tGhRs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=NWK77cO8; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="NWK77cO8"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=bGLRd4d7yQ3H+9TIHcIPsE85mcc6keddmlE/BpghkFU=;
	b=NWK77cO8Yv/ZtTPldvzb/QPdz3/CFVRwIXgRoyC/BtjPaQFYhCnQGJkmDAWaLGUhVQ/lGhCyv
	IheC3FMs33YD/DqemB5CErNwP9ig8m92kioE8MQhepZMcOi9/13KYqlNPXhZDZ4Pv6gHmPkYj1O
	PzjCePBUSLHfBS3XFb13SYw=
Received: from mail.maildlp.com (unknown [172.19.163.127])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4fcf994STHznTWn;
	Fri, 20 Mar 2026 18:35:41 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 2467A402AB;
	Fri, 20 Mar 2026 18:41:12 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 18:41:09 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <chenhuacai@kernel.org>,
	<kernel@xen0n.name>, <hca@linux.ibm.com>, <gor@linux.ibm.com>,
	<agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<oleg@redhat.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<shuah@kernel.org>, <kevin.brodsky@arm.com>, <ruanjinjie@huawei.com>,
	<yeoreum.yun@arm.com>, <anshuman.khandual@arm.com>, <thuth@redhat.com>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <song@kernel.org>,
	<ziyao@disroot.org>, <linusw@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<akpm@linux-foundation.org>, <mathieu.desnoyers@efficios.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
Subject: [PATCH v14 1/4] s390: Rename TIF_SINGLE_STEP to TIF_SINGLESTEP
Date: Fri, 20 Mar 2026 18:42:19 +0800
Message-ID: <20260320104222.1381274-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260320104222.1381274-1-ruanjinjie@huawei.com>
References: <20260320104222.1381274-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems100002.china.huawei.com (7.221.188.206) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Rename TIF_SINGLE_STEP to TIF_SINGLESTEP to align with the naming
convention used by arm64, x86, and other architectures.

By aligning the name, TIF_SINGLESTEP can be consolidated into the generic
TIF bits definitions, reducing architectural divergence and simplifying
cross-architecture entry/exit logic.

No functional changes intended.

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/s390/include/asm/thread_info.h |  4 ++--
 arch/s390/kernel/process.c          |  2 +-
 arch/s390/kernel/ptrace.c           | 20 ++++++++++----------
 arch/s390/kernel/signal.c           |  6 +++---
 4 files changed, 16 insertions(+), 16 deletions(-)

diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 6a548a819400..1bcd42614e41 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -69,7 +69,7 @@ void arch_setup_new_exec(void);
 #define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
 #define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
 #define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
-#define TIF_SINGLE_STEP		21	/* This task is single stepped */
+#define TIF_SINGLESTEP		21	/* This task is single stepped */
 #define TIF_BLOCK_STEP		22	/* This task is block stepped */
 #define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
 
@@ -77,7 +77,7 @@ void arch_setup_new_exec(void);
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
-#define _TIF_SINGLE_STEP	BIT(TIF_SINGLE_STEP)
+#define _TIF_SINGLESTEP	BIT(TIF_SINGLESTEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
 
diff --git a/arch/s390/kernel/process.c b/arch/s390/kernel/process.c
index 0df95dcb2101..3accc0c064a0 100644
--- a/arch/s390/kernel/process.c
+++ b/arch/s390/kernel/process.c
@@ -122,7 +122,7 @@ int copy_thread(struct task_struct *p, const struct kernel_clone_args *args)
 	/* Don't copy debug registers */
 	memset(&p->thread.per_user, 0, sizeof(p->thread.per_user));
 	memset(&p->thread.per_event, 0, sizeof(p->thread.per_event));
-	clear_tsk_thread_flag(p, TIF_SINGLE_STEP);
+	clear_tsk_thread_flag(p, TIF_SINGLESTEP);
 	p->thread.per_flags = 0;
 	/* Initialize per thread user and system timer values */
 	p->thread.user_timer = 0;
diff --git a/arch/s390/kernel/ptrace.c b/arch/s390/kernel/ptrace.c
index 125ca4c4e30c..d2cf91f4ac3f 100644
--- a/arch/s390/kernel/ptrace.c
+++ b/arch/s390/kernel/ptrace.c
@@ -90,8 +90,8 @@ void update_cr_regs(struct task_struct *task)
 	new.start.val = thread->per_user.start;
 	new.end.val = thread->per_user.end;
 
-	/* merge TIF_SINGLE_STEP into user specified PER registers. */
-	if (test_tsk_thread_flag(task, TIF_SINGLE_STEP) ||
+	/* merge TIF_SINGLESTEP into user specified PER registers. */
+	if (test_tsk_thread_flag(task, TIF_SINGLESTEP) ||
 	    test_tsk_thread_flag(task, TIF_UPROBE_SINGLESTEP)) {
 		if (test_tsk_thread_flag(task, TIF_BLOCK_STEP))
 			new.control.val |= PER_EVENT_BRANCH;
@@ -119,18 +119,18 @@ void update_cr_regs(struct task_struct *task)
 void user_enable_single_step(struct task_struct *task)
 {
 	clear_tsk_thread_flag(task, TIF_BLOCK_STEP);
-	set_tsk_thread_flag(task, TIF_SINGLE_STEP);
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
 void user_disable_single_step(struct task_struct *task)
 {
 	clear_tsk_thread_flag(task, TIF_BLOCK_STEP);
-	clear_tsk_thread_flag(task, TIF_SINGLE_STEP);
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
 void user_enable_block_step(struct task_struct *task)
 {
-	set_tsk_thread_flag(task, TIF_SINGLE_STEP);
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
 	set_tsk_thread_flag(task, TIF_BLOCK_STEP);
 }
 
@@ -143,7 +143,7 @@ void ptrace_disable(struct task_struct *task)
 {
 	memset(&task->thread.per_user, 0, sizeof(task->thread.per_user));
 	memset(&task->thread.per_event, 0, sizeof(task->thread.per_event));
-	clear_tsk_thread_flag(task, TIF_SINGLE_STEP);
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 	clear_tsk_thread_flag(task, TIF_PER_TRAP);
 	task->thread.per_flags = 0;
 }
@@ -155,19 +155,19 @@ static inline unsigned long __peek_user_per(struct task_struct *child,
 {
 	if (addr == offsetof(struct per_struct_kernel, cr9))
 		/* Control bits of the active per set. */
-		return test_thread_flag(TIF_SINGLE_STEP) ?
+		return test_thread_flag(TIF_SINGLESTEP) ?
 			PER_EVENT_IFETCH : child->thread.per_user.control;
 	else if (addr == offsetof(struct per_struct_kernel, cr10))
 		/* Start address of the active per set. */
-		return test_thread_flag(TIF_SINGLE_STEP) ?
+		return test_thread_flag(TIF_SINGLESTEP) ?
 			0 : child->thread.per_user.start;
 	else if (addr == offsetof(struct per_struct_kernel, cr11))
 		/* End address of the active per set. */
-		return test_thread_flag(TIF_SINGLE_STEP) ?
+		return test_thread_flag(TIF_SINGLESTEP) ?
 			-1UL : child->thread.per_user.end;
 	else if (addr == offsetof(struct per_struct_kernel, bits))
 		/* Single-step bit. */
-		return test_thread_flag(TIF_SINGLE_STEP) ?
+		return test_thread_flag(TIF_SINGLESTEP) ?
 			(1UL << (BITS_PER_LONG - 1)) : 0;
 	else if (addr == offsetof(struct per_struct_kernel, starting_addr))
 		/* Start address of the user specified per set. */
diff --git a/arch/s390/kernel/signal.c b/arch/s390/kernel/signal.c
index 4874de5edea0..83f7650f2032 100644
--- a/arch/s390/kernel/signal.c
+++ b/arch/s390/kernel/signal.c
@@ -423,7 +423,7 @@ static void handle_signal(struct ksignal *ksig, sigset_t *oldset,
 	else
 		ret = setup_frame(ksig->sig, &ksig->ka, oldset, regs);
 
-	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLE_STEP));
+	signal_setup_done(ret, ksig, test_thread_flag(TIF_SINGLESTEP));
 }
 
 /*
@@ -491,7 +491,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 			regs->gprs[2] = regs->orig_gpr2;
 			current->restart_block.arch_data = regs->psw.addr;
 			regs->psw.addr = VDSO_SYMBOL(current, restart_syscall);
-			if (test_thread_flag(TIF_SINGLE_STEP))
+			if (test_thread_flag(TIF_SINGLESTEP))
 				clear_thread_flag(TIF_PER_TRAP);
 			break;
 		case -ERESTARTNOHAND:
@@ -499,7 +499,7 @@ void arch_do_signal_or_restart(struct pt_regs *regs)
 		case -ERESTARTNOINTR:
 			regs->gprs[2] = regs->orig_gpr2;
 			regs->psw.addr = __rewind_psw(regs->psw, regs->int_code >> 16);
-			if (test_thread_flag(TIF_SINGLE_STEP))
+			if (test_thread_flag(TIF_SINGLESTEP))
 				clear_thread_flag(TIF_PER_TRAP);
 			break;
 		}
-- 
2.34.1

