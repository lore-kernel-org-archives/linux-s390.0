Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4D2CC224FD;
	Tue, 28 May 2024 02:18:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716862718; cv=none; b=ervWPrR3P1vsm0DyZSa/nVk4YC8mULGOXVUfCbz8tZG0fFN69icapGBGuAFeLVBlzSHpqRuTOP/HiL2rE9bmoP1GK542B4YpuAnUKoFuECPAR3Hj8/ASAJltaZjueKejYHslIN9qI2w/Y/eBLe/jSfWH4oR5tsVOMPnFcYfJge4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716862718; c=relaxed/simple;
	bh=XUVDaLZZB0jtTHQ/d7v6HdM3/mdUtKGlHBGeb0bnkQI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nAkLWqhaGxv5IjzgukdsDTmnUj/qHyQKkQOAVcpEpDpChicG648GiCCUGnSK9t2TKv9wPA4wgRyQTwuA5Q9l/4evokU6zKkPxxSlXqZQbMWd2+MZSc2t7EO7mcJmwQ7Wl+I54B50DM55o5AVMEmojAQ8J89MpIQMSFltyfzOS6E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C0RiCU16; arc=none smtp.client-ip=10.30.226.201
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C0RiCU16"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50B11C4AF12;
	Tue, 28 May 2024 02:18:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1716862718;
	bh=XUVDaLZZB0jtTHQ/d7v6HdM3/mdUtKGlHBGeb0bnkQI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=C0RiCU16crLO7qqM8wuP/SCjsXP5NeNjJoo4SOSonXHkRo5Lq3GV1Gak37Cg85r4Y
	 jOVk8o6mg2FGWNxuzG80awNx409EYgmt6lkaaopofcNHkhboS5POGcGEapTEHiQO2l
	 m/ovXc0SugZOBbOb0FNFuNuQ3ctPXpxT15sL2BIAHKcK+9PfrOCzH0fk2OXrcP9ZDv
	 XrZ2oTmhQMu4xuW+ZImESosPuMym0YtM09Ph8kMGYQnOqADZNThrHLZyWoYAh9Sffr
	 b9+6HaVND3kj/MX9QukXgATFCZvfJLrafCwIqCAnNKtiKnPW9IGfoCtC2+61+MnF4R
	 D+3oQdKtaKE2Q==
From: Sasha Levin <sashal@kernel.org>
To: linux-kernel@vger.kernel.org,
	stable@vger.kernel.org
Cc: Stephen Brennan <stephen.s.brennan@oracle.com>,
	Masami Hiramatsu <mhiramat@kernel.org>,
	Guo Ren <guoren@kernel.org>,
	Steven Rostedt <rostedt@goodmis.org>,
	Sasha Levin <sashal@kernel.org>,
	mingo@redhat.com,
	jejb@parisc-linux.org,
	deller@gmx.de,
	benh@kernel.crashing.org,
	paulus@samba.org,
	mpe@ellerman.id.au,
	palmer@sifive.com,
	aou@eecs.berkeley.edu,
	schwidefsky@de.ibm.com,
	heiko.carstens@de.ibm.com,
	tglx@linutronix.de,
	bp@alien8.de,
	x86@kernel.org,
	naveen.n.rao@linux.vnet.ibm.com,
	anil.s.keshavamurthy@intel.com,
	davem@davemloft.net,
	linux-parisc@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org,
	linux-s390@vger.kernel.org
Subject: [PATCH AUTOSEL 6.9 5/5] kprobe/ftrace: bail out if ftrace was killed
Date: Mon, 27 May 2024 22:18:21 -0400
Message-ID: <20240528021823.3904980-5-sashal@kernel.org>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20240528021823.3904980-1-sashal@kernel.org>
References: <20240528021823.3904980-1-sashal@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.9.2
Content-Transfer-Encoding: 8bit

From: Stephen Brennan <stephen.s.brennan@oracle.com>

[ Upstream commit 1a7d0890dd4a502a202aaec792a6c04e6e049547 ]

