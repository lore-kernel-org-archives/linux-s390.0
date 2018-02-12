Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Philipp Rudo <prudo@linux.vnet.ibm.com>
Subject: [PATCH 13/17] s390/kexec_file: Add purgatory
Date: Mon, 12 Feb 2018 11:07:50 +0100
In-Reply-To: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
References: <20180212100754.55121-1-prudo@linux.vnet.ibm.com>
Message-Id: <20180212100754.55121-14-prudo@linux.vnet.ibm.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/lkml/>
List-Post: <mailto:linux-kernel@vger.kernel.org>
To: kexec@lists.infradead.org, linux-s390@vger.kernel.org
Cc: linux-kernel@vger.kernel.org, Eric Biederman <ebiederm@xmission.com>, Vivek Goyal <vgoyal@redhat.com>, Michael Ellerman <mpe@ellerman.id.au>, Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, x86@kernel.org
List-ID: <linux-s390.vger.kernel.org>

The common code expects the architecture to have a purgatory that runs
between the two kernels. Add it now. For simplicity first skip crash
support.

Signed-off-by: Philipp Rudo <prudo@linux.vnet.ibm.com>
---
 arch/s390/Kbuild                  |  1 +
 arch/s390/include/asm/purgatory.h | 17 +++++++
 arch/s390/kernel/asm-offsets.c    |  5 ++
 arch/s390/purgatory/Makefile      | 37 +++++++++++++++
 arch/s390/purgatory/head.S        | 96 +++++++++++++++++++++++++++++++++++++++
 arch/s390/purgatory/purgatory.c   | 38 ++++++++++++++++
 6 files changed, 194 insertions(+)
 create mode 100644 arch/s390/include/asm/purgatory.h
 create mode 100644 arch/s390/purgatory/Makefile
 create mode 100644 arch/s390/purgatory/head.S
 create mode 100644 arch/s390/purgatory/purgatory.c

diff --git a/arch/s390/Kbuild b/arch/s390/Kbuild
index 9fdff3fe1a42..091f14bc9af0 100644
--- a/arch/s390/Kbuild
+++ b/arch/s390/Kbuild
@@ -8,3 +8,4 @@ obj-$(CONFIG_APPLDATA_BASE)	+= appldata/
 obj-y				+= net/
 obj-$(CONFIG_PCI)		+= pci/
 obj-$(CONFIG_NUMA)		+= numa/
+obj-y				+= purgatory/
diff --git a/arch/s390/include/asm/purgatory.h b/arch/s390/include/asm/purgatory.h
new file mode 100644
index 000000000000..e297bcfc476f
--- /dev/null
+++ b/arch/s390/include/asm/purgatory.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
+ */
+
+#ifndef _S390_PURGATORY_H_
+#define _S390_PURGATORY_H_
+#ifndef __ASSEMBLY__
+
+#include <linux/purgatory.h>
+
+int verify_sha256_digest(void);
+
+#endif	/* __ASSEMBLY__ */
+#endif /* _S390_PURGATORY_H_ */
diff --git a/arch/s390/kernel/asm-offsets.c b/arch/s390/kernel/asm-offsets.c
index 587b195b588d..a22b478de567 100644
--- a/arch/s390/kernel/asm-offsets.c
+++ b/arch/s390/kernel/asm-offsets.c
@@ -10,6 +10,7 @@
 #include <linux/kbuild.h>
 #include <linux/kvm_host.h>
 #include <linux/sched.h>
+#include <linux/purgatory.h>
 #include <asm/idle.h>
 #include <asm/vdso.h>
 #include <asm/pgtable.h>
@@ -203,5 +204,9 @@ int main(void)
 	OFFSET(__GMAP_ASCE, gmap, asce);
 	OFFSET(__SIE_PROG0C, kvm_s390_sie_block, prog0c);
 	OFFSET(__SIE_PROG20, kvm_s390_sie_block, prog20);
+	/* kexec_sha_region */
+	OFFSET(__KEXEC_SHA_REGION_START, kexec_sha_region, start);
+	OFFSET(__KEXEC_SHA_REGION_LEN, kexec_sha_region, len);
+	DEFINE(__KEXEC_SHA_REGION_SIZE, sizeof(struct kexec_sha_region));
 	return 0;
 }
