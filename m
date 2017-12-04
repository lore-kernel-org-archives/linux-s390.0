Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Subject: [PATCH v2 6/6] perf s390: add regs_query_register_offset()
Date: Mon,  4 Dec 2017 10:56:49 +0100
In-Reply-To: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
References: <1512381409-19775-1-git-send-email-brueckner@linux.vnet.ibm.com>
Message-Id: <1512381409-19775-7-git-send-email-brueckner@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: Arnaldo Carvalho de Melo <acme@kernel.org>, Alexei Starovoitov <ast@kernel.org>, Daniel Borkmann <daniel@iogearbox.net>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Will Deacon <will.deacon@arm.com>, Ingo Molnar <mingo@redhat.com>
Cc: Arnd Bergmann <arnd@arndb.de>, Peter Zijlstra <peterz@infradead.org>, "David S. Miller" <davem@davemloft.net>, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, netdev@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>

The regs_query_register_offset() helper function converts
register name like "%r0" to an offset of a register in user_pt_regs
It is required by the BPF prologue generator.

The user_pt_regs structure was recently added to "asm/ptrace.h".
Hence, update tools/perf/check-headers.sh to keep the header file
in sync with kernel changes.

Suggested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Signed-off-by: Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
Reviewed-and-tested-by: Thomas Richter <tmricht@linux.vnet.ibm.com>
Acked-by: Alexei Starovoitov <ast@kernel.org>
Cc: Arnaldo Carvalho de Melo <acme@kernel.org>
Cc: Jiri Olsa <jolsa@redhat.com>
Cc: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 tools/perf/arch/s390/Makefile          |  1 +
 tools/perf/arch/s390/util/dwarf-regs.c | 32 +++++++++++++++++++++++++++++---
 tools/perf/check-headers.sh            |  1 +
 3 files changed, 31 insertions(+), 3 deletions(-)

diff --git a/tools/perf/arch/s390/Makefile b/tools/perf/arch/s390/Makefile
index 21322e0..09ba923 100644
--- a/tools/perf/arch/s390/Makefile
+++ b/tools/perf/arch/s390/Makefile
@@ -2,3 +2,4 @@ ifndef NO_DWARF
 PERF_HAVE_DWARF_REGS := 1
 endif
 HAVE_KVM_STAT_SUPPORT := 1
+PERF_HAVE_ARCH_REGS_QUERY_REGISTER_OFFSET := 1
diff --git a/tools/perf/arch/s390/util/dwarf-regs.c b/tools/perf/arch/s390/util/dwarf-regs.c
index f47576c..a8ace5c 100644
--- a/tools/perf/arch/s390/util/dwarf-regs.c
+++ b/tools/perf/arch/s390/util/dwarf-regs.c
@@ -2,17 +2,43 @@
 /*
  * Mapping of DWARF debug register numbers into register names.
  *
- *    Copyright IBM Corp. 2010
- *    Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ * Copyright IBM Corp. 2010, 2017
+ * Author(s): Heiko Carstens <heiko.carstens@de.ibm.com>,
+ *	      Hendrik Brueckner <brueckner@linux.vnet.ibm.com>
  *
  */
 
+#include <errno.h>
 #include <stddef.h>
-#include <dwarf-regs.h>
+#include <stdlib.h>
 #include <linux/kernel.h>
+#include <asm/ptrace.h>
+#include <string.h>
+#include <dwarf-regs.h>
 #include "dwarf-regs-table.h"
 
 const char *get_arch_regstr(unsigned int n)
 {
 	return (n >= ARRAY_SIZE(s390_dwarf_regs)) ? NULL : s390_dwarf_regs[n];
 }
+
+/*
+ * Convert the register name into an offset to struct pt_regs (kernel).
+ * This is required by the BPF prologue generator.  The BPF
+ * program is called in the BPF overflow handler in the perf
+ * core.
+ */
+int regs_query_register_offset(const char *name)
+{
+	unsigned long gpr;
+
+	if (!name || strncmp(name, "%r", 2))
+		return -EINVAL;
+
+	errno = 0;
+	gpr = strtoul(name + 2, NULL, 10);
+	if (errno || gpr >= 16)
+		return -EINVAL;
+
+	return offsetof(user_pt_regs, gprs) + 8 * gpr;
+}
diff --git a/tools/perf/check-headers.sh b/tools/perf/check-headers.sh
index 77406d2..6db9d80 100755
--- a/tools/perf/check-headers.sh
+++ b/tools/perf/check-headers.sh
@@ -30,6 +30,7 @@ arch/x86/include/uapi/asm/vmx.h
 arch/powerpc/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm.h
 arch/s390/include/uapi/asm/kvm_perf.h
+arch/s390/include/uapi/asm/ptrace.h
 arch/s390/include/uapi/asm/sie.h
 arch/arm/include/uapi/asm/kvm.h
 arch/arm64/include/uapi/asm/kvm.h
-- 
1.8.3.1