If an error happens in ftrace, ftrace_kill() will prevent disarming
kprobes. Eventually, the ftrace_ops associated with the kprobes will be
freed, yet the kprobes will still be active, and when triggered, they
will use the freed memory, likely resulting in a page fault and panic.

This behavior can be reproduced quite easily, by creating a kprobe and
then triggering a ftrace_kill(). For simplicity, we can simulate an
ftrace error with a kernel module like [1]:

[1]: https://github.com/brenns10/kernel_stuff/tree/master/ftrace_killer

  sudo perf probe --add commit_creds
  sudo perf trace -e probe:commit_creds
  # In another terminal
  make
  sudo insmod ftrace_killer.ko  # calls ftrace_kill(), simulating bug
  # Back to perf terminal
  # ctrl-c
  sudo perf probe --del commit_creds

After a short period, a page fault and panic would occur as the kprobe
continues to execute and uses the freed ftrace_ops. While ftrace_kill()
is supposed to be used only in extreme circumstances, it is invoked in
FTRACE_WARN_ON() and so there are many places where an unexpected bug
could be triggered, yet the system may continue operating, possibly
without the administrator noticing. If ftrace_kill() does not panic the
system, then we should do everything we can to continue operating,
rather than leave a ticking time bomb.

Link: https://lore.kernel.org/all/20240501162956.229427-1-stephen.s.brennan@oracle.com/

Signed-off-by: Stephen Brennan <stephen.s.brennan@oracle.com>
Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Acked-by: Guo Ren <guoren@kernel.org>
Reviewed-by: Steven Rostedt (Google) <rostedt@goodmis.org>
Signed-off-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/csky/kernel/probes/ftrace.c     | 3 +++
 arch/loongarch/kernel/ftrace_dyn.c   | 3 +++
 arch/parisc/kernel/ftrace.c          | 3 +++
 arch/powerpc/kernel/kprobes-ftrace.c | 3 +++
 arch/riscv/kernel/probes/ftrace.c    | 3 +++
 arch/s390/kernel/ftrace.c            | 3 +++
 arch/x86/kernel/kprobes/ftrace.c     | 3 +++
 include/linux/kprobes.h              | 7 +++++++
 kernel/kprobes.c                     | 6 ++++++
 kernel/trace/ftrace.c                | 1 +
 10 files changed, 35 insertions(+)

diff --git a/arch/csky/kernel/probes/ftrace.c b/arch/csky/kernel/probes/ftrace.c
index 834cffcfbce32..7ba4b98076de1 100644
--- a/arch/csky/kernel/probes/ftrace.c
+++ b/arch/csky/kernel/probes/ftrace.c
@@ -12,6 +12,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	struct pt_regs *regs;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/loongarch/kernel/ftrace_dyn.c b/arch/loongarch/kernel/ftrace_dyn.c
index 73858c9029cc9..bff058317062e 100644
--- a/arch/loongarch/kernel/ftrace_dyn.c
+++ b/arch/loongarch/kernel/ftrace_dyn.c
@@ -287,6 +287,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	struct kprobe_ctlblk *kcb;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/parisc/kernel/ftrace.c b/arch/parisc/kernel/ftrace.c
index 621a4b386ae4f..c91f9c2e61ed2 100644
--- a/arch/parisc/kernel/ftrace.c
+++ b/arch/parisc/kernel/ftrace.c
@@ -206,6 +206,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/powerpc/kernel/kprobes-ftrace.c b/arch/powerpc/kernel/kprobes-ftrace.c
index 072ebe7f290ba..f8208c027148f 100644
--- a/arch/powerpc/kernel/kprobes-ftrace.c
+++ b/arch/powerpc/kernel/kprobes-ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long nip, unsigned long parent_nip,
 	struct pt_regs *regs;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(nip, parent_nip);
 	if (bit < 0)
 		return;