diff --git a/arch/s390/purgatory/Makefile b/arch/s390/purgatory/Makefile
new file mode 100644
index 000000000000..c4b405d9c713
--- /dev/null
+++ b/arch/s390/purgatory/Makefile
@@ -0,0 +1,37 @@
+# SPDX-License-Identifier: GPL-2.0
+
+OBJECT_FILES_NON_STANDARD := y
+
+purgatory-y := head.o purgatory.o string.o sha256.o mem.o
+
+targets += $(purgatory-y) purgatory.ro kexec-purgatory.c
+PURGATORY_OBJS = $(addprefix $(obj)/,$(purgatory-y))
+
+$(obj)/sha256.o: $(srctree)/lib/sha256.c
+	$(call if_changed_rule,cc_o_c)
+
+$(obj)/mem.o: $(srctree)/arch/s390/lib/mem.S
+	$(call if_changed_rule,as_o_S)
+
+$(obj)/string.o: $(srctree)/arch/s390/lib/string.c
+	$(call if_changed_rule,cc_o_c)
+
+LDFLAGS_purgatory.ro := -e purgatory_start -r --no-undefined -nostdlib
+LDFLAGS_purgatory.ro += -z nodefaultlib
+KBUILD_CFLAGS := -fno-strict-aliasing -Wall -Wstrict-prototypes
+KBUILD_CFLAGS += -Wno-pointer-sign -Wno-sign-compare
+KBUILD_CFLAGS += -fno-zero-initialized-in-bss -fno-builtin -ffreestanding
+KBUILD_CFLAGS += -c -MD -Os -m64
+KBUILD_CFLAGS += $(call cc-option,-fno-PIE)
+
+$(obj)/purgatory.ro: $(PURGATORY_OBJS) FORCE
+		$(call if_changed,ld)
+
+CMD_BIN2C = $(objtree)/scripts/basic/bin2c
+quiet_cmd_bin2c = BIN2C   $@
+      cmd_bin2c = $(CMD_BIN2C) kexec_purgatory < $< > $@
+
+$(obj)/kexec-purgatory.c: $(obj)/purgatory.ro FORCE
+	$(call if_changed,bin2c)
+
+obj-y	+= kexec-purgatory.o
diff --git a/arch/s390/purgatory/head.S b/arch/s390/purgatory/head.S
new file mode 100644
index 000000000000..8735409d0280
--- /dev/null
+++ b/arch/s390/purgatory/head.S
@@ -0,0 +1,96 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Purgatory setup code
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
+ */
+
+#include <linux/linkage.h>
+#include <asm/asm-offsets.h>
+#include <asm/page.h>
+#include <asm/sigp.h>
+
+/* The purgatory is the code running between two kernels. It's main purpose
+ * is to verify that the next kernel was not corrupted after load and to
+ * start it.
+ */
+
+.macro START_NEXT_KERNEL base
+	lg	%r4,kernel_entry-\base(%r13)
+	lg	%r5,load_psw_mask-\base(%r13)
+	ogr	%r4,%r5
+	stg	%r4,0(%r0)
+
+	xgr	%r0,%r0
+	diag	%r0,%r0,0x308
+.endm
+
+.text
+.align PAGE_SIZE
+ENTRY(purgatory_start)
+	/* The purgatory might be called after a diag308 so better set
+	 * architecture and addressing mode.
+	 */
+	lhi	%r1,1
+	sigp	%r1,%r0,SIGP_SET_ARCHITECTURE
+	sam64
+
+	larl	%r5,gprregs
+	stmg	%r6,%r15,0(%r5)
+
+	basr	%r13,0
+.base_crash:
+
+	/* Setup stack */
+	larl	%r15,purgatory_end
+	aghi	%r15,-160
+
+.do_checksum_verification:
+	brasl	%r14,verify_sha256_digest
+
+	cghi	%r2,0		/* checksum match */
+	jne	.disabled_wait
+
+	/* start normal kernel */
+	START_NEXT_KERNEL .base_crash
+
+.disabled_wait:
+	lpswe	disabled_wait_psw-.base_crash(%r13)
+
+
+load_psw_mask:
+	.long	0x00080000,0x80000000
+
+	.align	8
+disabled_wait_psw:
+	.quad	0x0002000180000000
+	.quad	0x0000000000000000 + .do_checksum_verification
+
+gprregs:
+	.rept	10
+	.quad	0
+	.endr
+
+purgatory_sha256_digest:
+	.global purgatory_sha256_digest
+	.rept	32	/* SHA256_DIGEST_SIZE */
+	.byte	0
+	.endr
+
+purgatory_sha_regions:
+	.global purgatory_sha_regions
+	.rept	16 * __KEXEC_SHA_REGION_SIZE	/* KEXEC_SEGMENTS_MAX */
+	.byte	0
+	.endr
+
+kernel_entry:
+	.global kernel_entry
+	.quad	0
+
+	.align	PAGE_SIZE
+stack:
+	.skip	PAGE_SIZE
+	.align	PAGE_SIZE
+purgatory_end:
diff --git a/arch/s390/purgatory/purgatory.c b/arch/s390/purgatory/purgatory.c
new file mode 100644
index 000000000000..fec67b58b8be
--- /dev/null
+++ b/arch/s390/purgatory/purgatory.c
@@ -0,0 +1,38 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Purgatory code running between two kernels.
+ *
+ * Copyright IBM Corp. 2018
+ *
+ * Author(s): Philipp Rudo <prudo@linux.vnet.ibm.com>
+ */
+
+#include <linux/kexec.h>
+#include <linux/sha256.h>
+#include <linux/string.h>
+#include <asm/purgatory.h>
+
+struct kexec_sha_region purgatory_sha_regions[KEXEC_SEGMENT_MAX];
+u8 purgatory_sha256_digest[SHA256_DIGEST_SIZE];
+
+u64 kernel_entry;
+
+int verify_sha256_digest(void)
+{
+	struct kexec_sha_region *ptr, *end;
+	u8 digest[SHA256_DIGEST_SIZE];
+	struct sha256_state sctx;
+
+	sha256_init(&sctx);
+	end = purgatory_sha_regions + ARRAY_SIZE(purgatory_sha_regions);
+
+	for (ptr = purgatory_sha_regions; ptr < end; ptr++)
+		sha256_update(&sctx, (uint8_t *)(ptr->start), ptr->len);
+
+	sha256_final(&sctx, digest);
+
+	if (memcmp(digest, purgatory_sha256_digest, sizeof(digest)))
+		return 1;
+
+	return 0;
+}
-- 
2.13.5
