From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH v2 0/8] add support for relative references in jump tables
Date: Wed, 4 Jul 2018 09:59:23 +0200
Message-ID: <20180704075923.GF3701@osiris>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 8bit
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Content-Disposition: inline
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org, Arnd Bergmann <arnd@arndb.de>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Mon, Jul 02, 2018 at 08:11:37PM +0200, Ard Biesheuvel wrote:
> This series implements support for emitting the data structures associated
> with jump tables as 32-bit relative references instead of absolute
> references, which take up more space on builds that target 64-bit
> architectures, or implement self relocation [or both].
> 
> This series enables it for arm64 and x86, although other architectures
> might benefit as well.

Hello Ard,

feel free to add the patch below which adds support for s390 to your series.

> Changes since v1:
> - change the relative reference to the static key to a 64-bit wide one on 64
>   bit architectures; this is necessary on arm64, which allows modules to
>   reside anywhere within a 4 GB window covering the core kernel text, which
>   means a 32-bit signed quantity with its +/- 2 GB range is insufficient.
>   Note that x86_64 changes are in preparation that widen the relocation
>   range as well (using the PIE linker), so I assumed that the same change
>   is appropriate for x86 as well.

FWIW, kernel modules on s390 are since ages more than 2GB away from the
core kernel text. So this is required for s390 as well.

From 77d87236f3d5474f33c25534d8ba2c7c54c88c55 Mon Sep 17 00:00:00 2001
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Date: Wed, 4 Jul 2018 09:13:37 +0200
Subject: [PATCH] s390/jump_label: switch to relative references

Signed-off-by: Heiko Carstens <heiko.carstens@de.ibm.com>
---
 arch/s390/Kconfig                  |  1 +
 arch/s390/include/asm/jump_label.h | 40 +++++++++++++++-----------------------
 arch/s390/kernel/jump_label.c      | 11 ++++++-----
 3 files changed, 23 insertions(+), 29 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index baed39772c84..0349fb06a2ec 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -121,6 +121,7 @@ config S390
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select CPU_NO_EFFICIENT_FFS if !HAVE_MARCH_Z9_109_FEATURES
 	select HAVE_ARCH_SECCOMP_FILTER
 	select HAVE_ARCH_SOFT_DIRTY
diff --git a/arch/s390/include/asm/jump_label.h b/arch/s390/include/asm/jump_label.h
index 40f651292aa7..e2d3e6c43395 100644
--- a/arch/s390/include/asm/jump_label.h
+++ b/arch/s390/include/asm/jump_label.h
@@ -14,41 +14,33 @@
  * We use a brcl 0,2 instruction for jump labels at compile time so it
  * can be easily distinguished from a hotpatch generated instruction.
  */
-static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
+static inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl	0,"__stringify(JUMP_LABEL_NOP_OFFSET)"\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-static __always_inline bool arch_static_branch_jump(struct static_key *key, bool branch)
+static inline bool arch_static_branch_jump(struct static_key *key, bool branch)
 {
-	asm_volatile_goto("0:	brcl 15, %l[label]\n"
-		".pushsection __jump_table, \"aw\"\n"
-		".balign 8\n"
-		".quad 0b, %l[label], %0\n"
-		".popsection\n"
-		: : "X" (&((char *)key)[branch]) : : label);
-
+	asm_volatile_goto("0:	brcl 15,%l[label]\n"
+			  ".pushsection __jump_table,\"aw\"\n"
+			  ".balign	8\n"
+			  ".long	0b-.,%l[label]-.\n"
+			  ".quad	%0-.\n"
+			  ".popsection\n"
+			  : : "X" (&((char *)key)[branch]) : : label);
 	return false;
 label:
 	return true;
 }
 
-typedef unsigned long jump_label_t;
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #endif  /* __ASSEMBLY__ */
 #endif
diff --git a/arch/s390/kernel/jump_label.c b/arch/s390/kernel/jump_label.c
index 43f8430fb67d..50a1798604a8 100644
--- a/arch/s390/kernel/jump_label.c
+++ b/arch/s390/kernel/jump_label.c
@@ -33,13 +33,13 @@ static void jump_label_make_branch(struct jump_entry *entry, struct insn *insn)
 {
 	/* brcl 15,offset */
 	insn->opcode = 0xc0f4;
-	insn->offset = (entry->target - entry->code) >> 1;
+	insn->offset = (jump_entry_target(entry) - jump_entry_code(entry)) >> 1;
 }
 
 static void jump_label_bug(struct jump_entry *entry, struct insn *expected,
 			   struct insn *new)
 {
-	unsigned char *ipc = (unsigned char *)entry->code;
+	unsigned char *ipc = (unsigned char *)jump_entry_code(entry);
 	unsigned char *ipe = (unsigned char *)expected;
 	unsigned char *ipn = (unsigned char *)new;
 
@@ -59,6 +59,7 @@ static void __jump_label_transform(struct jump_entry *entry,
 				   enum jump_label_type type,
 				   int init)
 {
+	void *code = (void *)jump_entry_code(entry);
 	struct insn old, new;
 
 	if (type == JUMP_LABEL_JMP) {
@@ -69,13 +70,13 @@ static void __jump_label_transform(struct jump_entry *entry,
 		jump_label_make_nop(entry, &new);
 	}
 	if (init) {
-		if (memcmp((void *)entry->code, &orignop, sizeof(orignop)))
+		if (memcmp(code, &orignop, sizeof(orignop)))
 			jump_label_bug(entry, &orignop, &new);
 	} else {
-		if (memcmp((void *)entry->code, &old, sizeof(old)))
+		if (memcmp(code, &old, sizeof(old)))
 			jump_label_bug(entry, &old, &new);
 	}
-	s390_kernel_write((void *)entry->code, &new, sizeof(new));
+	s390_kernel_write(code, &new, sizeof(new));
 }
 
 static int __sm_arch_jump_label_transform(void *data)
-- 
2.16.4
