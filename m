Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A9E4A36213E;
	Tue, 26 May 2026 15:22:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1779808942; cv=none; b=H+U6bGzkrWsMUy/xHK6gsA4Lz3Tr44xcwkNJsVRUqxCIRLWwHq1eyOzYXdTIbJS4+w0t/yPsL/kf1giRsOCf6/8yj291O1djAyEbEWoZW++CJYTGr1swWxwUhTxhHR+CvFTT0sn92gzHeFGH6P9A0vDIFy1pUPcY0VxpZzVoU+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1779808942; c=relaxed/simple;
	bh=NEybVWvpS+MEbtuV3qzVwmhvObUaSRpp8D+B9GVK8zw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XAshBQ41DqshS0du0CFRwq80DxEjSX4wzpdZrIVaUghFk6kSPi393vKdfVcB6/OxOObsfwC7SCagnawhrev8MjhyW/6d8yvsfXNE/ustWUb6CUADqSeJUNJHXWPOXVQuXjv3xhcuGne7wRKWfoNgGQfmbsBBfDXXo/wixWkMSyM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=G8RBJLfT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="G8RBJLfT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B43A1F000E9;
	Tue, 26 May 2026 15:22:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1779808940;
	bh=0xyhM4HteEfLSVlD5tA7ywkZHMTsZYrq5mYmAf7E9Y4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References;
	b=G8RBJLfTIiBtgmRgO7V++0TbQmi8PtBsoqcONR06OoxbE/RfJcZT/+ACWXxdQwdEn
	 R78jmk5b6rxwSiS36R4qLUymx2kS/jI3OX2yWLBEND9U+mdCA753ZjES0uMOFPA8sM
	 cdvw3x4p6vhzpq6/ixSJXsGIRZBeTVZmBmxdlrEhVBarIAvCzl2sNFksp9iCZk0frz
	 IZAiBnq8wv7ve+7NBzpXKNxl6Mr3EpSlv4BIfUXZozzyB6n55+rDpwb0ACuttBbXv1
	 8yoMqnu9xngsD0vhS7il28bxHvlW1a+MbFcJ4RNRcySOoOikMFIQR1i37FGOLKil+y
	 /zEzsDrRr1Qeg==
Received: from phl-compute-06.internal (phl-compute-06.internal [10.202.2.46])
	by mailfauth.phl.internal (Postfix) with ESMTP id E2561F4007A;
	Tue, 26 May 2026 11:22:17 -0400 (EDT)
Received: from phl-frontend-03 ([10.202.2.162])
  by phl-compute-06.internal (MEProxy); Tue, 26 May 2026 11:22:17 -0400
X-ME-Sender: <xms:qboVanWSh-bTM-Vm_rq8euLAHhbWNSXen0BGD498cmJyt8RsxZ_Iuw>
    <xme:qboVaioQ1O6XvH8P01bBIRJtNPNBIeRoZVtD7iNcV-2ysSFOZ5UPQFJPF9WFAmFiI
    HEZTkSGe7AMB9F0776zDaYp6YqVCeRUyNZ85uN6qKRGXIupejlivQ>
