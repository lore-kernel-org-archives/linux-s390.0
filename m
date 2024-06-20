Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE01B43AAE;
	Thu, 20 Jun 2024 10:01:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718877703; cv=none; b=ATDeQg1XpL/1CrvKQwFWvfK/wVVz9754n4oge+ZupB6rJRkLz2yTgWpMcWBhDIv6vbzajEVhxqSOIaiK59Wex5OGM7fzJdiAGK/EeaNX0Q663eOOUjX7mNnndC2VbqrRgV2+FSld95PxDQPvB0+PlmC6d5sEe7gGf3U8Nkp08rI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718877703; c=relaxed/simple;
	bh=PDGtyeeusX0nD2GQDIr6CWpuxU3LoCSwsVM4+P0lebk=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=sSjfvy3Oa9NQ9aBnsvnZJz6fcILbwbnKpAriWA6Ub8GWLITX/tP5TcOMCygtcI/1aEdwkYAB5WRP0K4I2UI8SLxOmg0aB7Q5wvikLg1NqixHv7q/U7KRIm6hG/GZz+nP2F0551t2+/EsdXszRYsP9+x3XLrSnVUVMO4Ew/Uby24=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E6C6EDA7;
	Thu, 20 Jun 2024 03:02:05 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BFCF13F73B;
	Thu, 20 Jun 2024 03:01:36 -0700 (PDT)
Date: Thu, 20 Jun 2024 11:01:34 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Kees Cook <kees@kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, Yuntao Liu <liuyuntao12@huawei.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>,
	"Gustavo A. R. Silva" <gustavoars@kernel.org>,
	Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>,
	Claudio Imbrenda <imbrenda@linux.ibm.com>,
	Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	linux-kernel@vger.kernel.org, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, linux-riscv@lists.infradead.org
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
Message-ID: <ZnP9_sDa-oHFepes@J2N7QTR9R3>
References: <20240619214711.work.953-kees@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240619214711.work.953-kees@kernel.org>

On Wed, Jun 19, 2024 at 02:47:15PM -0700, Kees Cook wrote:
> An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> Improve entropy diffusion") was that the per-architecture entropy size
> filtering reduced how many bits were being added to the mix, rather than
> how many bits were being used during the offsetting. All architectures
> fell back to the existing default of 0x3FF (10 bits), which will consume
> at most 1KiB of stack space. It seems that this is working just fine,
> so let's avoid the confusion and update everything to use the default.
> 
> The prior intent of the per-architecture limits were:
> 
>   arm64: capped at 0x1FF (9 bits), 5 bits effective
>   powerpc: uncapped (10 bits), 6 or 7 bits effective
>   riscv: uncapped (10 bits), 6 bits effective
>   x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
>   s390: capped at 0xFF (8 bits), undocumented effective entropy
> 
> Current discussion has led to just dropping the original per-architecture
> filters. The additional entropy appears to be safe for arm64, x86,
> and s390. Quoting Arnd, "There is no point pretending that 15.75KB is
> somehow safe to use while 15.00KB is not."
> 
> Co-developed-by: Yuntao Liu <liuyuntao12@huawei.com>
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>
> Fixes: 9c573cd31343 ("randomize_kstack: Improve entropy diffusion")
> Link: https://lore.kernel.org/r/20240617133721.377540-1-liuyuntao12@huawei.com
> Signed-off-by: Kees Cook <kees@kernel.org>
> ---
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Mark Rutland <mark.rutland@arm.com>
> ---
>  arch/arm64/kernel/syscall.c          | 16 +++++++---------
>  arch/s390/include/asm/entry-common.h |  2 +-
>  arch/x86/include/asm/entry-common.h  | 15 ++++++---------
>  3 files changed, 14 insertions(+), 19 deletions(-)

Acked-by: Mark Rutland <mark.rutland@arm.com>

Mark.

> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index ad198262b981..7230f6e20ab8 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -53,17 +53,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	syscall_set_return_value(current, regs, 0, ret);
>  
>  	/*
> -	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -	 * but not enough for arm64 stack utilization comfort. To keep
> -	 * reasonable stack head room, reduce the maximum offset to 9 bits.
> +	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> +	 * bits. The actual entropy will be further reduced by the compiler
> +	 * when applying stack alignment constraints: the AAPCS mandates a
> +	 * 16-byte aligned SP at function boundaries, which will remove the
> +	 * 4 low bits from any entropy chosen here.
>  	 *
> -	 * The actual entropy will be further reduced by the compiler when
> -	 * applying stack alignment constraints: the AAPCS mandates a
> -	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
> -	 *
> -	 * The resulting 5 bits of entropy is seen in SP[8:4].
> +	 * The resulting 6 bits of entropy is seen in SP[9:4].
>  	 */
> -	choose_random_kstack_offset(get_random_u16() & 0x1FF);
> +	choose_random_kstack_offset(get_random_u16());
>  }
>  
>  static inline bool has_syscall_work(unsigned long flags)
> diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
> index 7f5004065e8a..35555c944630 100644
> --- a/arch/s390/include/asm/entry-common.h
> +++ b/arch/s390/include/asm/entry-common.h
> @@ -54,7 +54,7 @@ static __always_inline void arch_exit_to_user_mode(void)
>  static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  						  unsigned long ti_work)
>  {
> -	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
> +	choose_random_kstack_offset(get_tod_clock_fast());
>  }
>  
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index 7e523bb3d2d3..fb2809b20b0a 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -73,19 +73,16 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  #endif
>  
>  	/*
> -	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -	 * but not enough for x86 stack utilization comfort. To keep
> -	 * reasonable stack head room, reduce the maximum offset to 8 bits.
> -	 *
> -	 * The actual entropy will be further reduced by the compiler when
> -	 * applying stack alignment constraints (see cc_stack_align4/8 in
> +	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> +	 * bits. The actual entropy will be further reduced by the compiler
> +	 * when applying stack alignment constraints (see cc_stack_align4/8 in
>  	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
>  	 * low bits from any entropy chosen here.
>  	 *
> -	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> -	 * 6 (ia32) bits.
> +	 * Therefore, final stack offset entropy will be 7 (x86_64) or
> +	 * 8 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	choose_random_kstack_offset(rdtsc());
>  }
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>  
> -- 
> 2.34.1
> 
