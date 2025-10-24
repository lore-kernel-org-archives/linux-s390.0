Received: from mail-pl1-f175.google.com (mail-pl1-f175.google.com [209.85.214.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7844034A3CE
	for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 18:36:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761330994; cv=none; b=q1y+vf3+2Y/KA71Wq7Iith8++vsXzvGXDqcM9HGtsGYt2I68n7LCPlQM5uWcXTHzGnjwj1qljrNY4h/SYQQhhwWTLhZl4BCaG9wUpVEJP5FWVGQiwDXF8tL5qPR95MX1kzb93dv73ubl1vuz6S63S9F71AOP4MMfC7myC0xHU38=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761330994; c=relaxed/simple;
	bh=fH2L8/x4vjswu06Vd4AVwYJ9Qz4n7GCYmO3CrnIhXDw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=tUJd+rd23pjDGSvFKdnnnshekLvFr8n6oS+feuFuB1McpZWTC+HPGux3W2gupRZg6/3r+Mk8LJ4DFzGXMT12MeHMWcYGI9Y7yiPClIR3Y0fRn/xxDDMz4/jAN5FHqOwuNwxLxUo4xhfKktmszV4YFMiCWnmVgsSBFM6XsjYdfrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=Pak8wEUE; arc=none smtp.client-ip=209.85.214.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Pak8wEUE"
Received: by mail-pl1-f175.google.com with SMTP id d9443c01a7336-27c369f898fso37749315ad.3
        for <linux-s390@vger.kernel.org>; Fri, 24 Oct 2025 11:36:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761330991; x=1761935791; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ymE5LZJ6zs5xE09Xyu4PakHLOfv+9wIHhFFXTwwKVEs=;
        b=Pak8wEUEpFChLjcD4M66Bk/bf78y2OIPOEeYbSl+eYPaVsETlF5UShkJZgtyTw1y5O
         ADFHzxOoKhDkYUM8KA3f6NxgFS+BPy80NkF7XO3lFuV4Jzn3dP/76erKClOjucD8zein
         BEQf27bQKz+XrVWcWGuqXB6Z8UGTWdk06y4tBZnZs+BTUVYHuAth8Mb9DG6ubQ18JKHo
         ZPTo6sxM/5pdBuY4ZYgtx/rYHjhF7UnM1qYHaNyOo/etmsuTP5w86O93VHRoXj2/mjMQ
         XMFbGS8+1PTPWyl4p4XxdgNJiCiCj5hiQUK3Jm3aeGHL1iJk3OsrCUjO8110oaZMl/4L
         q1zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761330991; x=1761935791;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ymE5LZJ6zs5xE09Xyu4PakHLOfv+9wIHhFFXTwwKVEs=;
        b=iF2fTRzJVmASEtnpGD7AeZCbVuD+GQLBHd4vd423P4V+CBhFl2nyyhCDvhm7n16qVw
         djIQBXh1UqJqhBeVGmAtly04IkuJW0A501H+UMTUEYTq0PJw1kafl7CeyF/8aRTFT71U
         92Kkg4qDAGRWa5gLxkhqJd/5YIojZ4tYZcQ1uZ4hRiGy5Om4XlvTXuWUj0TuXn8CTV/u
         i734k2U9uJueKRuoALXaTr0qSFI7rXQ7toIcBOq7NdtwA7Qnpas+1dZK+MK8zNn8u2p2
         quXfNm+KsOkAxCJdSe26Rrjdebl0aRG7JBKFcfxpywGqVg6fpIV3QcjZ4ryY22u/kaVn
         a8Dg==
X-Forwarded-Encrypted: i=1; AJvYcCVTnekNdUEmrgEpU5DgznG4Lq6Pjg8Al/tqsy8TD+iRpP0OSHYv47jrDqOd7+L5pzGpnObwDcLu4kTm@vger.kernel.org
X-Gm-Message-State: AOJu0YwSRCw8MVVt2n8C70aKL9Q0MkixmLVGq+TepLdSeSsKxQoh7vxQ
	FJcUdkWqN0RuMHkZU9MpwzaaGZJR9ZXubWMnUlABspX04juF/6qbPA28
X-Gm-Gg: ASbGncu5bFFKgqczK697czTE4RkoSg9UIUSb+yw1GpZdgSWguZvG7ANFGpfb1zch+/T
	/NVXl95CC1N8pw7TdQGNTPpDu4U2BnnbsHvw6pW8orjnZJRczGKaNwIt09xsy0fXb6BZCutEURN
	VTOP1g3MBrZbPIrIJYu2f2dOKfRa3YzNCATXVxxKRBPG4g6+OZEbs+A+TrGODoTIUQjjcSexfqq
	cuMVxPsqmfLOCwBhUXES/zHhC+oE3Nv1wVs7ve+2RlyB4WWn8bThcEl2C6HMuFkKjNYcOsfLJ91
	oBh9mo8wDj4cdl/P0W6x9QmCoGqEsDgBuHZ5OL7xlWiTzr0PIj3PHyyHeLj98RvBs87nk4HO+aL
	CSSxS4y2GuKZ6Gv9GDODTZJVY7LNRLNlTK4EK/aJ0dKTPXKIb1JHAlT1uMhvTv4RQ9ZRvTCqmin
	rXpxYHFxWRXkXhS88G9JMp
X-Google-Smtp-Source: AGHT+IGYqFM3/0pu+ov3PKRm8sjZ7itj+qiE3PfAaxE/hH/oitSQk/LH4xJ8+HAFHf913lIP6eY5ow==
X-Received: by 2002:a17:903:440c:b0:264:8a8d:92dd with SMTP id d9443c01a7336-290c9cb8b95mr387069125ad.20.1761330985938;
        Fri, 24 Oct 2025 11:36:25 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2946e2579e2sm62725945ad.111.2025.10.24.11.36.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 24 Oct 2025 11:36:25 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: linux@armlinux.org.uk,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
	peterz@infradead.org,
	acme@kernel.org,
	namhyung@kernel.org,
	mark.rutland@arm.com,
	alexander.shishkin@linux.intel.com,
	jolsa@kernel.org,
	irogers@google.com,
	adrian.hunter@intel.com,
	anna-maria@linutronix.de,
	frederic@kernel.org,
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	riel@surriel.com,
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
	segher@kernel.crashing.org,
	ryan.roberts@arm.com,
	max.kellermann@ionos.com,
	urezki@gmail.com,
	nysal@linux.ibm.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	will@kernel.org
Subject: [PATCH 3/3] Set the subfunctions called by finish_task_switch to be inline
Date: Sat, 25 Oct 2025 02:35:41 +0800
Message-ID: <20251024183541.68955-2-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024183541.68955-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
 <20251024183541.68955-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The prev commit changed finish_task_switch as inline called, which
resulted in an increase in the number of calls to the subfunctions(which
called in finish_task_switch) in this translation unit due to the inline
expansion of finish_task_switch. Due to compiler optimization strategies,
these functions may transition from inline functions to non inline
functions, which can actually lead to performance degradation.

Modify some subfunctions of finish_task_stwitch to be called inline to
prevent degradation.

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
---
 arch/arm/include/asm/mmu_context.h      |  6 +++++-
 arch/riscv/include/asm/sync_core.h      |  2 +-
 arch/s390/include/asm/mmu_context.h     |  6 +++++-
 arch/sparc/include/asm/mmu_context_64.h |  6 +++++-
 arch/x86/include/asm/sync_core.h        |  2 +-
 include/linux/perf_event.h              |  2 +-
 include/linux/sched/mm.h                | 10 +++++-----
 include/linux/tick.h                    |  4 ++--
 include/linux/vtime.h                   |  8 ++++----
 kernel/sched/core.c                     | 11 ++++++-----
 10 files changed, 35 insertions(+), 22 deletions(-)

diff --git a/arch/arm/include/asm/mmu_context.h b/arch/arm/include/asm/mmu_context.h
index db2cb06aa8cf..d238f915f65d 100644
--- a/arch/arm/include/asm/mmu_context.h
+++ b/arch/arm/include/asm/mmu_context.h
@@ -73,39 +73,43 @@ static inline void check_and_switch_context(struct mm_struct *mm,
 		 * finish_arch_post_lock_switch() call.
 		 */
 		mm->context.switch_pending = 1;
 	else
 		cpu_switch_mm(mm->pgd, mm);
 }
 
 #ifndef MODULE
 #define finish_arch_post_lock_switch \
 	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	struct mm_struct *mm = current->mm;
 
 	if (mm && mm->context.switch_pending) {
 		/*
 		 * Preemption must be disabled during cpu_switch_mm() as we
 		 * have some stateful cache flush implementations. Check
 		 * switch_pending again in case we were preempted and the
 		 * switch to this mm was already done.
 		 */
 		preempt_disable();
 		if (mm->context.switch_pending) {
 			mm->context.switch_pending = 0;
 			cpu_switch_mm(mm->pgd, mm);
 		}
 		preempt_enable_no_resched();
 	}
 }
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
 #endif /* !MODULE */
 
 #endif	/* CONFIG_MMU */
 
 #endif	/* CONFIG_CPU_HAS_ASID */
 
 #define activate_mm(prev,next)		switch_mm(prev, next, NULL)
 
 /*
  * This is the actual mm switch as far as the scheduler
diff --git a/arch/riscv/include/asm/sync_core.h b/arch/riscv/include/asm/sync_core.h
index 9153016da8f1..2fe6b7fe6b12 100644
--- a/arch/riscv/include/asm/sync_core.h
+++ b/arch/riscv/include/asm/sync_core.h
@@ -1,19 +1,19 @@
 /* SPDX-License-Identifier: GPL-2.0 */
 #ifndef _ASM_RISCV_SYNC_CORE_H
 #define _ASM_RISCV_SYNC_CORE_H
 
 /*
  * RISC-V implements return to user-space through an xRET instruction,
  * which is not core serializing.
  */
-static inline void sync_core_before_usermode(void)
+static __always_inline void sync_core_before_usermode(void)
 {
 	asm volatile ("fence.i" ::: "memory");
 }
 
 #ifdef CONFIG_SMP
 /*
  * Ensure the next switch_mm() on every CPU issues a core serializing
  * instruction for the given @mm.
  */
 static inline void prepare_sync_core_cmd(struct mm_struct *mm)
diff --git a/arch/s390/include/asm/mmu_context.h b/arch/s390/include/asm/mmu_context.h
index d9b8501bc93d..abe734068193 100644
--- a/arch/s390/include/asm/mmu_context.h
+++ b/arch/s390/include/asm/mmu_context.h
@@ -90,21 +90,21 @@ static inline void switch_mm(struct mm_struct *prev, struct mm_struct *next,
 			     struct task_struct *tsk)
 {
 	unsigned long flags;
 
 	local_irq_save(flags);
 	switch_mm_irqs_off(prev, next, tsk);
 	local_irq_restore(flags);
 }
 
 #define finish_arch_post_lock_switch finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	struct task_struct *tsk = current;
 	struct mm_struct *mm = tsk->mm;
 	unsigned long flags;
 
 	if (mm) {
 		preempt_disable();
 		while (atomic_read(&mm->context.flush_count))
 			cpu_relax();
 		cpumask_set_cpu(smp_processor_id(), mm_cpumask(mm));
@@ -112,20 +112,24 @@ static inline void finish_arch_post_lock_switch(void)
 		preempt_enable();
 	}
 	local_irq_save(flags);
 	if (test_thread_flag(TIF_ASCE_PRIMARY))
 		local_ctl_load(1, &get_lowcore()->kernel_asce);
 	else
 		local_ctl_load(1, &get_lowcore()->user_asce);
 	local_ctl_load(7, &get_lowcore()->user_asce);
 	local_irq_restore(flags);
 }
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
 
 #define activate_mm activate_mm
 static inline void activate_mm(struct mm_struct *prev,
                                struct mm_struct *next)
 {
 	switch_mm_irqs_off(prev, next, current);
 	cpumask_set_cpu(smp_processor_id(), mm_cpumask(next));
 	if (test_thread_flag(TIF_ASCE_PRIMARY))
 		local_ctl_load(1, &get_lowcore()->kernel_asce);
 	else
diff --git a/arch/sparc/include/asm/mmu_context_64.h b/arch/sparc/include/asm/mmu_context_64.h
index 78bbacc14d2d..9102ab2adfbc 100644
--- a/arch/sparc/include/asm/mmu_context_64.h
+++ b/arch/sparc/include/asm/mmu_context_64.h
@@ -153,21 +153,21 @@ static inline void arch_start_context_switch(struct task_struct *prev)
 			:
 			: "g1");
 		if (tmp_mcdper)
 			set_tsk_thread_flag(prev, TIF_MCDPER);
 		else
 			clear_tsk_thread_flag(prev, TIF_MCDPER);
 	}
 }
 
 #define finish_arch_post_lock_switch	finish_arch_post_lock_switch