X-ME-Received: <xmr:qboVaipkJU1_qxyKshqy4oylz4QY9Qohwnjuyzpr5wTT9Z860kbuHoOjSVR7YOTTHq1Rhg2nw89g9EG08Xg9Lyptt9tZLT-P>
X-ME-Proxy-Cause: dmFkZTFpmA1McbnqjIdDoCcC8/dKh9RDeYcaA/XB6dgQZoHsdisS7Rnte/RUY2pDCqsaCf
    lYH/GXfkGRmzTYnB4S+g0DoIzy4KUSXH1v1hqWsXA4v5WIAvvT6c8zNgUsod23Kpq2+47O
    yYMzbMVdimQJPpKCDvwUMQiSwLgkBGzQ1ckebHI5CwcU5PXtm0paPap1/zDmdG+vWcQc/M
    pmWI2idDed0xMRSQV9XOsN/PBFcH6SBYELvyO/AtrMtpHg8r71AQlMzDlEp1H1iVazK3oS
    DonyrliF9qRbQD87XBn6QOt2bC/09pqeijaNsBJFU0GwQ/sar+bEYdVoRVtkXuEiBwHIF8
    5LKKAX24vCoOzlaEKK2N3STq58Ivc/as+HiOo7IZiJuGEugVTYUVe0FYs+lA5mdTQnVv8Q
    8MIYyef0YxoUAfDyk54HqPPhyBJKM2XyyShIOJdvROfOWpLIVelvirHT2WX4LP+MBxCwG5
    +jVV5Xvj5i2MgSbMbx+mHvjJu7Z+n6eFrKnO9tUIaQ9J5/PcfvXJWhGWR8+Miob+Eu//3r
    3Zm+MrciKQYc71VUKOgRNkSnO5rgDdEtU4on+T/oBiIFxPYG5qOKCKvpPxnglrBqU0joAO
    IBjn6JlvNHPsKExDsvm7fi6qpBFJMnFUkmWV0Pj9qMDMNMHJQn8fJ+cQKZ7A
X-ME-Proxy: <xmx:qboVagC51fRUYOnAMps-q1ccPZ-epjhZ_sOo9jDCzgJYqLzFU6dnFg>
    <xmx:qboVapwxD5FJ-RyuyI1urJktXP_8eoldpLNi_gVVe9xC5ylkTNsC1w>
    <xmx:qboVajEMOpq_5Bh19XhUm_Q5qqK2aGCjSg17Bo8S4wfZ6nvmkOlccg>
    <xmx:qboVav6-OJnnfLj15_1gefjPhs3TlOBwH6rzkLc_6A_z9-Si4wlGAA>
    <xmx:qboVao4AMqeAqLLRKVGe3kB8v0VLGzHMZNOhh3CbhEshp_DbHS0JvXW8>
Feedback-ID: i8dbe485b:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 26 May 2026 11:22:17 -0400 (EDT)
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
	Daniel Almeida <daniel.almeida@collabora.com>
Subject: [PATCH v2 10/12] preempt: Introduce HAS_SEPARATE_PREEMPT_RESCHED_BITS
Date: Tue, 26 May 2026 08:21:46 -0700
Message-ID: <20260526152148.30514-11-boqun@kernel.org>
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

With the changes that enable preempt count to tracking irq disabling
nesting, we don't have enough bits in 32bit preempt count
implementation, as a result we move NMI nesting bits out of the 32bit
preempt count. However on the architectures that can support 64bit
preempt count implementation, we can keep the NMI nesting bits in the
32bit preempt count and avoid maintaining NMI nesting bits out of the
same cache line.

Therefore HAS_SEPARATE_PREEMPT_RESCHED_BITS is introduced to allow
architectures to select this. Note that under this kconfig, preempt
count is maintained in a 64bit word however preempt_count() still
remains as an int because all the effective bits still fit in
(previously we mask out NEED_RESCHED bit in preempt_count()). This
should make no functional changes for existing preempt_count() users.

Enable this for x86_64 along with the introduction of the Kconfig.

Originally-by: Peter Zijlstra <peterz@infradead.org>
Signed-off-by: Boqun Feng <boqun@kernel.org>
---
 arch/x86/Kconfig               |  1 +
 arch/x86/include/asm/preempt.h | 55 +++++++++++++++++++++++-----------
 arch/x86/kernel/cpu/common.c   |  2 +-
 include/linux/hardirq.h        | 50 +++++++++++++++++++++++--------
 include/linux/preempt.h        | 20 +++++++------
 kernel/Kconfig.preempt         |  4 +++
 kernel/sched/core.c            | 12 ++++++--
 kernel/softirq.c               |  6 ++++
 lib/locking-selftest.c         |  2 +-
 9 files changed, 109 insertions(+), 43 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index f3f7cb01d69d..bf8288b3d52b 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -327,6 +327,7 @@ config X86
 	select USER_STACKTRACE_SUPPORT
 	select HAVE_ARCH_KCSAN			if X86_64
 	select PROC_PID_ARCH_STATUS		if PROC_FS
