Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from mail.kernel.org ([198.145.29.99]:40840 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725849AbgKFCfu (ORCPT <rfc822;linux-s390@vger.kernel.org>);
        Thu, 5 Nov 2020 21:35:50 -0500
Message-ID: <20201106023546.944907560@goodmis.org>
Date: Thu, 05 Nov 2020 21:32:40 -0500
From: Steven Rostedt (VMware) <rostedt@goodmis.org>
Subject: [PATCH 05/11 v3] kprobes/ftrace: Add recursion protection to the ftrace callback
References: <20201106023235.367190737@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Masami Hiramatsu <mhiramat@kernel.org>, Andrew Morton <akpm@linux-foundation.org>, Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Josh Poimboeuf <jpoimboe@redhat.com>, Jiri Kosina <jikos@kernel.org>, Miroslav Benes <mbenes@suse.cz>, Petr Mladek <pmladek@suse.com>, Guo Ren <guoren@kernel.org>, "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>, Helge Deller <deller@gmx.de>, Michael Ellerman <mpe@ellerman.id.au>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Christian Borntraeger <borntraeger@de.ibm.com>, Thomas Gleixner <tglx@linutronix.de>, Borislav Petkov <bp@alien8.de>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>, Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>, "David S. Miller" <davem@davemloft.net>, linux-csky@vger.kernel.org, linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org

From: "Steven Rostedt (VMware)" <rostedt@goodmis.org>

If a ftrace callback does not supply its own recursion protection and
does not set the RECURSION_SAFE flag in its ftrace_ops, then ftrace will
make a helper trampoline to do so before calling the callback instead of
just calling the callback directly.

The default for ftrace_ops is going to change. It will expect that handlers
provide their own recursion protection, unless its ftrace_ops states
otherwise.

Link: https://lkml.kernel.org/r/20201028115613.140212174@goodmis.org

Cc: Andrew Morton <akpm@linux-foundation.org>
Cc: Masami Hiramatsu <mhiramat@kernel.org>
Cc: Guo Ren <guoren@kernel.org>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Paul Mackerras <paulus@samba.org>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Borislav Petkov <bp@alien8.de>
Cc: x86@kernel.org
Cc: "H. Peter Anvin" <hpa@zytor.com>
Cc: "Naveen N. Rao" <naveen.n.rao@linux.ibm.com>
Cc: Anil S Keshavamurthy <anil.s.keshavamurthy@intel.com>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: linux-csky@vger.kernel.org
Cc: linux-parisc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-s390@vger.kernel.org
Signed-off-by: Steven Rostedt (VMware) <rostedt@goodmis.org>
---

Changes since v2:

 - Move get_kprobe() into preempt disabled sections for various archs


 arch/csky/kernel/probes/ftrace.c     | 12 ++++++++++--
 arch/parisc/kernel/ftrace.c          | 16 +++++++++++++---
 arch/powerpc/kernel/kprobes-ftrace.c | 11 ++++++++++-
 arch/s390/kernel/ftrace.c            | 16 +++++++++++++---
 arch/x86/kernel/kprobes/ftrace.c     | 12 ++++++++++--
 5 files changed, 56 insertions(+), 11 deletions(-)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index 5264763d05be..5eb2604fdf71 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -13,16 +13,21 @@ int arch_check_ftrace_location(struct kprobe *p)
 void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
 {
+	int bit;
 	bool lr_saver = false;
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 
-	/* Preempt is disabled by ftrace */
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (!p) {
 		p = get_kprobe((kprobe_opcode_t *)(ip - MCOUNT_INSN_SIZE));
 		if (unlikely(!p) || kprobe_disabled(p))
-			return;
+			goto out;
 		lr_saver = true;
 	}
 
@@ -56,6 +61,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		 */
 		__this_cpu_write(current_kprobe, NULL);
 	}
+out:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 63e3ecb9da81..13d85042810a 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -207,14 +207,21 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 			   struct ftrace_ops *ops, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb;
-	struct kprobe *p = get_kprobe((kprobe_opcode_t *)ip);
+	struct kprobe *p;
+	int bit;
 
-	if (unlikely(!p) || kprobe_disabled(p))
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
 		return;
 
+	preempt_disable_notrace();
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		goto out;
+
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
-		return;
+		goto out;
 	}
 
 	__this_cpu_write(current_kprobe, p);
@@ -235,6 +242,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		}
 	}
 	__this_cpu_write(current_kprobe, NULL);
+out:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 972cb28174b2..5df8d50c65ae 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -18,10 +18,16 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 {
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
+	int bit;
 
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)nip);
 	if (unlikely(!p) || kprobe_disabled(p))
-		return;
+		goto out;
 
 	kcb = get_kprobe_ctlblk();
 	if (kprobe_running()) {
@@ -52,6 +58,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 		 */
 		__this_cpu_write(current_kprobe, NULL);
 	}
+out:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index b388e87a08bf..8f31c726537a 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -201,14 +201,21 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		struct ftrace_ops *ops, struct pt_regs *regs)
 {
 	struct kprobe_ctlblk *kcb;
-	struct kprobe *p = get_kprobe((kprobe_opcode_t *)ip);
+	struct kprobe *p;
+	int bit;
 
-	if (unlikely(!p) || kprobe_disabled(p))
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
 		return;
 
+	preempt_disable_notrace();
+	p = get_kprobe((kprobe_opcode_t *)ip);
+	if (unlikely(!p) || kprobe_disabled(p))
+		goto out;
+
 	if (kprobe_running()) {
 		kprobes_inc_nmissed_count(p);
-		return;
+		goto out;
 	}
 
 	__this_cpu_write(current_kprobe, p);
@@ -228,6 +235,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		}
 	}
 	__this_cpu_write(current_kprobe, NULL);
+out:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index 681a4b36e9bb..a40a6cdfcca3 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -18,11 +18,16 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 {
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
+	int bit;
 
-	/* Preempt is disabled by ftrace */
+	bit = ftrace_test_recursion_trylock();
+	if (bit < 0)
+		return;
+
+	preempt_disable_notrace();
 	p = get_kprobe((kprobe_opcode_t *)ip);
 	if (unlikely(!p) || kprobe_disabled(p))
-		return;
+		goto out;
 
 	kcb = get_kprobe_ctlblk();
 	if (kprobe_running()) {
@@ -52,6 +57,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 		 */
 		__this_cpu_write(current_kprobe, NULL);
 	}
+out:
+	preempt_enable_notrace();
+	ftrace_test_recursion_unlock(bit);
 }
 NOKPROBE_SYMBOL(kprobe_ftrace_handler);
 
-- 
2.28.0
