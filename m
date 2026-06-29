Received: from canpmsgout12.his.huawei.com (canpmsgout12.his.huawei.com [113.46.200.227])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DD7BD405C4E;
	Mon, 29 Jun 2026 13:06:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=113.46.200.227
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782738409; cv=none; b=d0Fa91KA1hBqpm47MVvhTE8D5xT78qSi/AydWXjOhTXNpoPCSlp/ETbICTNubD84QVcfJQe/a0ixKEiUfnR4bMpq+Op4XHyS2LrMs5vnf+oQ/mD21/O+BbCLCrGqK90Q12LCseSDTT/YbwDEs1NYRYL1AAsbYqoceGFLb5AuyE0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782738409; c=relaxed/simple;
	bh=RZQ2vOopZwLs5hcWkD0/+/TY2Jivhra4r1hK8NSN8qI=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JHEsZu/X+ZEYb1OfK1Ql9k636koTBEaNcnDRHARi3qLy9+5EEpsDas+lHnZTdL+JXXo/6Vj5UpeP3qudhGbY7OTfrzc1hkCtRNEDWGT2SoKZ5j3q2YAHiAPAUrtgWK0ltm0gNUyvYahxBHwqqcTRJQnbH3cdSBuIOJGY2mcpFyo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b=1oRqDVsk; arc=none smtp.client-ip=113.46.200.227
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=huawei.com header.i=@huawei.com header.b="1oRqDVsk"
dkim-signature: v=1; a=rsa-sha256; d=huawei.com; s=dkim;
	c=relaxed/relaxed; q=dns/txt;
	h=From;
	bh=FpVjGy5aeSQhunvyi2Xuc17B04S0ouUuvQ1UWTRt8kU=;
	b=1oRqDVskhXvBBhfXFGXA/VGmjs6PpdGVRH3eEmqLRJQ++ijTlR58/3gI/ZpmCgTpGAAVeeQCg
	aHSAaWhdNUhXF4Azx2BJdalIk6wM0Mkt4YQXnGZtZRhVdxnN4E7kleGzp8DcUyHqvW5eXdyBXMH
	YJic25lBt4YfanQBGOlklOw=
Received: from mail.maildlp.com (unknown [172.19.163.15])
	by canpmsgout12.his.huawei.com (SkyGuard) with ESMTPS id 4gpmXp0YMrznTWC;
	Mon, 29 Jun 2026 20:58:02 +0800 (CST)
Received: from dggpemf500011.china.huawei.com (unknown [7.185.36.131])
	by mail.maildlp.com (Postfix) with ESMTPS id 1195040586;
	Mon, 29 Jun 2026 21:06:43 +0800 (CST)
Received: from huawei.com (10.90.53.73) by dggpemf500011.china.huawei.com
 (7.185.36.131) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.11; Mon, 29 Jun
 2026 21:06:38 +0800
