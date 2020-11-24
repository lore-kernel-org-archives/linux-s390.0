Return-Path: <linux-kernel-owner@vger.kernel.org>
From: Dmitry Safonov <dima@arista.com>
Subject: [PATCH v2 07/19] elf: Use sysinfo_ehdr in ARCH_DLINFO()
Date: Tue, 24 Nov 2020 00:29:20 +0000
Message-Id: <20201124002932.1220517-8-dima@arista.com>
In-Reply-To: <20201124002932.1220517-1-dima@arista.com>
References: <20201124002932.1220517-1-dima@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
List-ID: <linux-s390.vger.kernel.org>
To: linux-kernel@vger.kernel.org
Cc: Dmitry Safonov <0x7f454c46@gmail.com>, Dmitry Safonov <dima@arista.com>, Alexander Viro <viro@zeniv.linux.org.uk>, Andrew Morton <akpm@linux-foundation.org>, Andy Lutomirski <luto@kernel.org>, Arnd Bergmann <arnd@arndb.de>, Borislav Petkov <bp@alien8.de>, Catalin Marinas <catalin.marinas@arm.com>, Christophe Leroy <christophe.leroy@csgroup.eu>, Guo Ren <guoren@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>, Oleg Nesterov <oleg@redhat.com>, Russell King <linux@armlinux.org.uk>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Thomas Gleixner <tglx@linutronix.de>, Vincenzo Frascino <vincenzo.frascino@arm.com>, Will Deacon <will@kernel.org>, x86@kernel.org, Christian Borntraeger <borntraeger@de.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org

Instead mm->context.vdso use the pointer provided by elf loader.
That allows to drop the pointer on arm/s390/sparc.

Cc: Christian Borntraeger <borntraeger@de.ibm.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Signed-off-by: Dmitry Safonov <dima@arista.com>
---
 arch/alpha/include/asm/elf.h    |  2 +-
 arch/arm/include/asm/elf.h      |  5 ++---
 arch/arm64/include/asm/elf.h    | 18 +++++-------------
 arch/ia64/include/asm/elf.h     |  2 +-
 arch/mips/include/asm/elf.h     |  5 ++---
 arch/nds32/include/asm/elf.h    |  5 ++---
 arch/powerpc/include/asm/elf.h  |  4 ++--
 arch/riscv/include/asm/elf.h    |  5 ++---
 arch/s390/include/asm/elf.h     |  5 ++---
 arch/sh/include/asm/elf.h       | 10 +++++-----
 arch/sparc/include/asm/elf_64.h |  5 ++---
 arch/x86/include/asm/elf.h      | 33 ++++++++++++++-------------------
 arch/x86/um/asm/elf.h           |  4 ++--
 fs/binfmt_elf.c                 |  6 +++---
 fs/binfmt_elf_fdpic.c           | 11 ++++++-----
 15 files changed, 51 insertions(+), 69 deletions(-)

diff --git a/arch/alpha/include/asm/elf.h b/arch/alpha/include/asm/elf.h
index 8049997fa372..701e820f28f0 100644
--- a/arch/alpha/include/asm/elf.h
+++ b/arch/alpha/include/asm/elf.h
@@ -155,7 +155,7 @@ extern int alpha_l2_cacheshape;
 extern int alpha_l3_cacheshape;
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
   do {								\
     NEW_AUX_ENT(AT_L1I_CACHESHAPE, alpha_l1i_cacheshape);	\
     NEW_AUX_ENT(AT_L1D_CACHESHAPE, alpha_l1d_cacheshape);	\
diff --git a/arch/arm/include/asm/elf.h b/arch/arm/include/asm/elf.h
index 47347d7412ec..76a0f04190f0 100644
--- a/arch/arm/include/asm/elf.h
+++ b/arch/arm/include/asm/elf.h
@@ -138,10 +138,9 @@ extern void elf_set_personality(const struct elf32_hdr *);
 #define SET_PERSONALITY(ex)	elf_set_personality(&(ex))
 
 #ifdef CONFIG_VDSO
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
 do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		    (elf_addr_t)current->mm->context.vdso);	\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 } while (0)
 #endif
 
