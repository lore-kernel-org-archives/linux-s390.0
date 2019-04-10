From: Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH RFC 3/5] powerpc/speculation: Add support for 'cpu_spec_mitigations=' cmdline options
Date: Wed, 10 Apr 2019 16:06:50 +1000
Message-ID: <87pnpuwg05.fsf@concordia.ellerman.id.au>
References: <cover.1554396090.git.jpoimboe@redhat.com> <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
Mime-Version: 1.0
Content-Type: text/plain
Return-path: <linux-kernel-owner@vger.kernel.org>
In-Reply-To: <91b92d8182d2f114d92c95689fcd4bb1a8dda1b0.1554396090.git.jpoimboe@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg
List-ID: <linux-s390.vger.kernel.org>

Josh Poimboeuf <jpoimboe@redhat.com> writes:
> Configure powerpc CPU runtime speculation bug mitigations in accordance
> with the 'cpu_spec_mitigations=' cmdline options.  This affects
> Meltdown, Spectre v1, Spectre v2, and Speculative Store Bypass.
>
> The default behavior is unchanged.
>
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
>  Documentation/admin-guide/kernel-parameters.txt | 9 +++++----
>  arch/powerpc/kernel/security.c                  | 6 +++---
>  arch/powerpc/kernel/setup_64.c                  | 2 +-
>  3 files changed, 9 insertions(+), 8 deletions(-)
>
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index 29dc03971630..0e8eae1e8a25 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2552,10 +2552,11 @@
>  
>  			off
>  				Disable all speculative CPU mitigations.
> -				Equivalent to: nopti [x86]
> +				Equivalent to: nopti [x86, powerpc]
> +					       nospectre_v1 [powerpc]
>  					       nospectre_v2 [x86]

Not sure if you meant to omit powerpc from nospectre_v2?

You have patched it in the code below.

>  					       spectre_v2_user=off [x86]
> -					       spec_store_bypass_disable=off [x86]
> +					       spec_store_bypass_disable=off [x86, powerpc]
>  					       l1tf=off [x86]
>  
>  			auto (default)
> @@ -2568,7 +2569,7 @@
>  				Equivalent to: pti=auto [x86]
>  					       spectre_v2=auto [x86]
>  					       spectre_v2_user=auto [x86]
> -					       spec_store_bypass_disable=auto [x86]
> +					       spec_store_bypass_disable=auto [x86, powerpc]
>  					       l1tf=flush [x86]
>  
>  			auto,nosmt
> @@ -2579,7 +2580,7 @@
>  				Equivalent to: pti=auto [x86]
>  					       spectre_v2=auto [x86]
>  					       spectre_v2_user=auto [x86]
> -					       spec_store_bypass_disable=auto [x86]
> +					       spec_store_bypass_disable=auto [x86, powerpc]
>  					       l1tf=flush,nosmt [x86]
>  
>  	mminit_loglevel=
> diff --git a/arch/powerpc/kernel/security.c b/arch/powerpc/kernel/security.c
> index b33bafb8fcea..5aed4ad729ba 100644
> --- a/arch/powerpc/kernel/security.c
> +++ b/arch/powerpc/kernel/security.c
> @@ -57,7 +57,7 @@ void setup_barrier_nospec(void)
>  	enable = security_ftr_enabled(SEC_FTR_FAVOUR_SECURITY) &&
>  		 security_ftr_enabled(SEC_FTR_BNDS_CHK_SPEC_BAR);
>  
> -	if (!no_nospec)
> +	if (!no_nospec && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		enable_barrier_nospec(enable);

Adding a wrapper func that checks for CPU_SPEC_MITIGATIONS_OFF would
make these a little less verbose, eg:

	if (!no_nospec && !cpu_spec_mitigations_off())
  		enable_barrier_nospec(enable);

But that's a nitpick.

> @@ -116,7 +116,7 @@ static int __init handle_nospectre_v2(char *p)
>  early_param("nospectre_v2", handle_nospectre_v2);
>  void setup_spectre_v2(void)
>  {
> -	if (no_spectrev2)
> +	if (no_spectrev2 || cpu_spec_mitigations == CPU_SPEC_MITIGATIONS_OFF)
>  		do_btb_flush_fixups();
>  	else
>  		btb_flush_enabled = true;
> @@ -300,7 +300,7 @@ void setup_stf_barrier(void)
>  
>  	stf_enabled_flush_types = type;
>  
> -	if (!no_stf_barrier)
> +	if (!no_stf_barrier && cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		stf_barrier_enable(enable);
>  }
>  
> diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
> index ba404dd9ce1d..d9d796a66a79 100644
> --- a/arch/powerpc/kernel/setup_64.c
> +++ b/arch/powerpc/kernel/setup_64.c
> @@ -932,7 +932,7 @@ void setup_rfi_flush(enum l1d_flush_type types, bool enable)
>  
>  	enabled_flush_types = types;
>  
> -	if (!no_rfi_flush)
> +	if (!no_rfi_flush || cpu_spec_mitigations != CPU_SPEC_MITIGATIONS_OFF)
>  		rfi_flush_enable(enable);
>  }

LGTM.

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