From: Jinjie Ruan <ruanjinjie@huawei.com>
To: <oleg@redhat.com>, <richard.henderson@linaro.org>, <mattst88@gmail.com>,
	<linmag7@gmail.com>, <linux@armlinux.org.uk>, <catalin.marinas@arm.com>,
	<will@kernel.org>, <kees@kernel.org>, <guoren@kernel.org>,
	<chenhuacai@kernel.org>, <kernel@xen0n.name>, <geert@linux-m68k.org>,
	<tsbogend@alpha.franken.de>, <James.Bottomley@HansenPartnership.com>,
	<deller@gmx.de>, <maddy@linux.ibm.com>, <mpe@ellerman.id.au>,
	<npiggin@gmail.com>, <chleroy@kernel.org>, <pjw@kernel.org>,
	<palmer@dabbelt.com>, <aou@eecs.berkeley.edu>, <alex@ghiti.fr>,
	<hca@linux.ibm.com>, <gor@linux.ibm.com>, <agordeev@linux.ibm.com>,
	<borntraeger@linux.ibm.com>, <svens@linux.ibm.com>,
	<ysato@users.sourceforge.jp>, <dalias@libc.org>,
	<glaubitz@physik.fu-berlin.de>, <richard@nod.at>,
	<anton.ivanov@cambridgegreys.com>, <johannes@sipsolutions.net>,
	<luto@kernel.org>, <tglx@kernel.org>, <mingo@redhat.com>, <bp@alien8.de>,
	<dave.hansen@linux.intel.com>, <hpa@zytor.com>, <chris@zankel.net>,
	<jcmvbkbc@gmail.com>, <peterz@infradead.org>, <wad@chromium.org>,
	<ruanjinjie@huawei.com>, <thuth@redhat.com>, <mark.rutland@arm.com>,
	<ada.coupriediaz@arm.com>, <kevin.brodsky@arm.com>, <linusw@kernel.org>,
	<yeoreum.yun@arm.com>, <song@kernel.org>, <james.morse@arm.com>,
	<anshuman.khandual@arm.com>, <broonie@kernel.org>, <liqiang01@kylinos.cn>,
	<pengcan@kylinos.cn>, <ryan.roberts@arm.com>, <yangtiezhu@loongson.cn>,
	<sshegde@linux.ibm.com>, <mchauras@linux.ibm.com>, <austin.kim@lge.com>,
	<jchrist@linux.ibm.com>, <arnd@arndb.de>, <thomas.weissschuh@linutronix.de>,
	<sohil.mehta@intel.com>, <andrew.cooper3@citrix.com>, <jgross@suse.com>,
	<kas@kernel.org>, <x86@kernel.org>, <linux-alpha@vger.kernel.org>,
	<linux-kernel@vger.kernel.org>, <linux-arm-kernel@lists.infradead.org>,
	<linux-mm@kvack.org>, <linux-csky@vger.kernel.org>,
	<loongarch@lists.linux.dev>, <linux-m68k@lists.linux-m68k.org>,
	<linux-mips@vger.kernel.org>, <linux-parisc@vger.kernel.org>,
	<linuxppc-dev@lists.ozlabs.org>, <linux-riscv@lists.infradead.org>,
	<linux-s390@vger.kernel.org>, <linux-sh@vger.kernel.org>,
	<linux-um@lists.infradead.org>
Subject: [PATCH v16 01/18] seccomp: Convert __secure_computing() to return boolean
Date: Mon, 29 Jun 2026 21:05:59 +0800
Message-ID: <20260629130616.642022-2-ruanjinjie@huawei.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20260629130616.642022-1-ruanjinjie@huawei.com>
References: <20260629130616.642022-1-ruanjinjie@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: kwepems500001.china.huawei.com (7.221.188.70) To
 dggpemf500011.china.huawei.com (7.185.36.131)

The return value of __secure_computing() currently uses 0 to indicate
that a system call should be allowed, and -1 to indicate that it should
be blocked/killed. This 0/-1 pattern is non-intuitive for a security
check function and makes the control flow at the call sites less readable.

Furthermore, any potential future changes to these return values would
require a high-risk, error-prone audit of all its users across different
architectures.

Sanitize this logic by converting the return type of __secure_computing()
to a proper boolean, where 'true' explicitly means 'allow' and 'false'
means 'fail/deny'.

Update all the two dozen or so call sites across the tree to align with
this new boolean semantic. No functional changes are intended, as the
callers still return -1 to the lower-level assembly entry code upon
seccomp denial.

Suggested-by: Thomas Gleixner <tglx@kernel.org>
Signed-off-by: Jinjie Ruan <ruanjinjie@huawei.com>
---
 arch/alpha/kernel/ptrace.c            |  2 +-
 arch/arm/kernel/ptrace.c              |  2 +-
 arch/arm64/kernel/ptrace.c            |  2 +-
 arch/csky/kernel/ptrace.c             |  2 +-
 arch/m68k/kernel/ptrace.c             |  2 +-
 arch/mips/kernel/ptrace.c             |  2 +-
 arch/parisc/kernel/ptrace.c           |  2 +-
 arch/sh/kernel/ptrace_32.c            |  2 +-
 arch/um/kernel/skas/syscall.c         |  2 +-
 arch/x86/entry/vsyscall/vsyscall_64.c |  2 +-
 arch/xtensa/kernel/ptrace.c           |  3 +--
 include/linux/entry-common.h          |  7 +++---
 include/linux/seccomp.h               | 10 ++++----
 kernel/seccomp.c                      | 34 +++++++++++++--------------
 14 files changed, 36 insertions(+), 38 deletions(-)

