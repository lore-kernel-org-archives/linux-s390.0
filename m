Received: from mail-pl1-f174.google.com (mail-pl1-f174.google.com [209.85.214.174])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F2E2730E83D
	for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 19:13:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.174
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739612; cv=none; b=UZf7emynB8aJvYXY7Ck2o7BJojjvh+QiQp1TyPocCg/GIOPEKuZjY0FXGS+9WqyUQsmJDlALSthTU0Q4JBcj4DRPJ4OruDrK7eQK+BlxnnlNoHFsD4+kWhSH+VLNYzP2Ie3u3avOQafi4HJar9sTPGDqkOcdx+/jlgmtrYkLtns=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739612; c=relaxed/simple;
	bh=xmG3/PRlSstyTQZDxMH8tbMZ6volASb8bJiStIxq6BM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZmI5ZqTIX7TugH0P0joIDyVzUYp9Z9kurQkUwQosv3vA392gAVPnl8BefojlPn9dpJhI0nHTNOeD+j9ECxj1ekAH9tjMwV2spfz/VqZI56+7pJloQeJIntSO/qmFcV2b73PMWRYLswOEBj1Zzt+IQJbijWEdMzRpQNk/m8t6UkY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=fh0qaiR+; arc=none smtp.client-ip=209.85.214.174
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fh0qaiR+"
Received: by mail-pl1-f174.google.com with SMTP id d9443c01a7336-29844c68068so34378555ad.2
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 11:13:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765739610; x=1766344410; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fl9yzitEzWMnip+yhMTSxm/r3KEx/d9qv1UD8LhQoS4=;
        b=fh0qaiR+kz2/v5NcTpdInCv1/a+7oZHeq9gdMEHGEFD7xfsRSU/HMYbxY/+pAVVpCq
         OUPB3JYA0JgVk7vnZ+LiT6+7ta4D5oDQdPSGGrZS2msDXsPgVyUvuHJ6XUMZLqUanZMD
         YS3psMQfMDMgKvmfHEdyFspRzvZpknYJ6DCI3Q7NV9hV4Va/tivWmLwNYj/Hzb3uoZ0i
         QQkZ5c+WN5Fv/pELXjY1YaHjoflYqRMWCURdnhwGoQhdngYYYVbrrbUx0uHwqsJLwmis
         aoW/+yP2jp3KY4G8Xo8vtP6D/ftOhdnI/t4w2kwvWMqSQbNonTIYO36KPjEOeBd5gV2p
         Koiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765739610; x=1766344410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fl9yzitEzWMnip+yhMTSxm/r3KEx/d9qv1UD8LhQoS4=;
        b=o14SVnnYA+HQid0L58JlHQPzXUJtlKW7sCYWm52jvF1nhnO6PomPwEbYPb08FyBoDs
         h9J1rry0M8EcRHbafPKfUWX2jgM0g4zWTZTbzqDk4CU5WXAzNpvcdNIlnE68pEgSKpvx
         Hm19yxB3NFJFGlqpgZq6jSG0HKHp5lnxBP1Awufajc18c8mWw2Y/xdAdGoz1389hmR+e
         Df7qZbJ+Mj/KK3aaifqTbu+nSPIXhGm23g1V/ZZ4jP/RVb9Mvy+rjBXNwihyYzMYbihq
         GlokHfYu/5xkeyC23xLMgJFxohLo50csjpfDfkJv5jY2aiR2Q69v1zM/eCZmQ3D9drEO
         G0AQ==
X-Forwarded-Encrypted: i=1; AJvYcCUADhukdeOaeRo7CJj63s5001P+2EqMn3+ZGE21BXSeCm/8a1iJJYAQIfDhFHkapwDEcqLwuUUpnSlU@vger.kernel.org
X-Gm-Message-State: AOJu0YzHQv9IXEokZd9sH+ZBOOtYabDyB3d+sbAWUQH56NEYZp1/kvhR
	hv3D7j3WIguNSGP7bCHkECTbmJRBdGbLuSuDtHCf9wOSbBgGXKTaor5l
