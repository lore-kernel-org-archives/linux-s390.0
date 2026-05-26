Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 50787337B99;
	Tue, 26 May 2026 15:22:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808930; cv=none; b=r8+cAWDoV1lWrp77YpbRsdODDHED6XnKZoqK33P7+ca0/fCUaHoOHsF0gTHxpyc48djXnBAvzkoz2ZY+XZy4NkaclrnCtgntsFCwrAwlsiavwCRmsRBmS582bGglY9ZayuE8hYpKVgYVeAbQ04mAdnOLUKqt+mRuWNXgFxpPOA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808930; c=relaxed/simple;
	bh=MArbMv8AaFS+7ApE0mUu3oJOSjwSvZ109++M2+8OOFI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CkyRBGCMVBs5veyAIT8H3NTLXLCyHnXA/CH/q8Rd1Zy0yJbq1dYZrWZDIgBs65cCpgnozcaVv6t/nAXVJ1xo+2kmzoK+dGSJ7KQWd9zLr06CF6+UojhzxmCCPFeGoFYLul5GZIO9d7ZJ/qJ3QvbleX0CdTEGaWl379xtEXG1ZBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ghLoggT4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ghLoggT4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB501F00A3A;
	Tue, 26 May 2026 15:22:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808928;
	bh=2QzUptOM11xBJqM5VgLTtXtckHxJX3bU+Ng24B20kP4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=ghLoggT4NctUAD29c/KZVqFUR+pABNWU9IC5uceMr6Tk8efVS2hbdqpzcnDEU4pTF
	 z0QD30Eny6lOONpWh/xTMdH9ayk/ZM4z9PgEJMwhtL9SQwTeLFWc1kndolLH+sCTW/
	 xuiEMatfUWoDkfq1a2a1wCRW+0oDxYG2tm3TqZenN9mLSKOug6JdbHYKzgewwqjOeB
	 VH1dHO5dAcc2hpZWSyl6cWkbLE4eA8EcpqPdBmQzUP/YHTPSv+TVO1C6wibpdPsWqe
	 Jv7FKbLp2YbtFZMZOYZZvApzjqh3CRvnz/OsjsMmc5URAFqC/NFtjglaLJosmQzHpL
	 kqEYuiN6+a5tQ==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id 6129EF4006B;
	Tue, 26 May 2026 11:22:05 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 11:22:05 -0400
X-ME-Sender: <xms:nboVarL9A4BhGc8Lwcaa7LlsZ5RZvABupKrfjA84YmObV3Ngzpjk3w>
    <xme:nboVajJrAWwYeRmRAUDEVCovHtMdvix3GvVSKuISV-22pmG4qM4-5piWcFIzBTrJt
    LXfRSiyIX_Bu2IHRZ2eRCpTWPDkbf9yXTnCLNHd11dMo3sJkqVILQ>
X-ME-Received: <xmr:nboVaizHIm5ngxR2MKKElmKmKpIiHfOCgKlxHVBUCS9SYg8l0RXYRm8Ki3q0AvOyHL9kp5dLNl1Ns6gdKJbTZt6D5bFFZQ_s>
X-ME-Proxy-Cause: dmFkZTF4DRy3SVWvFgbrMj6NLZAzcFoz2nQXqxcC29g0cJodSSCq7SigXkNqkKyVKY8Fbo
    tNBxK9l0cvUpEcoUsqlrgnGG6AzHesWFMvhCV6UChh28B/l+B0XcBDFyQ2SWxY98PRXmdP
    ve6x2DuaGBoFqFLd2X7JY1xDLL8Lf/ioMpNOlpSu5ND04mQF0abbcBqGyVfp8F97H4GS64
    01N0I2TPo3FNH+Cuc07t/TxhH401g1cp7tJox+/qtGqhdAiDNrA6UhBiIAP6Db2Lvi6zzp
    xv6mPObw6hMkfIMZb/rc84q9l5Cts9sZTAVAmwRqp1ZV95wmde3E4mdlYb8YI08MmQLdKV
    yLAxGzQjHGVQMaNctjx6zMP+jQp80eRmPI3yb8hlb/wL2I+fmnYnOXUUXFiKkRXvN3/8cs
    3BXq8i2bdH9ukGH1Q1hR2Hdi/RdeucA7YS4+h3lsNqfvQfG16DEhLq2FlitoAQwRG+ug3a
    oRxT+wbPPB6uzIDOH6DBiDLAJGgLbL6NmR9cQQBo9P/4OVuIkoBY9LKuLmIDKrxc9LsD0E
    UktnFSb9UNuy1l9uEkdNGAAhgJg5AAnc69sMo93WjHbJ0+Ey7cfA6RbYIIOrDzBNpaw9EV
    ndCXbmO44rkviHN+I5U3H18pRKS81Mv2e4L3PyxdcuTQ+7haPw7K8h3XWTHA