diff --git a/arch/riscv/kernel/probes/ftrace.c b/arch/riscv/kernel/probes/ftrace.c
index 7142ec42e889f..a69dfa610aa85 100644
--- a/arch/riscv/kernel/probes/ftrace.c
+++ b/arch/riscv/kernel/probes/ftrace.c
@@ -11,6 +11,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/s390/kernel/ftrace.c b/arch/s390/kernel/ftrace.c
index c46381ea04ecb..7f6f8c438c265 100644
--- a/arch/s390/kernel/ftrace.c
+++ b/arch/s390/kernel/ftrace.c
@@ -296,6 +296,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe *p;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/arch/x86/kernel/kprobes/ftrace.c b/arch/x86/kernel/kprobes/ftrace.c
index dd2ec14adb77b..15af7e98e161a 100644
--- a/arch/x86/kernel/kprobes/ftrace.c
+++ b/arch/x86/kernel/kprobes/ftrace.c
@@ -21,6 +21,9 @@ void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 	struct kprobe_ctlblk *kcb;
 	int bit;
 
+	if (unlikely(kprobe_ftrace_disabled))
+		return;
+
 	bit = ftrace_test_recursion_trylock(ip, parent_ip);
 	if (bit < 0)
 		return;
diff --git a/include/linux/kprobes.h b/include/linux/kprobes.h
index 0ff44d6633e33..5fcbc254d1864 100644
--- a/include/linux/kprobes.h
+++ b/include/linux/kprobes.h
@@ -378,11 +378,15 @@ static inline void wait_for_kprobe_optimizer(void) { }
 extern void kprobe_ftrace_handler(unsigned long ip, unsigned long parent_ip,
 				  struct ftrace_ops *ops, struct ftrace_regs *fregs);
 extern int arch_prepare_kprobe_ftrace(struct kprobe *p);
+/* Set when ftrace has been killed: kprobes on ftrace must be disabled for safety */
+extern bool kprobe_ftrace_disabled __read_mostly;
+extern void kprobe_ftrace_kill(void);
 #else
 static inline int arch_prepare_kprobe_ftrace(struct kprobe *p)
 {
 	return -EINVAL;
 }
+static inline void kprobe_ftrace_kill(void) {}
 #endif /* CONFIG_KPROBES_ON_FTRACE */
 
 /* Get the kprobe at this addr (if any) - called with preemption disabled */
@@ -495,6 +499,9 @@ static inline void kprobe_flush_task(struct task_struct *tk)
 static inline void kprobe_free_init_mem(void)
 {
 }
+static inline void kprobe_ftrace_kill(void)
+{
+}
 static inline int disable_kprobe(struct kprobe *kp)
 {
 	return -EOPNOTSUPP;
diff --git a/kernel/kprobes.c b/kernel/kprobes.c
index 65adc815fc6e6..166ebf81dc450 100644
--- a/kernel/kprobes.c
+++ b/kernel/kprobes.c
@@ -1068,6 +1068,7 @@ static struct ftrace_ops kprobe_ipmodify_ops __read_mostly = {
 
 static int kprobe_ipmodify_enabled;
 static int kprobe_ftrace_enabled;
+bool kprobe_ftrace_disabled;
 
 static int __arm_kprobe_ftrace(struct kprobe *p, struct ftrace_ops *ops,
 			       int *cnt)
@@ -1136,6 +1137,11 @@ static int disarm_kprobe_ftrace(struct kprobe *p)
 		ipmodify ? &kprobe_ipmodify_ops : &kprobe_ftrace_ops,
 		ipmodify ? &kprobe_ipmodify_enabled : &kprobe_ftrace_enabled);
 }
+
+void kprobe_ftrace_kill()
+{
+	kprobe_ftrace_disabled = true;
+}
 #else	/* !CONFIG_KPROBES_ON_FTRACE */
 static inline int arm_kprobe_ftrace(struct kprobe *p)
 {
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index da1710499698b..96db99c347b3b 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7895,6 +7895,7 @@ void ftrace_kill(void)
 	ftrace_disabled = 1;
 	ftrace_enabled = 0;
 	ftrace_trace_function = ftrace_stub;
+	kprobe_ftrace_kill();
 }
 
 /**
-- 
2.43.0