-static inline void finish_arch_post_lock_switch(void)
+static __always_inline void finish_arch_post_lock_switch_ainline(void)
 {
 	/* Restore the state of MCDPER register for the new process
 	 * just switched to.
 	 */
 	if (adi_capable()) {
 		register unsigned long tmp_mcdper;
 
 		tmp_mcdper = test_thread_flag(TIF_MCDPER);
 		__asm__ __volatile__(
 			"mov %0, %%g1\n\t"
@@ -177,20 +177,24 @@ static inline void finish_arch_post_lock_switch(void)
 			: "ir" (tmp_mcdper)
 			: "g1");
 		if (current && current->mm && current->mm->context.adi) {
 			struct pt_regs *regs;
 
 			regs = task_pt_regs(current);
 			regs->tstate |= TSTATE_MCDE;
 		}
 	}
 }
+static inline void finish_arch_post_lock_switch(void)
+{
+	finish_arch_post_lock_switch_ainline();
+}
 
 #define mm_untag_mask mm_untag_mask
 static inline unsigned long mm_untag_mask(struct mm_struct *mm)
 {
        return -1UL >> adi_nbits();
 }
 
 #include <asm-generic/mmu_context.h>
 
 #endif /* !(__ASSEMBLER__) */
diff --git a/arch/x86/include/asm/sync_core.h b/arch/x86/include/asm/sync_core.h
index 96bda43538ee..4b55fa353bb5 100644
--- a/arch/x86/include/asm/sync_core.h
+++ b/arch/x86/include/asm/sync_core.h
@@ -86,21 +86,21 @@ static __always_inline void sync_core(void)
 	 * hypervisor.
 	 */
 	iret_to_self();
 }
 
 /*
  * Ensure that a core serializing instruction is issued before returning
  * to user-mode. x86 implements return to user-space through sysexit,
  * sysrel, and sysretq, which are not core serializing.
  */