X-ME-Proxy: <xmx:nboVamLMMoOIQ3Jjv7TnLCrRecv7B6erfoB38wnI8IWOUsscjjp7DQ>
    <xmx:nboVaqQqCEq8eBoZYaTx3BkazoI7DRnOM__QCF10IxBtpP4I3ZwPuw>
    <xmx:nboVasJeDTSqlUQ3Zsxhn6YwHJc4WAUsGH9tCMYBFOAMRNexYoZDUQ>
    <xmx:nboVaqqRlQPxBBcOVWSGti0uFEVQK8rviSyPrUlzX-mq-elut7liYQ>
    <xmx:nboValG3OwUvdznvIqQhMFi5WsU_XyI_lRXxPqEzcJXMz_5fs8nx7gLN>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:03 -0400 (EDT)
From: Boqun Feng <boqun@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>,	Will Deacon <will@kernel.org>,
	Jonas Bonn <jonas@southpole.se>,
	Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
	Stafford Horne <shorne@gmail.com>,	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,	Thomas Gleixner <tglx@kernel.org>,
	Ingo Molnar <mingo@redhat.com>,	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,	x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,	Arnd Bergmann <arnd@arndb.de>,
	Juri Lelli <juri.lelli@redhat.com>,
	Vincent Guittot <vincent.guittot@linaro.org>,
	Dietmar Eggemann <dietmar.eggemann@arm.com>,
	Steven Rostedt <rostedt@goodmis.org>,	Ben Segall <bsegall@google.com>,
	Mel Gorman <mgorman@suse.de>,	Valentin Schneider <vschneid@redhat.com>,
	K Prateek Nayak <kprateek.nayak@amd.com>,	Boqun Feng <boqun@kernel.org>,
	Waiman Long <longman@redhat.com>,
	Andrew Morton <akpm@linux-foundation.org>,
	Andrii Nakryiko <andrii@kernel.org>,
	Eduard Zingerman <eddyz87@gmail.com>,
	Alexei Starovoitov <ast@kernel.org>,
	Daniel Borkmann <daniel@iogearbox.net>,
	Martin KaFai Lau <martin.lau@linux.dev>,
	Kumar Kartikeya Dwivedi <memxor@gmail.com>,	Song Liu <song@kernel.org>,
	Yonghong Song <yonghong.song@linux.dev>,	Jiri Olsa <jolsa@kernel.org>,
	Shuah Khan <shuah@kernel.org>,	Miguel Ojeda <ojeda@kernel.org>,
	Gary Guo <gary@garyguo.net>,
	=?UTF-8?q?Bj=C3=B6rn=20Roy=20Baron?= <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>,	Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,	Jinjie Ruan <ruanjinjie@huawei.com>,
	Lyude Paul <lyude@redhat.com>,	Thomas Huth <thuth@redhat.com>,
	Sohil Mehta <sohil.mehta@intel.com>,	"Xin Li (Intel)" <xin@zytor.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	Nikunj A Dadhania <nikunj@amd.com>,
	Joel Fernandes <joelagnelf@nvidia.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Randy Dunlap <rdunlap@infradead.org>,	Yury Norov <ynorov@nvidia.com>,
	Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
	linux-kernel@vger.kernel.org,	linux-openrisc@vger.kernel.org,
	linux-s390@vger.kernel.org,	linux-arch@vger.kernel.org,
	bpf@vger.kernel.org,	linux-kselftest@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	=?UTF-8?q?Onur=20=C3=96zkan?= <work@onurozkan.dev>,
	Daniel Almeida <daniel.almeida@collabora.com>,
	Boqun Feng <boqun.feng@gmail.com>
