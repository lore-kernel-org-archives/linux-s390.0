Return-Path: <linux-arch-owner@vger.kernel.org>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH RFC 4/5] s390/speculation: Add support for 'cpu_spec_mitigations=' cmdline options
Date: Thu,  4 Apr 2019 11:44:14 -0500
Message-ID: <a887ee8cd195939c377ba60aac9e5c792809e447.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404164414.cktiJTWLfAEnxNs2wsW9YNTw8sV7S6dkTOl6n1bXI5U@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Configure s390 runtime CPU speculation bug mitigations in accordance
with the 'cpu_spec_mitigations=' cmdline options.  This affects Spectre
v1 and Spectre v2.

The default behavior is unchanged.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 Documentation/admin-guide/kernel-parameters.txt | 7 ++++---
 arch/s390/kernel/nospec-branch.c                | 4 +++-
 2 files changed, 7 insertions(+), 4 deletions(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index 0e8eae1e8a25..e838af96daa4 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2554,8 +2554,9 @@
 				Disable all speculative CPU mitigations.
 				Equivalent to: nopti [x86, powerpc]
 					       nospectre_v1 [powerpc]
-					       nospectre_v2 [x86]
+					       nospectre_v2 [x86, powerpc, s390]
 					       spectre_v2_user=off [x86]
+					       nobp=0 [s390]
 					       spec_store_bypass_disable=off [x86, powerpc]
 					       l1tf=off [x86]
 
@@ -2567,7 +2568,7 @@
 				upgrades, or who have other ways of avoiding
 				SMT-based attacks.
 				Equivalent to: pti=auto [x86]
-					       spectre_v2=auto [x86]
+					       spectre_v2=auto [x86, s390]
 					       spectre_v2_user=auto [x86]
 					       spec_store_bypass_disable=auto [x86, powerpc]
 					       l1tf=flush [x86]
@@ -2578,7 +2579,7 @@
 				always want to be fully mitigated, even if it
 				means losing SMT.
 				Equivalent to: pti=auto [x86]
-					       spectre_v2=auto [x86]
+					       spectre_v2=auto [x86, s390]
 					       spectre_v2_user=auto [x86]
 					       spec_store_bypass_disable=auto [x86, powerpc]
 					       l1tf=flush,nosmt [x86]
diff --git a/arch/s390/kernel/nospec-branch.c b/arch/s390/kernel/nospec-branch.c
index bdddaae96559..c40eb672b43a 100644
--- a/arch/s390/kernel/nospec-branch.c
+++ b/arch/s390/kernel/nospec-branch.c
@@ -1,6 +1,7 @@
 // SPDX-License-Identifier: GPL-2.0
 #include <linux/module.h>
 #include <linux/device.h>
+#include <linux/cpu.h>
 #include <asm/nospec-branch.h>
 
 static int __init nobp_setup_early(char *str)
@@ -58,7 +59,8 @@ early_param("nospectre_v2", nospectre_v2_setup_early);
 
 void __init nospec_auto_detect(void)
 {
-	if (test_facility(156)) {
+	if (test_facility(156) ||
+	    cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
 		/*
 		 * The machine supports etokens.
 		 * Disable expolines and disable nobp.
-- 
2.17.2