-static inline void sync_core_before_usermode(void)
+static __always_inline void sync_core_before_usermode(void)
 {
 	/* With PTI, we unconditionally serialize before running user code. */
 	if (static_cpu_has(X86_FEATURE_PTI))
 		return;
 
 	/*
 	 * Even if we're in an interrupt, we might reschedule before returning,
 	 * in which case we could switch to a different thread in the same mm
 	 * and return using SYSRET or SYSEXIT.  Instead of trying to keep
 	 * track of our need to sync the core, just sync right away.
diff --git a/include/linux/perf_event.h b/include/linux/perf_event.h
index fd1d91017b99..2b1c752af207 100644
--- a/include/linux/perf_event.h
+++ b/include/linux/perf_event.h
@@ -1617,21 +1617,21 @@ static __always_inline bool __perf_sw_enabled(int swevt)
 {
 	return static_key_false(&perf_swevent_enabled[swevt]);
 }
 
 static inline void perf_event_task_migrate(struct task_struct *task)
 {
 	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS))
 		task->sched_migrated = 1;
 }
 
-static inline void perf_event_task_sched_in(struct task_struct *prev,
+static __always_inline void perf_event_task_sched_in(struct task_struct *prev,
 					    struct task_struct *task)
 {
 	if (static_branch_unlikely(&perf_sched_events))
 		__perf_event_task_sched_in(prev, task);
 
 	if (__perf_sw_enabled(PERF_COUNT_SW_CPU_MIGRATIONS) &&
 	    task->sched_migrated) {
 		__perf_sw_event_sched(PERF_COUNT_SW_CPU_MIGRATIONS, 1, 0);
 		task->sched_migrated = 0;
 	}
diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
index 0e1d73955fa5..e7787a6e7d22 100644
--- a/include/linux/sched/mm.h
+++ b/include/linux/sched/mm.h
@@ -37,21 +37,21 @@ static inline void mmgrab(struct mm_struct *mm)
 	atomic_inc(&mm->mm_count);
 }
 
 static inline void smp_mb__after_mmgrab(void)
 {
 	smp_mb__after_atomic();
 }
 
 extern void __mmdrop(struct mm_struct *mm);
 
-static inline void mmdrop(struct mm_struct *mm)
+static __always_inline void mmdrop(struct mm_struct *mm)
 {
 	/*
 	 * The implicit full barrier implied by atomic_dec_and_test() is
 	 * required by the membarrier system call before returning to
 	 * user-space, after storing to rq->curr.
 	 */
 	if (unlikely(atomic_dec_and_test(&mm->mm_count)))
 		__mmdrop(mm);
 }
 