Subject: [PATCH v2 05/12] irq & spin_lock: Add counted interrupt disabling/enabling
Date: Tue, 26 May 2026 08:21:41 -0700
Message-ID: <20260526152148.30514-6-boqun@kernel.org>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20260526152148.30514-1-boqun@kernel.org>
References: <20260526152148.30514-1-boqun@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Boqun Feng <boqun.feng@gmail.com>

Currently the nested interrupt disabling and enabling is present by
_irqsave() and _irqrestore() APIs, which are relatively unsafe, for
example:

	<interrupts are enabled as beginning>
	spin_lock_irqsave(l1, flag1);
	spin_lock_irqsave(l2, flag2);
	spin_unlock_irqrestore(l1, flags1);
	<l2 is still held but interrupts are enabled>
	// accesses to interrupt-disable protect data will cause races.

This is even easier to triggered with guard facilities:

	unsigned long flag2;

	scoped_guard(spin_lock_irqsave, l1) {
		spin_lock_irqsave(l2, flag2);
	}
	// l2 locked but interrupts are enabled.
	spin_unlock_irqrestore(l2, flag2);

(Hand-to-hand locking critical sections are not uncommon for a
fine-grained lock design)

And because this unsafety, Rust cannot easily wrap the
interrupt-disabling locks in a safe API, which complicates the design.

To resolve this, introduce a new set of interrupt disabling APIs:

*	local_interrupt_disable();
*	local_interrupt_enable();

They work like local_irq_save() and local_irq_restore() except that 1)
the outermost local_interrupt_disable() call save the interrupt state
into a percpu variable, so that the outermost local_interrupt_enable()
can restore the state, and 2) a percpu counter is added to record the
nest level of these calls, so that interrupts are not accidentally
enabled inside the outermost critical section.

Also add the corresponding spin_lock primitives: spin_lock_irq_disable()
and spin_unlock_irq_enable(), as a result, code as follow:

	spin_lock_irq_disable(l1);
	spin_lock_irq_disable(l2);
	spin_unlock_irq_enable(l1);
	// Interrupts are still disabled.
	spin_unlock_irq_enable(l2);

doesn't have the issue that interrupts are accidentally enabled.

This also makes the wrapper of interrupt-disabling locks on Rust easier
to design.

Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
Signed-off-by: Lyude Paul <lyude@redhat.com>
Signed-off-by: Boqun Feng <boqun@kernel.org>
Link: https://patch.msgid.link/20260121223933.1568682-6-lyude@redhat.com
---
 include/linux/interrupt_rc.h     | 65 ++++++++++++++++++++++++++++++++
 include/linux/preempt.h          |  4 ++
 include/linux/spinlock.h         | 22 +++++++++++
 include/linux/spinlock_api_smp.h | 41 ++++++++++++++++++++
 include/linux/spinlock_api_up.h  | 16 ++++++++
 include/linux/spinlock_rt.h      | 18 +++++++++
 kernel/locking/spinlock.c        | 29 ++++++++++++++
 kernel/softirq.c                 | 14 ++++++-
 8 files changed, 208 insertions(+), 1 deletion(-)
 create mode 100644 include/linux/interrupt_rc.h

