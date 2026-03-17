Received: from canpmsgout05.his.huawei.com (canpmsgout05.his.huawei.com [113.46.200.220])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AFF6339B4AF;
	Tue, 17 Mar 2026 08:20:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.220
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735634; cv=none; b=cupx/3O5n4jURw6AcShZETtTUa7YzLKj5A1VPHrKseNU/4Tx0L+WUNZpwrdwp82AsGgfdFl8S25YaaqMX/WLiUN+1I5gzSYQip/87mZhkJ2Vvq8cAT0EI3q0cn1Jl91lUQ14bXjhj/cc91L6q4lpD0MK5cOtxUA6V3GQD74xtsE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735634; c=relaxed/simple;
	bh=UzNbDGUxcKA8PuhXpQkc6W7n7W9+fTQz5Y9zZZ+FFBU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n9JGaDtb91sZqCQ4/K/w5WGEfqS+JP1FekUhUR6WrEX1NYUle83/JUVwKj+haHZprbKKO2/1TClR53uZAY88kc+YRMPSWCwdlgFEmOffzc93OO4NpMeRLKsNfO/LCgDeUpN4AT3JkBWqlLkE+zsjqY5AELmOCrUwnI7JxSphVRU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=Co1lrTUX; arc=none smtp.client-ip=113.46.200.220
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="Co1lrTUX"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=6w/TL5zFKdLh+z9CiffKOn6a7V3L6FA9QT+X+Y2EYv4=;
	b=Co1lrTUX1JpdRmCCXrf3zdhsaZQXUE3ZS/y6GOHVMAXF9NOiHY3MGwbnra+sro8pRz4yEbMyD
	a7tuOt58iacPHHEmyBI6M10XwEAmHnypl5XY7bfpEbOs6kVh5p7rr+JvSgADOi0kQiEMjlyAWVg
	aq+gf6GaZ6qOxCO1HkMRwTM=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout05.his.huawei.com (SkyGuard) with ESMTPS id 4fZlBB06bMz12LdJ;
	Tue, 17 Mar 2026 16:14:58 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 042F540561;
	Tue, 17 Mar 2026 16:20:30 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:27 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <catalin.marinas@arm.com>, <will@kernel.org>, <oleg@redhat.com>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <hca@linux.ibm.com>,
	<gor@linux.ibm.com>, <agordeev@linux.ibm.com>, <borntraeger@linux.ibm.com>,
	<svens@linux.ibm.com>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <arnd@arndb.de>,
	<peterz@infradead.org>, <luto@kernel.org>, <shuah@kernel.org>,
	<kees@kernel.org>, <wad@chromium.org>, <kevin.brodsky@arm.com>,
	<deller@gmx.de>, <macro@orcam.me.uk>, <akpm@linux-foundation.org>,
	<ldv@strace.io>, <anshuman.khandual@arm.com>, <ryan.roberts@arm.com>,
	<mark.rutland@arm.com>, <thuth@redhat.com>, <song@kernel.org>,
	<ada.coupriediaz@arm.com>, <linusw@kernel.org>, <broonie@kernel.org>,
	<pengcan@kylinos.cn>, <liqiang01@kylinos.cn>, <ziyao@disroot.org>,
	<guanwentao@uniontech.com>, <guoren@kernel.org>,
	<schuster.simon@siemens-energy.com>, <jremus@linux.ibm.com>,
	<david@kernel.org>, <mathieu.desnoyers@efficios.com>, <edumazet@google.com>,
	<kmal@cock.li>, <dvyukov@google.com>, <reddybalavignesh9979@gmail.com>,
	<x86@kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-kernel@vger.kernel.org>, <loongarch@lists.linux.dev>,
	<linux-s390@vger.kernel.org>, <linux-arch@vger.kernel.org>,
	<linux-kselftest@vger.kernel.org>
CC: <ruanjinjie@huawei.com>
Subject: [PATCH v13 RESEND 13/14] arm64: Use generic TIF bits for common thread flags
Date: Tue, 17 Mar 2026 16:20:19 +0800
Message-ID: <20260317082020.737779-14-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260317082020.737779-1-ruanjinjie@huawei.com>
References: <20260317082020.737779-1-ruanjinjie@huawei.com>
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

Cc: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/arm64/Kconfig                   |  1 +
 arch/arm64/include/asm/thread_info.h | 62 ++++++++++++----------------
 2 files changed, 28 insertions(+), 35 deletions(-)

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
-- 
2.34.1

