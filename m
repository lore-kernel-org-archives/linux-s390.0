Return-Path: <linux-arch-owner@vger.kernel.org>
From: Josh Poimboeuf <jpoimboe@redhat.com>
Subject: [PATCH RFC 1/5] cpu/speculation: Add 'cpu_spec_mitigations=' cmdline options
Date: Thu,  4 Apr 2019 11:44:11 -0500
Message-ID: <f0bd17358ab478eaca52f3b1da8305c150911b40.1554396090.git.jpoimboe@redhat.com>
In-Reply-To: <cover.1554396090.git.jpoimboe@redhat.com>
References: <cover.1554396090.git.jpoimboe@redhat.com>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190404164411.Gy3S4HmcWfyKhBREvXHY5FPLSwAUc9Z1y2KsB07Pmm4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>
List-ID: <linux-s390.vger.kernel.org>

Keeping track of the number of mitigations for all the CPU speculation
bugs has become overwhelming for many users.  It's getting more and more
complicated to decide which mitigations are needed for a given
architecture.  Complicating matters is the fact that each arch tends to
their own custom way to mitigate the same vulnerability.

Most users fall into a few basic categories:

a) they want all mitigations off;

b) they want all reasonable mitigations on, with SMT enabled even if
   it's vulnerable; or

c) they want all reasonable mitigations on, with SMT disabled if
   vulnerable.

Define a set of curated, arch-independent options, each of which is an
aggregation of existing options:

- cpu_spec_mitigations=off: Disable all mitigations.

- cpu_spec_mitigations=auto: [default] Enable all the default
  mitigations, but leave SMT enabled, even if it's vulnerable.

- cpu_spec_mitigations=auto,nosmt: Enable all the default mitigations,
  disabling SMT if needed by a mitigation.

Currently, these options are placeholders which don't actually do
anything.  They will be fleshed out in upcoming patches.

Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
---
 .../admin-guide/kernel-parameters.txt         | 23 +++++++++++++++++++
 include/linux/cpu.h                           |  8 +++++++
 kernel/cpu.c                                  | 15 ++++++++++++
 3 files changed, 46 insertions(+)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index c4d830003b21..ac42e510bd6e 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -2544,6 +2544,29 @@
 			in the "bleeding edge" mini2440 support kernel at
 			http://repo.or.cz/w/linux-2.6/mini2440.git
 
+	cpu_spec_mitigations=
+			[KNL] Control mitigations for CPU speculation
+			vulnerabilities on affected CPUs.  This is a set of
+			curated, arch-independent options, each of which is an
+			aggregation of existing options.
+
+			off
+				Disable all speculative CPU mitigations.
+
+			auto (default)
+				Mitigate all speculative CPU vulnerabilities,
+				but leave SMT enabled, even if it's vulnerable.
+				This is useful for users who don't want to be
+				surprised by SMT getting disabled across kernel
+				upgrades, or who have other ways of avoiding
+				SMT-based attacks.
+
+			auto,nosmt
+				Mitigate all speculative CPU vulnerabilities,
+				disabling SMT if needed.  This is for users who
+				always want to be fully mitigated, even if it
+				means losing SMT.
+
 	mminit_loglevel=
 			[KNL] When CONFIG_DEBUG_MEMORY_INIT is set, this
 			parameter allows control of the logging verbosity for
diff --git a/include/linux/cpu.h b/include/linux/cpu.h
index 5041357d0297..3a1740fda2e2 100644
--- a/include/linux/cpu.h
+++ b/include/linux/cpu.h
@@ -187,4 +187,12 @@ static inline void cpu_smt_disable(bool force) { }
 static inline void cpu_smt_check_topology(void) { }
 #endif
 
+enum cpu_spec_mitigations {
+	CPU_SPEC_MITIGATIONS_OFF,
+	CPU_SPEC_MITIGATIONS_AUTO,
+	CPU_SPEC_MITIGATIONS_AUTO_NOSMT,
+};
+
+extern enum cpu_spec_mitigations cpu_spec_mitigations;
+
 #endif /* _LINUX_CPU_H_ */
diff --git a/kernel/cpu.c b/kernel/cpu.c
index 6c959aea0f9e..0a9d66b90a00 100644
--- a/kernel/cpu.c
+++ b/kernel/cpu.c
@@ -2306,3 +2306,18 @@ void __init boot_cpu_hotplug_init(void)
 #endif
 	this_cpu_write(cpuhp_state.state, CPUHP_ONLINE);
 }
+
+enum cpu_spec_mitigations cpu_spec_mitigations __ro_after_init = CPU_SPEC_MITIGATIONS_AUTO;
+
+static int __init cpu_spec_mitigations_setup(char *arg)
+{
+	if (!strcmp(arg, "off"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_OFF;
+	else if (!strcmp(arg, "auto"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_AUTO;
+	else if (!strcmp(arg, "auto,nosmt"))
+		cpu_spec_mitigations = CPU_SPEC_MITIGATIONS_AUTO_NOSMT;
+
+	return 0;
+}
+early_param("cpu_spec_mitigations", cpu_spec_mitigations_setup);
-- 
2.17.2