@@ -64,28 +64,28 @@ static inline void __mmdrop_delayed(struct rcu_head *rhp)
 {
 	struct mm_struct *mm = container_of(rhp, struct mm_struct, delayed_drop);
 
 	__mmdrop(mm);
 }
 
 /*
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
 #endif
 
 /* Helpers for lazy TLB mm refcounting */
 static inline void mmgrab_lazy_tlb(struct mm_struct *mm)
 {
 	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmgrab(mm);
@@ -97,21 +97,21 @@ static inline void mmdrop_lazy_tlb(struct mm_struct *mm)
 		mmdrop(mm);
 	} else {
 		/*
 		 * mmdrop_lazy_tlb must provide a full memory barrier, see the
 		 * membarrier comment finish_task_switch which relies on this.
 		 */
 		smp_mb();
 	}
 }
 
-static inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
+static __always_inline void mmdrop_lazy_tlb_sched(struct mm_struct *mm)
 {
 	if (IS_ENABLED(CONFIG_MMU_LAZY_TLB_REFCOUNT))
 		mmdrop_sched(mm);
 	else
 		smp_mb(); /* see mmdrop_lazy_tlb() above */
 }
 
 /**
  * mmget() - Pin the address space associated with a &struct mm_struct.
  * @mm: The address space to pin.
@@ -524,21 +524,21 @@ enum {
 
 enum {
 	MEMBARRIER_FLAG_SYNC_CORE	= (1U << 0),
 	MEMBARRIER_FLAG_RSEQ		= (1U << 1),
 };
 
 #ifdef CONFIG_ARCH_HAS_MEMBARRIER_CALLBACKS
 #include <asm/membarrier.h>
 #endif
 
-static inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
+static __always_inline void membarrier_mm_sync_core_before_usermode(struct mm_struct *mm)
 {
 	/*
 	 * The atomic_read() below prevents CSE. The following should
 	 * help the compiler generate more efficient code on architectures
 	 * where sync_core_before_usermode() is a no-op.
 	 */
 	if (!IS_ENABLED(CONFIG_ARCH_HAS_SYNC_CORE_BEFORE_USERMODE))
 		return;
 	if (current->mm != mm)
 		return;