+	select HAS_SEPARATE_PREEMPT_RESCHED_BITS		if X86_64
 	select HAVE_ARCH_NODE_DEV_GROUP		if X86_SGX
 	select FUNCTION_ALIGNMENT_16B		if X86_64 || X86_ALIGNMENT_16
 	select FUNCTION_ALIGNMENT_4B
diff --git a/arch/x86/include/asm/preempt.h b/arch/x86/include/asm/preempt.h
index 1220656f3370..12353eeebc52 100644
--- a/arch/x86/include/asm/preempt.h
+++ b/arch/x86/include/asm/preempt.h
@@ -7,10 +7,20 @@
 
 #include <linux/static_call_types.h>
 
-DECLARE_PER_CPU_CACHE_HOT(int, __preempt_count);
+DECLARE_PER_CPU_CACHE_HOT(unsigned long, __preempt_count);
 
-/* We use the MSB mostly because its available */
-#define PREEMPT_NEED_RESCHED	0x80000000
+/*
+ * We use the MSB for PREEMPT_NEED_RESCHED mostly because it is available.
+ */
+#define PREEMPT_NEED_RESCHED	(~(((unsigned long)-1L) >> 1))
+
+#ifdef CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
+#define __pc_dec		"decq"
+#define __pc_op(op, ...)	raw_cpu_##op##_8(__VA_ARGS__)
+#else
+#define __pc_dec		"decl"
+#define __pc_op(op, ...)	raw_cpu_##op##_4(__VA_ARGS__)
+#endif
 
 /*
  * We use the PREEMPT_NEED_RESCHED bit as an inverted NEED_RESCHED such
@@ -24,18 +34,26 @@ DECLARE_PER_CPU_CACHE_HOT(int, __preempt_count);
  */
 static __always_inline int preempt_count(void)
 {
-	return raw_cpu_read_4(__preempt_count) & ~PREEMPT_NEED_RESCHED;
+	return __pc_op(read, __preempt_count) & ~PREEMPT_NEED_RESCHED;
 }
 
