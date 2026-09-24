Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4FC6473C64;
	Thu, 24 Sep 2026 13:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790254867; cv=none; b=eStGtjSgQwWtmxQIQFs0v1f83rfSJnYA39xooB0ZEtJSQp1Z/eAGgtk0hpKe2JuE4pUuu+KZUBI7z9QjbNr37T3jnZXPyUCyijwze9C+oNZODZ4pez9Bniy6LgQ2dFMJLUhv2kLWr7KRE+MaQLfjC77VxP3ngXw8EWYbTM7E7xI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790254867; c=relaxed/simple;
	bh=jDtylBrLN/a1252jPNiwFJuQtiidzC1kh77CNh7jkSc=;
	h=Message-ID:Date:MIME-Version:Subject:To:References:From:
	 In-Reply-To:Content-Type; b=sECpF3ThIl/U2ndXtEBDYW+QUgMrM9OOIApq5jmt+L3P8R/B22xCKeJXRO8cVBxxzsjNTww+/EHoTA86Cwi6RLYJ9Nm2zmVsFAEmTolPiHueBP2kDNDB/Zp1fY9gJE+Rsexc4zCY8c3g4dpd37Om8ihaQg/jO1VzvfzrSKWFZTw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dIORYiS4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dIORYiS4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59D721F00893;
	Thu, 24 Sep 2026 13:00:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790254865;
	bh=5mW1VB3pDEIDhmMqh3D8+tIkgllmPkZq/qfIRkZ7CXM=;
	h=Date:Subject:To:References:From:In-Reply-To;
	b=dIORYiS4ZEvjXdZ19UBLE7NWwu46JucWv7Mo8+WbBFdDyDPMM1FLbg3r9PXToHYwZ
	 CkjEHlEpFq+Eta3WdQ8eCS1n3vMgTb1VgPFTopNlPANxO1g7MAgTHHCUsYNe6/M9ml
	 YAJlzBlcA0Gt4d27sPrwkyiKdZ86GVKAfqWX/ihjc8pS8EC79/GaLLEFSfR0yvsiHH
	 DHPMj7I87odRHun5kbhtc+vwCP413neHsSzNL2RGU+y58qKcPsE+iDy9nCS/NqhV3x
	 jhuya31OuSgXhvRj7xykjfl96HePnGiScDFoHVLqnB1WRBuTTtN4oGNrY+00fuOvyd
	 hlhoZ78PdR72Q==
Message-ID: <122118f0-1147-492d-8a81-b2f839e0cd7a@kernel.org>
Date: Thu, 24 Sep 2026 15:00:50 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC] rust: kernel: Add KUnit tests for ARCH_WARN_ASM bug table
 emission
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
 catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
 maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
 ritesh.list@gmail.com, sshegde@linux.ibm.com, pjw@kernel.org,
 palmer@dabbelt.com, aou@eecs.berkeley.edu, alex@ghiti.fr, hca@linux.ibm.com,
 gor@linux.ibm.com, agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
 svens@linux.ibm.com, tglx@kernel.org, mingo@redhat.com, bp@alien8.de,
 dave.hansen@linux.intel.com, x86@kernel.org, hpa@zytor.com,
 ojeda@kernel.org, boqun@kernel.org, gary@garyguo.net,
 bjorn3_gh@protonmail.com, lossin@kernel.org, a.hindborg@kernel.org,
 aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org,
 daniel.almeida@collabora.com, tamird@kernel.org, acourbot@nvidia.com,
 work@onurozkan.dev, nathan@kernel.org, ndesaulniers@google.com,
 morbo@google.com, justinstitt@google.com, jszhang@kernel.org,
 japo@linux.ibm.com, peterz@infradead.org, jpoimboe@kernel.org,
 seanjc@google.com, pmladek@suse.com, thuth@redhat.com, ynorov@nvidia.com,
 joelagnelf@nvidia.com, david@davidgow.net, fujita.tomonori@gmail.com,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, rust-for-linux@vger.kernel.org,
 llvm@lists.linux.dev
