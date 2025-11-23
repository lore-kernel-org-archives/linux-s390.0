Received: from mail-pf1-f178.google.com (mail-pf1-f178.google.com [209.85.210.178])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6D30E227BA4
	for <linux-s390@vger.kernel.org>; Sun, 23 Nov 2025 12:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.178
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763900524; cv=none; b=LpbWhJNa8LrsJNTNldfJFS9K0onZT70WF05fXRHX1nYqdL8XTEZbVnIVrm65rNhm3oHZ/GtLKjMuekHD9YK1GfOviFCu8PldZlsMwADazIMdlljnkFGARqA6C4UUn/QXZafMwfouxp4Kz94+BtW7q3RaxMZ36oUrfDWA7ugn4ng=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763900524; c=relaxed/simple;
	bh=k1f/jUkDoITnqLerveGgqMfTU+v9sz+NID8eKECNkAo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Q81lMHSQkVGugL2sh7HZmWIROVNSPvXEargOvFbS1btlYz4kNs0D3kUaxeEoymoaCUC1n0LSMqNPLyegY0UuivILWaTaIx3TiuWWi+MWFap4r97lRn81YxElFcm82Nnx1lNDZkL6NNpr8pWdAp6q9//zvYxfWRfDeGWl+IPT1lU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=GL/c6ESY; arc=none smtp.client-ip=209.85.210.178
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="GL/c6ESY"
Received: by mail-pf1-f178.google.com with SMTP id d2e1a72fcca58-7bb710d1d1dso5274385b3a.1
        for <linux-s390@vger.kernel.org>; Sun, 23 Nov 2025 04:22:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763900521; x=1764505321; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rB4uv8kGHrYdQ+qu/Ya46ZVR53dC3l9vjdLUEI9k7FQ=;
        b=GL/c6ESYFtSpYl2L8NVghRtTwoenT4qeCKvqGpM6+xLmS8CP7Qom4zo1J4xYi4jsqz
         B36WDOccQiDoQCd8INTJoPvu9unRtO4IL9zqHTzukyLRXA0B4vcem/lhQPxG38Am7YaB
         SwJ7O9j7sGQiSC1Ib80a4fs9jnFHNN98j9dIX/J8yRDwJXLwm8WKyDN0d2bvDX/CQMKs
         xYmeO+NkNYoONcV+7SLUQzS3oeRM37aRu4UpHgAA2L0dC+TQ6JxsN+XMSnMHkc1cNXUN
         bpGPGeKRhSVuI71W08BOGl2WESds6twkUrX2KRbiYgnbL4Blm5F9d+57lGNvnPYu2LvW
         sPTg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763900521; x=1764505321;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rB4uv8kGHrYdQ+qu/Ya46ZVR53dC3l9vjdLUEI9k7FQ=;
        b=T7k6gRR2qsJcHTF62FwUE6s4u3Go2j+zxWFzBewoFXDHsOQpqoyT7TENdwgbB3jAHE
         llCO1bBPj1D+5VtdiyKQEAVPEArl3WwxH4GbatXjErdiq+/eAhJT2BqtK/e+oVEbqJKj
         lHyLPEgZbZFZozkfuEUgu4k1XfrirfecpDXg+ZBree5AM2uigZ17Py6kma6uiMXuuOPl
         +i04o+LtAn7I3cbGGKx5zLxpqOpGF10IVLVAXX+vXgY6myIq3d3yCGL5JIFPxrTajAIy
         5/Ge7BAfP6nPP1bPm+PxMHTdqHZtJPtMeG/Ya6ETWto3T3gfXEmdTzshQMaMJSpZA1yH
         DB0g==
X-Forwarded-Encrypted: i=1; AJvYcCW5fNZtmJwMxHlUFvCTISR/9c7tqsWZ3xViIXhLNP32BFzWj+CGWHIp9OLEerVWO5X3AdiS26meS1oz@vger.kernel.org
X-Gm-Message-State: AOJu0Yx+oBHE7Shisp+lo7NV3vLI0ZNXyliWGhKs9gaDQo2G2SxwlSCL
	icTrg3xM2Qm4hNTrEL9VI6iWKUZ56ge3lMxMjMsxbqzUqLeQyXq39ju9
X-Gm-Gg: ASbGncsPUuxc7aaxqGrkv3kPGlw+YcPr18Rvv50la4ssD9+NEozTfuTjSBoXWFpD5Hh
	+0yWQAkJjP8cq9nudy/O0+Y4/z4Uarld99FxZ+Pv8cU83lg+u6zlf/ByiEUps0r7aKzcBlQBsAY
	9mYPSzlVX+ejzr63c4Br5svdBTaWLedbBz7z5Poqak4gxy+G2j1iMXwws0RLGzix/A9r2R38Gax
	/7+0wI+vhiUK4xibsr2SewGTAWT1QAsjTbkDf/D1EN9hkcKhtdxmpVCa/fBqhxD/YF5ddpsDmEs
	/zcw9gj86u5nf4rDmJ/3xNH5gITs8na8SsL06ORuxc36SNsYxz5YX0uo/hl+A373b9Ve7PWS6nC
	R0YIvoF9AxIzMB5A385xo6XwkhspJOdSrhYYca/opY8Ngl5/kx6wJBUB1boa8pTkSj/z+9JVUdZ
	X4iCoIT00CJO+hahTMwZ+QA0i3lFUabzBqP/OhMGzwJYCE/81l
