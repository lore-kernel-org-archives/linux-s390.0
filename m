Return-Path: <SRS0=HMm1=J4=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v13 02/18] x86: initialize static branching early
Date: Wed, 11 Jul 2018 20:04:03 -0400
Message-Id: <20180712000419.5165-3-pasha.tatashin@oracle.com>
In-Reply-To: <20180712000419.5165-1-pasha.tatashin@oracle.com>
References: <20180712000419.5165-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com
List-ID: <linux-s390.vger.kernel.org>

static branching is useful to hot-patch branches that are used in hot
path, but are infrequently changed.

x86 clock framework is one example that uses static branches to setup
the best clock during boot and never change it again.

Since we plan to enable clock early, we need static branching
functionality early as well.

static branching requires patching nop instructions, thus, we need
arch_init_ideal_nops() to be called prior to jump_label_init()

Here we do all the necessary steps to call arch_init_ideal_nops
after early_cpu_init().

Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
Suggested-by: Peter Zijlstra <peterz@infradead.org>
Reviewed-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/amd.c    | 13 +++++++-----
 arch/x86/kernel/cpu/common.c | 38 +++++++++++++++++++-----------------
 arch/x86/kernel/setup.c      |  4 ++--
 3 files changed, 30 insertions(+), 25 deletions(-)

diff --git a/arch/x86/kernel/cpu/amd.c b/arch/x86/kernel/cpu/amd.c
index 38915fbfae73..b732438c1a1e 100644
--- a/arch/x86/kernel/cpu/amd.c
+++ b/arch/x86/kernel/cpu/amd.c
@@ -232,8 +232,6 @@ static void init_amd_k7(struct cpuinfo_x86 *c)
 		}
 	}
 
-	set_cpu_cap(c, X86_FEATURE_K7);
-
 	/* calling is from identify_secondary_cpu() ? */
 	if (!c->cpu_index)
 		return;
@@ -617,6 +615,14 @@ static void early_init_amd(struct cpuinfo_x86 *c)
 
 	early_init_amd_mc(c);
 
+#ifdef CONFIG_X86_32
+	if (c->x86 == 6)
+		set_cpu_cap(c, X86_FEATURE_K7);
+#endif
+
+	if (c->x86 >= 0xf)
+		set_cpu_cap(c, X86_FEATURE_K8);
+
 	rdmsr_safe(MSR_AMD64_PATCH_LEVEL, &c->microcode, &dummy);
 
 	/*
@@ -863,9 +869,6 @@ static void init_amd(struct cpuinfo_x86 *c)
 
 	init_amd_cacheinfo(c);
 
-	if (c->x86 >= 0xf)
-		set_cpu_cap(c, X86_FEATURE_K8);
-
 	if (cpu_has(c, X86_FEATURE_XMM2)) {
 		unsigned long long val;
 		int ret;
diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index eb4cb3efd20e..71281ac43b15 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1015,6 +1015,24 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
 	setup_force_cpu_bug(X86_BUG_CPU_MELTDOWN);
 }
 
+/*
+ * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
+ * unfortunately, that's not true in practice because of early VIA
+ * chips and (more importantly) broken virtualizers that are not easy
+ * to detect. In the latter case it doesn't even *fail* reliably, so
+ * probing for it doesn't even work. Disable it completely on 32-bit
+ * unless we can find a reliable way to detect all the broken cases.
+ * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
+ */
+static void detect_nopl(struct cpuinfo_x86 *c)
+{
+#ifdef CONFIG_X86_32
+	clear_cpu_cap(c, X86_FEATURE_NOPL);
+#else
+	set_cpu_cap(c, X86_FEATURE_NOPL);
+#endif
+}
+
 /*
  * Do minimum CPU detection early.
  * Fields really needed: vendor, cpuid_level, family, model, mask,
@@ -1089,6 +1107,8 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	 */
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
+
+	detect_nopl(c);
 }
 
 void __init early_cpu_init(void)
@@ -1124,24 +1144,6 @@ void __init early_cpu_init(void)
 	early_identify_cpu(&boot_cpu_data);
 }
 
-/*
- * The NOPL instruction is supposed to exist on all CPUs of family >= 6;
- * unfortunately, that's not true in practice because of early VIA
- * chips and (more importantly) broken virtualizers that are not easy
- * to detect. In the latter case it doesn't even *fail* reliably, so
- * probing for it doesn't even work. Disable it completely on 32-bit
- * unless we can find a reliable way to detect all the broken cases.
- * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
- */
-static void detect_nopl(struct cpuinfo_x86 *c)
-{
-#ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
-#else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
-#endif
-}
-
 static void detect_null_seg_behavior(struct cpuinfo_x86 *c)
 {
 #ifdef CONFIG_X86_64
diff --git a/arch/x86/kernel/setup.c b/arch/x86/kernel/setup.c
index 2f86d883dd95..403b2d2c31d2 100644
--- a/arch/x86/kernel/setup.c
+++ b/arch/x86/kernel/setup.c
@@ -866,6 +866,8 @@ void __init setup_arch(char **cmdline_p)
 
 	idt_setup_early_traps();
 	early_cpu_init();
+	arch_init_ideal_nops();
+	jump_label_init();
 	early_ioremap_init();
 
 	setup_olpc_ofw_pgd();
@@ -1272,8 +1274,6 @@ void __init setup_arch(char **cmdline_p)
 
 	mcheck_init();
 
-	arch_init_ideal_nops();
-
 	register_refined_jiffies(CLOCK_TICK_RATE);
 
 #ifdef CONFIG_EFI
-- 
2.18.0
