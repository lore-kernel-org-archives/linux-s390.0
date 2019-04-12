Return-Path: <linux-arch-owner@vger.kernel.org>
Subject: Re: [PATCH v2 5/5] arm64/speculation: Support 'mitigations=' cmdline
 option
References: <cover.1555085500.git.jpoimboe@redhat.com>
 <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
From: Randy Dunlap <rdunlap@infradead.org>
Message-ID: <25174c3c-0e39-0562-7d02-bb7d51cd2b43@infradead.org>
Date: Fri, 12 Apr 2019 16:34:47 -0700
MIME-Version: 1.0
In-Reply-To: <24039e1370ed57e8075730c0b88c505afd9e0ab7.1555085500.git.jpoimboe@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-arch-owner@vger.kernel.org
Message-ID: <20190412233447.6vhNI7dVlTrs30vYLlx-BpJ5ZFIoLHrRoL3lBdrI4xI@z>
List-Archive: <https://lore.kernel.org/linux-arch/>
List-Post: <mailto:linux-arch@vger.kernel.org>
To: Josh Poimboeuf <jpoimboe@redhat.com>, linux-kernel@vger.kernel.org
Cc: x86@kernel.org, Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>, "H . Peter Anvin" <hpa@zytor.com>, Andy Lutomirski <luto@kernel.org>, Peter Zijlstra <peterz@infradead.org>, Jiri Kosina <jikos@kernel.org>, Waiman Long <longman@redhat.com>, Andrea Arcangeli <aarcange@redhat.com>, Jon Masters <jcm@redhat.com>, Benjamin Herrenschmidt <benh@kernel.crashing.org>, Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Martin Schwidefsky <schwidefsky@de.ibm.com>, Heiko Carstens <heiko.carstens@de.ibm.com>, linux-s390@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will.deacon@arm.com>, linux-arm-kernel@lists.infradead.org, linux-arch@vger.kernel.org, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, Tyler Hicks <tyhicks@canonical.com>, Linus Torvalds <torvalds@linux-foundation.org>, Steven Price <steven.price@arm.com>, Phil Auld <pauld@redhat.com>
List-ID: <linux-s390.vger.kernel.org>

On 4/12/19 1:39 PM, Josh Poimboeuf wrote:
> Configure arm64 runtime CPU speculation bug mitigations in accordance
> with the 'mitigations=' cmdline option.  This affects Meltdown, Spectre
> v2, and Speculative Store Bypass.
> 
> The default behavior is unchanged.
> 
> Signed-off-by: Josh Poimboeuf <jpoimboe@redhat.com>
> ---
> NOTE: This is based on top of Jeremy Linton's patches:
>       https://lkml.kernel.org/r/20190410231237.52506-1-jeremy.linton@arm.com
> 
>  Documentation/admin-guide/kernel-parameters.txt | 8 +++++---
>  arch/arm64/kernel/cpu_errata.c                  | 6 +++++-
>  arch/arm64/kernel/cpufeature.c                  | 8 +++++++-
>  3 files changed, 17 insertions(+), 5 deletions(-)
> 
> diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
> index e84a01d90e92..79bfc755defe 100644
> --- a/Documentation/admin-guide/kernel-parameters.txt
> +++ b/Documentation/admin-guide/kernel-parameters.txt
> @@ -2545,8 +2545,8 @@
>  			http://repo.or.cz/w/linux-2.6/mini2440.git
>  
>  	mitigations=
> -			[X86,PPC,S390] Control optional mitigations for CPU
> -			vulnerabilities.  This is a set of curated,
> +			[X86,PPC,S390,ARM64] Control optional mitigations for
> +			CPU vulnerabilities.  This is a set of curated,
>  			arch-independent options, each of which is an
>  			aggregation of existing arch-specific options.
>  
> @@ -2555,11 +2555,13 @@
>  				improves system performance, but it may also
>  				expose users to several CPU vulnerabilities.
>  				Equivalent to: nopti [X86,PPC]
> +					       kpti=0 [ARM64]
>  					       nospectre_v1 [PPC]
>  					       nobp=0 [S390]
> -					       nospectre_v2 [X86,PPC,S390]
> +					       nospectre_v2 [X86,PPC,S390,ARM64]
>  					       spectre_v2_user=off [X86]
>  					       spec_store_bypass_disable=off [X86,PPC]
> +					       ssbd=force-off [ARM64]
>  					       l1tf=off [X86]
>  
>  			auto (default)

Hi,
Do we need to add "ARM64" to Documentation/admin-guide/kernel-parameters.rst?


-- 
~Randy
