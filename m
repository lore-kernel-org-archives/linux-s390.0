Return-Path: <linux-arch-owner@vger.kernel.org>
MIME-Version: 1.0
References: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
In-Reply-To: <1553062828-27798-1-git-send-email-yamada.masahiro@socionext.com>
From: Masahiro Yamada <yamada.masahiro@socionext.com>
Date: Wed, 20 Mar 2019 15:40:39 +0900
Message-ID: <CAK7LNAQu9hmeSgKO_B1LhXqq9Z923H25HXNS9XYNvFi55WrFYw@mail.gmail.com>
Subject: Re: [PATCH] compiler: allow all arches to enable CONFIG_OPTIMIZE_INLINING
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190320064039.BOpX4vBATRYdGcupJtRZ8Yaa6NxE4Z-uQaOw2pslFEU@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>
Cc: linux-s390 <linux-s390@vger.kernel.org>, Dave Hansen <dave@sr71.net>, Arnd Bergmann <arnd@arndb.de>, Michael Ellerman <mpe@ellerman.id.au>, X86 ML <x86@kernel.org>, linux-mips@vger.kernel.org, Linux Kernel Mailing List <linux-kernel@vger.kernel.org>, Paul Burton <paul.burton@mips.com>, Ingo Molnar <mingo@redhat.com>, linux-mtd <linux-mtd@lists.infradead.org>, linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, linux-arm-kernel <linux-arm-kernel@lists.infradead.org>
List-ID: <linux-s390.vger.kernel.org>

On Wed, Mar 20, 2019 at 3:21 PM Masahiro Yamada
<yamada.masahiro@socionext.com> wrote:
>
> Commit 60a3cdd06394 ("x86: add optimized inlining") introduced
> CONFIG_OPTIMIZE_INLINING, but it has been available only for x86.
>
> The idea is obviously arch-agnostic although we need some code fixups.
> This commit moves the config entry from arch/x86/Kconfig.debug to
> lib/Kconfig.debug so that all architectures (except MIPS for now) can
> benefit from it.
>
> At this moment, I added "depends on !MIPS" because fixing 0day bot report=
s
> for MIPS was complex to me.

BTW, I got the following error if I enabled CONFIG_OPTIMIZE_INLINING for MI=
PS.

It is unclear to me how to fix it.
That's why I ended up with "depends on !MIPS".


  MODPOST vmlinux.o
arch/mips/mm/sc-mips.o: In function `mips_sc_prefetch_enable.part.2':
sc-mips.c:(.text+0x98): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0x9c): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xbc): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xc8): undefined reference to `mips_gcr_base'
sc-mips.c:(.text+0xdc): undefined reference to `mips_gcr_base'
arch/mips/mm/sc-mips.o:sc-mips.c:(.text.unlikely+0x44): more undefined
references to `mips_gcr_base'


Perhaps, MIPS folks may know how to fix it.