diff --git a/arch/alpha/kernel/ptrace.c b/arch/alpha/kernel/ptrace.c
index 0687760ea466..27d9847b1082 100644
--- a/arch/alpha/kernel/ptrace.c
+++ b/arch/alpha/kernel/ptrace.c
@@ -387,7 +387,7 @@ asmlinkage unsigned long syscall_trace_enter(void)
 	 * If this fails, seccomp may already have set up the return value
 	 * (e.g. SECCOMP_RET_ERRNO / TRACE).
 	 */
-	if (secure_computing() == -1) {
+	if (!secure_computing()) {
 		if (regs->r19 == 0 && regs->r0 == (unsigned long)-1)
 			syscall_set_return_value(current, regs, -ENOSYS, 0);
 		syscall_set_nr(current, regs, -1);
diff --git a/arch/arm/kernel/ptrace.c b/arch/arm/kernel/ptrace.c
index 7951b2c06fec..5210745725ca 100644
--- a/arch/arm/kernel/ptrace.c
+++ b/arch/arm/kernel/ptrace.c
@@ -855,7 +855,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 
 	/* Do seccomp after ptrace; syscall may have changed. */
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return -1;
 #else
 	/* XXX: remove this once OABI gets fixed */
diff --git a/arch/arm64/kernel/ptrace.c b/arch/arm64/kernel/ptrace.c
index 4d08598e2891..2ca6fab39a37 100644
--- a/arch/arm64/kernel/ptrace.c
+++ b/arch/arm64/kernel/ptrace.c
@@ -2420,7 +2420,7 @@ int syscall_trace_enter(struct pt_regs *regs)
 	}
 
 	/* Do the secure computing after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return NO_SYSCALL;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
diff --git a/arch/csky/kernel/ptrace.c b/arch/csky/kernel/ptrace.c
index 6bb685a2646b..11c5eff41e9d 100644
--- a/arch/csky/kernel/ptrace.c
+++ b/arch/csky/kernel/ptrace.c
@@ -323,7 +323,7 @@ asmlinkage int syscall_trace_enter(struct pt_regs *regs)
 		if (ptrace_report_syscall_entry(regs))
 			return -1;
 
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return -1;
 
 	if (test_thread_flag(TIF_SYSCALL_TRACEPOINT))
diff --git a/arch/m68k/kernel/ptrace.c b/arch/m68k/kernel/ptrace.c
index cfa2df24eced..d2411404b9df 100644
--- a/arch/m68k/kernel/ptrace.c
+++ b/arch/m68k/kernel/ptrace.c
@@ -281,7 +281,7 @@ asmlinkage int syscall_trace_enter(void)
 	if (test_thread_flag(TIF_SYSCALL_TRACE))
 		ret = ptrace_report_syscall_entry(task_pt_regs(current));
 
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return -1;
 
 	return ret;
diff --git a/arch/mips/kernel/ptrace.c b/arch/mips/kernel/ptrace.c
index 3f4c94c88124..0d809cda7542 100644
--- a/arch/mips/kernel/ptrace.c
+++ b/arch/mips/kernel/ptrace.c
@@ -1328,7 +1328,7 @@ asmlinkage long syscall_trace_enter(struct pt_regs *regs)
 			return -1;
 	}
 
-	if (secure_computing())
+	if (!secure_computing())
 		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
diff --git a/arch/parisc/kernel/ptrace.c b/arch/parisc/kernel/ptrace.c
index 8a17ab7e6e0b..565b51a48c8a 100644
--- a/arch/parisc/kernel/ptrace.c
+++ b/arch/parisc/kernel/ptrace.c
@@ -351,7 +351,7 @@ long do_syscall_trace_enter(struct pt_regs *regs)
 	}
 
 	/* Do the secure computing check after ptrace. */
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return -1;
 
 #ifdef CONFIG_HAVE_SYSCALL_TRACEPOINTS
diff --git a/arch/sh/kernel/ptrace_32.c b/arch/sh/kernel/ptrace_32.c
index 06f765d71a29..8687f17cbe5a 100644
--- a/arch/sh/kernel/ptrace_32.c
+++ b/arch/sh/kernel/ptrace_32.c
@@ -460,7 +460,7 @@ asmlinkage long do_syscall_trace_enter(struct pt_regs *regs)
 		return -1;
 	}
 
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		return -1;
 
 	if (unlikely(test_thread_flag(TIF_SYSCALL_TRACEPOINT)))
