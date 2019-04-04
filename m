Return-Path: <linux-arch-owner@vger.kernel.org>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH RFC 2/5] x86/speculation: Add support for 'cpu_spec_mitigations=' cmdline options
Date: Thu,  4 Apr 2019 11:44:12 -0500
Message-ID: <78c63cb08f36f55407f534d49cc2543079e44dbb.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404164412.goQjNbtLtNK5Xhety5Y2SrWdf5jOoB1EZ0aqJLJdxHw@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Configure x86 runtime CPU speculation bug mitigations in accordance with
the 'cpu_spec_mitigations=' cmdline options.  This affects Meltdown,
Spectre v2, Speculative Store Bypass, and L1TF.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 15 +++++++++
 arch/x86/include/asm/processor.h              |  1 +
 arch/x86/kernel/cpu/bugs.c                    | 32 ++++++++++++++++---
 arch/x86/kvm/vmx/vmx.c                        |  2 ++
 arch/x86/mm/pti.c                             |  4 ++-
 5 files changed, 49 insertions(+), 5 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index ac42e510bd6e..29dc03971630 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2552,6 +2552,11 @@
 
 			off
 				Disable all speculative CPU mitigations.
+				Equivalent to: nopti [x86]
+					       nospectre_v2 [x86]
+					       spectre_v2_user=off [x86]
+					       spec_store_bypass_disable=off [x86]
+					       l1tf=off [x86]
 
 			auto (default)
 				Mitigate all speculative CPU vulnerabilities,
@@ -2560,12 +2565,22 @@
 				surprised by SMT getting disabled across kernel
 				upgrades, or who have other ways of avoiding
 				SMT-based attacks.
+				Equivalent to: pti=auto [x86]
+					       spectre_v2=auto [x86]
+					       spectre_v2_user=auto [x86]
+					       spec_store_bypass_disable=auto [x86]
+					       l1tf=flush [x86]
 
 			auto,nosmt
 				Mitigate all speculative CPU vulnerabilities,
 				disabling SMT if needed.  This is for users who
 				always want to be fully mitigated, even if it
 				means losing SMT.
+				Equivalent to: pti=auto [x86]
+					       spectre_v2=auto [x86]
+					       spectre_v2_user=auto [x86]
+					       spec_store_bypass_disable=auto [x86]
+					       l1tf=flush,nosmt [x86]
 
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
diff --git a/arch/x86/include/asm/processor.h b/arch/x86/include/asm/processor.h
index 2bb3a648fc12..7e95b310f869 100644
--- a/arch/x86/include/asm/processor.h
+++ b/arch/x86/include/asm/processor.h
@@ -982,6 +982,7 @@ void microcode_check(void);
 
 enum l1tf_mitigations {
 	L1TF_MITIGATION_OFF,
+	L1TF_MITIGATION_DEFAULT,
 	L1TF_MITIGATION_FLUSH_NOWARN,
 	L1TF_MITIGATION_FLUSH,
 	L1TF_MITIGATION_FLUSH_NOSMT,
diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 2da82eff0eb4..65b95fb95ba5 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -308,8 +308,11 @@ spectre_v2_parse_user_cmdline(enum spectre_v2_mitigation_cmd v2_cmd)
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2_user",
 				  arg, sizeof(arg));
