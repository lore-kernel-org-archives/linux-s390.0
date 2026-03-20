Received: from canpmsgout04.his.huawei.com (canpmsgout04.his.huawei.com [113.46.200.219])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1165396B82;
	Fri, 20 Mar 2026 10:41:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.219
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1774003279; cv=none; b=Ro3axsQybtJt0fq/S0VG4ln7kSzJolXq/Z3awyjAPJ5FrQZQM4ejWg2CyuEZXxBX8Lit/kVlLBqzoUMgBxtfmM7/7egKJOP92IaRHJLhJlmkAmwOaYcDavpOCC+bEq4sgFkFJTZFgxQvWZt+det7kDdXb47gRTDzOY2luKNwSG8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1774003279; c=relaxed/simple;
	bh=uqtoHEnKrMD9AOu+mT4dlXzcrCRXLOUQPqRC1csUNWg=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPKTUHWIVxbDIOTqndqi8K2i0wwM3x82t7L+eMLySSsCA19jfJl28TisgwZPokkjZ3KKoMpZFo+zWxZSMShH6uNBlamOzGa6lUqLEu28v40caYMzG9PjZlrH4JuUn8NXd+TyENb9EFNK+udF3TzX6AejC59yydUe/aULY75pq38=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=uMw8JNjJ; arc=none smtp.client-ip=113.46.200.219
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="uMw8JNjJ"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=RlEOjT/JGfRsNSEE+lFWaeBcRGitlwJLE3NLIWJLUhs=;
	b=uMw8JNjJm65egx8filgcNYg+xKS4KD2QlOiXufHgPtmQQNWs5nElNcRPJeDAQVRhk1bMjzXuB
	a55fTFogezyM4v2x6cA/PsKiAVNz7sVdOjDJOK3nA3hE5c3p1iPUba8osxw9Vri65Hu/XjBkfXQ
	253FJOp1+Iru6/z1DHnHERU=
Received: from mail.maildlp.com (unknown [172.19.163.104])
	by canpmsgout04.his.huawei.com (SkyGuard) with ESMTPS id 4fcf9l1hTJz1prLS;
	Fri, 20 Mar 2026 18:36:11 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 471C3404AD;
	Fri, 20 Mar 2026 18:41:14 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Fri, 20 Mar
 2026 18:41:12 +0800
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
Subject: [PATCH v14 2/4] asm-generic: Move TIF_SINGLESTEP to generic TIF bits
Date: Fri, 20 Mar 2026 18:42:20 +0800
Message-ID: <20260320104222.1381274-3-ruanjinjie@huawei.com>
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

Currently, x86, ARM64, s390, and LoongArch all define and use
TIF_SINGLESTEP to track single-stepping state.

Since this flag is shared across multiple major architectures and serves
a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
into the generic Thread Information Flags (TIF) infrastructure.

This consolidation reduces architecture-specific boilerplate code and
ensures consistency for generic features that rely on single-step
state tracking.

Cc: Thomas Gleixner <tglx@kernel.org>
Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
Reviewed-by: Linus Walleij <linusw@kernel.org>
Reviewed-by: Yeoreum Yun <yeoreum.yun@arm.com>
Acked-by: Heiko Carstens <hca@linux.ibm.com> # s390
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/loongarch/include/asm/thread_info.h | 11 +++++------
 arch/s390/include/asm/thread_info.h      |  7 +++----
 arch/x86/include/asm/thread_info.h       |  6 ++----
 include/asm-generic/thread_info_tif.h    |  5 +++++
 4 files changed, 15 insertions(+), 14 deletions(-)

diff --git a/arch/loongarch/include/asm/thread_info.h b/arch/loongarch/include/asm/thread_info.h
index 4d7117fcdc78..a2ec87f18e1d 100644
--- a/arch/loongarch/include/asm/thread_info.h
+++ b/arch/loongarch/include/asm/thread_info.h
@@ -70,6 +70,7 @@ register unsigned long current_stack_pointer __asm__("$sp");
  */
 #define HAVE_TIF_NEED_RESCHED_LAZY
 #define HAVE_TIF_RESTORE_SIGMASK
+#define HAVE_TIF_SINGLESTEP
 
 #include <asm-generic/thread_info_tif.h>
 
@@ -82,11 +83,10 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define TIF_32BIT_REGS		21	/* 32-bit general purpose registers */
 #define TIF_32BIT_ADDR		22	/* 32-bit address space */
 #define TIF_LOAD_WATCH		23	/* If set, load watch registers */
-#define TIF_SINGLESTEP		24	/* Single Step */
-#define TIF_LSX_CTX_LIVE	25	/* LSX context must be preserved */
-#define TIF_LASX_CTX_LIVE	26	/* LASX context must be preserved */
-#define TIF_USEDLBT		27	/* LBT was used by this task this quantum (SMP) */
-#define TIF_LBT_CTX_LIVE	28	/* LBT context must be preserved */
+#define TIF_LSX_CTX_LIVE	24	/* LSX context must be preserved */
+#define TIF_LASX_CTX_LIVE	25	/* LASX context must be preserved */
+#define TIF_USEDLBT		26	/* LBT was used by this task this quantum (SMP) */
+#define TIF_LBT_CTX_LIVE	27	/* LBT context must be preserved */
 
 #define _TIF_NOHZ		BIT(TIF_NOHZ)
 #define _TIF_USEDFPU		BIT(TIF_USEDFPU)
@@ -96,7 +96,6 @@ register unsigned long current_stack_pointer __asm__("$sp");
 #define _TIF_32BIT_REGS		BIT(TIF_32BIT_REGS)
 #define _TIF_32BIT_ADDR		BIT(TIF_32BIT_ADDR)
 #define _TIF_LOAD_WATCH		BIT(TIF_LOAD_WATCH)
-#define _TIF_SINGLESTEP		BIT(TIF_SINGLESTEP)
 #define _TIF_LSX_CTX_LIVE	BIT(TIF_LSX_CTX_LIVE)
 #define _TIF_LASX_CTX_LIVE	BIT(TIF_LASX_CTX_LIVE)
 #define _TIF_USEDLBT		BIT(TIF_USEDLBT)
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

