Received: from canpmsgout03.his.huawei.com (canpmsgout03.his.huawei.com [113.46.200.218])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 35DB538C43E;
	Fri, 13 Mar 2026 09:47:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.218
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773395263; cv=none; b=IRUK/pX/fWyMx20Y6Y4WHfhso5N6Yern6nSOeXkBXxxC/BpwpMG9YzBFqUVNi3A8Fua7GVeBDhEGs7P0Ag2AQlw+oM1NhTpBOH9Ls2Z28mXRWYa/3PhchKO4q2HpiKGLTcUM6CqER/SHL9K24gntcECaUaVBfDiNp/3wMNBfyyA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773395263; c=relaxed/simple;
	bh=O5Ojmx0oqenL/elIkl6ipncQiOm8xiuSfSkDONPXsN4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gis1MIitBXu8vqyMCaoEKV7iNtQFBP04kYleksmR9AVUhOjcVaJEK+4e3evjsXXJN4I+mSLq/PJN/9vWKjQ2R3ZGhMrjS8PjLuioyixflcNrSR1mAz14secqsQ7OeLonNHKA90gfo1nq0qUG8d0YTYzvIPCCobrluM4xZfGJLJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Ohex99ig; arc=none smtp.client-ip=113.46.200.218
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Ohex99ig"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=0geB6zsxJkAjIbeBinLR3nVq7eK49hwAhw/yk6UZJHU=;
	b=Ohex99iggdtUUMN/JOX9GC6WjaC2sxkIM0+OgBIm/hQNfV0hZVc52C88Oz04M4SgQ5R5oTVI3
	r6J1MtJWUw4XZJIc+ZvSUBvDzg1A4KE0IFkLwnvaRqHNQI7gN+EjRbnQuyBWi6KA9aCReU3ib8d
	HS4CZY3fg5qWHi9Usy8sxws=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout03.his.huawei.com (SkyGuard) with ESMTPS id 4fXKJv2Xt0zpSw3;
	Fri, 13 Mar 2026 17:42:23 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 6648B40561;
	Fri, 13 Mar 2026 17:47:38 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 13 Mar
 2026 17:47:36 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>, <tglx@kernel.org>,
	<mingo@redhat.com>, <bp@alien8.de>, <dave.hansen@linux.intel.com>,
	<hpa@zytor.com>, <arnd@arndb.de>, <shuah@kernel.org>, <kees@kernel.org>,
	<luto@amacapital.net>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<charlie@rivosinc.com>, <macro@orcam.me.uk>, <deller@gmx.de>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <song@kernel.org>,
	<ryan.roberts@arm.com>, <mark.rutland@arm.com>, <ada.coupriediaz@arm.com>,
	<broonie@kernel.org>, <pengcan@kylinos.cn>, <liqiang01@kylinos.cn>,
	<thuth@redhat.com>, <andreas@gaisler.com>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<jgross@suse.com>, <mathieu.desnoyers@efficios.com>, <yeoreum.yun@arm.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <akpm@linux-foundation.org>,
	<reddybalavignesh9979@gmail.com>, <richard.weiyang@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <linux-s390@vger.kernel.org>,
	<linux-arch@vger.kernel.org>, <linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 11/12] arm64: Use generic TIF bits for common thread flags
Date: Fri, 13 Mar 2026 17:47:37 +0800
Message-ID: <20260313094738.3985794-12-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260313094738.3985794-1-ruanjinjie@huawei.com>
References: <20260313094738.3985794-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems200001.china.huawei.com (7.221.188.67) To
 dggpemf500011.china.huawei.com (7.185.36.131)

Use the generic TIF bits defined in <asm-generic/thread_info_tif.h> for
standard thread flags (TIF_SIGPENDING, TIF_NEED_RESCHED, TIF_NOTIFY_RESUME,
TIF_RESTORE_SIGMASK, TIF_SINGLESTEP, etc.) instead of defining
them locally.

Arm64-specific bits (TIF_FOREIGN_FPSTATE, TIF_MTE_ASYNC_FAULT, TIF_SVE,
TIF_SSBD, etc.) are renumbered to start at bit 16 to avoid conflicts.

This enables RSEQ optimizations which require CONFIG_HAVE_GENERIC_TIF_BITS
combined with the generic entry infrastructure (already used by arm64).

Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                    |  1 +
 arch/arm64/include/asm/thread_info.h  | 62 ++++++++++++---------------
 arch/s390/include/asm/thread_info.h   |  7 ++-
 arch/x86/include/asm/thread_info.h    |  6 +--
 include/asm-generic/thread_info_tif.h |  5 +++
 5 files changed, 38 insertions(+), 43 deletions(-)

diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
index 96fef01598be..33cf901fb1a0 100644
--- a/arch/arm64/Kconfig
+++ b/arch/arm64/Kconfig
@@ -224,6 +224,7 @@ config ARM64
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI
 	select HAVE_BUILDTIME_MCOUNT_SORT
 	select HAVE_EFFICIENT_UNALIGNED_ACCESS