-	if (ret < 0)
+	if (ret < 0) {
+		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+			return SPECTRE_V2_USER_CMD_NONE;
 		return SPECTRE_V2_USER_CMD_AUTO;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(v2_user_options); i++) {
 		if (match_option(arg, ret, v2_user_options[i].option)) {
@@ -444,8 +447,11 @@ static enum spectre_v2_mitigation_cmd __init spectre_v2_parse_cmdline(void)
 		return SPECTRE_V2_CMD_NONE;
 
 	ret = cmdline_find_option(boot_command_line, "spectre_v2", arg, sizeof(arg));
-	if (ret < 0)
+	if (ret < 0) {
+		if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+			return SPECTRE_V2_CMD_NONE;
 		return SPECTRE_V2_CMD_AUTO;
+	}
 
 	for (i = 0; i < ARRAY_SIZE(mitigation_options); i++) {
 		if (!match_option(arg, ret, mitigation_options[i].option))
@@ -677,8 +683,11 @@ static enum ssb_mitigation_cmd __init ssb_parse_cmdline(void)
 	} else {
 		ret = cmdline_find_option(boot_command_line, "spec_store_bypass_disable",
 					  arg, sizeof(arg));
-		if (ret < 0)
+		if (ret < 0) {
+			if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
+				return SPEC_STORE_BYPASS_CMD_NONE;
 			return SPEC_STORE_BYPASS_CMD_AUTO;
+		}
 
 		for (i = 0; i < ARRAY_SIZE(ssb_mitigation_options); i++) {
 			if (!match_option(arg, ret, ssb_mitigation_options[i].option))
@@ -955,7 +964,7 @@ void x86_spec_ctrl_setup_ap(void)
 #define pr_fmt(fmt)	"L1TF: " fmt
 
 /* Default mitigation for L1TF-affected CPUs */
-enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
+enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_DEFAULT;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
@@ -1010,8 +1019,23 @@ static void __init l1tf_select_mitigation(void)
 
 	override_cache_bits(&boot_cpu_data);
 
+	if (l1tf_mitigation == L1TF_MITIGATION_DEFAULT) {
+		switch (cpu_spec_mitigations) {
+		case CPU_SPEC_MITIGATIONS_OFF:
+			l1tf_mitigation = L1TF_MITIGATION_OFF;
+			break;
+		case CPU_SPEC_MITIGATIONS_AUTO:
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH;
+			break;
+		case CPU_SPEC_MITIGATIONS_AUTO_NOSMT:
+			l1tf_mitigation = L1TF_MITIGATION_FLUSH_NOSMT;
+			break;
+		}
+	}
+
 	switch (l1tf_mitigation) {
 	case L1TF_MITIGATION_OFF:
+	case L1TF_MITIGATION_DEFAULT:
 	case L1TF_MITIGATION_FLUSH_NOWARN:
 	case L1TF_MITIGATION_FLUSH:
 		break;
diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index ab432a930ae8..83b5bdc3c777 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -233,6 +233,7 @@ static int vmx_setup_l1d_flush(enum vmx_l1d_flush_state l1tf)
 		case L1TF_MITIGATION_FLUSH_NOWARN:
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
+		case L1TF_MITIGATION_DEFAULT:
 			l1tf = VMENTER_L1D_FLUSH_COND;
 			break;
 		case L1TF_MITIGATION_FULL:
@@ -6686,6 +6687,7 @@ static int vmx_vm_init(struct kvm *kvm)
 		case L1TF_MITIGATION_FLUSH:
 		case L1TF_MITIGATION_FLUSH_NOSMT:
 		case L1TF_MITIGATION_FULL:
+		case L1TF_MITIGATION_DEFAULT:
 			/*
 			 * Warn upon starting the first VM in a potentially
 			 * insecure environment.
diff --git a/arch/x86/mm/pti.c b/arch/x86/mm/pti.c
index 139b28a01ce4..6d3bf680bf95 100644
--- a/arch/x86/mm/pti.c
+++ b/arch/x86/mm/pti.c
@@ -35,6 +35,7 @@
 #include <linux/spinlock.h>
 #include <linux/mm.h>
 #include <linux/uaccess.h>
+#include <linux/cpu.h>
 
 #include <asm/cpufeature.h>
 #include <asm/hypervisor.h>
@@ -115,7 +116,8 @@ void __init pti_check_boottime_disable(void)
 		}
 	}
 
-	if (cmdline_find_option_bool(boot_command_line, "nopti")) {
+	if (cmdline_find_option_bool(boot_command_line, "nopti") ||
+	    cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
 		pti_mode = PTI_FORCE_OFF;
 		pti_print_if_insecure("disabled on command line.");
 		return;
-- 
2.17.2