diff --git a/arch/arm64/include/asm/elf.h b/arch/arm64/include/asm/elf.h
index a81953bcc1cf..e62818967a69 100644
--- a/arch/arm64/include/asm/elf.h
+++ b/arch/arm64/include/asm/elf.h
@@ -165,10 +165,9 @@ typedef struct user_fpsimd_state elf_fpregset_t;
 })
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define ARCH_DLINFO(sysinfo_ehdr)					\
 do {									\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (elf_addr_t)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);			\
 									\
 	/*								\
 	 * Should always be nonzero unless there's a kernel bug.	\
@@ -223,19 +222,12 @@ typedef compat_elf_greg_t		compat_elf_gregset_t[COMPAT_ELF_NGREG];
 	set_thread_flag(TIF_32BIT);					\
  })
 #ifdef CONFIG_COMPAT_VDSO
-#define COMPAT_ARCH_DLINFO						\
+#define COMPAT_ARCH_DLINFO(sysinfo_ehdr)				\
 do {									\
-	/*								\
-	 * Note that we use Elf64_Off instead of elf_addr_t because	\
-	 * elf_addr_t in compat is defined as Elf32_Addr and casting	\
-	 * current->mm->context.vdso to it triggers a cast warning of	\
-	 * cast from pointer to integer of different size.		\
-	 */								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-			(Elf64_Off)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);			\
 } while (0)
 #else
-#define COMPAT_ARCH_DLINFO
+#define COMPAT_ARCH_DLINFO(sysinfo_ehdr)
 #endif
 
 #endif /* CONFIG_COMPAT */
diff --git a/arch/ia64/include/asm/elf.h b/arch/ia64/include/asm/elf.h
index 6629301a2620..a257e5abddce 100644
--- a/arch/ia64/include/asm/elf.h
+++ b/arch/ia64/include/asm/elf.h
@@ -208,7 +208,7 @@ struct task_struct;
 #define GATE_EHDR	((const struct elfhdr *) GATE_ADDR)
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO								\
+#define ARCH_DLINFO(sysinfo_ehdr)						\
 do {										\
 	extern char __kernel_syscall_via_epc[];					\
 	NEW_AUX_ENT(AT_SYSINFO, (unsigned long) __kernel_syscall_via_epc);	\
diff --git a/arch/mips/include/asm/elf.h b/arch/mips/include/asm/elf.h
index 6665cf7870b3..5bdc8d00ac37 100644
--- a/arch/mips/include/asm/elf.h
+++ b/arch/mips/include/asm/elf.h
@@ -474,10 +474,9 @@ extern const char *__elf_base_platform;
 #endif
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							\
+#define ARCH_DLINFO(sysinfo_ehdr)					\
 do {									\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,					\
-		    (unsigned long)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);			\
 } while (0)
 
 #ifdef CONFIG_MIPS_FP_SUPPORT
diff --git a/arch/nds32/include/asm/elf.h b/arch/nds32/include/asm/elf.h
index 36cec4ae5a84..4f5894208efe 100644
--- a/arch/nds32/include/asm/elf.h
+++ b/arch/nds32/include/asm/elf.h
@@ -165,13 +165,12 @@ struct elf32_hdr;
 #define FPU_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
 #endif
 
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
 do {								\
 	/* Optional FPU initialization */			\
 	FPU_AUX_ENT;						\
 								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		    (elf_addr_t)current->mm->context.vdso);	\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 } while (0)
 
 #endif
diff --git a/arch/powerpc/include/asm/elf.h b/arch/powerpc/include/asm/elf.h
index ba0e1e331088..b1ae4411f4bd 100644
--- a/arch/powerpc/include/asm/elf.h
+++ b/arch/powerpc/include/asm/elf.h
@@ -155,7 +155,7 @@ extern int ucache_bsize;
  *   even if DLINFO_ARCH_ITEMS goes to zero or is undefined.
  * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes
  */