+	select HAVE_GENERIC_TIF_BITS
 	select HAVE_GUP_FAST
 	select HAVE_FTRACE_GRAPH_FUNC
 	select HAVE_FUNCTION_TRACER
diff --git a/arch/arm64/include/asm/thread_info.h b/arch/arm64/include/asm/thread_info.h
index f89a15dc6ad5..be1a0651cfe2 100644
--- a/arch/arm64/include/asm/thread_info.h
+++ b/arch/arm64/include/asm/thread_info.h
@@ -58,42 +58,34 @@ void arch_setup_new_exec(void);
 
 #endif
 
-#define TIF_SIGPENDING		0	/* signal pending */
-#define TIF_NEED_RESCHED	1	/* rescheduling necessary */
-#define TIF_NEED_RESCHED_LAZY	2	/* Lazy rescheduling needed */
-#define TIF_NOTIFY_RESUME	3	/* callback before returning to user */
-#define TIF_FOREIGN_FPSTATE	4	/* CPU's FP state is not current's */
-#define TIF_UPROBE		5	/* uprobe breakpoint or singlestep */
-#define TIF_MTE_ASYNC_FAULT	6	/* MTE Asynchronous Tag Check Fault */
-#define TIF_NOTIFY_SIGNAL	7	/* signal notifications exist */
-#define TIF_PATCH_PENDING	13	/* pending live patching update */
-#define TIF_MEMDIE		18	/* is terminating due to OOM killer */
-#define TIF_FREEZE		19
-#define TIF_RESTORE_SIGMASK	20
-#define TIF_SINGLESTEP		21
-#define TIF_32BIT		22	/* 32bit process */
-#define TIF_SVE			23	/* Scalable Vector Extension in use */
-#define TIF_SVE_VL_INHERIT	24	/* Inherit SVE vl_onexec across exec */
-#define TIF_SSBD		25	/* Wants SSB mitigation */
-#define TIF_TAGGED_ADDR		26	/* Allow tagged user addresses */
-#define TIF_SME			27	/* SME in use */
-#define TIF_SME_VL_INHERIT	28	/* Inherit SME vl_onexec across exec */
-#define TIF_KERNEL_FPSTATE	29	/* Task is in a kernel mode FPSIMD section */
-#define TIF_TSC_SIGSEGV		30	/* SIGSEGV on counter-timer access */
-#define TIF_LAZY_MMU_PENDING	31	/* Ops pending for lazy mmu mode exit */
+/*
+ * Tell the generic TIF infrastructure which bits arm64 supports
+ */
+#define HAVE_TIF_NEED_RESCHED_LAZY
+#define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_SINGLESTEP
+
+#include <asm-generic/thread_info_tif.h>
+
+#define TIF_FOREIGN_FPSTATE	16	/* CPU's FP state is not current's */
+#define TIF_MTE_ASYNC_FAULT	17	/* MTE Asynchronous Tag Check Fault */
+#define TIF_FREEZE		18
+#define TIF_32BIT		19      /* 32bit process */
+#define TIF_SVE			20	/* Scalable Vector Extension in use */
+#define TIF_SVE_VL_INHERIT	21	/* Inherit SVE vl_onexec across exec */
+#define TIF_SSBD		22	/* Wants SSB mitigation */
+#define TIF_TAGGED_ADDR		23	/* Allow tagged user addresses */
+#define TIF_SME			24	/* SME in use */
+#define TIF_SME_VL_INHERIT	25	/* Inherit SME vl_onexec across exec */
+#define TIF_KERNEL_FPSTATE	26	/* Task is in a kernel mode FPSIMD section */
+#define TIF_TSC_SIGSEGV		27	/* SIGSEGV on counter-timer access */
+#define TIF_LAZY_MMU_PENDING	28	/* Ops pending for lazy mmu mode exit */
 
-#define _TIF_SIGPENDING		(1 << TIF_SIGPENDING)
-#define _TIF_NEED_RESCHED	(1 << TIF_NEED_RESCHED)
-#define _TIF_NEED_RESCHED_LAZY	(1 << TIF_NEED_RESCHED_LAZY)
-#define _TIF_NOTIFY_RESUME	(1 << TIF_NOTIFY_RESUME)
-#define _TIF_FOREIGN_FPSTATE	(1 << TIF_FOREIGN_FPSTATE)
-#define _TIF_PATCH_PENDING	(1 << TIF_PATCH_PENDING)
-#define _TIF_UPROBE		(1 << TIF_UPROBE)
-#define _TIF_32BIT		(1 << TIF_32BIT)
-#define _TIF_SVE		(1 << TIF_SVE)
-#define _TIF_MTE_ASYNC_FAULT	(1 << TIF_MTE_ASYNC_FAULT)
-#define _TIF_NOTIFY_SIGNAL	(1 << TIF_NOTIFY_SIGNAL)
-#define _TIF_TSC_SIGSEGV	(1 << TIF_TSC_SIGSEGV)
+#define _TIF_FOREIGN_FPSTATE	BIT(TIF_FOREIGN_FPSTATE)
+#define _TIF_32BIT		BIT(TIF_32BIT)
+#define _TIF_SVE		BIT(TIF_SVE)
+#define _TIF_MTE_ASYNC_FAULT	BIT(TIF_MTE_ASYNC_FAULT)
+#define _TIF_TSC_SIGSEGV	BIT(TIF_TSC_SIGSEGV)
 
 #ifdef CONFIG_SHADOW_CALL_STACK
 #define INIT_SCS							\