X-Gm-Gg: AY/fxX5tBoSQsXqHS2HHFlKyIpVAYg/h/rHo8k0ixOPFlKcvP4kayraXbIZ3gDvJBND
	NgFpbUdOBHh6RtYdDQIcTOKwPplXYWN+Orv8NJI0BtxINws9BYLIUJh80vVB4Wd5xVRN2OZ69hY
	AQkZDgNRf6mIWU7iVbuWAAROZ0Q8vJbKMxT4d3684sHu20VTUTwVlr/bVF+nms7Mal1/rrIjNxJ
	3zF6wyd1bUnZ/asPucfc6iELJgs1RSuLbs1f30bmEO/P87LaPnKvQR2K0YGT+4caYrkkDzB24WB
	raMBge7le37yocrO5TaE7lHgDRdSxQNBqdPjvN0qwhvWVbTtg5c55xdEYM6TIFe708cKkDjvit0
	j8KIyCmp6tJR0UBoYyLR3WGBFXSBKXynN3zLv2ENw3gXWzaF6peuk/PCL0WB5LWX5sY71ZoaNsY
	O0dt0c73QuWhGXXFzCkEIFuUA0mCIu+9QhCN/rJ83pfA==
X-Google-Smtp-Source: AGHT+IFkPAgo+F+nh8G1sroML+5G+v23BEpyf+YWaLQCqZKpFQmfga1RZx5fSxm2YZQbILgHdSsDbg==
X-Received: by 2002:a17:902:ebd1:b0:298:3aa6:c03d with SMTP id d9443c01a7336-29f244cca9emr85496425ad.57.1765739610184;
        Sun, 14 Dec 2025 11:13:30 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c50974a7sm10524213b3a.53.2025.12.14.11.13.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 11:13:29 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@kernel.org,
	hpa@zytor.com,
	arnd@arndb.de,
	acme@kernel.org,
	adrian.hunter@intel.com,
	agordeev@linux.ibm.com,
	akpm@linux-foundation.org,
	alex@ghiti.fr,
	alexander.shishkin@linux.intel.com,
	andreas@gaisler.com,
	anshuman.khandual@arm.com,
	aou@eecs.berkeley.edu,
	borntraeger@linux.ibm.com,
	bp@alien8.de,
	bsegall@google.com,
	dave.hansen@linux.intel.com,
	davem@davemloft.net,
	dietmar.eggemann@arm.com,
	frederic@kernel.org,
	gor@linux.ibm.com,
	hca@linux.ibm.com,
	irogers@google.com,
	james.clark@linaro.org,
	jolsa@kernel.org,
	juri.lelli@redhat.com,
	justinstitt@google.com,
	lorenzo.stoakes@oracle.com,
	luto@kernel.org,
	mark.rutland@arm.com,
	mathieu.desnoyers@efficios.com,
	max.kellermann@ionos.com,
	mgorman@suse.de,
	mingo@redhat.com,
	morbo@google.com,
	namhyung@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	nysal@linux.ibm.com,
	palmer@dabbelt.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	rostedt@goodmis.org,
	ryan.roberts@arm.com,
	svens@linux.ibm.com,
	thuth@redhat.com,
	urezki@gmail.com,
	vincent.guittot@linaro.org,
	vschneid@redhat.com,
	linux@armlinux.org.uk
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH v5 3/3] sched/core: Make finish_task_switch() and its subfunctions always inline
Date: Mon, 15 Dec 2025 03:13:07 +0800
Message-ID: <20251214191307.184897-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251214190907.184793-1-qq570070308@gmail.com>
References: <20251214190907.184793-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finish_task_switch() is a hot code path in context switching.

Depending on the cpu's vulnerability and mitigation configuration, kernel
will likely perform mitigations in switch_mm_irqs_off() and switch_to(),
which may include branch prediction hardening, clearing the instruction
cache and L1D cache, etc.

finish_task_switch() is right after switch_mm_irqs_off() and switch_to(),
the performance here is greatly affected by function calls and branch
jumps.

Make finish_task_switch() always inline to optimize performance.

After finish_task_switch() is changed as always inline, the number of
calling points of subfunctions increases. According to the compiler
optimization strategy, subfunctions that were originally inline may no
longer be inline.

Also make the subfunctions of finish_task_stwitch() always inline to
prevent performance degradation.

