Return-Path: <linux-arch-owner@vger.kernel.org>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline option
Date: Fri, 12 Apr 2019 15:39:32 -0500
Message-ID: <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1555085500.git.jpoimboe@redhat.com>
References: <cover.1555085500.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190412203932.Og81qP5wmLKQjsYrUY8VYkCs3QzsBFmn969n2MPjUsc@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Randy Dunlap <rdunlap@infradead.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

Configure arm64 runtime CPU speculation bug mitigations in accordance
with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
v2, and Speculative Store Bypass.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
NOTE: This is based on top of Jeremy Linton's patches:
      https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com

 Documentation/admin-guide/kernel-parameters.txt | 8 +++++---
 arch/arm64/kernel/cpu_errata.c                  | 6 +++++-
 arch/arm64/kernel/cpufeature.c                  | 8 +++++++-
 3 files changed, 17 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index e84a01d90e92..79bfc755defe 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2545,8 +2545,8 @@
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
 	mitigations=
-			[X86,PPC,S390] Control optional mitigations for CPU
-			vulnerabilities.  This is a set of curated,
+			[X86,PPC,S390,ARM64] Control optional mitigations for
+			CPU vulnerabilities.  This is a set of curated,
 			arch-independent options, each of which is an
 			aggregation of existing arch-specific options.
 
@@ -2555,11 +2555,13 @@
 				improves system performance, but it may also
 				expose users to several CPU vulnerabilities.
 				Equivalent to: nopti [X86,PPC]
+					       kpti=0 [ARM64]
 					       nospectre_v1 [PPC]
 					       nobp=0 [S390]
-					       nospectre_v2 [X86,PPC,S390]
+					       nospectre_v2 [X86,PPC,S390,ARM64]
 					       spectre_v2_user=off [X86]
 					       spec_store_bypass_disable=off [X86,PPC]
+					       ssbd=force-off [ARM64]
 					       l1tf=off [X86]
 
 			auto (default)
diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
index a1f3188c7be0..65bcd7f0cca1 100644
--- a/arch/arm64/kernel/cpu_errata.c
+++ b/arch/arm64/kernel/cpu_errata.c
@@ -19,6 +19,7 @@
 #include <linux/arm-smccc.h>
 #include <linux/psci.h>
 #include <linux/types.h>
+#include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cputype.h>
 #include <asm/cpufeature.h>
@@ -405,6 +406,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
 		this_cpu_safe = true;
 	}
 
+	if (cpu_mitigations_off())
+		ssbd_state = ARM64_SSBD_FORCE_DISABLE;
+
 	if (psci_ops.smccc_version == SMCCC_VERSION_1_0) {
 		ssbd_state = ARM64_SSBD_UNKNOWN;
 		if (!this_cpu_safe)
@@ -599,7 +603,7 @@ check_branch_predictor(const struct arm64_cpu_capabilities *entry, int scope)
 	}
 
 	/* forced off */
-	if (__nospectre_v2) {
+	if (__nospectre_v2 || cpu_mitigations_off()) {
 		pr_info_once("spectrev2 mitigation disabled by command line option\n");
 		__hardenbp_enab = false;
 		return false;
diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 6b7e1556460a..d826b17f7820 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -25,6 +25,7 @@
 #include <linux/stop_machine.h>
 #include <linux/types.h>
 #include <linux/mm.h>
+#include <linux/cpu.h>
 #include <asm/cpu.h>
 #include <asm/cpufeature.h>
 #include <asm/cpu_ops.h>
@@ -966,7 +967,7 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		MIDR_ALL_VERSIONS(MIDR_HISI_TSV110),
 		{ /* sentinel */ }
 	};
-	char const *str = "command line option";
+	char const *str = "kpti command line option";
 	bool meltdown_safe;
 
 	meltdown_safe = is_midr_in_range_list(read_cpuid_id(), kpti_safe_list);
@@ -988,6 +989,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		__kpti_forced = -1;
 	}
 
+	if (cpu_mitigations_off() && !__kpti_forced) {
+		str = "mitigations=off";
+		__kpti_forced = -1;
+	}
+
 	/* Useful for KASLR robustness */
 	if (IS_ENABLED(CONFIG_RANDOMIZE_BASE) && kaslr_offset() > 0) {
 		if (!__kpti_forced) {
-- 
2.17.2
