Received: from mail-pl1-f182.google.com (mail-pl1-f182.google.com [209.85.214.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9014625D202
	for <linux-s390@vger.kernel.org>; Sat,  8 Nov 2025 17:27:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762622831; cv=none; b=TeOgbiDl9KtfeU+WnMmPKumMVuhHQBo8d0SDkij8l9l2kYj/gQA+edP268u+iPDFMMp3NXIRYPp4dt8LqLFXXy0wu7989q2lJOyyVbJiA8ZkIzofDk4xtFoi8RD9ytkLrymGlr2pQxWaG1ocB1Jda7tUJdsiMYszU5Np7ZE+5js=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762622831; c=relaxed/simple;
	bh=ji12vfJaJnPixmTdZzLZe3/51Z/QGvSCAgUOwgH5sy0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=L6FHIICVfpSAHjpc+snptipbX66iAEszftKqnvMtxojedgfdxFC3I0YI6PHrWUqMBGPov0QYETSZ0N/JwNJwR5wEXlZSgiXYbeEygjeZtWjENEzJUrHDo2YjEVSo4AVVNTodtwGGo0G8uKghVZGwmPTgrI5Nlzouh5VF4i0furc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=eNACkMuA; arc=none smtp.client-ip=209.85.214.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="eNACkMuA"
Received: by mail-pl1-f182.google.com with SMTP id d9443c01a7336-297e264528aso6882135ad.2
        for <linux-s390@vger.kernel.org>; Sat, 08 Nov 2025 09:27:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1762622828; x=1763227628; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ifgJwqhkz81AiW/M580r37kIiR/Zt38Daw4xBcO/V58=;
        b=eNACkMuAfqE/8hjKP4taD8X/YC9P8uE09LE+ykSQcr3UAIGYVF3OTHLuY10M560Pes
         cpVxFem9PS080zs8cs8fIe3HK2yoJ+Sy3zyFuJ+UkA/+MZ6C1MOaG4LW/LXi79qpvdUi
         1cE34LZmw5CVT7x3Yh70cjZw3U7FrwqVJUzvIL3YfBYalabsr4CLkPSk/PcHl03T01OO
         Yap0UEZS22ulaN3xaqFdlPRS+xPtGZuQR54IKx4G2BeTnW6+oefdjU4eIiOjIg361AQK
         4NbsC3Z76t9Srck9uOzhdGadw5fCIPsj/mrGEC9JLkT0sZzXV+jZeeAOjhZnh/bWstJb
         MvpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762622828; x=1763227628;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=ifgJwqhkz81AiW/M580r37kIiR/Zt38Daw4xBcO/V58=;
        b=DuMJSzvEH8WJN7rCrc5qx0JCXsLxiZebehriQZ4GAS4ZcW/QfPW0Iv3HsIq18bn/kW
         j8h2/8VGMcSMFd50sodyrwiXO1kiYXuODxJXLNUS3Q4aChyML30AvoPfo7oE8hWOWbdA
         VYJ8rkmHRLHxcaQk0W2WOAxb+xsS/+WPPP9yyl0JAY4Ghp2aIKsB6CVytkXrzvDtpATV
         NY6Z9sQQC3VFfhPYsEqZtLbpb0aMnYsT1AfF3rQXEVqpgl0/nTFWMpub9qV4/DOxhStm
         qmAD8oy0h9HvWUR8z2yn8je9ptWzzoGnZl6WxHcTRhcomwaOaD9+7Dy+4Mqo2jgmOAz/
         jmvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXxY9+ogRBYQ/lt2EgeLX1sp9OiGmcmTR8lF6gPfobJng6Z2ErZ3PQOsDUvx51ZGsM5PVQCjj+UGfyU@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1cQlfzE2jyRRUmTcQBYxAex0dViKXq+C8/oEaOXZeM21n6oSl
	yKqf0YjKSrpf8Iv+zrTMd0Pm5ysrGdjeYxqOWhjJR3DbOFhgnXmKW8Mo
X-Gm-Gg: ASbGncvqAZNLePgkHNUuQv0lPQYPxGv/yJocdUvmWqX1VMNzCwDnPV/3rN4CShNjrfI
	6vIThjt+cDFOtLLNjs0dFo5GzGpwDsQeAk+gISulj3VaU2TK+nkDPf7ksr8L8zpwpxt1QGhzotv
	Uh0wpxf8iCCQCA/rmaRLJFu+CNEpZPYHIKWy+rw7qJHlLNffYF1vi3bm1ZVPU2ZwXIZejA9ydOH
	l6zyX1yumW1ajVjdZu676623sGBVMD2v97zxTPTQ/WuHeftBCIYTKVt8ypoaUJnzXA9L4xkhZq7
	8C2vu2iM2XWNJuW+sSh8sBo2gnzgPfjkVImtu3xKXOJ3Igp1/utKxxq6acjZ2UmI+8zd0oQ6VgO
	bFLVSg5V+04OfLo/9MCF+U5sRQsDlZLgCVSakOTe0+bIDY3qjLHwl3uEO5e/qE0D8PgKBmAn+/m
	XanmekzqA1ILQOcSMXA+aJm5P+z/owo5rYa0k=
X-Google-Smtp-Source: AGHT+IG2XNPxrCil9As1GPMbFbfiTLeZrJq06uWpTB8/dDMRqGxGXKnu96wXs+iZFmt1AddBNZ4izQ==
X-Received: by 2002:a17:902:cf42:b0:295:8da4:6404 with SMTP id d9443c01a7336-297e56f9154mr40667245ad.40.1762622827520;
        Sat, 08 Nov 2025 09:27:07 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3436c3d7dddsm2769122a91.7.2025.11.08.09.26.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Nov 2025 09:27:07 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: david@redhat.com,
	tglx@linutronix.de,
	segher@kernel.crashing.org,
	riel@surriel.com,
	peterz@infradead.org,
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
	luto@kernel.org,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
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
	juri.lelli@redhat.com,
	vincent.guittot@linaro.org,
	dietmar.eggemann@arm.com,
	rostedt@goodmis.org,
	bsegall@google.com,
	mgorman@suse.de,
	vschneid@redhat.com,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	qq570070308@gmail.com,
	thuth@redhat.com,
	brauner@kernel.org,
	arnd@arndb.de,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	max.kellermann@ionos.com,
	ryan.roberts@arm.com,
	nysal@linux.ibm.com,
	urezki@gmail.com
Cc: x86@kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org,
	linux-perf-users@vger.kernel.org,
	llvm@lists.linux.dev,
	will@kernel.org
Subject: [PATCH v2 4/4] Make finish_task_switch and its subfuncs inline in context switching
Date: Sun,  9 Nov 2025 01:23:46 +0800
Message-ID: <20251108172346.263590-5-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251108172346.263590-1-qq570070308@gmail.com>
References: <20251108172346.263590-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

`finish_task_switch` is a hot path in context switching, and due to
possible mitigations inside switch_mm, performance here is greatly
affected by function calls and branch jumps. Make it inline to optimize
the performance.

After `finish_task_switch` is changed to an inline function, the number of
calls to the subfunctions (called by `finish_task_switch`) increases in
this translation unit due to the inline expansion of `finish_task_switch`.
Due to compiler optimization strategies, these functions may transition
from inline functions to non inline functions, which can actually lead to
performance degradation.

Make the subfunctions of finish_task_stwitch inline to prevent
degradation.

Time spent on calling finish_task_switch (rdtsc):
 | compiler && appended cmdline | without patch   | with patch    |
 | gcc + NA                     | 13.93 - 13.94   | 12.39 - 12.44 |
 | gcc + "spectre_v2_user=on"   | 24.69 - 24.85   | 13.68 - 13.73 |
 | clang + NA                   | 13.89 - 13.90   | 12.70 - 12.73 |
 | clang + "spectre_v2_user=on" | 29.00 - 29.02   | 18.88 - 18.97 |

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
---
 arch/riscv/include/asm/sync_core.h |  2 +-
 arch/x86/include/asm/sync_core.h   |  2 +-
 include/linux/perf_event.h         |  2 +-
 include/linux/sched/mm.h           | 10 +++++-----
 include/linux/tick.h               |  4 ++--
 include/linux/vtime.h              |  8 ++++----
 kernel/sched/core.c                | 18 +++++++++---------
 kernel/sched/sched.h               | 20 ++++++++++----------
 8 files changed, 33 insertions(+), 33 deletions(-)

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
index c50e672e22c4..cba8b93ed37b 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -4868,7 +4868,7 @@ static inline void prepare_task(struct task_struct *next)
 	WRITE_ONCE(next->on_cpu, 1);
 }
 
-static inline void finish_task(struct task_struct *prev)
+static __always_inline void finish_task(struct task_struct *prev)
 {
 	/*
 	 * This must be the very last reference to @prev from this CPU. After
@@ -4930,7 +4930,7 @@ struct balance_callback balance_push_callback = {
 	.func = balance_push,
 };
 
-static inline struct balance_callback *
+static __always_inline struct balance_callback *
 __splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct balance_callback *head = rq->balance_callback;
@@ -4967,12 +4967,12 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
  */
 static __always_inline void __balance_callbacks_ainline(struct rq *rq)
 {
-	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
+	do_balance_callbacks_ainline(rq, __splice_balance_callbacks(rq, false));
 }
 
 static void __balance_callbacks(struct rq *rq)
 {
-	__balance_callbacks_ainline(rq);
+	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
 
 void balance_callbacks(struct rq *rq, struct balance_callback *head)
@@ -5003,7 +5003,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static __always_inline void finish_lock_switch(struct rq *rq)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5011,7 +5011,7 @@ static inline void finish_lock_switch(struct rq *rq)
 	 * prev into current:
 	 */
 	spin_acquire(&__rq_lockp(rq)->dep_map, 0, 0, _THIS_IP_);
-	__balance_callbacks(rq);
+	__balance_callbacks_ainline(rq);
 	raw_spin_rq_unlock_irq(rq);
 }
 
@@ -5036,7 +5036,7 @@ static inline void kmap_local_sched_out(void)
 #endif
 }
 
-static inline void kmap_local_sched_in(void)
+static __always_inline void kmap_local_sched_in(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
@@ -5134,7 +5134,7 @@ static __always_inline struct rq *finish_task_switch_ainline(struct task_struct
 	finish_task(prev);
 	tick_nohz_task_switch();
 	finish_lock_switch(rq);
-	finish_arch_post_lock_switch();
+	finish_arch_post_lock_switch_ainline();
 	kcov_finish_switch(current);
 	/*
 	 * kmap_local_sched_out() is invoked with rq::lock held and
@@ -5289,7 +5289,7 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	return finish_task_switch_ainline(prev);
 }
 
 /*
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 7d305ec10374..ec301a91cb43 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1374,12 +1374,12 @@ static inline struct cpumask *sched_group_span(struct sched_group *sg);
 
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
@@ -1388,7 +1388,7 @@ static inline bool sched_core_disabled(void)
  * Be careful with this function; not for general use. The return value isn't
  * stable unless you actually hold a relevant rq->__lock.
  */
-static inline raw_spinlock_t *rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *rq_lockp(struct rq *rq)
 {
 	if (sched_core_enabled(rq))
 		return &rq->core->__lock;
@@ -1396,7 +1396,7 @@ static inline raw_spinlock_t *rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
+static __always_inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 {
 	if (rq->core_enabled)
 		return &rq->core->__lock;
@@ -1487,12 +1487,12 @@ static inline bool sched_core_disabled(void)
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
@@ -1542,23 +1542,23 @@ static inline void lockdep_assert_rq_held(struct rq *rq)
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

