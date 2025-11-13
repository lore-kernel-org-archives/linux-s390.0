Received: from mail-pj1-f48.google.com (mail-pj1-f48.google.com [209.85.216.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94B85332907
	for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 10:52:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763031176; cv=none; b=aElIRGrgnZGRsD3z8pqL3EkPYNPfw+3F8WRxQDHJ8KZjPx4GkHRaAZm9wV2CpjmJW/YU7d+iiMg5ZlO9LarqzA0NXl1sbdX+FIe9CqOXQYbhTggjqAKMrktRB4Jv7noko/Dr+WIhSitbyDg923lCgDKBPZumPlCW5Rj+geBsMuE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763031176; c=relaxed/simple;
	bh=ptjnN+kV6KtL9cjMx1i4vilb0N1AN7KTugMe4NyA6zk=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=BamLS0ikSpXp1vKybIt6cYPhltqqkp1etihQ4aepuN3a+ArA9FJbyT2tixWBm53eGeD+/vzzQe0QTmmF7yxboXX/woB73ErDJTylax1B1DygsGcgnwHeQgTqhY5gLDZjFa9a/mRrDEaShpuzEnyaDs1HAxyD2wr76ouD4rhcgD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=WUEAdvHt; arc=none smtp.client-ip=209.85.216.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WUEAdvHt"
Received: by mail-pj1-f48.google.com with SMTP id 98e67ed59e1d1-3437ea05540so667434a91.0
        for <linux-s390@vger.kernel.org>; Thu, 13 Nov 2025 02:52:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1763031174; x=1763635974; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=3OrLY1Uohp4fNrpBoSywOsXuTx3rqnDqEt2AlKMMSpE=;
        b=WUEAdvHtk39Ef92MgKvBDjyB91pInZlKhkChZhKq72cQha3UFIbikQdlykmF9J4HKb
         0yjfXuOeFUWwWnTvsD//wkWZJLF/suCzzCeiV+s2aPt8LUvybIozBNC/j4rGkmOcATf0
         N5/OAf+XDReo/c8KuvPVs7gGi6RIgQ2B5qswtQEbwYh6RjNCOaNEy74WaGUlL7GnXIRb
         97XgEdMzS9QU41H9aP0MXCxbe/Z02RIY2pXoFe+Px+x5S5rGvK+vuEXcsmFZvPuG9cw2
         +1qaCBqPtnaQQ5JCdU0zFJr/RRb51CbuKKoIt8XGNDnPVzKsw71wwxjtPkpBC8lPqjVb
         oPpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763031174; x=1763635974;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3OrLY1Uohp4fNrpBoSywOsXuTx3rqnDqEt2AlKMMSpE=;
        b=woq1KiyJjbwe0oyN+n3PhrU0kqjMro8cvHNboMg9qpmN5vDQBAKh3Tuy++e2iMTb5U
         qUS/9gUnNel/KV4WENA4zTvSamEmGLdlmhMi3KwB10jb48PEuOoe54O4VQIuPCrJCAS4
         Xo0IrZF1s4P+jqeSknUwnhqM4I8CkOIvyxym/kLaAHV6dLnGtD/bf/NP2fKctGvpQS3T
         ShtAXQUhsKNer90wQwEuFhZAgaUI0ruf0LSkbE46j2sS/c4Cjxu8q8fkAtekYFYPORNa
         cs9Uok9KMNqMIHrXl90rYwW5nssE0nZX+QE/GBpr/PEkluzsh41Osi2EX/Va06xjJb/b
         u6iw==
X-Forwarded-Encrypted: i=1; AJvYcCW8wJAQyLEDtcEZwu4vqsx1dDQfxG7NMr/1xmT2WHz/gTcRDOMi5HSLiHKUoLD1sstpET5egNxex+tK@vger.kernel.org
X-Gm-Message-State: AOJu0YzoujuGB0+a5TYVw2rWPiuhKrnDGQRQ7corDoT04KfRbhtgj2tP
	hmVwIl5rK7flMEmmLXzynfp4q93HRwY8jHs8+k93LzF9elnsx9/h5icD
X-Gm-Gg: ASbGncsocH7IofZX27UcMN9ezOqeTdL8Ql2vvrtBJhfj02QWnEZJiVkF1a441bUPhLg
	eGZ1J2qzbKRPL5Q40esNFjm39UYzRbe8bf2o5UL/n28NL3YuVxnJwSsCKZHDv4q7xV5eTCzs5if
	KV8ohtS4Ra7BJ7KoZPWZIBHRS72nAETluk2DPtDJ+2l5t/sUKrc+rb+/X2yZyWYOk0gvL+yYbU3
	RMMhzsFtX1WvQAQpWYSHXTL4/tApQo81Fe0sQfpwbPiYvUb2lt9MPcRb4gpMdXrDP+aLDXNpJGz
	ovakBrL4xyHXiPevr5C1ESksb1FvLrHBgM9W7wpInLDW6m2ylC8aJTaveamZgaj7vXqEZpcODPb
	aWGOTo5b+XhxefG7ht4NOTuu3vRO5U1ZxnMWTorckSXQhrjefST+njd/4HOq/VrMEi9H9Nums4N
	VMEarAaAeAnCpCxRicDud/pvryN1nhPRyro90=
X-Google-Smtp-Source: AGHT+IHzp6UCtl35V4whLnPDL/LSjb2HQjwqo7fMEKu5Lo9MkJ9BX0nvNUtMKAS1HyvsK3oZoUW6iA==
X-Received: by 2002:a17:90a:fc50:b0:343:a631:28a8 with SMTP id 98e67ed59e1d1-343dded5123mr8338802a91.37.1763031173562;
        Thu, 13 Nov 2025 02:52:53 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-343ed4c939dsm2139616a91.6.2025.11.13.02.52.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Nov 2025 02:52:52 -0800 (PST)
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
Subject: [PATCH v3 0/3] Optimize code generation during context switching
Date: Thu, 13 Nov 2025 18:52:24 +0800
Message-ID: <20251113105227.57650-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

The purpose of this series of patches is to optimize the performance of
context switching. It does not change the code logic, but only modifies
the inline attributes of some functions.

It is found that `finish_task_switch` is not inlined even in the O2 level
optimization. This may affect performance for the following reasons:
1. It is in the context switching code, which is a hot code path.
2. Because of the modern CPU mitigations for vulnerabilities, inside
switch_mm, the instruction pipeline and cache may be cleared.
finish_task_switch is right after that, so the performance is greatly
affected by function calls and branch jumps.
3. The __schedule function has __sched attribute, which makes it be
placed in the ".sched.text" section, while finish_task_switch does not,
which causes their distance to be very far in binary, aggravating the
above performance degradation.

This series of patches mainly does the following things:
1. Make enter_lazy_tlb inline on x86.
2. Make raw_spin_rq_unlock inline.
3. Let the finish_task_switch function be called inline during context
switching.
4. Set the subfunctions called by finish_task_switch to be inline:
After finish_task_switch is changed to an inline function, the number of
calls to the subfunctions (called by finish_task_switch) increases in
this translation unit due to the inline expansion of finish_task_switch.
For example, the finish_lock_switch function originally had only one
calling point in core.o (in finish_task_switch func), but because the
finish_task_switch was inlined, the calling points become two.
Due to compiler optimization strategies, these functions may transition
from inline functions to non inline functions, which can actually lead to
performance degradation.
Make the subfunctions of finish_task_stwitch inline to prevent
degradation.

Performance test data for these patches:
Time spent on calling finish_task_switch (unit: rdtsc):
 | compiler && appended cmdline | without patches | with patches  |
 | gcc + NA                     | 13.93 - 13.94   | 12.39 - 12.44 |
 | gcc + "spectre_v2_user=on"   | 24.69 - 24.85   | 13.68 - 13.73 |
 | clang + NA                   | 13.89 - 13.90   | 12.70 - 12.73 |
 | clang + "spectre_v2_user=on" | 29.00 - 29.02   | 18.88 - 18.97 |

Note: I use x86 for testing here. Different architectures have different
cmdlines for configuring mitigations. For example, on arm64, spectre v2
mitigation is enabled by default, and it should be disabled by adding
"nospectre_v2" to the cmdline.

Test info:
1. kernel source:
linux-next
commit 9c0826a5d9aa4d52206d ("Add linux-next specific files for 20251107")
2. test machine:
cpu: intel i5-8300h@4Ghz
mem: DDR4 2666MHz
Bare-metal boot, non-virtualized environment
3. compiler:
gcc: gcc version 15.2.0 (Debian 15.2.0-7) with
GNU ld (GNU Binutils for Debian) 2.45
clang: Debian clang version 21.1.4 (8) with
Debian LLD 21.1.4 (compatible with GNU linkers)
4. config:
base on default x86_64_defconfig, and setting:
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_CGROUPS=n
CONFIG_BLK_DEV_NVME=y
5. test method:
Use rdtsc (cntvct_el0 can be use on arm64/arm) to obtain timestamps
before and after finish_task_switch calling point, and created multiple
processes to trigger context switches, then calculated the average
duration of the finish_task_switch call.
Note that using multiple processes rather than threads is recommended for
testing, because this will trigger switch_mm (where spectre v2 mitigations
may be performed) during context switching.
The test code is attached at the end of the mail.


I also tested the impact on bzImage size, which may affect
embedded devices:
1. kernel source && compiler: same as above
2. config:
base on default x86_64_defconfig, and setting:
CONFIG_SCHED_CORE=y
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_NO_HZ_FULL=y

bzImage size:
 | compiler | without patches | with patches  |
 | clang    | 13722624        | 13722624      |
 | gcc      | 12596224        | 12596224      |

No size changes were found on bzImage.

testing code:
kernel(just for testing, not a commit):
```c
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index 8a4ac4841be6..5a42ec008620 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -395,6 +395,7 @@
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
 470	common	listns			sys_listns
+471	common	sched_test		sys_sched_test
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 81cf8452449a..d7e2095aeb7d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5195,6 +5195,36 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
+static DEFINE_PER_CPU(uint64_t, start_time);
+static DEFINE_PER_CPU(uint64_t, total_time);
+static DEFINE_PER_CPU(uint64_t, total_count);
+
+static __always_inline uint64_t test_rdtsc(void)
+{
+    register uint64_t rax __asm__("rax");
+    register uint64_t rdx __asm__("rdx");
+
+    __asm__ __volatile__ ("rdtsc" : "=a"(rax), "=d"(rdx));
+    return rax | (rdx << 32);
+}
+
+static __always_inline void test_start(void)
+{
+	raw_cpu_write(start_time, test_rdtsc());
+}
+
+static __always_inline void test_end(void)
+{
+	const uint64_t end_time = test_rdtsc();
+	const uint64_t cost_time = end_time - raw_cpu_read(start_time);
+
+	raw_cpu_add(total_time, cost_time);
+	if (unlikely(raw_cpu_inc_return(total_count) % (1 << 20) == 0)) {
+		pr_emerg("cpu %d total_time %llu\n", raw_smp_processor_id(), raw_cpu_read(total_time));
+		raw_cpu_write(total_time, 0);
+	}
+}
+
 /*
  * context_switch - switch to the new MM and the new thread's register state.
  */
@@ -5264,7 +5294,10 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	test_start();
+	rq = finish_task_switch(prev);
+	test_end();
+	return rq;
 }
 
 /*
@@ -10861,3 +10894,18 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+static struct task_struct *wait_task;
+
+SYSCALL_DEFINE0(sched_test)
+{
+	preempt_disable();
+	while (1) {
+		if (likely(wait_task))
+			wake_up_process(wait_task);
+		wait_task = current;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		__schedule(SM_NONE);
+	}
+	return 0;
+}
```

User program:
```c
int main()
{
	cpu_set_t mask;
	if (fork())
		sleep(1);

	CPU_ZERO(&mask);
	CPU_SET(5, &mask); // Assume that cpu5 exists
	assert(sched_setaffinity(0, sizeof(mask), &mask) == 0);
	syscall(471);
	// unreachable
	return 0;
}
```

Usage:
1. set core5 as isolated cpu: add "isolcpus=5" to cmdline
2. run user programe
3. wait for kernel print

v2->v3: https://lore.kernel.org/20251108172346.263590-1-qq570070308@gmail.com
  - Fix building error in patch 1
  - Simply add the __always_inline attribute to the existing function,
    Instead of adding the always inline version functions

v1->v2: https://lore.kernel.org/20251024182628.68921-1-qq570070308@gmail.com
  - Make raw_spin_rq_unlock inline
  - Make __balance_callbacks inline
  - Add comments for always inline functions
  - Add Performance Test Data

Xie Yuanbin (3):
  Make enter_lazy_tlb inline on x86
  Make raw_spin_rq_unlock inline
  Make finish_task_switch and its subfuncs inline in context switching

 arch/arm/include/asm/mmu_context.h      |  2 +-
 arch/riscv/include/asm/sync_core.h      |  2 +-
 arch/s390/include/asm/mmu_context.h     |  2 +-
 arch/sparc/include/asm/mmu_context_64.h |  2 +-
 arch/x86/include/asm/mmu_context.h      | 23 ++++++++++++++++++++++-
 arch/x86/include/asm/sync_core.h        |  2 +-
 arch/x86/mm/tlb.c                       | 21 ---------------------
 include/linux/perf_event.h              |  2 +-
 include/linux/sched/mm.h                | 10 +++++-----
 include/linux/tick.h                    |  4 ++--
 include/linux/vtime.h                   |  8 ++++----
 kernel/sched/core.c                     | 19 +++++++------------
 kernel/sched/sched.h                    | 24 ++++++++++++++----------
 13 files changed, 60 insertions(+), 61 deletions(-)

-- 
2.51.0

