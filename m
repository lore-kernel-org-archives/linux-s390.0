From: Mark Rutland <mark.rutland@arm.com>
Subject: Re: [RESEND PATCH v3 02/11] arm64: mark (__)cpus_have_const_cap as
 __always_inline
Date: Tue, 23 Apr 2019 12:31:42 +0100
Message-ID: <20190423113142.GB56999@lakrids.cambridge.arm.com>
References: <20190423034959.13525-1-yamada.masahiro@socionext.com>
 <20190423034959.13525-3-yamada.masahiro@socionext.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Return-path: <linux-kernel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <20190423034959.13525-3-yamada.masahiro@socionext.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: Andrew Morton <akpm@linux-foundation.org>, linux-arch <linux-arch@vger.kernel.org>, linux-s390@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>, Arnd Bergmann <arnd@arndb.de>, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>, linux-mtd@lists.infradead.org, linux-arm-kernel@lists.infradead.org, Christophe Leroy <christophe.leroy@c-s.fr>, Mathieu Malaterre <malat@debian.org>, will.deacon@arm.com, catalin.marinas@arm.com, marc.zyngier@arm.com
List-ID: <linux-s390.vger.kernel.org>

[adding relevant arm64 folk to Cc]

On Tue, Apr 23, 2019 at 12:49:50PM +0900, Masahiro Yamada wrote:
> This prepares to move CONFIG_OPTIMIZE_INLINING from x86 to a common
> place. We need to eliminate potential issues beforehand.
> 
> If it is enabled for arm64, the following errors are reported:
> 
> In file included from ././include/linux/compiler_types.h:68,
>                  from <command-line>:
> ./arch/arm64/include/asm/jump_label.h: In function 'cpus_have_const_cap':
> ./include/linux/compiler-gcc.h:120:38: warning: asm operand 0 probably doesn't match constraints
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
> ./include/linux/compiler-gcc.h:120:38: error: impossible constraint in 'asm'
>  #define asm_volatile_goto(x...) do { asm goto(x); asm (""); } while (0)
>                                       ^~~
> ./arch/arm64/include/asm/jump_label.h:32:2: note: in expansion of macro 'asm_volatile_goto'
>   asm_volatile_goto(
>   ^~~~~~~~~~~~~~~~~
> 
> Signed-off-by: Masahiro Yamada <yamada.masahiro@socionext.com>

This looks sound to me, and from a quick scan of v5.1-rc6 with:

$ git grep -wW inline -- arch/arm64

... I didn't spot any other sites which obviously needed to be made
__always_inline.

I've built and booted this atop of defconfig and my usual suite of debug
options for fuzzing, at EL1 under QEMU/KVM, and at EL2 under QEMU/TCG,
with no issues in either case, so FWIW:

Tested-by: Mark Rutland <mark.rutland@arm.com>

Thanks,
Mark.

> ---
> 
> Changes in v3: None
> Changes in v2:
>   - split into a separate patch
> 
>  arch/arm64/include/asm/cpufeature.h | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cpufeature.h b/arch/arm64/include/asm/cpufeature.h
> index e505e1fbd2b9..77d1aa57323e 100644
> --- a/arch/arm64/include/asm/cpufeature.h
> +++ b/arch/arm64/include/asm/cpufeature.h
> @@ -406,7 +406,7 @@ static inline bool cpu_have_feature(unsigned int num)
>  }
>  
>  /* System capability check for constant caps */
> -static inline bool __cpus_have_const_cap(int num)
> +static __always_inline bool __cpus_have_const_cap(int num)
>  {
>  	if (num >= ARM64_NCAPS)
>  		return false;
> @@ -420,7 +420,7 @@ static inline bool cpus_have_cap(unsigned int num)
>  	return test_bit(num, cpu_hwcaps);
>  }
>  
> -static inline bool cpus_have_const_cap(int num)
> +static __always_inline bool cpus_have_const_cap(int num)
>  {
>  	if (static_branch_likely(&arm64_const_caps_ready))
>  		return __cpus_have_const_cap(num);
> -- 
> 2.17.1
> 
