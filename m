Return-Path: <linux-s390-owner@vger.kernel.org>
Received: from bedivere.hansenpartnership.com ([66.63.167.143]:56680 "EHLO
        bedivere.hansenpartnership.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728555AbgCDHoT (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 4 Mar 2020 02:44:19 -0500
Message-ID: <1583307813.3907.4.camel@HansenPartnership.com>
Subject: Re: [PATCH v2] ima: add a new CONFIG for loading arch-specific
 policies
From: James Bottomley <James.Bottomley@HansenPartnership.com>
Date: Tue, 03 Mar 2020 23:43:33 -0800
In-Reply-To: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
References: <1583289211-5420-1-git-send-email-nayna@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Sender: linux-s390-owner@vger.kernel.org
List-ID: <linux-s390.vger.kernel.org>
To: Nayna Jain <nayna@linux.ibm.com>, linux-integrity@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, linux-efi@vger.kernel.org, linux-s390@vger.kernel.org
Cc: Ard Biesheuvel <ardb@kernel.org>, Philipp Rudo <prudo@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, zohar@linux.ibm.com, linux-kernel@vger.kernel.org

On Tue, 2020-03-03 at 21:33 -0500, Nayna Jain wrote:
> Every time a new architecture defines the IMA architecture specific
> functions - arch_ima_get_secureboot() and arch_ima_get_policy(), the
> IMA
> include file needs to be updated. To avoid this "noise", this patch
> defines a new IMA Kconfig IMA_SECURE_AND_OR_TRUSTED_BOOT option,
> allowing
> the different architectures to select it.
> 
> Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
> Signed-off-by: Nayna Jain <nayna@linux.ibm.com>
> Cc: Ard Biesheuvel <ardb@kernel.org>
> Cc: Philipp Rudo <prudo@linux.ibm.com>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> ---
> v2:
> * Fixed the issue identified by Mimi. Thanks Mimi, Ard, Heiko and
> Michael for
> discussing the fix.
> 
>  arch/powerpc/Kconfig           | 1 +
>  arch/s390/Kconfig              | 1 +
>  arch/x86/Kconfig               | 1 +
>  include/linux/ima.h            | 3 +--
>  security/integrity/ima/Kconfig | 9 +++++++++
>  5 files changed, 13 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 497b7d0b2d7e..a5cfde432983 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -979,6 +979,7 @@ config PPC_SECURE_BOOT
>  	bool
>  	depends on PPC_POWERNV
>  	depends on IMA_ARCH_POLICY
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT
>  	help
>  	  Systems with firmware secure boot enabled need to define
> security
>  	  policies to extend secure boot to the OS. This config
> allows a user
> diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
> index 8abe77536d9d..4a502fbcb800 100644
> --- a/arch/s390/Kconfig
> +++ b/arch/s390/Kconfig
> @@ -195,6 +195,7 @@ config S390
>  	select ARCH_HAS_FORCE_DMA_UNENCRYPTED
>  	select SWIOTLB
>  	select GENERIC_ALLOCATOR
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT if IMA_ARCH_POLICY
>  
>  
>  config SCHED_OMIT_FRAME_POINTER
> diff --git a/arch/x86/Kconfig b/arch/x86/Kconfig
> index beea77046f9b..7f5bfaf0cbd2 100644
> --- a/arch/x86/Kconfig
> +++ b/arch/x86/Kconfig
> @@ -230,6 +230,7 @@ config X86
>  	select VIRT_TO_BUS
>  	select X86_FEATURE_NAMES		if PROC_FS
>  	select PROC_PID_ARCH_STATUS		if PROC_FS
> +	select IMA_SECURE_AND_OR_TRUSTED_BOOT	if EFI &&
> IMA_ARCH_POLICY
>  
>  config INSTRUCTION_DECODER
>  	def_bool y
> diff --git a/include/linux/ima.h b/include/linux/ima.h
> index 1659217e9b60..aefe758f4466 100644
> --- a/include/linux/ima.h
> +++ b/include/linux/ima.h
> @@ -30,8 +30,7 @@ extern void ima_kexec_cmdline(const void *buf, int
> size);
>  extern void ima_add_kexec_buffer(struct kimage *image);
>  #endif
>  
> -#if (defined(CONFIG_X86) && defined(CONFIG_EFI)) ||
> defined(CONFIG_S390) \
> -	|| defined(CONFIG_PPC_SECURE_BOOT)
> +#ifdef CONFIG_IMA_SECURE_AND_OR_TRUSTED_BOOT
>  extern bool arch_ima_get_secureboot(void);
>  extern const char * const *arch_get_ima_policy(void);
>  #else
> diff --git a/security/integrity/ima/Kconfig
> b/security/integrity/ima/Kconfig
> index 3f3ee4e2eb0d..d17972aa413a 100644
> --- a/security/integrity/ima/Kconfig
> +++ b/security/integrity/ima/Kconfig
> @@ -327,3 +327,12 @@ config IMA_QUEUE_EARLY_BOOT_KEYS
>  	depends on IMA_MEASURE_ASYMMETRIC_KEYS
>  	depends on SYSTEM_TRUSTED_KEYRING
>  	default y
> +
> +config IMA_SECURE_AND_OR_TRUSTED_BOOT
> +	bool
> +	depends on IMA
> +	depends on IMA_ARCH_POLICY
> +	default n

You can't do this: a symbol designed to be selected can't depend on
other symbols because Kconfig doesn't see the dependencies during
select.  We even have a doc for this now:

Documentation/kbuild/Kconfig.select-break

The only way to get this to work would be to have the long name symbol
select both IMA and IMA_ARCH_POLICY, which doesn't seem to be what you
want either.

Looking at what you're trying to do, I think making the symbol
independent of IMA and IMA_ARCH_POLICY is the correct thing, then
enforce the dependencies inside the outer #ifdef, but I haven't looked
deeply at the code.

James
