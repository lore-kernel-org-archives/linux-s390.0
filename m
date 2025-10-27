Received: from mail-pg1-f177.google.com (mail-pg1-f177.google.com [209.85.215.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7931730ACEC
	for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 15:21:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1761578492; cv=none; b=XzYG7f+L3kGYA0sRfXGUaSZAhMXUPCJUPtuDY1f0F9Eb3r7CdI9NH3gEO6HY8jKItt+ppDvWAjcLykQCH9H414QTdCFirDlxJPzJ2BdsNjJ7wfHGFe0MAHF/rseM0wUGQi2MgjC56cVfZwaoqD5YzmTnPIJAHU8d4e+irwAJeZk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1761578492; c=relaxed/simple;
	bh=uzvdb9L2hEpKRhWkf7joC4v7ZGbAToUwxioRTGyJ/ow=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=M5pA4SNhAMeRs7Zas1oSg7cBeHuhZFNZyHfKhqgMwWenxBLkXHFaVKWVHRW+i7OtP3I9/DIBQbaZUp9rR36BqapCN94+XRyCs1rEUVAM4rgFjvWT5MnK0aEE3fq9hPQuBr9Xp1vdH+Yt2cDqWA/6U9XOHN6iXpRbUYY0znkjAhY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=M89HVh23; arc=none smtp.client-ip=209.85.215.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="M89HVh23"
Received: by mail-pg1-f177.google.com with SMTP id 41be03b00d2f7-b6cf257f325so3904671a12.2
        for <linux-s390@vger.kernel.org>; Mon, 27 Oct 2025 08:21:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1761578489; x=1762183289; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FAuDRjv5uAXTsOVI/eb5J4UAMhtSLGfuIUeu/cvlLSU=;
        b=M89HVh23br6q7FGgKVxb3K+hEvL84SekdFMj3Eskwjy7b2lWpCaPEpQyXM7QGyfYY1
         0WUQ38KB5OEugmPq9nnOdqAx548cFHeJaNsSRW57Em7+Uv/D6B/aXuq4mHOu2AYcaJYL
         w6EBxFa/ThMuG4tpbdytBWKBuL/eP/+MoNu3LfPXzxhQKS7kCbHnsZev95JIvhoICFur
         SXEFZYF3J+tyTOLDDVCmKcNVaLwPJUK8A+CRoQVkllBCVi7TnmJ0ct7DVOCrQ1eLR4Eu
         nnnlmqUbX7BhUfYPhLGsTKXIWZhGQc1FiJASAQ178b4s9gQ364kAnl2ZR8TFAg1dAHcJ
         2t4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1761578490; x=1762183290;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FAuDRjv5uAXTsOVI/eb5J4UAMhtSLGfuIUeu/cvlLSU=;
        b=oDWVY7IvSKrpS0gN9tZzmsHEf5mByny6Zoliw16398UsLYHoophy/ZceaqSHiVY6YE
         cf2voli+RrkNB2UTBh6TY9Yw7FTWmpfQ9ZR+iOV03P0JLGsvy9HIZ+waoKUYMx59Jxqn
         QySmkoqudh05/WtGSY1vQWRe0trbdvCIjG6qJVSK1ecnJux+ZISE5swipBgf9qC3mRFU
         NF/jYQMbNwv4xS5Qivh9zSsxPqc3FrmyCa6SHSAAaGFwxOAEGeGs8kUfP2YnQzeioXj6
         LKpDPOWqty6w/An4pSwA0TOz1aVEWTtTvE6mtdJ0rit6Fs5Ng6cSEzH0cHXrvIzV3j0B
         SnbQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE5UpVqPMdUo3YZ+rzJVSyqpHChhSBQbubUU9XgYjMLPGozoQgIuuIB/aOlluAeyWq9shSMvJ5EdAc@vger.kernel.org
X-Gm-Message-State: AOJu0YyBxbWWA9BZH2d1uaHOB2f46DAJaWtMOLGOhw1vTk/fUFqQFBb5
	PG0GgUoRw/frRwpSdlU+5oKdxM875f14cnFDrEgpnN3h2UXbnBLZ8nF/
X-Gm-Gg: ASbGncs2x6mkUIN7QRCZ3EaxJ/4m0nV2fAv6x6dnkumP42oaI7j2gzTN9JH7ZRvYhav
	E5ZJkakdTPizwY71ncpD1uVjRM7HmxG/VGOPEItMxvSTN3WLqTo+mMsGGungH00YwsBZPirsJzv
	hDXRLYdeGyjoqU9aMKzSxZmFS7MBR+p8EOHsPtD+16tNVzIOjx5C/43anwsGAJPjB62vk4qZQOt
	2FwPgENkhjaIuuyjtZbkaN9iUlJr8G+MtNeCHf98mW01x+JuynrOHeOhJZNJp03DMZpTXXDgE+W
	KtOnt05hCTay+yGAp/ZBlOlboCFsHQ+LFXKdwuy9rF+tWx8XRuhuOpTOR0CCN+MlEXmhnpq891L
	hbH90Yvv+pAkDiINPeWefCsIZ9WiHCa6UK/gYeQb4MAVcjUyNo0wVbCzp1px3MMHu6j8um+07G2
	HULeHd+vJo1RHG1QmfW1LdKw76zCpKHB/bVjw=
X-Google-Smtp-Source: AGHT+IE98kyCeEo6PTndR/a9uNVMw9TW4vCsYVgseUaymh3OJieDxpigWzsO7C6JngKgDnTsgFT3wA==
X-Received: by 2002:a17:903:1d0:b0:290:dfab:ca91 with SMTP id d9443c01a7336-294cb68836emr3428795ad.54.1761578489223;
        Mon, 27 Oct 2025 08:21:29 -0700 (PDT)
Received: from DESKTOP-8TIG9K0.localdomain ([119.28.20.50])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-29498cf3426sm87711215ad.7.2025.10.27.08.21.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Oct 2025 08:21:28 -0700 (PDT)
From: Xie Yuanbin <qq570070308@gmail.com>
To: peterz@infradead.org,
	riel@surriel.com,
	segher@kernel.crashing.org,
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
	tglx@linutronix.de,
	mingo@redhat.com,
	bp@alien8.de,
	dave.hansen@linux.intel.com,
	hpa@zytor.com,
	luto@kernel.org,
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
	akpm@linux-foundation.org,
	david@redhat.com,
	lorenzo.stoakes@oracle.com,
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
Subject: Re: [PATCH 0/3] Optimize code generation during context
Date: Mon, 27 Oct 2025 23:21:00 +0800
Message-ID: <20251027152100.62906-1-qq570070308@gmail.com>
X-Mailer: git-send-email 2.51.0
In-Reply-To: <20251024182628.68921-1-qq570070308@gmail.com>
References: <20251024182628.68921-1-qq570070308@gmail.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

I conducted a more detailed performance test on this series of patches.
https://lore.kernel.org/lkml/20251024182628.68921-1-qq570070308@gmail.com/t/#u

The data is as follows:
1. Time spent on calling finish_task_switch (unit: rdtsc):
| compiler && appended cmdline | without patches | with patches  |
| clang + NA                   | 14.11 - 14.16   | 12.73 - 12.74 |
| clang + "spectre_v2_user=on" | 30.04 - 30.18   | 17.64 - 17.73 |
| gcc + NA                     | 16.73 - 16.83   | 15.35 - 15.44 |
| gcc + "spectre_v2_user=on"   | 40.91 - 40.96   | 30.61 - 30.66 |

Note: I use x86 for testing here. Different architectures have different
cmdlines for configuring mitigations. For example, on arm64, spectre v2
mitigation is enabled by default, and it should be disabled by adding
"nospectre_v2" to the cmdline.

2. bzImage size:
| compiler | without patches | with patches  |
| clang    | 13173760        | 13173760      |
| gcc      | 12166144        | 12166144      |

No size changes were found on bzImage.

Test info:
1. kernel source:
latest linux-next branch:
commit id 72fb0170ef1f45addf726319c52a0562b6913707
2. test machine:
cpu: intel i5-8300h@4Ghz
mem: DDR4 2666MHz
Bare-metal boot, non-virtualized environment
3. compiler:
gcc: gcc version 15.2.0 (Debian 15.2.0-7)
clang: Debian clang version 22.0.0 (++20250731080150+be449d6b6587-1~exp1+b1)
4. config:
base on default x86_64_defconfig, and setting:
CONFIG_PREEMPT=y
CONFIG_PREEMPT_DYNAMIC=n
CONFIG_CC_OPTIMIZE_FOR_SIZE=y
CONFIG_HZ=100
CONFIG_DEBUG_ENTRY=n
CONFIG_X86_DEBUG_FPU=n
CONFIG_EXPERT=y
CONFIG_MODIFY_LDT_SYSCALL=n
CONFIG_CGROUPS=n
CONFIG_BUG=n
CONFIG_BLK_DEV_NVME=y
5. test method:
Use rdtsc (cntvct_el0 can be use on arm64/arm) to obtain timestamps
before and after finish_task_switch calling point, and created multiple
processes to trigger context switches, then calculated the average
duration of the finish_task_switch call.
Note that using multiple processes rather than threads is recommended for
testing, because this will trigger switch_mm (where spectre v2 mitigations
may be performed) during context switching.

I put my test code here:
kernel(just for testing, not a commit):
```
diff --git a/arch/x86/entry/syscalls/syscall_64.tbl b/arch/x86/entry/syscalls/syscall_64.tbl
index ced2a1dee..9e72a4a1a 100644
--- a/arch/x86/entry/syscalls/syscall_64.tbl
+++ b/arch/x86/entry/syscalls/syscall_64.tbl
@@ -394,6 +394,7 @@
 467	common	open_tree_attr		sys_open_tree_attr
 468	common	file_getattr		sys_file_getattr
 469	common	file_setattr		sys_file_setattr
+470	common	mysyscall		sys_mysyscall
 
 #
 # Due to a historical design error, certain syscalls are numbered differently
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 1842285ea..bcbfea69d 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5191,6 +5191,40 @@ asmlinkage __visible void schedule_tail(struct task_struct *prev)
 	calculate_sigpending();
 }
 
+static DEFINE_PER_CPU(uint64_t, mytime);
+static DEFINE_PER_CPU(uint64_t, total_time);
+static DEFINE_PER_CPU(uint64_t, last_total_time);
+static DEFINE_PER_CPU(uint64_t, total_count);
+
+static __always_inline uint64_t myrdtsc(void)
+{
+    register uint64_t rax __asm__("rax");
+    register uint64_t rdx __asm__("rdx");
+
+    __asm__ __volatile__ ("rdtsc" : "=a"(rax), "=d"(rdx));
+    return rax | (rdx << 32);
+}
+
+static __always_inline void start_time(void)
+{
+	raw_cpu_write(mytime, myrdtsc());
+}
+
+static __always_inline void end_time(void)
+{
+	const uint64_t end_time = myrdtsc();
+	const uint64_t cost_time = end_time - raw_cpu_read(mytime);
+
+	raw_cpu_add(total_time, cost_time);
+	if (raw_cpu_inc_return(total_count) % (1 << 20) == 0) {
+		const uint64_t t = raw_cpu_read(total_time);
+		const uint64_t lt = raw_cpu_read(last_total_time);
+
+		pr_emerg("cpu %d total_time %llu, last_total_time %llu, cha : %llu\n", raw_smp_processor_id(), t, lt, t - lt);
+		raw_cpu_write(last_total_time, t);
+	}
+}
+
 /*
  * context_switch - switch to the new MM and the new thread's register state.
  */
@@ -5254,7 +5288,10 @@ context_switch(struct rq *rq, struct task_struct *prev,
 	switch_to(prev, next, prev);
 	barrier();
 
-	return finish_task_switch(prev);
+	start_time();
+	rq = finish_task_switch(prev);
+	end_time();
+	return rq;
 }
 
 /*
@@ -10854,3 +10891,19 @@ void sched_change_end(struct sched_change_ctx *ctx)
 		p->sched_class->prio_changed(rq, p, ctx->prio);
 	}
 }
+
+
+static struct task_struct *my_task;
+
+SYSCALL_DEFINE0(mysyscall)
+{
+	preempt_disable();
+	while (1) {
+		if (my_task)
+			wake_up_process(my_task);
+		my_task = current;
+		set_current_state(TASK_UNINTERRUPTIBLE);
+		__schedule(0);
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
	syscall(470);
	// unreachable
	return 0;
}
```

Usage:
1. set core5 as isolated cpu: add "isolcpus=5" to cmdline
2. run user programe
3. wait for kernel print

Everyone is welcome to test it.

Xie Yuanbin