X-Google-Smtp-Source: AGHT+IGQG35NYvN7K5sssKQSBcqyisoVwQMWJ1B/AAA9uaABXDE+fiVx1k3aI58ekzaclz7KCP6OAg==
X-Received: by 2002:a05:6a00:2384:b0:7ac:1444:6777 with SMTP id d2e1a72fcca58-7c58c89d553mr8910922b3a.12.1763900520454;
        Sun, 23 Nov 2025 04:22:00 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([45.121.215.197])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7c3f0b63aefsm11410178b3a.52.2025.11.23.04.21.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 23 Nov 2025 04:21:59 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	peterz@infradead.org,
	david@kernel.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
	hpa@zytor.com,
	arnd@arndb.de,
	mingo@redhat.com,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	luto@kernel.org,
	linux@armlinux.org.uk,
	mathieu.desnoyers@efficios.com,
	paulmck@kernel.org,
	pjw@kernel.org,
	palmer@dabbelt.com,
	aou@eecs.berkeley.edu,
	alex@ghiti.fr,
	hca@linux.ibm.com,
	gor@linux.ibm.com,
	agordeev@linux.ibm.com,
	borntraeger@linux.ibm.com,
	svens@linux.ibm.com,
	davem@davemloft.net,
	andreas@gaisler.com,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	james.clark@linaro.org,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	thuth@redhat.com,
	akpm@linux-foundation.org,
	lorenzo.stoakes@oracle.com,
	anshuman.khandual@arm.com,
	nysal@linux.ibm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	ryan.roberts@arm.com
Cc: linux-kernel@vger.kernel.org,
	x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	Xie Yuanbin <qq570070308@gmail.com>
Subject: [PATCH v4 3/3] sched/core: Make finish_task_switch() and its subfunctions always inline
Date: Sun, 23 Nov 2025 20:18:27 +0800
Message-ID: <20251123121827.1304-4-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251123121827.1304-1-qq570070308@gmail.com>
References: <20251123121827.1304-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

finish_task_switch() is a hot code path in context switching.
When spectre_v2_user is enabled, kernel is likely to perform branch
prediction hardening inside switch_mm_irqs_off(). finish_task_switch()
is right after switch_mm_irqs_off(), so the performance here is
greatly affected by function calls and branch jumps.

Make finish_task_switch() always inline to optimize performance.

After finish_task_switch() is changed as always inline, the number of
calling points of subfunctions increases. According to the compiler
optimization strategy, subfunctions that were originally inline may no
longer be inline.

Also make the subfunctions of finish_task_stwitch() always inline to
prevent performance degradation.

There is a improvement in the performace of finish_task_switch(). When
spectre v2 is enabled, the improvement is significant.

The following are testing results from intel i5-8300h@4Ghz (x86):
Time spent on calling finish_task_switch(), the unit is tsc from x86:
 | test scenario             | old   | new   | delta          |
 | gcc 15.2                  | 13.94 | 12.40 | 1.54  (-11.1%) |
 | gcc 15.2 + spectre_v2     | 24.78 | 13.70 | 11.08 (-44.7%) |
 | clang 21.1.4              | 13.90 | 12.71 | 1.19  (- 8.6%) |
 | clang 21.1.4 + spectre_v2 | 29.01 | 18.91 | 10.1  (-34.8%) |

There is a minor improvement in the size of .text section in vmlinux,
the unit is bytes:
 | test scenario             | old      | new      | delta |
 | gcc 15.2                  | 16208096 | 16208736 | 640   |
 | clang 21.1.4              | 17943328 | 17944224 | 896   |

No size changes were found on bzImage.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand (Red Hat) <david@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
Cc: Arnd Bergmann <arnd@arndb.de>
---
Additional information:
1. The default spectre_v2 mitigation strategy on x86 is conditional, it
can be set to always by appending "spectre_v2_user=on" to cmdline.
However, on arm64/arm32, spectre v2 mitigation is enabled by default, and
it should be disabled by adding "nospectre_v2" to the cmdline.

2. The testing kernel source is commit 9c0826a5d9aa4d52206d ("Add
linux-next specific files for 20251107") from linux-next branch.

3. When testing for performace, I use the default x86_64_defconfig,
and setting:
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_CGROUPS=n
CONFIG_BLK_DEV_NVME=y
When testing for size, I use the default x86_64_defconfig,
and setting:
CONFIG_SCHED_CORE=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_NO_HZ_FULL=y

4. It is recommended that using multiple processes rather than threads to
do the test, because this will trigger switch_mm_irqs_off(), where
spectre_v2 mitigations may be performed, during context switching.

5. The test code can be found at the end of the cover letter:
Link: https://lore.kernel.org/20251123121827.1304-1-qq570070308@gmail.com

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
index 0f9e9f54d0a8..e4ede8f7e0e3 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4865,7 +4865,7 @@ static inline void prepare_task(struct task_struct *next)
 	WRITE_ONCE(next->on_cpu, 1);
 }
 
-static inline void finish_task(struct task_struct *prev)
+static __always_inline void finish_task(struct task_struct *prev)
 {
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
@@ -4881,7 +4881,7 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
-static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
+static __always_inline void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
 	struct balance_callback *next;
@@ -4916,7 +4916,7 @@ struct balance_callback balance_push_callback = {
 	.func = balance_push,
 };
 
-static inline struct balance_callback *
+static __always_inline struct balance_callback *
 __splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct balance_callback *head = rq->balance_callback;
@@ -4946,7 +4946,7 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+static __always_inline void __balance_callbacks(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
@@ -4979,7 +4979,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static __always_inline void finish_lock_switch(struct rq *rq)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5011,7 +5011,7 @@ static inline void kmap_local_sched_out(void)
 #endif
 }
 
-static inline void kmap_local_sched_in(void)
+static __always_inline void kmap_local_sched_in(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
@@ -5064,7 +5064,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index a60b238cb0f5..412ff6149570 100644
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

