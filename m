Return-Path: <SRS0=/F/O=KD=vger.kernel.org=linux-kernel-owner@kernel.org>
From: Pavel Tatashin <pasha.tatashin@oracle.com>
Subject: [PATCH v15 10/26] x86/CPU: Call detect_nopl() only on the BSP
Date: Thu, 19 Jul 2018 16:55:29 -0400
Message-Id: <20180719205545.16512-11-pasha.tatashin@oracle.com>
In-Reply-To: <20180719205545.16512-1-pasha.tatashin@oracle.com>
References: <20180719205545.16512-1-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org, pasha.tatashin@oracle.com, boris.ostrovsky@oracle.com, jgross@suse.com, pbonzini@redhat.com
List-ID: <linux-s390.vger.kernel.org>

From: Borislav Petkov <bp@alien8.de>

Make it use the setup_* variants and have it be called only on the BSP
and drop the call in generic_identify() - X86_FEATURE_NOPL will be
replicated to the APs through the forced caps. Helps keep the mess at a
manageable level.

Signed-off-by: Borislav Petkov <bp@suse.de>
Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
---
 arch/x86/kernel/cpu/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 71281ac43b15..46408a8cdf62 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1024,12 +1024,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
  * unless we can find a reliable way to detect all the broken cases.
  * Enable it explicitly on 64-bit for non-constant inputs of cpu_has().
  */
-static void detect_nopl(struct cpuinfo_x86 *c)
+static void detect_nopl(void)
 {
 #ifdef CONFIG_X86_32
-	clear_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_clear_cpu_cap(X86_FEATURE_NOPL);
 #else
-	set_cpu_cap(c, X86_FEATURE_NOPL);
+	setup_force_cpu_cap(X86_FEATURE_NOPL);
 #endif
 }
 
@@ -1108,7 +1108,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
-	detect_nopl(c);
+	detect_nopl();
 }
 
 void __init early_cpu_init(void)
@@ -1206,8 +1206,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	detect_nopl(c);
-
 	detect_null_seg_behavior(c);
 
 	/*
-- 
2.18.0
