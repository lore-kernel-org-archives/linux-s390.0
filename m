Return-Path: <linux-arch-owner@vger.kernel.org>
From: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Subject: [PATCH v2 4/8] x86: add support for 64-bit place relative relocations
Date: Mon,  2 Jul 2018 20:11:41 +0200
Message-ID: <20180702181145.4799-5-ard.biesheuvel@linaro.org>
In-Reply-To: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
References: <20180702181145.4799-1-ard.biesheuvel@linaro.org>
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20180702181141.F3W4o8na7sHXn8dZa868peMdKWk7AG8oTvaJG7oOpSI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linux-arch@vger.kernel.org
Cc: Ard Biesheuvel <ard.biesheuvel@linaro.org>, Arnd Bergmann <arnd@arndb.de>, Heiko Carstens <heiko.carstens@de.ibm.com>, Kees Cook <keescook@chromium.org>, Will Deacon <will.deacon@arm.com>, Thomas Gleixner <tglx@linutronix.de>, Catalin Marinas <catalin.marinas@arm.com>, Ingo Molnar <mingo@redhat.com>, Steven Rostedt <rostedt@goodmis.org>, Martin Schwidefsky <schwidefsky@de.ibm.com>, Jessica Yu <jeyu@kernel.org>, Peter Zijlstra <peterz@infradead.org>
List-ID: <linux-s390.vger.kernel.org>

Add support for R_X86_64_PC64 relocations, which operate on 64-bit
quantities holding a relative symbol reference. This allows jump
table entries to be emitted in a way that makes them invariant under
runtime relocation, which means that no metadata needs to be emitted
into the kernel image to describe such data structures, resulting in
a size reduction.

Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
---
 arch/x86/include/asm/elf.h         |  1 +
 arch/x86/kernel/machine_kexec_64.c |  4 ++++
 arch/x86/kernel/module.c           |  6 ++++++
 arch/x86/tools/relocs.c            | 10 ++++++++++
 4 files changed, 21 insertions(+)

diff --git a/arch/x86/include/asm/elf.h b/arch/x86/include/asm/elf.h
index 0d157d2a1e2a..d3925d684296 100644
--- a/arch/x86/include/asm/elf.h
+++ b/arch/x86/include/asm/elf.h
@@ -62,6 +62,7 @@ typedef struct user_fxsr_struct elf_fpxregset_t;
 #define R_X86_64_PC16		13	/* 16 bit sign extended pc relative */
 #define R_X86_64_8		14	/* Direct 8 bit sign extended  */
 #define R_X86_64_PC8		15	/* 8 bit sign extended pc relative */
+#define R_X86_64_PC64		24	/* Place relative 64-bit signed */
 
 #define R_X86_64_NUM		16
 
diff --git a/arch/x86/kernel/machine_kexec_64.c b/arch/x86/kernel/machine_kexec_64.c
index 4c8acdfdc5a7..6638d1edb2be 100644
--- a/arch/x86/kernel/machine_kexec_64.c
+++ b/arch/x86/kernel/machine_kexec_64.c
@@ -496,6 +496,10 @@ int arch_kexec_apply_relocations_add(struct purgatory_info *pi,
 			value -= (u64)address;
 			*(u32 *)location = value;
 			break;
+		case R_X86_64_PC64:
+			value -= (u64)address;
+			*(u64 *)location = value;
+			break;
 		default:
 			pr_err("Unknown rela relocation: %llu\n",
 			       ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/kernel/module.c b/arch/x86/kernel/module.c
index f58336af095c..b052e883dd8c 100644
--- a/arch/x86/kernel/module.c
+++ b/arch/x86/kernel/module.c
@@ -201,6 +201,12 @@ int apply_relocate_add(Elf64_Shdr *sechdrs,
 				goto overflow;
 #endif
 			break;
+		case R_X86_64_PC64:
+			if (*(u64 *)loc != 0)
+				goto invalid_relocation;
+			val -= (u64)loc;
+			*(u64 *)loc = val;
+			break;
 		default:
 			pr_err("%s: Unknown rela relocation: %llu\n",
 			       me->name, ELF64_R_TYPE(rel[i].r_info));
diff --git a/arch/x86/tools/relocs.c b/arch/x86/tools/relocs.c
index 220e97841e49..a4075bc37e8f 100644
--- a/arch/x86/tools/relocs.c
+++ b/arch/x86/tools/relocs.c
@@ -195,6 +195,7 @@ static const char *rel_type(unsigned type)
 #if ELF_BITS == 64
 		REL_TYPE(R_X86_64_NONE),
 		REL_TYPE(R_X86_64_64),
+		REL_TYPE(R_X86_64_PC64),
 		REL_TYPE(R_X86_64_PC32),
 		REL_TYPE(R_X86_64_GOT32),
 		REL_TYPE(R_X86_64_PLT32),
@@ -781,6 +782,15 @@ static int do_reloc64(struct section *sec, Elf_Rel *rel, ElfW(Sym) *sym,
 			add_reloc(&relocs32neg, offset);
 		break;
 
+	case R_X86_64_PC64:
+		/*
+		 * Only used by jump labels
+		 */
+		if (is_percpu_sym(sym, symname))
+			die("Invalid R_X86_64_PC64 relocation against per-CPU symbol %s\n",
+			    symname);
+		break;
+
 	case R_X86_64_32:
 	case R_X86_64_32S:
 	case R_X86_64_64:
-- 
2.17.1