Performance test data - time spent on calling finish_task_switch():
1. x86-64: Intel i5-8300h@4Ghz, DDR4@2666mhz; unit: x86's tsc
 | test scenario                     |    old |   new |           delta |
 | gcc 15.2                          |  27.50 | 25.45 |  -2.05 ( -7.5%) |
 | gcc 15.2     + spectre_v2_user=on |  46.75 | 25.96 | -20.79 (-44.5%) |
 | clang 21.1.7                      |  27.25 | 25.45 |  -1.80 ( -6.6%) |
 | clang 21.1.7 + spectre_v2_user=on |  39.50 | 26.00 | -13.50 (-34.2%) |

2. x86-64: AMD 9600x@5.45Ghz, DDR5@4800mhz; unit: x86's tsc
 | test scenario                     |    old |   new |           delta |
 | gcc 15.2                          |  27.51 | 27.51 |      0 (    0%) |
 | gcc 15.2     + spectre_v2_user=on | 105.21 | 67.89 | -37.32 (-35.5%) |
 | clang 21.1.7                      |  27.51 | 27.51 |      0 (    0%) |
 | clang 21.1.7 + spectre_v2_user=on | 104.15 | 67.52 | -36.63 (-35.2%) |

3. arm64: Raspberry Pi 3b Rev 1.2, Cortex-A53@1.2Ghz; unit: cntvct_el0
 | test scenario                     |    old |   new |           delta |
 | gcc 15.2                          |  1.453 | 1.115 | -0.338 (-23.3%) |
 | clang 21.1.7                      |  1.532 | 1.123 | -0.409 (-26.7%) |

4. arm32: Raspberry Pi 3b Rev 1.2, Cortex-A53@1.2Ghz; unit: cntvct_el0
 | test scenario                     |    old |   new |           delta |
 | gcc 15.2                          |  1.421 | 1.187 | -0.234 (-16.5%) |
 | clang 21.1.7                      |  1.437 | 1.200 | -0.237 (-16.5%) |

Size test data:
1. bzImage size:
 | test scenario             | old      | new      | delta |
 | gcc 15.2     + -Os        | 12604416 | 12604416 |     0 |
 | gcc 15.2     + -O2        | 14500864 | 14500864 |     0 |
 | clang 21.1.7 + -Os        | 13718528 | 13718528 |     0 |
 | clang 21.1.7 + -O2        | 14558208 | 14566400 |  8192 |

