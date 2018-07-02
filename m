Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 6/8] x86/kernel: jump_table: use relative references
Date: Mon,  2 Jul 2018 20:11:43 +0200
Message-ID: <20180702181145.4799-7-ard.biesheuvel@linaro.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180702181143.3iyD-3LXWV3Yn4LiwAdEj4uZLpyiq_cpKZW4RCZ03t4@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Similar to the arm64 case, 64-bit x86 can benefit from using relative
references rather than absolute ones when emitting struct jump_entry
instances. Not only does this reduce the memory footprint of the entries
themselves by 33%, it also removes the need for carrying relocation
metadata on relocatable builds (i.e., for KASLR) which saves a fair
chunk of .init space as well (although the savings are not as dramatic
as on arm64)

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/Kconfig                  |  1 +
 arch/x86/include/asm/jump_label.h | 24 +++++++-------------
 tools/objtool/special.c           |  4 ++--
 3 files changed, 11 insertions(+), 18 deletions(-)

diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
index e10a3542db7e..dd71258ec1cc 100644
--- a/arch/x86/Kconfig
+++ b/arch/x86/Kconfig
@@ -118,6 +118,7 @@ config X86
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_HUGE_VMAP		if X86_64 || X86_PAE
 	select HAVE_ARCH_JUMP_LABEL
+	select HAVE_ARCH_JUMP_LABEL_RELATIVE
 	select HAVE_ARCH_KASAN			if X86_64
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_MMAP_RND_BITS		if MMU
diff --git a/arch/x86/include/asm/jump_label.h b/arch/x86/include/asm/jump_label.h
index 8c0de4282659..21efc9d07ed9 100644
--- a/arch/x86/include/asm/jump_label.h
+++ b/arch/x86/include/asm/jump_label.h
@@ -37,7 +37,8 @@ static __always_inline bool arch_static_branch(struct static_key *key, bool bran
 		".byte " __stringify(STATIC_KEY_INIT_NOP) "\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -53,7 +54,8 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 		"2:\n\t"
 		".pushsection __jump_table,  \"aw\" \n\t"
 		_ASM_ALIGN "\n\t"
-		_ASM_PTR "1b, %l[l_yes], %c0 + %c1 \n\t"
+		".long 1b - ., %l[l_yes] - . \n\t"
+		_ASM_PTR "%c0 + %c1 - .\n\t"
 		".popsection \n\t"
 		: :  "i" (key), "i" (branch) : : l_yes);
 
@@ -62,18 +64,6 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 	return true;
 }
 
-#ifdef CONFIG_X86_64
-typedef u64 jump_label_t;
-#else
-typedef u32 jump_label_t;
-#endif
-
-struct jump_entry {
-	jump_label_t code;
-	jump_label_t target;
-	jump_label_t key;
-};
-
 #else	/* __ASSEMBLY__ */
 
 .macro STATIC_JUMP_IF_TRUE target, key, def
@@ -88,7 +78,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key - .
 	.popsection
 .endm
 
@@ -104,7 +95,8 @@ struct jump_entry {
 	.endif
 	.pushsection __jump_table, "aw"
 	_ASM_ALIGN
-	_ASM_PTR	.Lstatic_jump_\@, \target, \key + 1
+	.long		.Lstatic_jump_\@ - ., \target - .
+	_ASM_PTR	\key + 1 - .
 	.popsection
 .endm
 
diff --git a/tools/objtool/special.c b/tools/objtool/special.c
index 84f001d52322..50af4e1274b3 100644
--- a/tools/objtool/special.c
+++ b/tools/objtool/special.c
@@ -30,9 +30,9 @@
 #define EX_ORIG_OFFSET		0
 #define EX_NEW_OFFSET		4
 
-#define JUMP_ENTRY_SIZE		24
+#define JUMP_ENTRY_SIZE		16
 #define JUMP_ORIG_OFFSET	0
-#define JUMP_NEW_OFFSET		8
+#define JUMP_NEW_OFFSET		4
 
 #define ALT_ENTRY_SIZE		13
 #define ALT_ORIG_OFFSET		0
-- 
2.17.1