-#define ARCH_DLINFO							\
+#define ARCH_DLINFO(sysinfo_ehdr)					\
 do {									\
 	/* Handle glibc compatibility. */				\
 	NEW_AUX_ENT(AT_IGNOREPPC, AT_IGNOREPPC);			\
@@ -164,7 +164,7 @@ do {									\
 	NEW_AUX_ENT(AT_DCACHEBSIZE, dcache_bsize);			\
 	NEW_AUX_ENT(AT_ICACHEBSIZE, icache_bsize);			\
 	NEW_AUX_ENT(AT_UCACHEBSIZE, ucache_bsize);			\
-	VDSO_AUX_ENT(AT_SYSINFO_EHDR, current->mm->context.vdso_base);	\
+	VDSO_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);			\
 	ARCH_DLINFO_CACHE_GEOMETRY;					\
 } while (0)
 
diff --git a/arch/riscv/include/asm/elf.h b/arch/riscv/include/asm/elf.h
index 5e2543673e42..cd659e1dc259 100644
--- a/arch/riscv/include/asm/elf.h
+++ b/arch/riscv/include/asm/elf.h
@@ -58,10 +58,9 @@ extern unsigned long elf_hwcap;
 #define ELF_PLATFORM	(NULL)
 
 #ifdef CONFIG_MMU
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
 do {								\
-	NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-		(elf_addr_t)current->mm->context.vdso);		\
+	NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 	NEW_AUX_ENT(AT_L1I_CACHESIZE,				\
 		get_cache_size(1, CACHE_TYPE_INST));		\
 	NEW_AUX_ENT(AT_L1I_CACHEGEOMETRY,			\
diff --git a/arch/s390/include/asm/elf.h b/arch/s390/include/asm/elf.h
index f6ce9df8a996..1087a52f3257 100644
--- a/arch/s390/include/asm/elf.h
+++ b/arch/s390/include/asm/elf.h
@@ -269,11 +269,10 @@ do {								\
 #define STACK_RND_MASK	MMAP_RND_MASK
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO							    \
+#define ARCH_DLINFO(sysinfo_ehdr)					    \
 do {									    \
 	if (vdso_enabled)						    \
-		NEW_AUX_ENT(AT_SYSINFO_EHDR,				    \
-			    (unsigned long)current->mm->context.vdso_base); \
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		    \
 } while (0)
 
 #endif
diff --git a/arch/sh/include/asm/elf.h b/arch/sh/include/asm/elf.h
index 9b3e22e771a1..03b813c0bc39 100644
--- a/arch/sh/include/asm/elf.h
+++ b/arch/sh/include/asm/elf.h
@@ -170,13 +170,13 @@ extern void __kernel_vsyscall;
 #define VDSO_BASE		((unsigned long)current->mm->context.vdso)
 #define VDSO_SYM(x)		(VDSO_BASE + (unsigned long)(x))
 
-#define VSYSCALL_AUX_ENT					\
+#define VSYSCALL_AUX_ENT(sysinfo_ehdr)				\
 	if (vdso_enabled)					\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_BASE);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);	\
 	else							\
 		NEW_AUX_ENT(AT_IGNORE, 0)
 #else
-#define VSYSCALL_AUX_ENT	NEW_AUX_ENT(AT_IGNORE, 0)
+#define VSYSCALL_AUX_ENT(sysinfo_ehdr)	NEW_AUX_ENT(AT_IGNORE, 0)
 #endif /* CONFIG_VSYSCALL */
 
 #ifdef CONFIG_SH_FPU