> I tested this patch on my arm/arm64 boards.
>
> This can make a huge difference in kernel image size especially when
> CONFIG_OPTIMIZE_FOR_SIZE is enabled.
>
> For example, I got 3.5% smaller arm64 kernel image for v5.1-rc1.
>
>   dec       file
>   18983424  arch/arm64/boot/Image.before
>   18321920  arch/arm64/boot/Image.after
>
> This also slightly improves the "Kernel hacking" Kconfig menu.
> Commit e61aca5158a8 ("Merge branch 'kconfig-diet' from Dave Hansen')
> mentioned this config option would be a good fit in the "compiler option"
> menu. I did so.
>
> I fixed up some files to avoid build warnings/errors.
>
> [1] arch/arm64/include/asm/cpufeature.h
>
> In file included from ././include/linux/compiler_types.h:68,
>                  from <command-line>:
> ./arch/arm64/include/asm/jump_label.h: In function 'cpus_have_const_cap':
> ./include/linux/compiler-gcc.h:120:38: warning: asm operand 0 probably do=
esn't match constraints
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro '=
asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler-gcc.h:120:38: error: impossible constraint in 'a=
sm'
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro '=
asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
>
> [2] arch/mips/kernel/cpu-bugs64.c
>
> arch/mips/kernel/cpu-bugs64.c: In function 'mult_sh_align_mod.constprop':
> arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't=
 match constraints [-Werror]
>   asm volatile(
>   ^~~
> arch/mips/kernel/cpu-bugs64.c:33:2: error: asm operand 1 probably doesn't=
 match constraints [-Werror]
>   asm volatile(
>   ^~~
> arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
>   asm volatile(
>   ^~~
> arch/mips/kernel/cpu-bugs64.c:33:2: error: impossible constraint in 'asm'
>   asm volatile(
>   ^~~
>
> [3] arch/powerpc/mm/tlb-radix.c
>
> arch/powerpc/mm/tlb-radix.c: In function '__radix__flush_tlb_range_psize'=
:
> arch/powerpc/mm/tlb-radix.c:104:2: error: asm operand 3 probably doesn't =
match constraints [-Werror]
>   asm volatile(PPC_TLBIEL(%0, %4, %3, %2, %1)
>   ^~~
> arch/powerpc/mm/tlb-radix.c:104:2: error: impossible constraint in 'asm'
>   CC      arch/powerpc/perf/hv-gpci.o
>
> [4] arch/s390/include/asm/cpacf.h
>
> In file included from arch/s390/crypto/des_s390.c:19:
> ./arch/s390/include/asm/cpacf.h: In function 'cpacf_query':
> ./arch/s390/include/asm/cpacf.h:170:2: warning: asm operand 3 probably do=
esn't match constraints
>   asm volatile(
>   ^~~
> ./arch/s390/include/asm/cpacf.h:170:2: error: impossible constraint in 'a=
sm'
>
> [5] arch/powerpc/kernel/prom_init.c
>
> WARNING: vmlinux.o(.text.unlikely+0x20): Section mismatch in reference fr=
om the function .prom_getprop() to the function .init.text:.call_prom()
> The function .prom_getprop() references
> the function __init .call_prom().
> This is often because .prom_getprop lacks a __init
> annotation or the annotation of .call_prom is wrong.
>
> WARNING: vmlinux.o(.text.unlikely+0x3c): Section mismatch in reference fr=
om the function .prom_getproplen() to the function .init.text:.call_prom()
> The function .prom_getproplen() references
> the function __init .call_prom().
> This is often because .prom_getproplen lacks a __init
> annotation or the annotation of .call_prom is wrong.
>
> [6] drivers/mtd/nand/raw/vf610_nfc.c
>
> drivers/mtd/nand/raw/vf610_nfc.c: In function =E2=80=98vf610_nfc_cmd=E2=
=80=99:
> drivers/mtd/nand/raw/vf610_nfc.c:455:3: warning: =E2=80=98offset=E2=80=99=
 may be used uninitialized in this function [-Wmaybe-uninitialized]
>    vf610_nfc_rd_from_sram(instr->ctx.data.buf.in + offset,
>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             nfc->regs + NFC_MAIN_AREA(0) + offset,
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>             trfr_sz, !nfc->data_access);
>             ~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> [7] arch/arm/kernel/smp.c
>
> arch/arm/kernel/smp.c: In function =E2=80=98raise_nmi=E2=80=99:
> arch/arm/kernel/smp.c:522:2: warning: array subscript is above array boun=
ds [-Warray-bounds]
>   trace_ipi_raise_rcuidle(target, ipi_types[ipinr]);
>   ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>
> The fixup is not included in this. The patch is available in ML:
>
> http://lists.infradead.org/pipermail/linux-arm-kernel/2016-February/40939=
3.html
>
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>
> ---
>
>  arch/arm64/include/asm/cpufeature.h |  4 ++--
>  arch/mips/kernel/cpu-bugs64.c       |  4 ++--
>  arch/powerpc/kernel/prom_init.c     |  6 +++---
>  arch/powerpc/mm/tlb-radix.c         |  2 +-
>  arch/s390/include/asm/cpacf.h       |  2 +-
>  arch/x86/Kconfig                    |  3 ---
>  arch/x86/Kconfig.debug              | 14 --------------
>  drivers/mtd/nand/raw/vf610_nfc.c    |  2 +-
>  include/linux/compiler_types.h      |  3 +--
>  lib/Kconfig.debug                   | 15 +++++++++++++++
>  10 files changed, 26 insertions(+), 29 deletions(-)
>
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm=
/cpufeature.h
> index e505e1f..77d1aa5 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -406,7 +406,7 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>
>  /* System capability check for constant caps */
> -static inline bool __cpus_have_const_cap(int num)
> +static __always_inline bool __cpus_have_const_cap(int num)
>  {
>         if (num >=3D ARM64_NCAPS)
>                 return false;
> @@ -420,7 +420,7 @@ static inline bool cpus_have_cap(unsigned int num)
>         return test_bit(num, cpu_hwcaps);
>  }
>
> -static inline bool cpus_have_const_cap(int num)
> +static __always_inline bool cpus_have_const_cap(int num)
>  {
>         if (static_branch_likely(&arm64_const_caps_ready))
>                 return __cpus_have_const_cap(num);
> diff --git a/arch/mips/kernel/cpu-bugs64.c b/arch/mips/kernel/cpu-bugs64.=
c
> index bada74a..c04b97a 100644
> --- a/arch/mips/kernel/cpu-bugs64.c
> +++ b/arch/mips/kernel/cpu-bugs64.c
> @@ -42,8 +42,8 @@ static inline void align_mod(const int align, const int=
 mod)
>                 : "n"(align), "n"(mod));
>  }
>
> -static inline void mult_sh_align_mod(long *v1, long *v2, long *w,
> -                                    const int align, const int mod)
> +static __always_inline void mult_sh_align_mod(long *v1, long *v2, long *=
w,
> +                                             const int align, const int =
mod)
>  {
>         unsigned long flags;
>         int m1, m2;
> diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_i=
nit.c
> index f33ff41..241fe6b 100644
> --- a/arch/powerpc/kernel/prom_init.c
> +++ b/arch/powerpc/kernel/prom_init.c
> @@ -501,14 +501,14 @@ static int __init prom_next_node(phandle *nodep)
>         }
>  }
>
> -static inline int prom_getprop(phandle node, const char *pname,
> -                              void *value, size_t valuelen)
> +static inline int __init prom_getprop(phandle node, const char *pname,
> +                                     void *value, size_t valuelen)
>  {
>         return call_prom("getprop", 4, 1, node, ADDR(pname),
>                          (u32)(unsigned long) value, (u32) valuelen);
>  }
>
> -static inline int prom_getproplen(phandle node, const char *pname)
> +static inline int __init prom_getproplen(phandle node, const char *pname=
)
>  {
>         return call_prom("getproplen", 2, 1, node, ADDR(pname));
>  }
> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
> index 6a23b9e..a2b2848 100644
> --- a/arch/powerpc/mm/tlb-radix.c
> +++ b/arch/powerpc/mm/tlb-radix.c
> @@ -928,7 +928,7 @@ void radix__tlb_flush(struct mmu_gather *tlb)
>         tlb->need_flush_all =3D 0;
>  }
>
> -static inline void __radix__flush_tlb_range_psize(struct mm_struct *mm,
> +static __always_inline void __radix__flush_tlb_range_psize(struct mm_str=
uct *mm,
>                                 unsigned long start, unsigned long end,
>                                 int psize, bool also_pwc)
>  {
> diff --git a/arch/s390/include/asm/cpacf.h b/arch/s390/include/asm/cpacf.=
h
> index 3cc52e3..f316de4 100644
> --- a/arch/s390/include/asm/cpacf.h
> +++ b/arch/s390/include/asm/cpacf.h
> @@ -202,7 +202,7 @@ static inline int __cpacf_check_opcode(unsigned int o=
pcode)
>         }
>  }
>
> -static inline int cpacf_query(unsigned int opcode, cpacf_mask_t *mask)
> +static __always_inline int cpacf_query(unsigned int opcode, cpacf_mask_t=
 *mask)
>  {
>         if (__cpacf_check_opcode(opcode)) {
>                 __cpacf_query(opcode, mask);
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index c1f9b3c..1a3e2b5 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -310,9 +310,6 @@ config ZONE_DMA32
>  config AUDIT_ARCH
>         def_bool y if X86_64
>
> -config ARCH_SUPPORTS_OPTIMIZED_INLINING
> -       def_bool y
> -
>  config ARCH_SUPPORTS_DEBUG_PAGEALLOC
>         def_bool y
>
> diff --git a/arch/x86/Kconfig.debug b/arch/x86/Kconfig.debug
> index 15d0fbe..f730680 100644
> --- a/arch/x86/Kconfig.debug
> +++ b/arch/x86/Kconfig.debug
> @@ -266,20 +266,6 @@ config CPA_DEBUG
>         ---help---
>           Do change_page_attr() self-tests every 30 seconds.
>
> -config OPTIMIZE_INLINING
> -       bool "Allow gcc to uninline functions marked 'inline'"
> -       ---help---
> -         This option determines if the kernel forces gcc to inline the f=
unctions
> -         developers have marked 'inline'. Doing so takes away freedom fr=
om gcc to
> -         do what it thinks is best, which is desirable for the gcc 3.x s=
eries of
> -         compilers. The gcc 4.x series have a rewritten inlining algorit=
hm and
> -         enabling this option will generate a smaller kernel there. Hope=
fully
> -         this algorithm is so good that allowing gcc 4.x and above to ma=
ke the
> -         decision will become the default in the future. Until then this=
 option
> -         is there to test gcc for this.
> -
> -         If unsure, say N.
> -
>  config DEBUG_ENTRY
>         bool "Debug low-level entry code"
>         depends on DEBUG_KERNEL
> diff --git a/drivers/mtd/nand/raw/vf610_nfc.c b/drivers/mtd/nand/raw/vf61=
0_nfc.c
> index a662ca1..19792d7 100644
> --- a/drivers/mtd/nand/raw/vf610_nfc.c
> +++ b/drivers/mtd/nand/raw/vf610_nfc.c
> @@ -364,7 +364,7 @@ static int vf610_nfc_cmd(struct nand_chip *chip,
>  {
>         const struct nand_op_instr *instr;
>         struct vf610_nfc *nfc =3D chip_to_nfc(chip);
> -       int op_id =3D -1, trfr_sz =3D 0, offset;
> +       int op_id =3D -1, trfr_sz =3D 0, offset =3D 0;
>         u32 col =3D 0, row =3D 0, cmd1 =3D 0, cmd2 =3D 0, code =3D 0;
>         bool force8bit =3D false;
>
> diff --git a/include/linux/compiler_types.h b/include/linux/compiler_type=
s.h
> index ba814f1..19e58b9 100644
> --- a/include/linux/compiler_types.h
> +++ b/include/linux/compiler_types.h
> @@ -140,8 +140,7 @@ struct ftrace_likely_data {
>   * Do not use __always_inline here, since currently it expands to inline=
 again
>   * (which would break users of __always_inline).
>   */
> -#if !defined(CONFIG_ARCH_SUPPORTS_OPTIMIZED_INLINING) || \
> -       !defined(CONFIG_OPTIMIZE_INLINING)
> +#if !defined(CONFIG_OPTIMIZE_INLINING)
>  #define inline inline __attribute__((__always_inline__)) __gnu_inline \
>         __maybe_unused notrace
>  #else
> diff --git a/lib/Kconfig.debug b/lib/Kconfig.debug
> index 0d9e817..20f3dfc 100644
> --- a/lib/Kconfig.debug
> +++ b/lib/Kconfig.debug
> @@ -310,6 +310,21 @@ config HEADERS_CHECK
>           exported to $(INSTALL_HDR_PATH) (usually 'usr/include' in
>           your build tree), to make sure they're suitable.
>
> +config OPTIMIZE_INLINING
> +       bool "Allow compiler to uninline functions marked 'inline'"
> +       depends on !MIPS  # TODO: look into MIPS code
> +       help
> +         This option determines if the kernel forces gcc to inline the f=
unctions
> +         developers have marked 'inline'. Doing so takes away freedom fr=
om gcc to
> +         do what it thinks is best, which is desirable for the gcc 3.x s=
eries of
> +         compilers. The gcc 4.x series have a rewritten inlining algorit=
hm and
> +         enabling this option will generate a smaller kernel there. Hope=
fully
> +         this algorithm is so good that allowing gcc 4.x and above to ma=
ke the
> +         decision will become the default in the future. Until then this=
 option
> +         is there to test gcc for this.
> +
> +         If unsure, say N.
> +
>  config DEBUG_SECTION_MISMATCH
>         bool "Enable full Section mismatch analysis"
>         help
> --
> 2.7.4
>
>
> ______________________________________________________
> Linux MTD discussion mailing list
> http://lists.infradead.org/mailman/listinfo/linux-mtd/



--=20
Best Regards
Masahiro Yamada
