Return-Path: <heiko.carstens@de.ibm.com>
Date: Wed, 20 Jan 2016 10:43:26 +0100
From: Heiko Carstens <heiko.carstens@de.ibm.com>
Subject: Re: [PATCH 3/4] s390: enable text relative kallsyms for 64-bit targets
Message-ID: <20160120094326.GD3395@osiris>
References: <1453280738-18721-1-git-send-email-ard.biesheuvel@linaro.org>
 <1453280738-18721-4-git-send-email-ard.biesheuvel@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1453280738-18721-4-git-send-email-ard.biesheuvel@linaro.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>
To: Ard Biesheuvel <ard.biesheuvel@linaro.org>
Cc: linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, x86@kernel.org, keescook@chromium.org, akpm@linux-foundation.org, mingo@kernel.org, hpa@zytor.com, benh@kernel.crashing.org, mpe@ellerman.id.au, mmarek@suse.cz, rusty@rustcorp.com.au
List-ID: <linux-s390.vger.kernel.org>

On Wed, Jan 20, 2016 at 10:05:37AM +0100, Ard Biesheuvel wrote:
> This enables the newly introduced text-relative kallsyms support when
> building 64-bit targets. This cuts the size of the kallsyms address
> table in half, reducing the memory footprint of the kernel .rodata
> section by about 250 KB for a defconfig build.
> 
> Signed-off-by: Ard Biesheuvel <ard.biesheuvel@linaro.org>
> ---
> 
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index dbeeb3a049f2..588160fd1db0 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -149,6 +149,7 @@ config S390
>  	select HAVE_REGS_AND_STACK_ACCESS_API
>  	select HAVE_SYSCALL_TRACEPOINTS
>  	select HAVE_VIRT_CPU_ACCOUNTING
> +	select KALLSYMS_TEXT_RELATIVE if 64BIT

Please remove the "if 64BIT" since s390 is always 64BIT in the meantime.
Tested on s390 and everything seems still to work ;)

Acked-by: Heiko Carstens <heiko.carstens@de.ibm.com>
