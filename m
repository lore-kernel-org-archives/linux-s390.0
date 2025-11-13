Received: from mail-pj1-f45.google.com (mail-pj1-f45.google.com [209.85.216.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 95DA5333740
	for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 10:54:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031257; cv=none; b=IjQ+pM2JgkL6eV/7v0gXQzMfuiHkXkrW4CZcpFOnvUU0Jzs2ULM/bTjNKb3ol/gxcS31xrYj9CPZM/0ZmODS+K4AjvTlD7EjSZsTaeqim2Pt7EG13RAHezpJxOtPl6yjdrX7a5ijYLsMJog1chNV9RCoWV/DdrWQvey806H5QsQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031257; c=relaxed/simple;
	bh=xfQ68Z5SJiRfAfkfJq6qzln5mUYMVZzft9oRbU6pxK8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UKGBU+DV27kIu89kO8ag+dj6JMQD7MjjpwZ/I75/jJ/nMCRMVUSqqUptSaFWvBqBNb1DHoWzld3t2+Wo2nMaozR2lhVc9/HNibjKgbxqmzVPsBMaoWCyqyHLH0MwUzdjEf50+dw1dUkvstpgrv9qz2XIjHpYvYnlEYwd1KCqoI8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=gHW+NuPn; arc=none smtp.client-ip=209.85.216.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="gHW+NuPn"
Received: by mail-pj1-f45.google.com with SMTP id 98e67ed59e1d1-34182b1c64bso430705a91.3
        for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 02:54:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031255; x=1763636055; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pyYQg/XjxJP8oSPs0jUhiEt1HKw71tyhJFd27FTylsA=;
        b=gHW+NuPnVXp72GSP21sewvDYGhd8/2+HbP5jgLepZjD36pSQY9GbUu4g9/oTLkVFBd
         L6/ZTs5fZ2M7DEn3sOOxr+7Ho7Hda7cgLJWEZK4v+9V28EA6f2kQozQEmWnFLY2xa6n2
         RYG7pN83P4Jdn6E/tPjTyeo7CVmlyAID9mOdyG1rKoFxT3J2uOwv8Z18dTp91cyHtj9q
         NXrktZWXxguYyVyqOAFG7RR2PYkZESzUQUqvqVhrhSJHEdGlRMlanWC1fTHzr81jPFmN
         PANyeX7zG9QzWfG4t1cd1N39Grct8s+62ZUCcJ66DKmxvmveJsOKxSmEpvCsQww5wTuL
         TM9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031255; x=1763636055;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pyYQg/XjxJP8oSPs0jUhiEt1HKw71tyhJFd27FTylsA=;
        b=pvkWpIJUozS/O2IxJ8tLsTJvmZdIORvwYdzUojOgQShnoNsVLYhirodUnOxpO6qmqm
         6vM0IYPBnCCqvJcgClsVq1WRJlQOv4fcAnlFlckxMUI91ExIkgBxevFVB/lELovj3fm3
         C6YnQDljXJe4sDkTr8hh8SFQndc1parrVP7MOoJhCsEaBGFKZ1vYYQULZ/zPiGqxY1Oy
         dqlV8f2J0jwmxvAGWmaLcHb8UYwBaClEU8XmPXQCNI1Z0q270VezH5j/qg0wLo5eUz4X
         c+d24Ne1budvUK6ALPBW47kAaDG8kbaRMUE0IGseK5i9fEJL47ggYNQyyQ8CMCGlbsNu
         IjNw==
X-Forwarded-Encrypted: i=1; AJvYcCXSvH/7BP6zGQHZu+i0WH46ab8FON67KNsIxxPMoXLU0mAcRAuvPGq/BF8Xaf442SN0RkVYwFN3l2U0@vger.kernel.org
X-Gm-Message-State: AOJu0YzIGpKnpTv/Ht/+YMuUzi+x4t7yvGIhk+sCOCMHuLNJyLYHA4VN
	NHlobVO3N7Oqr0Szz7IRp7KVrnZNeuy9JSeOq//sOlmU0wPjcLO60rg5
X-Gm-Gg: ASbGnctKo41c6jmPGouZm7UvoncKQF9W9xC1lQNyFxV4o7Yg7oawxzSzSkRPNV0Cnt+
	s3g688afvUcYhV4VmhO9N/0eo4V2KsU3vkMRTOfg8Z+XJI8a7aYcdF+I/lcpD/v0UBzWlDnmW5R
	Q76SyEEYFC5dOBaQch3R8cHYBROQehpMtXqIxRPgJuVWxao4YfwHYVsgF4+YRg4SCKk+mlH0Ws3
	YOyLH/x609yu8EvTdP9bNMwsmDwlcl3EME+uNTZ/2TWKc+Ai+4BUE91IMFESyJ5hvPvC1lOT3yJ
	Boo9Dgd6ziWxW9LvpvJ/CLiyiELnyyMXE0utUdIc87xRJfRKpyIbn/mmpvFbDz9OrG7Cf8+22Uf
	Dl56ZrLa9M8MzwG3tJ0zd3QyfZx4l71jC0re35eUGaR+53CAbRkbqWMQ+0F6PBcWRV+EnldG83+
	3ic5TgXp2fAUpSowlpcCAKigmM
X-Google-Smtp-Source: AGHT+IGCW0ShjG6rPEd7TTM9fU/qaA3GTD+Zt4V6c9Z/7+p3piw8u4iEYCY97jT4XSt6uXwfG5ifag==
X-Received: by 2002:a17:90b:384c:b0:32b:df0e:9283 with SMTP id 98e67ed59e1d1-343ddefd3eemr7447918a91.34.1763031254493;
        Thu, 13 Nov 2025 02:54:14 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.53.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:54:13 -0800 (PST)
From: Xie Yuanbin <qq570070308@gmail.com>
To: tglx@linutronix.de,
	riel@surriel.com,
	segher@kernel.crashing.org,
	david@redhat.com,
	peterz@infradead.org,
	hpa@zytor.com,
	osalvador@suse.de,
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
	sforshee@kernel.org,
	mhiramat@kernel.org,
	andrii@kernel.org,
	oleg@redhat.com,
	jlayton@kernel.org,
	aalbersh@redhat.com,
	akpm@linux-foundation.org,
	david@kernel.org,
	lorenzo.stoakes@oracle.com,
	baolin.wang@linux.alibaba.com,
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
Subject: [PATCH v3 3/3] Make finish_task_switch and its subfuncs inline in context switching
Date: Thu, 13 Nov 2025 18:52:27 +0800
Message-ID: <20251113105227.57650-4-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251113105227.57650-1-qq570070308@gmail.com>
References: <20251113105227.57650-1-qq570070308@gmail.com>
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

Perf test:
Time spent on calling finish_task_switch (rdtsc):
 | compiler && appended cmdline | without patch   | with patch    |
 | gcc + NA                     | 13.93 - 13.94   | 12.39 - 12.44 |
 | gcc + "spectre_v2_user=on"   | 24.69 - 24.85   | 13.68 - 13.73 |
 | clang + NA                   | 13.89 - 13.90   | 12.70 - 12.73 |
 | clang + "spectre_v2_user=on" | 29.00 - 29.02   | 18.88 - 18.97 |

Perf test info:
1. kernel source:
linux-next
commit 9c0826a5d9aa4d52206d ("Add linux-next specific files for 20251107")
2. compiler:
gcc: gcc version 15.2.0 (Debian 15.2.0-7) with
GNU ld (GNU Binutils for Debian) 2.45
clang: Debian clang version 21.1.4 (8) with
Debian LLD 21.1.4 (compatible with GNU linkers)
3. config:
base on default x86_64_defconfig, and setting:
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_CGROUPS=n
CONFIG_BLK_DEV_NVME=y

Size test:
bzImage size:
 | compiler | without patches | with patches  |
 | clang    | 13722624        | 13722624      |
 | gcc      | 12596224        | 12596224      |

Size test info:
1. kernel source && compiler: same as above
2. config:
base on default x86_64_defconfig, and setting:
CONFIG_SCHED_CORE=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_NO_HZ_FULL=y

Signed-off-by: Xie Yuanbin <qq570070308@gmail.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Rik van Riel <riel@surriel.com>
Cc: Segher Boessenkool <segher@kernel.crashing.org>
Cc: David Hildenbrand <david@redhat.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: H. Peter Anvin (Intel) <hpa@zytor.com>
---
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
index 0e50ef3d819a..78d2c90bc73a 100644
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
@@ -4884,7 +4884,7 @@ static inline void finish_task(struct task_struct *prev)
 	smp_store_release(&prev->on_cpu, 0);
 }
 
-static void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
+static __always_inline void do_balance_callbacks(struct rq *rq, struct balance_callback *head)
 {
 	void (*func)(struct rq *rq);
 	struct balance_callback *next;
@@ -4919,7 +4919,7 @@ struct balance_callback balance_push_callback = {
 	.func = balance_push,
 };
 
-static inline struct balance_callback *
+static __always_inline struct balance_callback *
 __splice_balance_callbacks(struct rq *rq, bool split)
 {
 	struct balance_callback *head = rq->balance_callback;
@@ -4949,7 +4949,7 @@ struct balance_callback *splice_balance_callbacks(struct rq *rq)
 	return __splice_balance_callbacks(rq, true);
 }
 
-static void __balance_callbacks(struct rq *rq)
+static __always_inline void __balance_callbacks(struct rq *rq)
 {
 	do_balance_callbacks(rq, __splice_balance_callbacks(rq, false));
 }
@@ -4982,7 +4982,7 @@ prepare_lock_switch(struct rq *rq, struct task_struct *next, struct rq_flags *rf
 #endif
 }
 
-static inline void finish_lock_switch(struct rq *rq)
+static __always_inline void finish_lock_switch(struct rq *rq)
 {
 	/*
 	 * If we are tracking spinlock dependencies then we have to
@@ -5014,7 +5014,7 @@ static inline void kmap_local_sched_out(void)
 #endif
 }
 
-static inline void kmap_local_sched_in(void)
+static __always_inline void kmap_local_sched_in(void)
 {
 #ifdef CONFIG_KMAP_LOCAL
 	if (unlikely(current->kmap_ctrl.idx))
@@ -5067,7 +5067,7 @@ prepare_task_switch(struct rq *rq, struct task_struct *prev,
  * past. 'prev == current' is still correct but we need to recalculate this_rq
  * because prev may have moved to another CPU.
  */
-static struct rq *finish_task_switch(struct task_struct *prev)
+static __always_inline struct rq *finish_task_switch(struct task_struct *prev)
 	__releases(rq->lock)
 {
 	struct rq *rq = this_rq();
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