-static __always_inline void preempt_count_set(int pc)
+/*
+ * unsigned long preempt count parameter works for both 32bit and 64bit cases:
+ *
+ * - For 32bit, "int" (the return of preempt_count()) and "unsigned long" have
+ *   the same size.
+ * - For 64bit, the effective bits of a preempt count sits in 32bit, and we
+ *   reserve the NEED_RESCHED bit from the old count.
+ */
+static __always_inline void preempt_count_set(unsigned long pc)
 {
-	int old, new;
+	unsigned long old, new;
 
-	old = raw_cpu_read_4(__preempt_count);
+	old = __pc_op(read, __preempt_count);
 	do {
 		new = (old & PREEMPT_NEED_RESCHED) |
 			(pc & ~PREEMPT_NEED_RESCHED);
-	} while (!raw_cpu_try_cmpxchg_4(__preempt_count, &old, new));
+	} while (!__pc_op(try_cmpxchg, __preempt_count, &old, new));
 }
 
 /*
@@ -58,17 +76,17 @@ static __always_inline void preempt_count_set(int pc)
 
 static __always_inline void set_preempt_need_resched(void)
 {
-	raw_cpu_and_4(__preempt_count, ~PREEMPT_NEED_RESCHED);
+	__pc_op(and, __preempt_count, ~PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline void clear_preempt_need_resched(void)
 {
-	raw_cpu_or_4(__preempt_count, PREEMPT_NEED_RESCHED);
+	__pc_op(or, __preempt_count, PREEMPT_NEED_RESCHED);
 }
 
 static __always_inline bool test_preempt_need_resched(void)
 {
-	return !(raw_cpu_read_4(__preempt_count) & PREEMPT_NEED_RESCHED);
+	return !(__pc_op(read, __preempt_count) & PREEMPT_NEED_RESCHED);
 }
 
 /*
@@ -77,22 +95,22 @@ static __always_inline bool test_preempt_need_resched(void)
 
 static __always_inline void __preempt_count_add(int val)
 {
-	raw_cpu_add_4(__preempt_count, val);
+	__pc_op(add, __preempt_count, val);
 }
 
 static __always_inline void __preempt_count_sub(int val)
 {
-	raw_cpu_add_4(__preempt_count, -val);
+	__pc_op(add, __preempt_count, -val);
 }
 
 static __always_inline int __preempt_count_add_return(int val)
 {
-	return raw_cpu_add_return_4(__preempt_count, val);
+	return __pc_op(add_return, __preempt_count, val);
 }
 
 static __always_inline int __preempt_count_sub_return(int val)
 {
-	return raw_cpu_add_return_4(__preempt_count, -val);
+	return __pc_op(add_return, __preempt_count, -val);
 }
 
 /*
@@ -102,7 +120,7 @@ static __always_inline int __preempt_count_sub_return(int val)
  */
 static __always_inline bool __preempt_count_dec_and_test(void)
 {
-	return GEN_UNARY_RMWcc("decl", __my_cpu_var(__preempt_count), e,
+	return GEN_UNARY_RMWcc(__pc_dec, __my_cpu_var(__preempt_count), e,
 			       __percpu_arg([var]));
 }
 
@@ -111,7 +129,7 @@ static __always_inline bool __preempt_count_dec_and_test(void)
  */
 static __always_inline bool should_resched(int preempt_offset)
 {
-	return unlikely(raw_cpu_read_4(__preempt_count) == preempt_offset);
+	return unlikely(__pc_op(read, __preempt_count) == preempt_offset);
 }
 
 #ifdef CONFIG_PREEMPTION
@@ -158,4 +176,7 @@ do { \
 
 #endif /* PREEMPTION */
 
+#undef __pc_op
+#undef __pc_dec
+
 #endif /* __ASM_PREEMPT_H */
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index a4268c47f2bc..182772b6ad6d 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -2240,7 +2240,7 @@ DEFINE_PER_CPU_CACHE_HOT(struct task_struct *, current_task) = &init_task;
 EXPORT_PER_CPU_SYMBOL(current_task);
 EXPORT_PER_CPU_SYMBOL(const_current_task);
 
-DEFINE_PER_CPU_CACHE_HOT(int, __preempt_count) = INIT_PREEMPT_COUNT;
+DEFINE_PER_CPU_CACHE_HOT(unsigned long, __preempt_count) = INIT_PREEMPT_COUNT;
 EXPORT_PER_CPU_SYMBOL(__preempt_count);
 
 DEFINE_PER_CPU_CACHE_HOT(unsigned long, cpu_current_top_of_stack) = TOP_OF_INIT_STACK;
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 1a0360a1000f..26e106b0dc30 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -10,8 +10,6 @@
 #include <linux/vtime.h>
 #include <asm/hardirq.h>
 
-DECLARE_PER_CPU(unsigned int, nmi_nesting);
-
 extern void synchronize_irq(unsigned int irq);
 extern bool synchronize_hardirq(unsigned int irq);
 
@@ -94,6 +92,40 @@ void irq_exit_rcu(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
+#ifdef CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
+static __always_inline void __preempt_count_nmi_enter(void)
+{
+	__preempt_count_add(NMI_OFFSET + HARDIRQ_OFFSET);
+}
+
+static __always_inline void __preempt_count_nmi_exit(void)
+{
+	__preempt_count_sub(NMI_OFFSET + HARDIRQ_OFFSET);
+}
+#else
+DECLARE_PER_CPU(unsigned int, nmi_nesting);
+
+#define __preempt_count_nmi_enter()				\
+	do {							\
+		unsigned int _o = NMI_MASK + HARDIRQ_OFFSET;	\
+		/* Maximum NMI nesting is 15. */		\
+		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
+		__this_cpu_inc(nmi_nesting);			\
+		_o -= (preempt_count() & NMI_MASK);		\
+		__preempt_count_add(_o);			\
+	} while (0)
+
+#define __preempt_count_nmi_exit()				\
+	do {							\
+		unsigned int _o = HARDIRQ_OFFSET;		\
+		if (!__this_cpu_dec_return(nmi_nesting))	\
+			_o += NMI_MASK;				\
+		__preempt_count_sub(_o);			\
+	} while (0)
+
+#endif
+
+
 /*
  * NMI vs Tracing
  * --------------
@@ -110,18 +142,14 @@ void irq_exit_rcu(void);
 	do {							\
 		lockdep_off();					\
 		arch_nmi_enter();				\
-		/* Maximum NMI nesting is 15. */		\
-		BUG_ON(__this_cpu_read(nmi_nesting) >= 15);	\
-		__this_cpu_inc(nmi_nesting);			\
-		__preempt_count_add(HARDIRQ_OFFSET);		\
-		preempt_count_set(preempt_count() | NMI_MASK);	\
+		__preempt_count_nmi_enter();			\
 	} while (0)
 
 #define nmi_enter()						\
 	do {							\
 		__nmi_enter();					\
 		lockdep_hardirq_enter();			\
-		ct_nmi_enter();				\
+		ct_nmi_enter();					\
 		instrumentation_begin();			\
 		ftrace_nmi_enter();				\
 		instrumentation_end();				\
@@ -129,12 +157,8 @@ void irq_exit_rcu(void);
 
 #define __nmi_exit()						\
 	do {							\
-		unsigned int nesting;				\
 		BUG_ON(!in_nmi());				\
-		__preempt_count_sub(HARDIRQ_OFFSET);		\
-		nesting = __this_cpu_dec_return(nmi_nesting);	\
-		if (!nesting)					\
-			__preempt_count_sub(NMI_OFFSET);	\
+		__preempt_count_nmi_exit();			\
 		arch_nmi_exit();				\
 		lockdep_on();					\
 	} while (0)
diff --git a/include/linux/preempt.h b/include/linux/preempt.h
index 33fc4c814a9f..87d5367f986c 100644
--- a/include/linux/preempt.h
+++ b/include/linux/preempt.h
@@ -30,18 +30,20 @@
  * NMI nesting depth is tracked in a separate per-CPU variable
  * (nmi_nesting) to save bits in preempt_count.
  *
- *         PREEMPT_MASK:	0x000000ff
- *         SOFTIRQ_MASK:	0x0000ff00
- * HARDIRQ_DISABLE_MASK:	0x00ff0000
- *         HARDIRQ_MASK:	0x0f000000
- *             NMI_MASK:	0x10000000
- * PREEMPT_NEED_RESCHED:	0x80000000
+ *				32bit		HAS_SEPARATE_PREEMPT_RESCHED_BITS
+ *
+ *         PREEMPT_MASK:	0x000000ff	0x00000000000000ff
+ *         SOFTIRQ_MASK:	0x0000ff00	0x000000000000ff00
+ * HARDIRQ_DISABLE_MASK:	0x00ff0000	0x0000000000ff0000
+ *         HARDIRQ_MASK:	0x0f000000	0x000000000f000000
+ *             NMI_MASK:	0x10000000	0x00000000f0000000
+ * PREEMPT_NEED_RESCHED:	0x80000000	0x8000000000000000
  */
 #define PREEMPT_BITS	8
 #define SOFTIRQ_BITS	8
 #define HARDIRQ_DISABLE_BITS	8
 #define HARDIRQ_BITS	4
-#define NMI_BITS	1
+#define NMI_BITS	(1 + 3*IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS))
 
 #define PREEMPT_SHIFT	0
 #define SOFTIRQ_SHIFT	(PREEMPT_SHIFT + PREEMPT_BITS)
@@ -116,8 +118,8 @@ static __always_inline unsigned char interrupt_context_level(void)
  * preempt_count() is commonly implemented with READ_ONCE().
  */
 
-#define nmi_count()	(preempt_count() & NMI_MASK)
-#define hardirq_count()	(preempt_count() & HARDIRQ_MASK)
+#define nmi_count()		(preempt_count() & NMI_MASK)
+#define hardirq_count()		(preempt_count() & HARDIRQ_MASK)
 #ifdef CONFIG_PREEMPT_RT
 # define softirq_count()	(current->softirq_disable_cnt & SOFTIRQ_MASK)
 # define irq_count()		((preempt_count() & (NMI_MASK | HARDIRQ_MASK)) | softirq_count())
diff --git a/kernel/Kconfig.preempt b/kernel/Kconfig.preempt
index 88c594c6d7fc..35f546a042b1 100644
--- a/kernel/Kconfig.preempt
+++ b/kernel/Kconfig.preempt
@@ -122,6 +122,10 @@ config PREEMPT_RT_NEEDS_BH_LOCK
 config PREEMPT_COUNT
        bool
 
+config HAS_SEPARATE_PREEMPT_RESCHED_BITS
+	bool
+	depends on PREEMPT_COUNT && 64BIT
+
 config PREEMPTION
        bool
        select PREEMPT_COUNT
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 636e6a15f104..f4c944878516 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5847,8 +5847,13 @@ void preempt_count_add(int val)
 #ifdef CONFIG_DEBUG_PREEMPT
 	/*
 	 * Underflow?
+	 *
+	 * Cannot detect underflow based on the current preempt_count() value
+	 * if using HAS_SEPARATE_PREEMPT_RESCHED_BITS because preempt count takes all 32
+	 * bits.
 	 */
-	if (DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
+	if (!IS_ENABLED(CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS) &&
+	    DEBUG_LOCKS_WARN_ON((preempt_count() < 0)))
 		return;
 #endif
 	__preempt_count_add(val);
@@ -5880,7 +5885,10 @@ void preempt_count_sub(int val)
 	/*
 	 * Underflow?
 	 */
-	if (DEBUG_LOCKS_WARN_ON(val > preempt_count()))
+	unsigned int uval = val;
+	unsigned int pc = preempt_count();
+
+	if (DEBUG_LOCKS_WARN_ON(pc - uval > pc))
 		return;
 	/*
 	 * Is the spinlock portion underflowing?
diff --git a/kernel/softirq.c b/kernel/softirq.c
index d1ab1799794c..491136a313db 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -91,7 +91,13 @@ EXPORT_PER_CPU_SYMBOL_GPL(hardirq_context);
 DEFINE_PER_CPU(struct interrupt_disable_state, local_interrupt_disable_state);
 EXPORT_PER_CPU_SYMBOL_GPL(local_interrupt_disable_state);
 
+#ifndef CONFIG_HAS_SEPARATE_PREEMPT_RESCHED_BITS
+/*
+ * Any 32bit architecture that still cares about performance should
+ * probably ensure this is near preempt_count.
+ */
 DEFINE_PER_CPU(unsigned int, nmi_nesting);
+#endif
 
 /*
  * SOFTIRQ_OFFSET usage:
diff --git a/lib/locking-selftest.c b/lib/locking-selftest.c
index d939403331b5..8fd216bd0be6 100644
--- a/lib/locking-selftest.c
+++ b/lib/locking-selftest.c
@@ -1429,7 +1429,7 @@ static int unexpected_testcase_failures;
 
 static void dotest(void (*testcase_fn)(void), int expected, int lockclass_mask)
 {
-	int saved_preempt_count = preempt_count();
+	long saved_preempt_count = preempt_count();
 #ifdef CONFIG_PREEMPT_RT
 #ifdef CONFIG_SMP
 	int saved_mgd_count = current->migration_disabled;
-- 
2.50.1 (Apple Git-155)