diff --git a/arch/s390/include/asm/thread_info.h b/arch/s390/include/asm/thread_info.h
index 1bcd42614e41..95be5258a422 100644
--- a/arch/s390/include/asm/thread_info.h
+++ b/arch/s390/include/asm/thread_info.h
@@ -61,6 +61,7 @@ void arch_setup_new_exec(void);
  */
 #define HAVE_TIF_NEED_RESCHED_LAZY
 #define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_SINGLESTEP
 
 #include <asm-generic/thread_info_tif.h>
 
@@ -69,15 +70,13 @@ void arch_setup_new_exec(void);
 #define TIF_GUARDED_STORAGE	17	/* load guarded storage control block */
 #define TIF_ISOLATE_BP_GUEST	18	/* Run KVM guests with isolated BP */
 #define TIF_PER_TRAP		19	/* Need to handle PER trap on exit to usermode */
-#define TIF_SINGLESTEP		21	/* This task is single stepped */
-#define TIF_BLOCK_STEP		22	/* This task is block stepped */
-#define TIF_UPROBE_SINGLESTEP	23	/* This task is uprobe single stepped */
+#define TIF_BLOCK_STEP		20	/* This task is block stepped */
+#define TIF_UPROBE_SINGLESTEP	21	/* This task is uprobe single stepped */
 
 #define _TIF_ASCE_PRIMARY	BIT(TIF_ASCE_PRIMARY)
 #define _TIF_GUARDED_STORAGE	BIT(TIF_GUARDED_STORAGE)
 #define _TIF_ISOLATE_BP_GUEST	BIT(TIF_ISOLATE_BP_GUEST)
 #define _TIF_PER_TRAP		BIT(TIF_PER_TRAP)
-#define _TIF_SINGLESTEP	BIT(TIF_SINGLESTEP)
 #define _TIF_BLOCK_STEP		BIT(TIF_BLOCK_STEP)
 #define _TIF_UPROBE_SINGLESTEP	BIT(TIF_UPROBE_SINGLESTEP)
 
diff --git a/arch/x86/include/asm/thread_info.h b/arch/x86/include/asm/thread_info.h
index 0067684afb5b..f59072ba1473 100644
--- a/arch/x86/include/asm/thread_info.h
+++ b/arch/x86/include/asm/thread_info.h
@@ -98,9 +98,8 @@ struct thread_info {
 #define TIF_IO_BITMAP		22	/* uses I/O bitmap */
 #define TIF_SPEC_FORCE_UPDATE	23	/* Force speculation MSR update in context switch */
 #define TIF_FORCED_TF		24	/* true if TF in eflags artificially */
-#define TIF_SINGLESTEP		25	/* reenable singlestep on user return*/
-#define TIF_BLOCKSTEP		26	/* set when we want DEBUGCTLMSR_BTF */
-#define TIF_ADDR32		27	/* 32-bit address space on 64 bits */
+#define TIF_BLOCKSTEP		25	/* set when we want DEBUGCTLMSR_BTF */
+#define TIF_ADDR32		26	/* 32-bit address space on 64 bits */
 
 #define _TIF_SSBD		BIT(TIF_SSBD)
 #define _TIF_SPEC_IB		BIT(TIF_SPEC_IB)
@@ -112,7 +111,6 @@ struct thread_info {
 #define _TIF_SPEC_FORCE_UPDATE	BIT(TIF_SPEC_FORCE_UPDATE)
 #define _TIF_FORCED_TF		BIT(TIF_FORCED_TF)
 #define _TIF_BLOCKSTEP		BIT(TIF_BLOCKSTEP)
-#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
 #define _TIF_ADDR32		BIT(TIF_ADDR32)
 
 /* flags to check in __switch_to() */
diff --git a/include/asm-generic/thread_info_tif.h b/include/asm-generic/thread_info_tif.h
index da1610a78f92..b277fe06aee3 100644
--- a/include/asm-generic/thread_info_tif.h
+++ b/include/asm-generic/thread_info_tif.h
@@ -48,4 +48,9 @@
 #define TIF_RSEQ		11	// Run RSEQ fast path
 #define _TIF_RSEQ		BIT(TIF_RSEQ)
 
+#ifdef HAVE_TIF_SINGLESTEP
+#define TIF_SINGLESTEP		12	/* reenable singlestep on user return*/
+#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
+#endif
+
 #endif /* _ASM_GENERIC_THREAD_INFO_TIF_H_ */
-- 
2.34.1

