Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH RFC 5/5] arm64/speculation: Add support for
 'cpu_spec_mitigations=' cmdline options
References: <cover.1554396090.git.jpoimboe@redhat.com>
 <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
From: Steven Price <steven.price@arm.com>
Message-ID: <be6ba8fe-b261-668a-05b9-7fa937ae650a@arm.com>
Date: Fri, 5 Apr 2019 15:39:58 +0100
MIME-Version: 1.0
In-Reply-To: <5f70df57b19bbccc4a0d5d76134b4681c9a50b0b.1554396090.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190405143958.68mhX8hptXUHk3hwMQ9WfDPhB-0ONhSHKqYsnMrEJjs@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Cc: Peter Zijlstra <peterz@infradead.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Heiko Carstens <heiko.carstens@de.ibm.com>, Paul Mackerras <paulus@samba.org>, "H . Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@kernel.org>, Andrea Arcangeli <aarcange@redhat.com>, linux-s390@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>, x86@kernel.org, Will Deacon <will.deacon@arm.com>, Linus Torvalds <torvalds@linux-foundation.org>, Catalin Marinas <catalin.marinas@arm.com>, Waiman Long <longman@redhat.com>, linux-arch@vger.kernel.org, Jon Masters <jcm@redhat.com>, Jiri Kosina <jikos@kernel.org>, Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-ID: <linux-s390.vger.kernel.org>

On 04/04/2019 17:44, Josh Poimboeuf wrote:
> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 2 ++
>  arch/arm64/kernel/cpu_errata.c                  | 4 ++++
>  arch/arm64/kernel/cpufeature.c                  | 6 ++++++
>  3 files changed, 12 insertions(+)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e838af96daa4..0b54385ee7a8 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2553,11 +2553,13 @@
>  			off
>  				Disable all speculative CPU mitigations.
>  				Equivalent to: nopti [x86, powerpc]
> +					       kpti=0 [arm64]
>  					       nospectre_v1 [powerpc]
>  					       nospectre_v2 [x86, powerpc, s390]
>  					       spectre_v2_user=off [x86]
>  					       nobp=0 [s390]
>  					       spec_store_bypass_disable=off [x86, powerpc]
> +					       ssbd=force-off [arm64]
>  					       l1tf=off [x86]
>  
>  			auto (default)
> diff --git a/arch/arm64/kernel/cpu_errata.c b/arch/arm64/kernel/cpu_errata.c
> index 9950bb0cbd52..db8d27e3fb1c 100644
> --- a/arch/arm64/kernel/cpu_errata.c
> +++ b/arch/arm64/kernel/cpu_errata.c
> @@ -19,6 +19,7 @@
>  #include <linux/arm-smccc.h>
>  #include <linux/psci.h>
>  #include <linux/types.h>
> +#include <linux/cpu.h>
>  #include <asm/cpu.h>
>  #include <asm/cputype.h>
>  #include <asm/cpufeature.h>
> @@ -385,6 +386,9 @@ static bool has_ssbd_mitigation(const struct arm64_cpu_capabilities *entry,
>  		return false;
>  	}
>  
> +	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
> +		ssbd_state = ARM64_SSBD_FORCE_DISABLE;
> +
>  	switch (psci_ops.conduit) {
>  	case PSCI_CONDUIT_HVC:
>  		arm_smccc_1_1_hvc(ARM_SMCCC_ARCH_FEATURES_FUNC_ID,
> diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
> index 4061de10cea6..4512b582d50f 100644
> --- a/arch/arm64/kernel/cpufeature.c
> +++ b/arch/arm64/kernel/cpufeature.c
> @@ -25,6 +25,7 @@
>  #include <linux/stop_machine.h>
>  #include <linux/types.h>
>  #include <linux/mm.h>
> +#include <linux/cpu.h>
>  #include <asm/cpu.h>
>  #include <asm/cpufeature.h>
>  #include <asm/cpu_ops.h>
> @@ -978,6 +979,11 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
>  		__kpti_forced = -1;
>  	}
>  
> +	if (cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF) {
> +		str = "cpu_spec_mitigations=off";

Might also be worth changing the initialisation of str, currently it is:

> 	char const *str = "command line option";

But now we have two command line options, perhaps "kpti command line
option".

Steve

> +		__kpti_forced = -1;
> +	}
> +
>  	/* Forced? */
>  	if (__kpti_forced) {
>  		pr_info_once("kernel page table isolation forced %s by %s\n",
> 