@@ -188,13 +188,13 @@ extern void __kernel_vsyscall;
 extern int l1i_cache_shape, l1d_cache_shape, l2_cache_shape;
 
 /* update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT entries changes */
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
 do {								\
 	/* Optional FPU initialization */			\
 	FPU_AUX_ENT;						\
 								\
 	/* Optional vsyscall entry */				\
-	VSYSCALL_AUX_ENT;					\
+	VSYSCALL_AUX_ENT(sysinfo_ehdr);				\
 								\
 	/* Cache desc */					\
 	NEW_AUX_ENT(AT_L1I_CACHESHAPE, l1i_cache_shape);	\
diff --git a/arch/sparc/include/asm/elf_64.h b/arch/sparc/include/asm/elf_64.h
index 63a622c36df3..1e7295b5ae2f 100644
--- a/arch/sparc/include/asm/elf_64.h
+++ b/arch/sparc/include/asm/elf_64.h
@@ -213,12 +213,11 @@ do {	if ((ex).e_ident[EI_CLASS] == ELFCLASS32)	\
 
 extern unsigned int vdso_enabled;
 
-#define	ARCH_DLINFO							\
+#define	ARCH_DLINFO(sysinfo_ehdr)					\
 do {									\
 	extern struct adi_config adi_state;				\
 	if (vdso_enabled)						\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-			    (unsigned long)current->mm->context.vdso);	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 	NEW_AUX_ENT(AT_ADI_BLKSZ, adi_state.caps.blksz);		\
 	NEW_AUX_ENT(AT_ADI_NBITS, adi_state.caps.nbits);		\
 	NEW_AUX_ENT(AT_ADI_UEONADI, adi_state.caps.ue_on_adi);		\
diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 51a08f6b18e5..ace9e9da3521 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -306,11 +306,14 @@ extern u32 elf_hwcap2;
 
 struct task_struct;
 
-#define	ARCH_DLINFO_IA32						\
+#define VDSO_ENTRY(sysinfo_ehdr)					\
+	(sysinfo_ehdr + vdso_image_32.sym___kernel_vsyscall)
+
+#define	ARCH_DLINFO_IA32(sysinfo_ehdr)					\
 do {									\
-	if (VDSO_CURRENT_BASE) {					\
-		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY);			\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR, VDSO_CURRENT_BASE);	\
+	if (sysinfo_ehdr) {						\
+		NEW_AUX_ENT(AT_SYSINFO,	VDSO_ENTRY(sysinfo_ehdr));	\
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 	}								\
 } while (0)
 
@@ -344,39 +347,31 @@ extern bool mmap_address_hint_valid(unsigned long addr, unsigned long len);
 #define __STACK_RND_MASK(is32bit) ((is32bit) ? 0x7ff : 0x3fffff)
 #define STACK_RND_MASK __STACK_RND_MASK(mmap_is_ia32())
 
-#define ARCH_DLINFO							\
+#define ARCH_DLINFO(sysinfo_ehdr)					\
 do {									\
 	if (vdso64_enabled)						\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-			    (unsigned long __force)current->mm->context.vdso); \
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 } while (0)
 
 /* As a historical oddity, the x32 and x86_64 vDSOs are controlled together. */
-#define ARCH_DLINFO_X32							\
+#define ARCH_DLINFO_X32(sysinfo_ehdr)					\
 do {									\
 	if (vdso64_enabled)						\
-		NEW_AUX_ENT(AT_SYSINFO_EHDR,				\
-			    (unsigned long __force)current->mm->context.vdso); \
+		NEW_AUX_ENT(AT_SYSINFO_EHDR, sysinfo_ehdr);		\
 } while (0)
 
 #define AT_SYSINFO		32
 
-#define COMPAT_ARCH_DLINFO						\
+#define COMPAT_ARCH_DLINFO(sysinfo_ehdr)				\
 if (exec->e_machine == EM_X86_64)					\
-	ARCH_DLINFO_X32;						\
+	ARCH_DLINFO_X32(sysinfo_ehdr);					\
 else									\
-	ARCH_DLINFO_IA32
+	ARCH_DLINFO_IA32(sysinfo_ehdr)
 
 #define COMPAT_ELF_ET_DYN_BASE	(TASK_UNMAPPED_BASE + 0x1000000)
 
 #endif /* !CONFIG_X86_32 */
 