2. sizeof .text section from vmlinx:
 | test scenario             | old      | new      | delta |
 | gcc 15.2     + -Os        | 16180040 | 16180616 |   576 |
 | gcc 15.2     + -O2        | 19556424 | 19561352 |  4928 |
 | clang 21.1.7 + -Os        | 17917832 | 17918664 |   832 |
 | clang 21.1.7 + -O2        | 20030856 | 20035784 |  4928 |

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
The detailed information of the test can be found in the cover letter:
Link: https://lore.kernel.org/20251214190907.184793-1-qq570070308@gmail.com

 arch/arm/include/asm/mmu_context.h      |  2 +-
 arch/riscv/include/asm/sync_core.h      |  2 +-
 arch/s390/include/asm/mmu_context.h     |  2 +-
 arch/sparc/include/asm/mmu_context_64.h |  2 +-
 arch/x86/include/asm/sync_core.h        |  2 +-
 include/linux/perf_event.h              |  2 +-
 include/linux/sched/mm.h                | 10 +++++-----
 include/linux/tick.h                    |  4 ++--
 include/linux/vtime.h                   |  8 ++++----
 kernel/sched/core.c                     | 14 +++++++-------
 kernel/sched/sched.h                    | 20 ++++++++++----------
 11 files changed, 34 insertions(+), 34 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index db2cb06aa8cf..bebde469f81a 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -80,7 +80,7 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 #ifndef MODULE
 #define finish_arch_post_lock_switch \
 	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch(void)
 {
 	struct mm_struct *mm = current->mm;
 
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
index 9153016da8f1..2fe6b7fe6b12 100644
--- a/arch/riscv/include/asm/sync_core.h
+++ b/arch/riscv/include/asm/sync_core.h
@@ -6,7 +6,7 @@
  * RISC-V implements return to user-space through an xRET instruction,
  * which is not core serializing.
  */
-static inline void sync_core_before_usermode(void)
+static __always_inline void sync_core_before_usermode(void)
 {
 	asm volatile ("fence.i" ::: "memory");
 }
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d9b8501bc93d..c124ef6a01b3 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -97,7 +97,7 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch(void)
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 78bbacc14d2d..d1967214ef25 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -160,7 +160,7 @@ static inline void arch_start_context_switch(struct task_struct *prev)
 }
 
 #define finish_arch_post_lock_switch	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch(void)
 {
 	/* Restore the state of MCDPER register for the new process
 	 * just switched to.
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..4b55fa353bb5 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -93,7 +93,7 @@ static __always_inline void sync_core(void)
  * to user-mode. x86 implements return to user-space through sysexit,
  * sysrel, and sysretq, which are not core serializing.
  */
-static inline void sync_core_before_usermode(void)
+static __always_inline void sync_core_before_usermode(void)
 {
 	/* With PTI, we unconditionally serialize before running user code. */
 	if (static_cpu_has(X86_FEATURE_PTI))
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index 9870d768db4c..d9de20c20f38 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1624,7 +1624,7 @@ static inline void perf_event_task_migrate(struct task_struct *task)
 		task->sched_migrated = 1;
 }
 
-static inline void perf_event_task_sched_in(struct task_struct *prev,
+static __always_inline void perf_event_task_sched_in(struct task_struct *prev,
 					    struct task_struct *task)
 {
 	if (static_branch_unlikely(&perf_sched_events))
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0e1d73955fa5..e7787a6e7d22 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -44,7 +44,7 @@ static inline void smp_mb__after_mmgrab(void)
 
 extern void __mmdrop(struct mm_struct *mm);
 
-static inline void mmdrop(struct mm_struct *mm)
+static __always_inline void mmdrop(struct mm_struct *mm)
 {
 	/*
 	 * The implicit full barrier implied by atomic_dec_and_test() is
@@ -71,14 +71,14 @@ static inline void __mmdrop_delayed(struct rcu_head *rhp)
  * Invoked from finish_task_switch(). Delegates the heavy lifting on RT
  * kernels via RCU.
  */
-static inline void mmdrop_sched(struct mm_struct *mm)
+static __always_inline void mmdrop_sched(struct mm_struct *mm)
 {
 	/* Provides a full memory barrier. See mmdrop() */
 	if (atomic_dec_and_test(&mm->mm_count))
 		call_rcu(&mm->delayed_drop, __mmdrop_delayed);
 }
 #else
-static inline void mmdrop_sched(struct mm_struct *mm)
+static __always_inline void mmdrop_sched(struct mm_struct *mm)
 {
 	mmdrop(mm);
 }
@@ -104,7 +104,7 @@ static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 	}
 }
 
-static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
+static __always_inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
 {
 	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop_sched(mm);
@@ -531,7 +531,7 @@ enum {
 #include <asm/membarrier.h>
 #endif
 
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
+static __always_inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 	/*
 	 * The atomic_read() below prevents CSE. The following should
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..fce16aa10ba2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -175,7 +175,7 @@ extern cpumask_var_t tick_nohz_full_mask;
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
 
-static inline bool tick_nohz_full_enabled(void)
+static __always_inline bool tick_nohz_full_enabled(void)
 {
 	if (!context_tracking_enabled())
 		return false;
@@ -299,7 +299,7 @@ static inline void __tick_nohz_task_switch(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 #endif
 
-static inline void tick_nohz_task_switch(void)
+static __always_inline void tick_nohz_task_switch(void)
 {
 	if (tick_nohz_full_enabled())
 		__tick_nohz_task_switch();
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 29dd5b91dd7d..428464bb81b3 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -67,24 +67,24 @@ static __always_inline void vtime_account_guest_exit(void)
  * For now vtime state is tied to context tracking. We might want to decouple
  * those later if necessary.
  */
-static inline bool vtime_accounting_enabled(void)
+static __always_inline bool vtime_accounting_enabled(void)
 {
 	return context_tracking_enabled();
 }
 
-static inline bool vtime_accounting_enabled_cpu(int cpu)
+static __always_inline bool vtime_accounting_enabled_cpu(int cpu)
 {
 	return context_tracking_enabled_cpu(cpu);
 }
 
-static inline bool vtime_accounting_enabled_this_cpu(void)
+static __always_inline bool vtime_accounting_enabled_this_cpu(void)
 {
 	return context_tracking_enabled_this_cpu();
 }
 
 extern void vtime_task_switch_generic(struct task_struct *prev);
 
-static inline void vtime_task_switch(struct task_struct *prev)
+static __always_inline void vtime_task_switch(struct task_struct *prev)
 {
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_task_switch_generic(prev);
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 20146da3f181..9f3e8fe0c5b8 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4864,7 +4864,7 @@ static inline void prepare_task(struct task_struct *next)
 	WRITE_ONCE(next->on_cpu, 1);
 }
 
-static inline void finish_task(struct task_struct *prev)
+static __always_inline void finish_task(struct task_struct *prev)
 {
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
@@ -4880,7 +4880,7 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
-static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
+static __always_inline void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
 	struct balance_callback *next;
@@ -4915,7 +4915,7 @@ struct balance_callback balance_push_callback = {
 	.func = balance_push,
 };
 
-static inline struct balance_callback *
+static __always_inline struct balance_callback *
 __splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct balance_callback *head = rq->balance_callback;
@@ -4945,7 +4945,7 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+static __always_inline void __balance_callbacks(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
@@ -4978,7 +4978,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static __always_inline void finish_lock_switch(struct rq *rq)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5010,7 +5010,7 @@ static inline void kmap_local_sched_out(void)
 #endif
 }
 
-static inline void kmap_local_sched_in(void)
+static __always_inline void kmap_local_sched_in(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
@@ -5063,7 +5063,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index bef6cb13266d..4ba122a15fb2 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1381,12 +1381,12 @@ static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
 DECLARE_STATIC_KEY_FALSE(__sched_core_enabled);
 
-static inline bool sched_core_enabled(struct rq *rq)
+static __always_inline bool sched_core_enabled(struct rq *rq)
 {
 	return static_branch_unlikely(&__sched_core_enabled) && rq->core_enabled;
 }
 
-static inline bool sched_core_disabled(void)
+static __always_inline bool sched_core_disabled(void)
 {
 	return !static_branch_unlikely(&__sched_core_enabled);
 }
@@ -1395,7 +1395,7 @@ static inline bool sched_core_disabled(void)
  * Be careful with this function; not for general use. The return value isn't
  * stable unless you actually hold a relevant rq->__lock.
  */
-static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	if (sched_core_enabled(rq))
 		return &rq->core->__lock;
@@ -1403,7 +1403,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 {
 	if (rq->core_enabled)
 		return &rq->core->__lock;
@@ -1497,12 +1497,12 @@ static inline bool sched_core_disabled(void)
 	return true;
 }
 
-static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
 }
 
-static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 {
 	return &rq->__lock;
 }
@@ -1552,23 +1552,23 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
 extern void raw_spin_rq_lock_nested(struct rq *rq, int subclass);
 extern bool raw_spin_rq_trylock(struct rq *rq);
 
-static inline void raw_spin_rq_lock(struct rq *rq)
+static __always_inline void raw_spin_rq_lock(struct rq *rq)
 {
 	raw_spin_rq_lock_nested(rq, 0);
 }
 
-static inline void raw_spin_rq_unlock(struct rq *rq)
+static __always_inline void raw_spin_rq_unlock(struct rq *rq)
 {
 	raw_spin_unlock(rq_lockp(rq));
 }
 
-static inline void raw_spin_rq_lock_irq(struct rq *rq)
+static __always_inline void raw_spin_rq_lock_irq(struct rq *rq)
 {
 	local_irq_disable();
 	raw_spin_rq_lock(rq);
 }
 
-static inline void raw_spin_rq_unlock_irq(struct rq *rq)
+static __always_inline void raw_spin_rq_unlock_irq(struct rq *rq)
 {
 	raw_spin_rq_unlock(rq);
 	local_irq_enable();
-- 
2.51.0

