Received: from canpmsgout06.his.huawei.com (canpmsgout06.his.huawei.com [113.46.200.221])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1B88F39FCD1;
	Tue, 17 Mar 2026 08:20:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.221
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1773735632; cv=none; b=cd0Jq0M827SvNmc6Wb0WLpFX2ziRUZHBt+4Va4pQVRwjPvofnynIPXkHb3dcyr+c6z9Gs80nPQimR/JDEo6Zp2diZlGYtSUf/+i6qDb+aq9Eb2YK3aUrqvrdfzEw6EJLeTA6dEWc5uVeJad4ZjnIckgMhoQCdyWOLprzUVCo0vI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1773735632; c=relaxed/simple;
	bh=YKxmf/BhHq/A+Q52u2poJYCuMFCK4A8AvkUx6sYDEMc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Kami6HuvtHQcqd2zcvcW2tf2B5YID4kNfJes44sAcqMx552gNqwUpww8l+b+FvK1UDHuya5xYxdjcXUOM8gr12vnss++dyRvNc0n0iA2ijBZDqIETgLlILHpahDMtj3sq8/Fkizw1gAFYql1a+ctwjYb59mj6nW9sv8y7wtibIE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1cJ7cBxD; arc=none smtp.client-ip=113.46.200.221
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1cJ7cBxD"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=Eag8zPhD7u5fRza4jXSIatUtv9E7ORwKTXXdLDDUNHs=;
	b=1cJ7cBxD6pB9GrNpH5o9q9dR4XFfSvFxNaU4gsi3/u+ezynBjCqJYa+Ynw3qZtGRPjOnujOh7
	fX85D6iinj9qtvWWlUw7xrutFxCUAV/1ttij6BdeKIno2VGPTSTey7s3VO+6C51bvU5Bp/4uOmC
	6VuaMJxpnn4uxyWHGyGGxC4=
Received: from mail.maildlp.com (unknown [172.19.162.223])
	by canpmsgout06.his.huawei.com (SkyGuard) with ESMTPS id 4fZlBn4hn4zRhR0;
	Tue, 17 Mar 2026 16:15:29 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id BDDC940561;
	Tue, 17 Mar 2026 16:20:27 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Tue, 17 Mar
 2026 16:20:25 +0800
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
Subject: [PATCH v13 RESEND 12/14] asm-generic: Move TIF_SINGLESTEP to generic TIF bits
Date: Tue, 17 Mar 2026 16:20:18 +0800
Message-ID: <20260317082020.737779-13-ruanjinjie@huawei.com>
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

Currently, x86, ARM64, s390, and LoongArch all define and use
TIF_SINGLESTEP to track single-stepping state.

Since this flag is shared across multiple major architectures and serves
a common purpose in the generic entry/exit paths, move TIF_SINGLESTEP
into the generic Thread Information Flags (TIF) infrastructure.

This consolidation reduces architecture-specific boilerplate code and
ensures consistency for generic features that rely on single-step
state tracking.

Cc: Thomas Gleixner <tglx@kernel.org>
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