diff --git a/arch/um/kernel/skas/syscall.c b/arch/um/kernel/skas/syscall.c
index ba7494f9bfe4..916cd7acceaf 100644
--- a/arch/um/kernel/skas/syscall.c
+++ b/arch/um/kernel/skas/syscall.c
@@ -27,7 +27,7 @@ void handle_syscall(struct uml_pt_regs *r)
 		goto out;
 
 	/* Do the seccomp check after ptrace; failures should be fast. */
-	if (secure_computing() == -1)
+	if (!secure_computing())
 		goto out;
 
 	syscall = UPT_SYSCALL_NR(r);
diff --git a/arch/x86/entry/vsyscall/vsyscall_64.c b/arch/x86/entry/vsyscall/vsyscall_64.c
index ea36de9fa864..6aed3987b9f9 100644
--- a/arch/x86/entry/vsyscall/vsyscall_64.c
+++ b/arch/x86/entry/vsyscall/vsyscall_64.c
@@ -198,7 +198,7 @@ static bool __emulate_vsyscall(struct pt_regs *regs, unsigned long address)
 	regs->orig_ax = syscall_nr;
 	regs->ax = -ENOSYS;
 	tmp = secure_computing();
-	if ((!tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
+	if ((tmp && regs->orig_ax != syscall_nr) || regs->ip != address) {
 		warn_bad_vsyscall(KERN_DEBUG, regs,
 				  "seccomp tried to change syscall nr or ip");
 		force_exit_sig(SIGSYS);
diff --git a/arch/xtensa/kernel/ptrace.c b/arch/xtensa/kernel/ptrace.c
index b80d54b2ea34..ef78fcd318ff 100644
--- a/arch/xtensa/kernel/ptrace.c
+++ b/arch/xtensa/kernel/ptrace.c
@@ -553,8 +553,7 @@ int do_syscall_trace_enter(struct pt_regs *regs)
 		return 0;
 	}
 
-	if (regs->syscall == NO_SYSCALL ||
-	    secure_computing() == -1) {
+	if (regs->syscall == NO_SYSCALL || !secure_computing()) {
 		do_syscall_trace_leave(regs);
 		return 0;
 	}
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 416a3352261f..3f66320e46d3 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -100,9 +100,8 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned l
 
 	/* Do seccomp after ptrace, to catch any tracer changes. */
 	if (work & SYSCALL_WORK_SECCOMP) {
-		ret = __secure_computing();
-		if (ret == -1L)
-			return ret;
+		if (!__secure_computing())
+			return -1L;
 	}
 
 	/* Either of the above might have changed the syscall number */
@@ -113,7 +112,7 @@ static __always_inline long syscall_trace_enter(struct pt_regs *regs, unsigned l
 
 	syscall_enter_audit(regs, syscall);
 
-	return ret ? : syscall;
+	return syscall;
 }
 
 /**
diff --git a/include/linux/seccomp.h b/include/linux/seccomp.h
index 9b959972bf4a..7af3173f40e9 100644
--- a/include/linux/seccomp.h
+++ b/include/linux/seccomp.h
@@ -22,14 +22,14 @@
 #include <linux/atomic.h>
 #include <asm/seccomp.h>
 
-extern int __secure_computing(void);
+extern bool __secure_computing(void);
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void)
+static inline bool secure_computing(void)
 {
 	if (unlikely(test_syscall_work(SECCOMP)))
 		return  __secure_computing();
-	return 0;
+	return true;
 }
 #else
 extern void secure_computing_strict(int this_syscall);
@@ -50,11 +50,11 @@ static inline int seccomp_mode(struct seccomp *s)
 struct seccomp_data;
 
 #ifdef CONFIG_HAVE_ARCH_SECCOMP_FILTER
-static inline int secure_computing(void) { return 0; }
+static inline bool secure_computing(void) { return true; }
 #else
 static inline void secure_computing_strict(int this_syscall) { return; }
 #endif
-static inline int __secure_computing(void) { return 0; }
+static inline bool __secure_computing(void) { return true; }
 
 static inline long prctl_get_seccomp(void)
 {
diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 066909393c38..1fec6efedab6 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1100,12 +1100,12 @@ void secure_computing_strict(int this_syscall)
 	else
 		BUG();
 }
-int __secure_computing(void)
+bool __secure_computing(void)
 {
 	int this_syscall = syscall_get_nr(current, current_pt_regs());
 
 	secure_computing_strict(this_syscall);
-	return 0;
+	return true;
 }
 #else
 
@@ -1256,7 +1256,7 @@ static int seccomp_do_user_notification(int this_syscall,
 	return -1;
 }
 
-static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
+static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	u32 filter_ret, action;
 	struct seccomp_data sd;
@@ -1294,7 +1294,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 	case SECCOMP_RET_TRACE:
 		/* We've been put in this state by the ptracer already. */
 		if (recheck_after_trace)
-			return 0;
+			return true;
 
 		/* ENOSYS these calls if there is no tracer attached. */
 		if (!ptrace_event_enabled(current, PTRACE_EVENT_SECCOMP)) {
@@ -1330,19 +1330,19 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		 * a skip would have already been reported.
 		 */
 		if (__seccomp_filter(this_syscall, true))
-			return -1;
+			return false;
 
-		return 0;
+		return true;
 
 	case SECCOMP_RET_USER_NOTIF:
 		if (seccomp_do_user_notification(this_syscall, match, &sd))
 			goto skip;
 
-		return 0;
+		return true;
 
 	case SECCOMP_RET_LOG:
 		seccomp_log(this_syscall, 0, action, true);
-		return 0;
+		return true;
 
 	case SECCOMP_RET_ALLOW:
 		/*
@@ -1350,7 +1350,7 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		 * this action since SECCOMP_RET_ALLOW is the starting
 		 * state in seccomp_run_filters().
 		 */
-		return 0;
+		return true;
 
 	case SECCOMP_RET_KILL_THREAD:
 	case SECCOMP_RET_KILL_PROCESS:
@@ -1367,46 +1367,46 @@ static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 		} else {
 			do_exit(SIGSYS);
 		}
-		return -1; /* skip the syscall go directly to signal handling */
+		return false; /* skip the syscall go directly to signal handling */
 	}
 
 	unreachable();
 
 skip:
 	seccomp_log(this_syscall, 0, action, match ? match->log : false);
-	return -1;
+	return false;
 }
 #else
-static int __seccomp_filter(int this_syscall, const bool recheck_after_trace)
+static bool __seccomp_filter(int this_syscall, const bool recheck_after_trace)
 {
 	BUG();
 
-	return -1;
+	return false;
 }
 #endif
 
-int __secure_computing(void)
+bool __secure_computing(void)
 {
 	int mode = current->seccomp.mode;
 	int this_syscall;
 
 	if (IS_ENABLED(CONFIG_CHECKPOINT_RESTORE) &&
 	    unlikely(current->ptrace & PT_SUSPEND_SECCOMP))
-		return 0;
+		return true;
 
 	this_syscall = syscall_get_nr(current, current_pt_regs());
 
 	switch (mode) {
 	case SECCOMP_MODE_STRICT:
 		__secure_computing_strict(this_syscall);  /* may call do_exit */
-		return 0;
+		return true;
 	case SECCOMP_MODE_FILTER:
 		return __seccomp_filter(this_syscall, false);
 	/* Surviving SECCOMP_RET_KILL_* must be proactively impossible. */
 	case SECCOMP_MODE_DEAD:
 		WARN_ON_ONCE(1);
 		do_exit(SIGKILL);
-		return -1;
+		return false;
 	default:
 		BUG();
 	}
-- 
2.34.1