diff --git a/include/linux/tick.h b/include/linux/tick.h
index ac76ae9fa36d..fce16aa10ba2 100644
--- a/include/linux/tick.h
+++ b/include/linux/tick.h
@@ -168,21 +168,21 @@ static inline u64 get_cpu_iowait_time_us(int cpu, u64 *unused) { return -1; }
  * Mask of CPUs that are nohz_full.
  *
  * Users should be guarded by CONFIG_NO_HZ_FULL or a tick_nohz_full_cpu()
  * check.
  */
 extern cpumask_var_t tick_nohz_full_mask;
 
 #ifdef CONFIG_NO_HZ_FULL
 extern bool tick_nohz_full_running;
 
-static inline bool tick_nohz_full_enabled(void)
+static __always_inline bool tick_nohz_full_enabled(void)
 {
 	if (!context_tracking_enabled())
 		return false;
 
 	return tick_nohz_full_running;
 }
 
 /*
  * Check if a CPU is part of the nohz_full subset. Arrange for evaluating
  * the cpu expression (typically smp_processor_id()) _after_ the static
@@ -292,21 +292,21 @@ static inline void tick_dep_init_task(struct task_struct *tsk) { }
 static inline void tick_dep_set_signal(struct task_struct *tsk,
 				       enum tick_dep_bits bit) { }
 static inline void tick_dep_clear_signal(struct signal_struct *signal,
 					 enum tick_dep_bits bit) { }
 
 static inline void tick_nohz_full_kick_cpu(int cpu) { }
 static inline void __tick_nohz_task_switch(void) { }
 static inline void tick_nohz_full_setup(cpumask_var_t cpumask) { }
 #endif
 
-static inline void tick_nohz_task_switch(void)
+static __always_inline void tick_nohz_task_switch(void)
 {
 	if (tick_nohz_full_enabled())
 		__tick_nohz_task_switch();
 }
 
 static inline void tick_nohz_user_enter_prepare(void)
 {
 	if (tick_nohz_full_cpu(smp_processor_id()))
 		rcu_nocb_flush_deferred_wakeup();
 }
diff --git a/include/linux/vtime.h b/include/linux/vtime.h
index 29dd5b91dd7d..428464bb81b3 100644
--- a/include/linux/vtime.h
+++ b/include/linux/vtime.h
@@ -60,38 +60,38 @@ static __always_inline void vtime_account_guest_exit(void)
 }
 
 #elif defined(CONFIG_VIRT_CPU_ACCOUNTING_GEN)
 
 /*
  * Checks if vtime is enabled on some CPU. Cputime readers want to be careful
  * in that case and compute the tickless cputime.
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
 }
 
 static __always_inline void vtime_account_guest_enter(void)
 {
 	if (vtime_accounting_enabled_this_cpu())
 		vtime_guest_enter(current);
 	else
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 6cb3f57c4d35..7a70d13d03fe 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4869,21 +4869,21 @@ static inline void prepare_task(struct task_struct *next)
 	/*
 	 * Claim the task as running, we do this before switching to it
 	 * such that any running task will have this set.
 	 *
 	 * See the smp_load_acquire(&p->on_cpu) case in ttwu() and
 	 * its ordering comment.
 	 */
 	WRITE_ONCE(next->on_cpu, 1);
 }
 