References: <20260922054959.955093-2-mkchauras@gmail.com>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260922054959.955093-2-mkchauras@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 22/09/2026 à 07:50, Mukesh Kumar Chaurasiya (IBM) a écrit :
> Verify that the __bug_table entry emitted by ARCH_WARN_ASM has a correct
> bug_addr displacement — i.e. the arch's trap label reference resolves to
> the trap instruction — by calling find_bug() with the exact virtual address
> of the trap, mirroring what the real trap handler does.
> 
> To support all architectures, each arch that implements ARCH_WARN_ASM now
> defines ARCH_WARN_ASM_TRAP_LABEL, a string constant naming the local label
> at which the trap instruction is placed:
> 
>    x86       "1"     (ud2 at label 1:)
>    powerpc   "1"     (twi at label 1:)

Shouldn't it also handle twnei and tdnei used for WARN_ON() and BUG_ON() ?

Christophe


>    riscv     "1"     (ebreak at label 1:)
>    arm64     "14471" (brk placed at 14471: by __BUG_ENTRY_END)
>    s390      "0"     (mc at label 0:)
> 
> The label is used consistently: in ARCH_WARN_ASM itself, in the
> bug_addr back-reference inside __BUG_ENTRY / _EMIT_BUG_ENTRY, and in
> the new generated_arch_warn_asm_trap_label.rs template, which the
> C preprocessor expands at build time into a .rs file included by the
> test's global_asm! block.
> 
> global_asm! is used instead of asm! because LLVM eliminates asm! blocks
> in dead branches; global_asm! is file-scope and always emitted.
> BUG_KUNIT_TRAP_ADDR is defined as a .global symbol in .data on top of a
> .dc.a {trap_label}b relocation so the linker resolves the trap address
> into it at link time. A Rust static initialized to zero would land in
> BSS where relocations are not applied.
> 
> The global_asm! string mirrors warn_flags!() exactly — same "/* {size} */"
> prefix, same generated_arch_warn_asm.rs and generated_arch_reachable_asm.rs
> includes, same operands — plus the .pushsection/.dc.a/.popsection tail.
> This keeps the test structurally in sync with the macro it exercises.
> 
> The CONFIG_RUST_BUG_WARN_ASM_KUNIT_TEST option depends on GENERIC_BUG
> and excludes ARM, LOONGARCH, and UML (which use a different warn_flags!
> path without ARCH_WARN_ASM).
> 
> Five tests are included in the rust_kernel_bug_warn_asm suite:
> 
>    bug_entry_found           - find_bug() returns non-NULL for the trap
>                                address, proving bug_addr is correct
>    bug_entry_is_warning      - the emitted entry has BUGFLAG_WARNING set
>    bug_entry_file            - bug_get_file_line() returns the correct
>                                source file (CONFIG_DEBUG_BUGVERBOSE only)
>    bug_entry_line            - recorded line number is non-zero, confirming
>                                the {line} operand was substituted correctly
>                                (CONFIG_DEBUG_BUGVERBOSE only)
>    bug_entry_addr_is_in_text - kernel_text_address() confirms the trap
>                                address lies in kernel text
> 
> Tested (pass:5 fail:0 skip:0) on:
>    x86_64  - QEMU x86_64
>    powerpc - QEMU pseries ppc64le (pseries_le_defconfig)
>    riscv   - QEMU riscv64
>    arm64   - QEMU aarch64
>    s390    - QEMU s390x
> 
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
> Note: I sent this out as a powerpc specific tests earlier. During review
> process some people wanted these to be arch independent. Hence sending
> this out as an RFC.
> 
> Earlier version: https://eur01.safelinks.protection.outlook.com/?url=https%3A%2F%2Flore.kernel.org%2Fall%2F20260915090453.1227034-3-mkchauras%40gmail.com%2F&data=05%7C02%7Cchristophe.leroy%40csgroup.eu%7C2fb25d39088f4c4e7ba308df186d76f5%7C8b87af7d86474dc78df45f69a2011bb5%7C0%7C0%7C639256530592353420%7CUnknown%7CTWFpbGZsb3d8eyJFbXB0eU1hcGkiOnRydWUsIlYiOiIwLjAuMDAwMCIsIlAiOiJXaW4zMiIsIkFOIjoiTWFpbCIsIldUIjoyfQ%3D%3D%7C0%7C%7C%7C&sdata=lzso63z76C74rUe7h%2FG%2FEkDi1yXK0oPXBVrlG427Z%2BM%3D&reserved=0
> 
>   arch/arm64/include/asm/asm-bug.h              |   3 +
>   arch/powerpc/include/asm/bug.h                |  22 +-
>   arch/riscv/include/asm/bug.h                  |   5 +-
>   arch/s390/include/asm/bug.h                   |   4 +-
>   arch/x86/include/asm/bug.h                    |   5 +-
>   rust/Makefile                                 |   2 +-
>   rust/kernel/.gitignore                        |   1 +
>   rust/kernel/Kconfig.test                      |  15 ++
>   rust/kernel/bug.rs                            | 191 ++++++++++++++++++
>   .../generated_arch_warn_asm_trap_label.rs.S   |   7 +
>   10 files changed, 239 insertions(+), 16 deletions(-)
>   create mode 100644 rust/kernel/generated_arch_warn_asm_trap_label.rs.S
> 
> diff --git a/arch/arm64/include/asm/asm-bug.h b/arch/arm64/include/asm/asm-bug.h
> index a5f13801b784..e0694543115e 100644
> --- a/arch/arm64/include/asm/asm-bug.h
> +++ b/arch/arm64/include/asm/asm-bug.h
> @@ -60,6 +60,9 @@ _BUGVERBOSE_LOCATION(__FILE__, __LINE__)		\
>   		".short " flags ";"			\
>   		__stringify(__BUG_ENTRY_END)
>   
> +/* Trap instruction is placed at label 14471: by __BUG_ENTRY_END */
> +#define ARCH_WARN_ASM_TRAP_LABEL "14471"
> +
>   #define ARCH_WARN_ASM(file, line, flags, size)		\
>   	__BUG_ENTRY_STRING(file, line, flags)		\
>   	__stringify(brk BUG_BRK_IMM)
> diff --git a/arch/powerpc/include/asm/bug.h b/arch/powerpc/include/asm/bug.h
> index bf31ee1e902a..f0333c564d4f 100644
> --- a/arch/powerpc/include/asm/bug.h
> +++ b/arch/powerpc/include/asm/bug.h
> @@ -32,6 +32,8 @@
>   #endif /* verbose */
>   
>   #else /* !__ASSEMBLER__ */
> +#define ARCH_WARN_ASM_TRAP_LABEL "1"
> +
>   #ifdef CONFIG_DEBUG_BUGVERBOSE
>   #define _EMIT_BUG_ENTRY(bug_entry, trap, file, line, flags)	\
>   	".section __bug_table,\"aw\"\n"				\
> @@ -45,21 +47,21 @@
>   	"		.short " flags "\n"
>   #endif
>   
> -#define BUG_ENTRY(cond_str, insn, flags, ...)			\
> -	__asm__ __volatile__(					\
> -		"1:	" insn "\n"				\
> -		_EMIT_BUG_ENTRY(2, 1b, "%0", "%1", "%2")	\
> -		".org 2b+%3\n"					\
> -		".previous\n"					\
> +#define BUG_ENTRY(cond_str, insn, flags, ...)				\
> +	__asm__ __volatile__(						\
> +		ARCH_WARN_ASM_TRAP_LABEL ":	" insn "\n"		\
> +		_EMIT_BUG_ENTRY(2, 1b, "%0", "%1", "%2")		\
> +		".org 2b+%3\n"						\
> +		".previous\n"						\
>   		: : "i" (WARN_CONDITION_STR(cond_str) __FILE__), "i" (__LINE__),	\
>   		  "i" (flags),					\
>   		  "i" (sizeof(struct bug_entry)),		\
>   		  ##__VA_ARGS__)
>   
> -#define ARCH_WARN_ASM(file, line, flags, size)			\
> -		"1:	twi 31, 0, 0\n"				\
> -		_EMIT_BUG_ENTRY(2, 1b, file, line, flags)	\
> -		".org 2b+" size "\n"				\
> +#define ARCH_WARN_ASM(file, line, flags, size)					\
> +		ARCH_WARN_ASM_TRAP_LABEL ":	twi 31, 0, 0\n"			\
> +		_EMIT_BUG_ENTRY(2, 1b, file, line, flags)			\
> +		".org 2b+" size "\n"						\
>   		".previous\n"
>   
>   #define ARCH_WARN_REACHABLE
> diff --git a/arch/riscv/include/asm/bug.h b/arch/riscv/include/asm/bug.h
> index 699c0cf3e4ef..def6b0d153f2 100644
> --- a/arch/riscv/include/asm/bug.h
> +++ b/arch/riscv/include/asm/bug.h
> @@ -29,7 +29,8 @@
>   
>   typedef u32 bug_insn_t;
>   
> -#define __BUG_ENTRY_ADDR	RISCV_INT " 1b - ."
> +#define ARCH_WARN_ASM_TRAP_LABEL	"1"
> +#define __BUG_ENTRY_ADDR	RISCV_INT " " ARCH_WARN_ASM_TRAP_LABEL "b - ."
>   #define __BUG_ENTRY_FILE(file)	RISCV_INT " " file " - ."
>   
>   #ifdef CONFIG_DEBUG_BUGVERBOSE
> @@ -47,7 +48,7 @@ typedef u32 bug_insn_t;
>   #ifdef CONFIG_GENERIC_BUG
>   
>   #define ARCH_WARN_ASM(file, line, flags, size)			\
> -		"1:\n\t"					\
> +		ARCH_WARN_ASM_TRAP_LABEL ":\n\t"		\
>   			"ebreak\n"				\
>   			".pushsection __bug_table,\"aw\"\n\t"	\
>   		"2:\n\t"					\
> diff --git a/arch/s390/include/asm/bug.h b/arch/s390/include/asm/bug.h
> index 2010342c97b1..3c0fa1acc92a 100644
> --- a/arch/s390/include/asm/bug.h
> +++ b/arch/s390/include/asm/bug.h
> @@ -26,9 +26,11 @@
>   #define WARN_CONDITION_STR(cond_str) ""
>   #endif
>   
> +#define ARCH_WARN_ASM_TRAP_LABEL "0"
> +
>   #define __BUG_ENTRY(format, file, line, flags, size)			\
>   		"	.section __bug_table,\"aw\"\n"			\
> -		"1:	.long	0b - .		# bug_entry::bug_addr\n"\
> +		"1:	.long	" ARCH_WARN_ASM_TRAP_LABEL "b - .	# bug_entry::bug_addr\n" \
>   		"	.long	" format " - .	# bug_entry::format\n"	\
>   		__BUG_ENTRY_VERBOSE(file, line)				\
>   		"	.short	"flags"		# bug_entry::flags\n"	\
> diff --git a/arch/x86/include/asm/bug.h b/arch/x86/include/asm/bug.h
> index 23ab05438269..6cca8880660e 100644
> --- a/arch/x86/include/asm/bug.h
> +++ b/arch/x86/include/asm/bug.h
> @@ -62,8 +62,9 @@ extern void __WARN_trap(struct bug_entry *bug, ...);
>   #define HAVE_ARCH_BUG_FORMAT_ARGS
>   #endif
>   
> +#define ARCH_WARN_ASM_TRAP_LABEL "1"
>   #define __BUG_ENTRY(format, file, line, flags)				\
> -	"\t.long 1b - ."	"\t# bug_entry::bug_addr\n"		\
> +	"\t.long " ARCH_WARN_ASM_TRAP_LABEL "b - ." "\t# bug_entry::bug_addr\n" \
>   	__BUG_ENTRY_FORMAT(format)					\
>   	__BUG_ENTRY_VERBOSE(file, line)					\
>   	"\t.word " flags	"\t# bug_entry::flags\n"
> @@ -101,7 +102,7 @@ do {									\
>   	"99:\n"								\
>   	"\t.string \"\"\n"						\
>   	".popsection\n"							\
> -	"1:\t " ASM_UD2 "\n"						\
> +	ARCH_WARN_ASM_TRAP_LABEL ":\t " ASM_UD2 "\n"			\
>   	_BUG_FLAGS_ASM("99b", file, line, flags, size, "")
>   
>   #else
> diff --git a/rust/Makefile b/rust/Makefile
> index da1a7409d984..8f253d516495 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -46,7 +46,7 @@ obj-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.o
>   
>   always-$(subst y,$(CONFIG_RUST),$(CONFIG_JUMP_LABEL)) += kernel/generated_arch_static_branch_asm.rs
>   ifndef CONFIG_UML
> -always-$(subst y,$(CONFIG_RUST),$(CONFIG_BUG)) += kernel/generated_arch_warn_asm.rs kernel/generated_arch_reachable_asm.rs
> +always-$(subst y,$(CONFIG_RUST),$(CONFIG_BUG)) += kernel/generated_arch_warn_asm.rs kernel/generated_arch_reachable_asm.rs kernel/generated_arch_warn_asm_trap_label.rs
>   endif
>   
>   # Avoids running `$(RUSTC)` when it may not be available.
> diff --git a/rust/kernel/.gitignore b/rust/kernel/.gitignore
> index f636ad95aaf3..05bb00bbb83c 100644
> --- a/rust/kernel/.gitignore
> +++ b/rust/kernel/.gitignore
> @@ -3,3 +3,4 @@
>   /generated_arch_static_branch_asm.rs
>   /generated_arch_warn_asm.rs
>   /generated_arch_reachable_asm.rs
> +/generated_arch_warn_asm_trap_label.rs
> diff --git a/rust/kernel/Kconfig.test b/rust/kernel/Kconfig.test
> index e6a5c7a795f0..8cd7c8f91b07 100644
> --- a/rust/kernel/Kconfig.test
> +++ b/rust/kernel/Kconfig.test
> @@ -83,4 +83,19 @@ config RUST_BITFIELD_KUNIT_TEST
>   
>   	  If unsure, say N.
>   
> +config RUST_BUG_WARN_ASM_KUNIT_TEST
> +	bool "KUnit tests for ARCH_WARN_ASM bug table emission" if !KUNIT_ALL_TESTS
> +	depends on GENERIC_BUG && !ARM && !LOONGARCH && !UML
> +	default KUNIT_ALL_TESTS
> +	help
> +	  This option enables KUnit tests that verify ARCH_WARN_ASM emits a
> +	  correct __bug_table entry: the bug_addr displacement must resolve
> +	  back to the trap instruction so that find_bug() can locate the
> +	  entry — exactly as the real trap handler does.
> +
> +	  Supported on all architectures that implement ARCH_WARN_ASM
> +	  (x86, powerpc, riscv, arm64, s390).
> +
> +	  If unsure, say N.
> +
>   endif
> diff --git a/rust/kernel/bug.rs b/rust/kernel/bug.rs
> index 3566f0234ca4..9e9b6d3a68b7 100644
> --- a/rust/kernel/bug.rs
> +++ b/rust/kernel/bug.rs
> @@ -152,3 +152,194 @@ macro_rules! warn_on {
>           cond
>       }};
>   }
> +
> +// Test-only constants and file static referenced by the global_asm block below.
> +//
> +// global_asm! is file-scope and always emitted — LLVM cannot eliminate it,
> +// unlike asm! inside a function which is subject to dead-code removal.
> +//
> +// BUG_KUNIT_TRAP_ADDR is declared as a .global symbol entirely inside the
> +// global_asm! block so the .dc.a {trap_label}b relocation lands directly on it.
> +// A Rust static initialized to zero would end up in BSS; the linker does
> +// not apply relocations to BSS, so the address would stay zero at runtime.
> +#[cfg(CONFIG_RUST_BUG_WARN_ASM_KUNIT_TEST)]
> +mod test_statics {
> +    use crate::bindings::{bug_entry, BUGFLAG_WARNING, TAINT_WARN};
> +
> +    pub(super) const FLAGS: u32 = BUGFLAG_WARNING | (TAINT_WARN << 8);
> +    pub(super) const SIZE: usize = core::mem::size_of::<bug_entry>();
> +
> +    // LINE and BUG_KUNIT_FILE are only referenced by the {file}/{line}
> +    // operands in global_asm!, which are only present when
> +    // CONFIG_DEBUG_BUGVERBOSE is set (the non-verbose _EMIT_BUG_ENTRY
> +    // drops the file/line fields from the bug table entry entirely).
> +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +    pub(super) const LINE: u32 = line!();
> +
> +    // Null-terminated source file name — the assembler references this symbol
> +    // for the verbose file pointer in __bug_table, same as warn_flags!.
> +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +    const _FILE: &[u8] = file!().as_bytes();
> +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +    #[no_mangle]
> +    pub(super) static BUG_KUNIT_FILE: [u8; _FILE.len() + 1] = {
> +        let mut bytes = [0u8; _FILE.len() + 1];
> +        let mut i = 0;
> +        while i < _FILE.len() {
> +            bytes[i] = _FILE[i];
> +            i += 1;
> +        }
> +        bytes
> +    };
> +}
> +
> +// Emit ARCH_WARN_ASM at file scope and capture the trap address.
> +//
> +// The asm string mirrors warn_flags!() exactly — same "/* {size} */" prefix,
> +// same generated_arch_warn_asm.rs and generated_arch_reachable_asm.rs includes,
> +// same operands — so the two stay in sync as the macro evolves.  The only
> +// addition is the .pushsection/.dc.a/.popsection tail that records the trap
> +// address into BUG_KUNIT_TRAP_ADDR at link time.
> +//
> +// BUG_KUNIT_TRAP_ADDR is a .global symbol in .data whose value is set by a
> +// .dc.a relocation to the arch's trap label (from
> +// generated_arch_warn_asm_trap_label.rs); .dc.a self-aligns to pointer width
> +// so no .balign is needed.
> +#[cfg(all(CONFIG_RUST_BUG_WARN_ASM_KUNIT_TEST, CONFIG_DEBUG_BUGVERBOSE))]
> +::core::arch::global_asm!(
> +    concat!(
> +        "/* {size} */",
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")),
> +        "\n\t.pushsection .data\n\t",
> +        ".global BUG_KUNIT_TRAP_ADDR\n\t",
> +        "BUG_KUNIT_TRAP_ADDR:\n\t",
> +        ".dc.a ",
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm_trap_label.rs")),
> +        "b\n\t",
> +        ".popsection\n",
> +    ),
> +    file  = sym test_statics::BUG_KUNIT_FILE,
> +    line  = const test_statics::LINE,
> +    flags = const test_statics::FLAGS,
> +    size  = const test_statics::SIZE,
> +);
> +
> +#[cfg(all(CONFIG_RUST_BUG_WARN_ASM_KUNIT_TEST, not(CONFIG_DEBUG_BUGVERBOSE)))]
> +::core::arch::global_asm!(
> +    concat!(
> +        "/* {size} */",
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm.rs")),
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_reachable_asm.rs")),
> +        "\n\t.pushsection .data\n\t",
> +        ".global BUG_KUNIT_TRAP_ADDR\n\t",
> +        "BUG_KUNIT_TRAP_ADDR:\n\t",
> +        ".dc.a ",
> +        include!(concat!(env!("OBJTREE"), "/rust/kernel/generated_arch_warn_asm_trap_label.rs")),
> +        "b\n\t",
> +        ".popsection\n",
> +    ),
> +    flags = const test_statics::FLAGS,
> +    size  = const test_statics::SIZE,
> +);
> +
> +#[cfg(CONFIG_RUST_BUG_WARN_ASM_KUNIT_TEST)]
> +#[::kernel::macros::kunit_tests(rust_kernel_bug_warn_asm)]
> +mod tests {
> +    use crate::bindings;
> +
> +    fn trap_addr() -> usize {
> +        // BUG_KUNIT_TRAP_ADDR is a .global symbol defined in the global_asm!
> +        // block above, placed in .data at the exact .dc.a 1b relocation word.
> +        // The linker resolves it to the virtual address of the twi instruction
> +        // before any Rust code runs, so reading it here is always safe.
> +        extern "C" {
> +            // .dc.a emits a pointer-width word: 4 bytes on ppc32, 8 on ppc64.
> +            // usize matches the native pointer width on both.
> +            static BUG_KUNIT_TRAP_ADDR: usize;
> +        }
> +        // SAFETY: read-only after link time, no concurrent mutation possible.
> +        unsafe { BUG_KUNIT_TRAP_ADDR }
> +    }
> +
> +    /// The `__bug_table` entry emitted by `ARCH_WARN_ASM` must be locatable
> +    /// via `find_bug()` using the trap instruction's address.  A NULL result
> +    /// means the `1b` label reference in `_EMIT_BUG_ENTRY` resolved to the
> +    /// wrong address and the real trap handler would not recognise the site.
> +    #[test]
> +    fn bug_entry_found() {
> +        // Non-zero proves the .dc.a relocation was resolved by the linker.
> +        assert!(trap_addr() != 0);
> +
> +        // SAFETY: find_bug() is always safe to call with any address; it
> +        // simply walks __bug_table and returns NULL if nothing matches.
> +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> +        // Non-NULL proves the bug_addr displacement in _EMIT_BUG_ENTRY is correct.
> +        assert!(!entry.is_null());
> +    }
> +
> +    /// The emitted entry must be flagged as a warning (not a hard BUG).
> +    #[test]
> +    fn bug_entry_is_warning() {
> +        assert!(trap_addr() != 0);
> +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> +        assert!(!entry.is_null());
> +        // SAFETY: entry is non-null and points to a valid bug_entry.
> +        let flags = unsafe { (*entry).flags } as u32;
> +        assert!(flags & bindings::BUGFLAG_WARNING != 0);
> +    }
> +
> +    /// With `CONFIG_DEBUG_BUGVERBOSE` the entry must record a non-null file
> +    /// pointer pointing back into this source file.
> +    #[test]
> +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +    fn bug_entry_file() {
> +        use kernel::str::CStrExt;
> +
> +        assert!(trap_addr() != 0);
> +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> +        assert!(!entry.is_null());
> +
> +        let mut file_ptr: *const kernel::ffi::c_char = core::ptr::null();
> +        let mut line: u32 = 0;
> +        // SAFETY: entry is non-null and valid; file_ptr and line are local
> +        // variables passed as out-parameters.
> +        unsafe { bindings::bug_get_file_line(entry, &mut file_ptr, &mut line) };
> +
> +        assert!(!file_ptr.is_null());
> +        // SAFETY: file_ptr is a non-null, null-terminated C string from BUG_KUNIT_FILE,
> +        // valid for the lifetime of this function.
> +        let file_str = unsafe { kernel::prelude::CStr::from_char_ptr(file_ptr) }
> +            .to_str()
> +            .unwrap_or("");
> +        assert!(file_str.contains("bug"));
> +    }
> +
> +    /// With `CONFIG_DEBUG_BUGVERBOSE` the recorded line number must be
> +    /// non-zero (a zero line would mean the asm operand was not substituted).
> +    #[test]
> +    #[cfg(CONFIG_DEBUG_BUGVERBOSE)]
> +    fn bug_entry_line() {
> +        assert!(trap_addr() != 0);
> +        let entry = unsafe { bindings::find_bug(trap_addr()) };
> +        assert!(!entry.is_null());
> +
> +        let mut file_ptr: *const kernel::ffi::c_char = core::ptr::null();
> +        let mut line: u32 = 0;
> +        // SAFETY: entry is non-null and valid.
> +        unsafe { bindings::bug_get_file_line(entry, &mut file_ptr, &mut line) };
> +
> +        assert!(line != 0);
> +    }
> +
> +    /// The trap address stored in `__bug_table` must lie within the kernel
> +    /// text segment.  If the label reference in `_EMIT_BUG_ENTRY` resolved
> +    /// to data or zero, `kernel_text_address()` would return false.
> +    #[test]
> +    fn bug_entry_addr_is_in_text() {
> +        assert!(trap_addr() != 0);
> +        // SAFETY: kernel_text_address() is always safe to call with any addr.
> +        let in_text = unsafe { bindings::kernel_text_address(trap_addr()) };
> +        assert!(in_text != 0);
> +    }
> +}
> diff --git a/rust/kernel/generated_arch_warn_asm_trap_label.rs.S b/rust/kernel/generated_arch_warn_asm_trap_label.rs.S
> new file mode 100644
> index 000000000000..d7bed8751f10
> --- /dev/null
> +++ b/rust/kernel/generated_arch_warn_asm_trap_label.rs.S
> @@ -0,0 +1,7 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +
> +#include <linux/bug.h>
> +
> +// Cut here.
> +
> +::kernel::concat_literals!(ARCH_WARN_ASM_TRAP_LABEL)

