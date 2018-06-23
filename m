Return-Path: <SRS0=hmx+=JJ=vger.kernel.org=linux-kernel-owner@kernel.org>
Date: Sat, 23 Jun 2018 11:16:48 +0200
From: Borislav Petkov <bp@alien8.de>
Subject: Re: [PATCH v12 02/11] x86: initialize static branching early
Message-ID: <20180623091648.GA29468@zn.tnic>
References: <20180621212518.19914-1-pasha.tatashin@oracle.com>
 <20180621212518.19914-3-pasha.tatashin@oracle.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20180621212518.19914-3-pasha.tatashin@oracle.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Pavel Tatashin <pasha.tatashin@oracle.com>
Cc: steven.sistare@oracle.com, daniel.m.jordan@oracle.com, linux@armlinux.org.uk, schwidefsky@de.ibm.com, heiko.carstens@de.ibm.com, john.stultz@linaro.org, sboyd@codeaurora.org, x86@kernel.org, linux-kernel@vger.kernel.org, mingo@redhat.com, tglx@linutronix.de, hpa@zytor.com, douly.fnst@cn.fujitsu.com, peterz@infradead.org, prarit@redhat.com, feng.tang@intel.com, pmladek@suse.com, gnomes@lxorguk.ukuu.org.uk, linux-s390@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

On Thu, Jun 21, 2018 at 05:25:09PM -0400, Pavel Tatashin wrote:
> static branching is useful to hot-patch branches that are used in hot
> path, but are infrequently changed.
> 
> x86 clock framework is one example that uses static branches to setup
> the best clock during boot and never change it again.
> 
> Since we plan to enable clock early, we need static branching
> functionality early as well.
> 
> static branching requires patching nop instructions, thus, we need
> arch_init_ideal_nops() to be called prior to jump_label_init()
> 
> Here we do all the necessary steps to call arch_init_ideal_nops
> after early_cpu_init().
> 
> Signed-off-by: Pavel Tatashin <pasha.tatashin@oracle.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> ---
>  arch/x86/kernel/cpu/amd.c    | 13 +++++++-----
>  arch/x86/kernel/cpu/common.c | 38 +++++++++++++++++++-----------------
>  arch/x86/kernel/setup.c      |  4 ++--
>  3 files changed, 30 insertions(+), 25 deletions(-)

Looks ok to me.

Reviewed-by: Borislav Petkov <bp@suse.de>

Also, please take the patch below into your queue and keep it a separate
patch in case we have to revert it later. It should help in keeping the
mess manageable and not let it go completely out of control before we've
done the cleanup.

Thx.

---
From: Borislav Petkov <bp@suse.de>
Date: Sat, 23 Jun 2018 11:04:47 +0200
Subject: [PATCH] x86/CPU: Call detect_nopl() only on the BSP

Make it use the setup_* variants and have it be called only on the BSP
and drop the call in generic_identify() - X86_FEATURE_NOPL will be
replicated to the APs through the forced caps. Helps keep the mess at a
manageable level.

Signed-off-by: Borislav Petkov <bp@suse.de>
---
 arch/x86/kernel/cpu/common.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kernel/cpu/common.c b/arch/x86/kernel/cpu/common.c
index 952d31f75821..1b5edbd8f6db 100644
--- a/arch/x86/kernel/cpu/common.c
+++ b/arch/x86/kernel/cpu/common.c
@@ -1021,12 +1021,12 @@ static void __init cpu_set_bug_bits(struct cpuinfo_x86 *c)
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
 
@@ -1105,7 +1105,7 @@ static void __init early_identify_cpu(struct cpuinfo_x86 *c)
 	if (!pgtable_l5_enabled())
 		setup_clear_cpu_cap(X86_FEATURE_LA57);
 
-	detect_nopl(c);
+	detect_nopl();
 }
 
 void __init early_cpu_init(void)
@@ -1203,8 +1203,6 @@ static void generic_identify(struct cpuinfo_x86 *c)
 
 	get_model_name(c); /* Default name */
 
-	detect_nopl(c);
-
 	detect_null_seg_behavior(c);
 
 	/*
-- 
2.17.0.582.gccdcbd54c

-- 
Regards/Gruss,
    Boris.

Good mailing practices for 400: avoid top-posting and trim the reply.
