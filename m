Received: from mail-pj1-f41.google.com (mail-pj1-f41.google.com [209.85.216.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3ABCA2773EE
	for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 19:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765739371; cv=none; b=O5tFPBetrcx7WN6Z7Ob1cZ1LFRcDN4ociex0PY3k7B5FFLt4MQFFJSH6+5ORmeBcTFLqV7r2Yxi2FtrJ/zCo+9OjF4qonK2yIw1WEMcMMkMdB11DVd5puj6oU7rZc72sPUlsrTGyD4HuqtXPXhuovu9Q61cJ9a47AnXKdCkNubM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765739371; c=relaxed/simple;
	bh=U7xYpqH6Xjygz0nh5JVeS24RCjCARABAZNiTaL/Zhgs=;
	h=From:To:Cc:Subject:Date:Message-ID:MIME-Version; b=KHrITTE16v7K7EiQS0JupIJaTB/cKuiwJp8e746CS6aNmBF64alMG2WkDdBayntUVnK7Xq4DbOO57i7NM125WsK1PAnfzU/T6RAM1MRYaCAzlraUBmB4qtXgCjoJ3fWpOT3V3mSLWhAL0+n/Y/X1olmyYKTC/c5HZA7uGuz/XpY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=k8xqB0+A; arc=none smtp.client-ip=209.85.216.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="k8xqB0+A"
Received: by mail-pj1-f41.google.com with SMTP id 98e67ed59e1d1-34ab8e0df53so2781996a91.3
        for <linux-s390@vger.kernel.org>; Sun, 14 Dec 2025 11:09:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765739369; x=1766344169; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=gwYfFrZqTktG5EJwSuxB41ry/yys4SZ6gm7ldRmxLAk=;
        b=k8xqB0+ASxzB3T871Oc5KRMGkQLFwX8ujYomthQSTcQqmq3v3ejvSOlRDXIljPC6ox
         ghYk4NYVooi4JOtpZIOCL7gVJPDJjBwkMJmGJV+blIMuuL1vLz7YOWS2gSr4cEfEGTbX
         WXthnnI2aFG7ODaiqWwwWEY/AvJ3AW7vI2g09ZE27YSf7PGZJ6hWFbIpBrjCr2bHn74C
         ziAo1OpaJ0hrFCPaToApVANrIb1oMsVRLBGk/jyG7K7V2WKQPu+GtrT+1/eoxzBAppQe
         M99h6hbhvKdbjcP+RnX1B4Zj29yUBhsFYb0pO0Wo7IkRO9whhUEwtGZvHIuja4BtqibO
         7TOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765739369; x=1766344169;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gwYfFrZqTktG5EJwSuxB41ry/yys4SZ6gm7ldRmxLAk=;
        b=vFgEMN5GU//Ih6Sif/Q1EYcX95de4L/vkR+nRrDyXOwimMhghILhMR/8xuNDB8t9nc
         G81uB+3Oel7sEM3VwKr1HVf6ioTYt5ul9kn2A/bXN9lg7P8iGw9k6/D84tpokxngKo5U
         mgOzu84mYBSX8/sg1hR/Q9v4DM+MGHYV1u9Ck5hajiEQ2FNvvrgvpdvupEdbhiigRow4
         XjSU3Ps7wGR3wWkouYjP0Qg2siKvVxfHzIasrvw5lEmxX5qiwnJzuVEaf8eSy7jkUF5H
         lvYpe5aHMasPU/cIf+n1k26lYnXcfN4CTo9rQVDGQa5YtJrBaLma36al0jgIoFDVK2Z7
         73WQ==
X-Forwarded-Encrypted: i=1; AJvYcCWAsW+E5kXL5wxwKIMeJt1eHd+uwd1+XMDs6ICvE8yH2adUcp/VMuINv6mBQ5KJJhOSD4479tiv8vO5@vger.kernel.org
X-Gm-Message-State: AOJu0YwMk9Dp6IDsJ7xS1NkZfeBYtrp2YQBY7GNRpYi9aWjr7SOX7Rk0
	zfLyS2c/FC1Q+xKHfENi+fNBcepxyLX0L7yCOUGbqwoVeF3bgMI2mfor
X-Gm-Gg: AY/fxX7c0rsYUSsw55IV0ffajAl+/CIAzDtgPKrG6YgV+E5OMVJsZxiUnKtzY7QwjKt
	B7cl7iZxH9EoXHxrgRxvmy9URgqRXGY0h/b1walA5pMrTY7s6sYLzXQIqSuCa7kvPVfuTXzKXNH
	rusgLmzMuZLK0buebiygq6srPaoYyOMn6VziEnEDiwgGRilluY2SyWzab4P1oI9BMRahWgljDEP
	0/9Pqz55ZXNXIHtbNB9j5pzmZxb2hFeVn8+R0rXv28YPU2rxz7P+1ALQEzKfWtr5eJTB8XfWGrx
	RKZF1GaO878C0Z3CMBwfVlPy4UpLjfwJPv6mGZvP+/JCH7mclp1BeaZrsMFuxIkTIbnQu7VIkC+
	UFvu18l3/TCT3gbN50nIPcLN+OkbRwaww8ik3kK0xbgNY8r9x/JKpadKvZ3t1iT46iZ0u4Zbar3
	DRY6KntcCW1C2tVoWFzOe/1MOr2EIfaAs=
X-Google-Smtp-Source: AGHT+IEzpAy6UzgKIaiNt30d6EFJXNojhkWsj/5bF1U6wDYKXx63j5RZJjCyAmw8FWWcopaIqnD09w==
X-Received: by 2002:a17:90b:3fc6:b0:343:60ab:ca8e with SMTP id 98e67ed59e1d1-34abd76ca02mr8890426a91.17.1765739369247;
        Sun, 14 Dec 2025 11:09:29 -0800 (PST)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-34abe3a1c5esm6909062a91.3.2025.12.14.11.09.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 14 Dec 2025 11:09:28 -0800 (PST)
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
Subject: [PATCH v5 0/3] Optimize code generation during context switching
Date: Mon, 15 Dec 2025 03:09:04 +0800
Message-ID: <20251214190907.184793-1-qq570070308@gmail.com>
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

It is found that finish_task_switch() is not inlined even in the O2 level
optimization. This may affect performance for the following reasons:
1. It is in the context switching code, which is a hot code path.

2. Because of the modern CPU vulnerabilities, kernel is likely to perform
some mitigations inside switch_mm_irq_off() and switch_to(), which may
include branch prediction hardening, clearing the instruction cache and
L1D cache, etc.
finish_task_switch() is right after these, so the performance here is
greatly affected by function calls and branch jumps.

3. The __schedule function has __sched attribute, which makes it be
placed in the ".sched.text" section, while finish_task_switch() does not,
which causes their distance to be very far in binary, aggravating the
above performance degradation.

This series of patches primarily make some functions called in context
switching as always inline to optimize performance. Here is the test data:

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

Test information:
1. Testing baseline source: commit d9771d0dbe18dd643760 ("Add linux-next
specific files for 20251212") from linux-next branch.

2. Testing config:
x86-64: `make x86_64_defconfig` first, then menuconfig setting:
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_STACKPROTECTOR=n
CONFIG_BLK_DEV_NVME=y (just for boot)

arm64: `make defconfig` first, then menuconfig setting:
CONFIG_KVM=n
CONFIG_HZ=100
CONFIG_SHADOW_CALL_STACK=y

arm32: `make multi_v7_defconfig` first, then menuconfig setting:
CONFIG_ARCH_OMAP2PLUS_TYPICAL=n
CONFIG_HIGHMEM=n

3. Testing compiler:
llvm: Debian clang version 21.1.7 (1) + Debian LLD 21.1.7
gcc: x86-64: gcc version 15.2.0 (Debian 15.2.0-11)
     arm64/arm32: gcc version 15.2.0 (Debian 15.2.0-7) +
     GNU ld (GNU Binutils for Debian) 2.45.50.20251209

4. Test appending cmdline:
isolcpus=3 to obtain more stable test results (assuming the test is run
on cpu3).
spectre_v2_user=on on x86-64 to force enable mitigations.

5. Test source:
kernel:
```patch
diff --git a/arch/arm/tools/syscall.tbl b/arch/arm/tools/syscall.tbl
index fd09afae72a2..40ce1b28cb27 100644
--- a/arch/arm/tools/syscall.tbl
+++ b/arch/arm/tools/syscall.tbl
@@ -485,3 +485,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	sched_test			sys_sched_test
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
diff --git a/include/linux/syscalls.h b/include/linux/syscalls.h
index cf84d98964b2..53f0d2e745bd 100644
--- a/include/linux/syscalls.h
+++ b/include/linux/syscalls.h
@@ -441,6 +441,7 @@ asmlinkage long sys_listmount(const struct mnt_id_req __user *req,
 asmlinkage long sys_listns(const struct ns_id_req __user *req,
 			   u64 __user *ns_ids, size_t nr_ns_ids,
 			   unsigned int flags);
+asmlinkage long sys_sched_test(void);
 asmlinkage long sys_truncate(const char __user *path, long length);
 asmlinkage long sys_ftruncate(unsigned int fd, off_t length);
 #if BITS_PER_LONG == 32
diff --git a/include/uapi/asm-generic/unistd.h b/include/uapi/asm-generic/unistd.h
index 942370b3f5d2..65023afc291b 100644
--- a/include/uapi/asm-generic/unistd.h
+++ b/include/uapi/asm-generic/unistd.h
@@ -860,8 +860,11 @@ __SYSCALL(__NR_file_setattr, sys_file_setattr)
 #define __NR_listns 470
 __SYSCALL(__NR_listns, sys_listns)
 
+#define __NR_listns 471
+__SYSCALL(__NR_sched_test, sys_sched_test)
+
 #undef __NR_syscalls
-#define __NR_syscalls 471
+#define __NR_syscalls 472
 
 /*
  * 32 bit systems traditionally used different
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 41ba0be16911..f53a423c8600 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5191,6 +5191,31 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
+static DEFINE_PER_CPU(uint64_t, total_time);
+
+static __always_inline uint64_t test_gettime(void)
+{
+#ifdef CONFIG_X86_64
+	register uint64_t rax __asm__("rax");
+	register uint64_t rdx __asm__("rdx");
+
+	__asm__ __volatile__ ("rdtsc" : "=a"(rax), "=d"(rdx));
+	return rax | (rdx << 32);
+#elif defined(CONFIG_ARM64)
+	uint64_t ret;
+
+	__asm__ __volatile__ ("mrs %0, cntvct_el0" : "=r"(ret));
+	return ret;
+#elif defined(CONFIG_ARM)
+	uint64_t ret;
+
+	__asm__ __volatile__ ("mrrc p15, 1, %Q0, %R0, c14" : "=r" (ret));
+	return ret;
+#else
+#error "Not support"
+#endif
+}
+
 /*
  * context_switch - switch to the new MM and the new thread's register state.
  */
@@ -5256,7 +5281,15 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	{
+		uint64_t end_time;
+		// add volatile to let it alloc on stack
+		__volatile__ uint64_t start_time = test_gettime();
+		rq = finish_task_switch(prev);
+		end_time = test_gettime();
+		raw_cpu_add(total_time, end_time - start_time);
+	}
+	return rq;
 }
 
 /*
@@ -10827,3 +10860,32 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+static struct task_struct *wait_task;
+#define PRINT_PERIOD (1U << 20)
+static DEFINE_PER_CPU(uint32_t, total_count);
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
+		if (unlikely(raw_cpu_inc_return(total_count) == PRINT_PERIOD)) {
+			const uint64_t total = raw_cpu_read(total_time);
+			uint64_t tmp_h, tmp_l;
+
+			tmp_h = total * 100000;
+			do_div(tmp_h, (uint32_t)PRINT_PERIOD);
+			tmp_l = do_div(tmp_h, (uint32_t)100000);
+
+			pr_emerg("cpu[%d]: total cost time %llu in %u tests, %llu.%05llu per test\n", raw_smp_processor_id(), total, PRINT_PERIOD, tmp_h, tmp_l);
+			raw_cpu_write(total_time, 0);
+			raw_cpu_write(total_count, 0);
+		}
+	}
+	return 0;
+}
diff --git a/scripts/syscall.tbl b/scripts/syscall.tbl
index e74868be513c..2a2d8d44cb3f 100644
--- a/scripts/syscall.tbl
+++ b/scripts/syscall.tbl
@@ -411,3 +411,4 @@
 468	common	file_getattr			sys_file_getattr
 469	common	file_setattr			sys_file_setattr
 470	common	listns				sys_listns
+471	common	sched_test			sys_sched_test
```

User program:
```c
int main()
{
	cpu_set_t mask;

	if (fork())
		sleep(1);

	CPU_ZERO(&mask);
	CPU_SET(3, &mask); // Assume that cpu3 exists
	assert(sched_setaffinity(0, sizeof(mask), &mask) == 0);
	syscall(471);
	// unreachable
	return 0;
}
```

Usage:
1. Patch the kernel and run the user programe.
2. Wait for kernel print.

v4->v5: https://lore.kernel.org/20251123121827.1304-1-qq570070308@gmail.com
  - Rebase to the latest linux-next source.
  - Improve the test code and retest.
  - Add the test of AMD 9600x and Raspberry Pi 3b.

v3->v4: https://lore.kernel.org/20251113105227.57650-1-qq570070308@gmail.com
  - Improve the commit message

v2->v3: https://lore.kernel.org/20251108172346.263590-1-qq570070308@gmail.com
  - Fix building error in patch 1
  - Simply add the __always_inline attribute to the existing function,
    Instead of adding the always inline version functions

v1->v2: https://lore.kernel.org/20251024182628.68921-1-qq570070308@gmail.com
  - Make raw_spin_rq_unlock() inline
  - Make __balance_callbacks() inline
  - Add comments for always inline functions
  - Add Performance Test Data

Xie Yuanbin (3):
  x86/mm/tlb: Make enter_lazy_tlb() always inline on x86
  sched: Make raw_spin_rq_unlock() inline
  sched/core: Make finish_task_switch() and its subfunctions always
    inline

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