-#define VDSO_CURRENT_BASE	((unsigned long)current->mm->context.vdso)
-
-#define VDSO_ENTRY							\
-	((unsigned long)current->mm->context.vdso +			\
-	 vdso_image_32.sym___kernel_vsyscall)
-
 /* Do not change the values. See get_align_mask() */
 enum align_flags {
 	ALIGN_VA_32	= BIT(0),
diff --git a/arch/x86/um/asm/elf.h b/arch/x86/um/asm/elf.h
index 7bc1d9d94d66..953c6b7f992e 100644
--- a/arch/x86/um/asm/elf.h
+++ b/arch/x86/um/asm/elf.h
@@ -88,7 +88,7 @@ extern unsigned long __kernel_vsyscall;
 #define AT_SYSINFO		32
 #define AT_SYSINFO_EHDR		33
 
-#define ARCH_DLINFO						\
+#define ARCH_DLINFO(sysinfo_ehdr)				\
 do {								\
 	if ( vsyscall_ehdr ) {					\
 		NEW_AUX_ENT(AT_SYSINFO,	__kernel_vsyscall);	\
@@ -183,7 +183,7 @@ do {								\
 
 extern unsigned long um_vdso_addr;
 #define AT_SYSINFO_EHDR 33
-#define ARCH_DLINFO	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
+#define ARCH_DLINFO(sysinfo_ehdr)	NEW_AUX_ENT(AT_SYSINFO_EHDR, um_vdso_addr)
 
 #endif
 
diff --git a/fs/binfmt_elf.c b/fs/binfmt_elf.c
index 049ff514aa19..bc81f29b3cfb 100644
--- a/fs/binfmt_elf.c
+++ b/fs/binfmt_elf.c
@@ -171,7 +171,7 @@ static int padzero(unsigned long elf_bss)
 static int
 create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 		unsigned long load_addr, unsigned long interp_load_addr,
-		unsigned long e_entry)
+		unsigned long e_entry, unsigned long sysinfo_ehdr)
 {
 	struct mm_struct *mm = current->mm;
 	unsigned long p = bprm->p;
@@ -251,7 +251,7 @@ create_elf_tables(struct linux_binprm *bprm, const struct elfhdr *exec,
 	 * update AT_VECTOR_SIZE_ARCH if the number of NEW_AUX_ENT() in
 	 * ARCH_DLINFO changes
 	 */
-	ARCH_DLINFO;
+	ARCH_DLINFO(sysinfo_ehdr);
 #endif
 	NEW_AUX_ENT(AT_HWCAP, ELF_HWCAP);
 	NEW_AUX_ENT(AT_PAGESZ, ELF_EXEC_PAGESIZE);
@@ -1255,7 +1255,7 @@ static int load_elf_binary(struct linux_binprm *bprm)
 		goto out;
 
 	retval = create_elf_tables(bprm, elf_ex,
-			  load_addr, interp_load_addr, e_entry);
+			  load_addr, interp_load_addr, e_entry, sysinfo_ehdr);
 	if (retval < 0)
 		goto out;
 
diff --git a/fs/binfmt_elf_fdpic.c b/fs/binfmt_elf_fdpic.c
index c9ee3c240855..f0e4803ab6ca 100644
--- a/fs/binfmt_elf_fdpic.c
+++ b/fs/binfmt_elf_fdpic.c
@@ -63,7 +63,7 @@ static int elf_fdpic_map_file(struct elf_fdpic_params *, struct file *,
 
 static int create_elf_fdpic_tables(struct linux_binprm *, struct mm_struct *,
 				   struct elf_fdpic_params *,
-				   struct elf_fdpic_params *);
+				   struct elf_fdpic_params *, unsigned long);
 
 #ifndef CONFIG_MMU
 static int elf_fdpic_map_file_constdisp_on_uclinux(struct elf_fdpic_params *,
@@ -434,8 +434,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 	current->mm->start_stack = current->mm->start_brk + stack_size;
 #endif
 
-	if (create_elf_fdpic_tables(bprm, current->mm,
-				    &exec_params, &interp_params) < 0)
+	if (create_elf_fdpic_tables(bprm, current->mm, &exec_params,
+				    &interp_params, sysinfo_ehdr) < 0)
 		goto error;
 
 	kdebug("- start_code  %lx", current->mm->start_code);
@@ -496,7 +496,8 @@ static int load_elf_fdpic_binary(struct linux_binprm *bprm)
 static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 				   struct mm_struct *mm,
 				   struct elf_fdpic_params *exec_params,
-				   struct elf_fdpic_params *interp_params)
+				   struct elf_fdpic_params *interp_params,
+				   unsigned long sysinfo_ehdr)
 {
 	const struct cred *cred = current_cred();
 	unsigned long sp, csp, nitems;
@@ -664,7 +665,7 @@ static int create_elf_fdpic_tables(struct linux_binprm *bprm,
 	/* ARCH_DLINFO must come last so platform specific code can enforce
 	 * special alignment requirements on the AUXV if necessary (eg. PPC).
 	 */
-	ARCH_DLINFO;
+	ARCH_DLINFO(sysinfo_ehdr);
 #endif
 #undef NEW_AUX_ENT
 
-- 
2.29.2