diff --git a/include/linux/interrupt_rc.h b/include/linux/interrupt_rc.h
new file mode 100644
index 000000000000..868f32524a87
--- /dev/null
+++ b/include/linux/interrupt_rc.h
@@ -0,0 +1,65 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * include/linux/interrupt_rc.h - refcounted local processor interrupt
+ * management.
+ *
+ * Since the implementation of this API currently depends on
+ * local_irq_save()/local_irq_restore(), we split this into it's own header to
+ * make it easier to include without hitting circular header dependencies.
+ */
+
+#ifndef __LINUX_INTERRUPT_RC_H
+#define __LINUX_INTERRUPT_RC_H
+
+#include <linux/irqflags.h>
+#include <asm/processor.h>
+#ifdef CONFIG_SMP
+#include <asm/smp.h>
+#endif
+
+/* Per-cpu interrupt disabling state for local_interrupt_{disable,enable}() */
+struct interrupt_disable_state {
+	unsigned long flags;
+};
+
+DECLARE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+
+static inline void local_interrupt_disable(void)
+{
+	unsigned long flags;
+	int new_count;
+
+	new_count = hardirq_disable_enter();
+
+	/* Interrupts can happen here, but it's OK, see __irq_exit_rcu(). */
+
+	if ((new_count & HARDIRQ_DISABLE_MASK) == HARDIRQ_DISABLE_OFFSET) {
+		local_irq_save(flags);
+		raw_cpu_write(local_interrupt_disable_state.flags, flags);
+	}
+}
+
+static inline void local_interrupt_enable(void)
+{
+	int new_count;
+
+	new_count = hardirq_disable_exit();
+
+	if ((new_count & HARDIRQ_DISABLE_MASK) == 0) {
+		unsigned long flags;
+
+		flags = raw_cpu_read(local_interrupt_disable_state.flags);
+		local_irq_restore(flags);
+		/*
+		 * TODO: re-read preempt count can be avoided, but it needs
+		 * should_resched() taking another parameter as the current
+		 * preempt count
+		 */
+#ifdef CONFIG_PREEMPTION
+		if (should_resched(0))
+			__preempt_schedule();
+#endif
+	}
+}
+
+#endif /* !__LINUX_INTERRUPT_RC_H */
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index e2d3079d3f5f..33fc4c814a9f 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -151,6 +151,10 @@ static __always_inline unsigned char interrupt_context_level(void)
 #define in_softirq()		(softirq_count())
 #define in_interrupt()		(irq_count())
 
+#define hardirq_disable_count()	((preempt_count() & HARDIRQ_DISABLE_MASK) >> HARDIRQ_DISABLE_SHIFT)
+#define hardirq_disable_enter()	__preempt_count_add_return(HARDIRQ_DISABLE_OFFSET)
+#define hardirq_disable_exit()	__preempt_count_sub_return(HARDIRQ_DISABLE_OFFSET)
+
 /*
  * The preempt_count offset after preempt_disable();
  */
diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
index 241277cd34cf..9d6012ac929d 100644
--- a/include/linux/spinlock.h
+++ b/include/linux/spinlock.h
@@ -57,6 +57,7 @@
 #include <linux/linkage.h>
 #include <linux/compiler.h>
 #include <linux/irqflags.h>
+#include <linux/interrupt_rc.h>
 #include <linux/thread_info.h>
 #include <linux/stringify.h>
 #include <linux/bottom_half.h>
@@ -273,9 +274,11 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 #endif
 
 #define raw_spin_lock_irq(lock)		_raw_spin_lock_irq(lock)
+#define raw_spin_lock_irq_disable(lock)	_raw_spin_lock_irq_disable(lock)
 #define raw_spin_lock_bh(lock)		_raw_spin_lock_bh(lock)
 #define raw_spin_unlock(lock)		_raw_spin_unlock(lock)
 #define raw_spin_unlock_irq(lock)	_raw_spin_unlock_irq(lock)