-static inline void finish_task(struct task_struct *prev)
+static __always_inline void finish_task(struct task_struct *prev)
 {
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
 	 * p->on_cpu is cleared, the task can be moved to a different CPU. We
 	 * must ensure this doesn't happen until the switch is completely
 	 * finished.
 	 *
 	 * In particular, the load of prev->state in finish_task_switch() must
 	 * happen before this.
 	 *
@@ -4983,53 +4983,54 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 	 * do an early lockdep release here:
 	 */
 	rq_unpin_lock(rq, rf);
 	spin_release(&__rq_lockp(rq)->dep_map, _THIS_IP_);
 #ifdef CONFIG_DEBUG_SPINLOCK
 	/* this is a valid case when another task releases the spinlock */
 	rq_lockp(rq)->owner = next;
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static __always_inline void finish_lock_switch(struct rq *rq)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
 	 * fix up the runqueue lock - which gets 'carried over' from
 	 * prev into current:
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
 	__balance_callbacks(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
 
 /*
  * NOP if the arch has not defined these:
  */
 
 #ifndef prepare_arch_switch
 # define prepare_arch_switch(next)	do { } while (0)
 #endif
 
 #ifndef finish_arch_post_lock_switch
-# define finish_arch_post_lock_switch()	do { } while (0)
+# define finish_arch_post_lock_switch()		do { } while (0)
+# define finish_arch_post_lock_switch_ainline()	do { } while (0)
 #endif
 
 static inline void kmap_local_sched_out(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
 		__kmap_local_sched_out();
 #endif
 }
 
-static inline void kmap_local_sched_in(void)
+static __always_inline void kmap_local_sched_in(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
 		__kmap_local_sched_in();
 #endif
 }
 
 /**
  * prepare_task_switch - prepare to switch tasks
  * @rq: the runqueue preparing to switch
@@ -5111,21 +5112,21 @@ static __always_inline struct rq *finish_task_switch_ainline(struct task_struct
 	 * finish_task), otherwise a concurrent wakeup can get prev
 	 * running on another CPU and we could rave with its RUNNING -> DEAD
 	 * transition, resulting in a double drop.
 	 */
 	prev_state = READ_ONCE(prev->__state);
 	vtime_task_switch(prev);
 	perf_event_task_sched_in(prev, current);
 	finish_task(prev);
 	tick_nohz_task_switch();
 	finish_lock_switch(rq);
-	finish_arch_post_lock_switch();
+	finish_arch_post_lock_switch_ainline();
 	kcov_finish_switch(current);
 	/*
 	 * kmap_local_sched_out() is invoked with rq::lock held and
 	 * interrupts disabled. There is no requirement for that, but the
 	 * sched out code does not have an interrupt enabled section.
 	 * Restoring the maps on sched in does not require interrupts being
 	 * disabled either.
 	 */
 	kmap_local_sched_in();
 
-- 
2.51.0