+#define raw_spin_unlock_irq_enable(lock)	_raw_spin_unlock_irq_enable(lock)
 
 #define raw_spin_unlock_irqrestore(lock, flags)		\
 	do {							\
@@ -290,6 +293,8 @@ static inline void do_raw_spin_unlock(raw_spinlock_t *lock) __releases(lock)
 
 #define raw_spin_trylock_irqsave(lock, flags) _raw_spin_trylock_irqsave(lock, &(flags))
 
+#define raw_spin_trylock_irq_disable(lock)	_raw_spin_trylock_irq_disable(lock)
+
 #ifndef CONFIG_PREEMPT_RT
 /* Include rwlock functions for !RT */
 #include <linux/rwlock.h>
@@ -372,6 +377,12 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	raw_spin_lock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
+{
+	raw_spin_lock_irq_disable(&lock->rlock);
+}
+
 #define spin_lock_irqsave(lock, flags)				\
 do {								\
 	raw_spin_lock_irqsave(spinlock_check(lock), flags);	\
@@ -402,6 +413,12 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	raw_spin_unlock_irq(&lock->rlock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+	__releases(lock) __no_context_analysis
+{
+	raw_spin_unlock_irq_enable(&lock->rlock);
+}
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock, unsigned long flags)
 	__releases(lock) __no_context_analysis
 {
@@ -427,6 +444,11 @@ static __always_inline bool _spin_trylock_irqsave(spinlock_t *lock, unsigned lon
 }
 #define spin_trylock_irqsave(lock, flags) _spin_trylock_irqsave(lock, &(flags))
 
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+{
+	return raw_spin_trylock_irq_disable(&lock->rlock);
+}
+
 /**
  * spin_is_locked() - Check whether a spinlock is locked.
  * @lock: Pointer to the spinlock.
diff --git a/include/linux/spinlock_api_smp.h b/include/linux/spinlock_api_smp.h
index bda5e7a390cd..07a94ba1d760 100644
--- a/include/linux/spinlock_api_smp.h
+++ b/include/linux/spinlock_api_smp.h
@@ -28,6 +28,8 @@ _raw_spin_lock_nest_lock(raw_spinlock_t *lock, struct lockdep_map *map)
 void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)		__acquires(lock);
 void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 								__acquires(lock);
+void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+								__acquires(lock);
 
 unsigned long __lockfunc _raw_spin_lock_irqsave(raw_spinlock_t *lock)
 								__acquires(lock);
@@ -39,6 +41,7 @@ int __lockfunc _raw_spin_trylock_bh(raw_spinlock_t *lock)	__cond_acquires(true,
 void __lockfunc _raw_spin_unlock(raw_spinlock_t *lock)		__releases(lock);
 void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)	__releases(lock);
+void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)	__releases(lock);
 void __lockfunc
 _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 								__releases(lock);
@@ -55,6 +58,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_lock_irq(lock) __raw_spin_lock_irq(lock)
 #endif
 
+/* Use the same config as spin_lock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_LOCK_IRQ
+#define _raw_spin_lock_irq_disable(lock) __raw_spin_lock_irq_disable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_LOCK_IRQSAVE
 #define _raw_spin_lock_irqsave(lock) __raw_spin_lock_irqsave(lock)
 #endif
@@ -79,6 +87,11 @@ _raw_spin_unlock_irqrestore(raw_spinlock_t *lock, unsigned long flags)
 #define _raw_spin_unlock_irq(lock) __raw_spin_unlock_irq(lock)
 #endif
 
+/* Use the same config as spin_unlock_irq() temporarily. */
+#ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+#define _raw_spin_unlock_irq_enable(lock) __raw_spin_unlock_irq_enable(lock)
+#endif
+
 #ifdef CONFIG_INLINE_SPIN_UNLOCK_IRQRESTORE
 #define _raw_spin_unlock_irqrestore(lock, flags) __raw_spin_unlock_irqrestore(lock, flags)
 #endif
@@ -105,6 +118,18 @@ static __always_inline bool _raw_spin_trylock_irq(raw_spinlock_t *lock)
 	return false;
 }
 
+static __always_inline bool _raw_spin_trylock_irq_disable(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	local_interrupt_disable();
+	if (do_raw_spin_trylock(lock)) {
+		spin_acquire(&lock->dep_map, 0, 1, _RET_IP_);
+		return true;
+	}
+	local_interrupt_enable();
+	return false;
+}
+
 static __always_inline bool _raw_spin_trylock_irqsave(raw_spinlock_t *lock, unsigned long *flags)
 	__cond_acquires(true, lock)
 {
@@ -143,6 +168,14 @@ static inline void __raw_spin_lock_irq(raw_spinlock_t *lock)
 	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
 }
 
+static inline void __raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+	__acquires(lock) __no_context_analysis
+{
+	local_interrupt_disable();
+	spin_acquire(&lock->dep_map, 0, 0, _RET_IP_);
+	LOCK_CONTENDED(lock, do_raw_spin_trylock, do_raw_spin_lock);
+}
+
 static inline void __raw_spin_lock_bh(raw_spinlock_t *lock)
 	__acquires(lock) __no_context_analysis
 {
@@ -188,6 +221,14 @@ static inline void __raw_spin_unlock_irq(raw_spinlock_t *lock)
 	preempt_enable();
 }
 
+static inline void __raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+	__releases(lock)
+{
+	spin_release(&lock->dep_map, _RET_IP_);
+	do_raw_spin_unlock(lock);
+	local_interrupt_enable();
+}
+
 static inline void __raw_spin_unlock_bh(raw_spinlock_t *lock)
 	__releases(lock)
 {
diff --git a/include/linux/spinlock_api_up.h b/include/linux/spinlock_api_up.h
index a9d5c7c66e03..e4de8bb26a15 100644
--- a/include/linux/spinlock_api_up.h
+++ b/include/linux/spinlock_api_up.h
@@ -42,6 +42,9 @@
 #define __LOCK_IRQSAVE(lock, flags, ...) \
   do { local_irq_save(flags); __LOCK(lock, ##__VA_ARGS__); } while (0)
 
+#define __LOCK_IRQ_DISABLE(lock, ...) \
+  do { local_interrupt_disable(); __LOCK(lock, ##__VA_ARGS__); } while (0)
+
 #define ___UNLOCK_(lock) \
   do { __release(lock); (void)(lock); } while (0)
 
@@ -61,6 +64,10 @@
 #define __UNLOCK_IRQRESTORE(lock, flags, ...) \
   do { local_irq_restore(flags); __UNLOCK(lock, ##__VA_ARGS__); } while (0)
 
+#define __UNLOCK_IRQ_ENABLE(lock, ...) \
+  do { __UNLOCK(lock, ##__VA_ARGS__); local_interrupt_enable(); } while (0)
+
+
 #define _raw_spin_lock(lock)			__LOCK(lock)
 #define _raw_spin_lock_nested(lock, subclass)	__LOCK(lock)
 #define _raw_read_lock(lock)			__LOCK(lock, shared)
@@ -70,6 +77,7 @@
 #define _raw_read_lock_bh(lock)			__LOCK_BH(lock, shared)
 #define _raw_write_lock_bh(lock)		__LOCK_BH(lock)
 #define _raw_spin_lock_irq(lock)		__LOCK_IRQ(lock)
+#define _raw_spin_lock_irq_disable(lock)	__LOCK_IRQ_DISABLE(lock)
 #define _raw_read_lock_irq(lock)		__LOCK_IRQ(lock, shared)
 #define _raw_write_lock_irq(lock)		__LOCK_IRQ(lock)
 #define _raw_spin_lock_irqsave(lock, flags)	__LOCK_IRQSAVE(lock, flags)
@@ -97,6 +105,13 @@ static __always_inline int _raw_spin_trylock_irq(raw_spinlock_t *lock)
 	return 1;
 }
 
+static __always_inline int _raw_spin_trylock_irq_disable(raw_spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	__LOCK_IRQ_DISABLE(lock);
+	return 1;
+}
+
 static __always_inline int _raw_spin_trylock_irqsave(raw_spinlock_t *lock, unsigned long *flags)
 	__cond_acquires(true, lock)
 {
@@ -132,6 +147,7 @@ static __always_inline int _raw_write_trylock_irqsave(rwlock_t *lock, unsigned l
 #define _raw_write_unlock_bh(lock)		__UNLOCK_BH(lock)
 #define _raw_read_unlock_bh(lock)		__UNLOCK_BH(lock, shared)
 #define _raw_spin_unlock_irq(lock)		__UNLOCK_IRQ(lock)
+#define _raw_spin_unlock_irq_enable(lock)	__UNLOCK_IRQ_ENABLE(lock)
 #define _raw_read_unlock_irq(lock)		__UNLOCK_IRQ(lock, shared)
 #define _raw_write_unlock_irq(lock)		__UNLOCK_IRQ(lock)
 #define _raw_spin_unlock_irqrestore(lock, flags) \
diff --git a/include/linux/spinlock_rt.h b/include/linux/spinlock_rt.h
index 373618a4243c..560d06384e0c 100644
--- a/include/linux/spinlock_rt.h
+++ b/include/linux/spinlock_rt.h
@@ -96,6 +96,12 @@ static __always_inline void spin_lock_irq(spinlock_t *lock)
 	rt_spin_lock(lock);
 }
 
+static __always_inline void spin_lock_irq_disable(spinlock_t *lock)
+	__acquires(lock)
+{
+	rt_spin_lock(lock);
+}
+
 #define spin_lock_irqsave(lock, flags)			 \
 	do {						 \
 		typecheck(unsigned long, flags);	 \
@@ -122,6 +128,12 @@ static __always_inline void spin_unlock_irq(spinlock_t *lock)
 	rt_spin_unlock(lock);
 }
 
+static __always_inline void spin_unlock_irq_enable(spinlock_t *lock)
+	__releases(lock)
+{
+	rt_spin_unlock(lock);
+}
+
 static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 						   unsigned long flags)
 	__releases(lock)
@@ -131,6 +143,12 @@ static __always_inline void spin_unlock_irqrestore(spinlock_t *lock,
 
 #define spin_trylock(lock)	rt_spin_trylock(lock)
 
+static __always_inline int spin_trylock_irq_disable(spinlock_t *lock)
+	__cond_acquires(true, lock)
+{
+	return rt_spin_trylock(lock);
+}
+
 #define spin_trylock_bh(lock)	rt_spin_trylock_bh(lock)
 
 #define spin_trylock_irq(lock)	rt_spin_trylock(lock)
diff --git a/kernel/locking/spinlock.c b/kernel/locking/spinlock.c
index b42d293da38b..764641f6ec57 100644
--- a/kernel/locking/spinlock.c
+++ b/kernel/locking/spinlock.c
@@ -129,6 +129,19 @@ static void __lockfunc __raw_##op##_lock_bh(locktype##_t *lock)		\
  */
 BUILD_LOCK_OPS(spin, raw_spinlock, __acquires);
 
+/* No rwlock_t variants for now, so just build this function by hand */
+static void __lockfunc __raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	for (;;) {
+		local_interrupt_disable();
+		if (likely(do_raw_spin_trylock(lock)))
+			break;
+		local_interrupt_enable();
+
+		arch_spin_relax(&lock->raw_lock);
+	}
+}
+
 #ifndef CONFIG_PREEMPT_RT
 BUILD_LOCK_OPS(read, rwlock, __acquires_shared);
 BUILD_LOCK_OPS(write, rwlock, __acquires);
@@ -176,6 +189,14 @@ noinline void __lockfunc _raw_spin_lock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_lock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_LOCK_IRQ
+noinline void __lockfunc _raw_spin_lock_irq_disable(raw_spinlock_t *lock)
+{
+	__raw_spin_lock_irq_disable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_lock_irq_disable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_LOCK_BH
 noinline void __lockfunc _raw_spin_lock_bh(raw_spinlock_t *lock)
 {
@@ -208,6 +229,14 @@ noinline void __lockfunc _raw_spin_unlock_irq(raw_spinlock_t *lock)
 EXPORT_SYMBOL(_raw_spin_unlock_irq);
 #endif
 
+#ifndef CONFIG_INLINE_SPIN_UNLOCK_IRQ
+noinline void __lockfunc _raw_spin_unlock_irq_enable(raw_spinlock_t *lock)
+{
+	__raw_spin_unlock_irq_enable(lock);
+}
+EXPORT_SYMBOL_GPL(_raw_spin_unlock_irq_enable);
+#endif
+
 #ifndef CONFIG_INLINE_SPIN_UNLOCK_BH
 noinline void __lockfunc _raw_spin_unlock_bh(raw_spinlock_t *lock)
 {
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 10af5ed859e7..d1ab1799794c 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -88,6 +88,9 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirqs_enabled);
 EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 #endif
 
+DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
+EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
+
 DEFINE_PER_CPU(unsigned int, nmi_nesting);
 
 /*
@@ -728,7 +731,16 @@ static inline void __irq_exit_rcu(void)
 #endif
 	account_hardirq_exit(current);
 	preempt_count_sub(HARDIRQ_OFFSET);
-	if (!in_interrupt() && local_softirq_pending()) {
+	/*
+	 * Interrupts may happen between hardirq_disable_enter() and
+	 * local_irq_save() in local_interrupt_disable(), if irq_exit() invokes
+	 * softirq here, we may have a softirq handler calling
+	 * local_interrupt_disable() but it won't disable the irq because
+	 * hardirq disabling count is already 1, hence we need to prevent
+	 * invoking softirq when a local_interrupt_disable() is ongoing.
+	 */
+	if (!in_interrupt() && !hardirq_disable_count() &&
+	    local_softirq_pending()) {
 		/*
 		 * If we left hrtimers unarmed, make sure to arm them now,
 		 * before enabling interrupts to run SoftIRQ.
-- 
2.50.1 (Apple Git-155)

