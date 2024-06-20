Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB031EF1D;
	Thu, 20 Jun 2024 03:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=45.249.212.188
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718855290; cv=none; b=BX4HS5/ynbQWPkf/FvD3VVLjnZeTUUZzk6+/sERbmQyyzHajggOuxd8jBdl2dTSi6b/dnAi6p8RET8yMjDbb8teXHuZbvAwiNlHYfZ/6fo6dm4RCyOQ8l5aHlG63ytxxoULm8tfpM/vswkd3du3bx8mVCx7CcP/khUuzaIt4HtA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718855290; c=relaxed/simple;
	bh=u++QIcknqBae1Tp5RFrY6Vww4ZcYFF8ag5okEarV/IY=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=gHHlljdPj6OgaHOpoUmnmY2ZjTk+Yaqe0fSbjyGwmFpCBGKgew5++/5TU/YLTuFisZJfw6aAcRuP7Ax6qNXt84W/lyhG2h32BBKdnKBzMN1cQdlkgew7YphfJrrlT0uvB5jfAx8P67QI/r3tIaxpnC1j/YfOSuPcgV6UdLkq4n4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com; spf=pass smtp.mailfrom=huawei.com; arc=none smtp.client-ip=45.249.212.188
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=quarantine dis=none) header.from=huawei.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=huawei.com
Received: from mail.maildlp.com (unknown [172.19.163.48])
	by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4W4RCW52rKznWnC;
	Thu, 20 Jun 2024 11:43:03 +0800 (CST)
Received: from dggpemd100004.china.huawei.com (unknown [7.185.36.20])
	by mail.maildlp.com (Postfix) with ESMTPS id 3FF5618007A;
	Thu, 20 Jun 2024 11:47:59 +0800 (CST)
Received: from [10.67.109.211] (10.67.109.211) by
 dggpemd100004.china.huawei.com (7.185.36.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1258.34; Thu, 20 Jun 2024 11:47:58 +0800
Message-ID: <98381dbf-f14e-4b6c-8c96-fb6b97ed46e1@huawei.com>
Date: Thu, 20 Jun 2024 11:47:58 +0800
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH] randomize_kstack: Remove non-functional per-arch entropy
 filtering
Content-Language: en-US
To: Kees Cook <kees@kernel.org>, Arnd Bergmann <arnd@arndb.de>
CC: Mark Rutland <mark.rutland@arm.com>, Catalin Marinas
	<catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko Carstens
	<hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
	<agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Thomas Gleixner <tglx@linutronix.de>,
	Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
	<dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>, "Gustavo A.
 R. Silva" <gustavoars@kernel.org>, Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>,
	Leonardo Bras <leobras@redhat.com>, Claudio Imbrenda
	<imbrenda@linux.ibm.com>, Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
	<linux-kernel@vger.kernel.org>, <x86@kernel.org>,
	<linux-arm-kernel@lists.infradead.org>, <linux-s390@vger.kernel.org>,
	<linux-hardening@vger.kernel.org>, <linux-riscv@lists.infradead.org>
References: <20240619214711.work.953-kees@kernel.org>
From: "liuyuntao (F)" <liuyuntao12@huawei.com>
In-Reply-To: <20240619214711.work.953-kees@kernel.org>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 dggpemd100004.china.huawei.com (7.185.36.20)



On 2024/6/20 5:47, Kees Cook wrote:
> An unintended consequence of commit 9c573cd31343 ("randomize_kstack:
> Improve entropy diffusion") was that the per-architecture entropy size
> filtering reduced how many bits were being added to the mix, rather than
> how many bits were being used during the offsetting. All architectures
> fell back to the existing default of 0x3FF (10 bits), which will consume
> at most 1KiB of stack space. It seems that this is working just fine,
> so let's avoid the confusion and update everything to use the default.
>

My original intent was indeed to do this, but I regret that not being 
more explicit in the commit log..

Additionally, I've tested the stack entropy by applying the following 
patch, the result was `Bits of stack entropy: 7` on arm64, too. It does 
not seem to affect the entropy value, maybe removing it is OK, or there 
may be some nuances of your intentions that I've overlooked.

--- a/include/linux/randomize_kstack.h
+++ b/include/linux/randomize_kstack.h
@@ -79,9 +79,7 @@ DECLARE_PER_CPU(u32, kstack_offset);
  #define choose_random_kstack_offset(rand) do {                         \
         if (static_branch_maybe(CONFIG_RANDOMIZE_KSTACK_OFFSET_DEFAULT, \
                                 &randomize_kstack_offset)) {            \
-               u32 offset = raw_cpu_read(kstack_offset);               \
-               offset = ror32(offset, 5) ^ (rand);                     \
-               raw_cpu_write(kstack_offset, offset);                   \
+               raw_cpu_write(kstack_offset, rand);                     \
         }                                                               \
  } while (0)
  #else /* CONFIG_RANDOMIZE_KSTACK_OFFSET */

> The prior intent of the per-architecture limits were:
> 
>    arm64: capped at 0x1FF (9 bits), 5 bits effective
>    powerpc: uncapped (10 bits), 6 or 7 bits effective
>    riscv: uncapped (10 bits), 6 bits effective
>    x86: capped at 0xFF (8 bits), 5 (x86_64) or 6 (ia32) bits effective
>    s390: capped at 0xFF (8 bits), undocumented effective entropy
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
>   arch/arm64/kernel/syscall.c          | 16 +++++++---------
>   arch/s390/include/asm/entry-common.h |  2 +-
>   arch/x86/include/asm/entry-common.h  | 15 ++++++---------
>   3 files changed, 14 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index ad198262b981..7230f6e20ab8 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -53,17 +53,15 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>   	syscall_set_return_value(current, regs, 0, ret);
>   
>   	/*
> -	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -	 * but not enough for arm64 stack utilization comfort. To keep
> -	 * reasonable stack head room, reduce the maximum offset to 9 bits.
> +	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> +	 * bits. The actual entropy will be further reduced by the compiler
> +	 * when applying stack alignment constraints: the AAPCS mandates a
> +	 * 16-byte aligned SP at function boundaries, which will remove the
> +	 * 4 low bits from any entropy chosen here.
>   	 *
> -	 * The actual entropy will be further reduced by the compiler when
> -	 * applying stack alignment constraints: the AAPCS mandates a
> -	 * 16-byte (i.e. 4-bit) aligned SP at function boundaries.
> -	 *
> -	 * The resulting 5 bits of entropy is seen in SP[8:4].
> +	 * The resulting 6 bits of entropy is seen in SP[9:4].
>   	 */
> -	choose_random_kstack_offset(get_random_u16() & 0x1FF);
> +	choose_random_kstack_offset(get_random_u16());
>   }
>   
>   static inline bool has_syscall_work(unsigned long flags)
> diff --git a/arch/s390/include/asm/entry-common.h b/arch/s390/include/asm/entry-common.h
> index 7f5004065e8a..35555c944630 100644
> --- a/arch/s390/include/asm/entry-common.h
> +++ b/arch/s390/include/asm/entry-common.h
> @@ -54,7 +54,7 @@ static __always_inline void arch_exit_to_user_mode(void)
>   static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   						  unsigned long ti_work)
>   {
> -	choose_random_kstack_offset(get_tod_clock_fast() & 0xff);
> +	choose_random_kstack_offset(get_tod_clock_fast());
>   }
>   
>   #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
> diff --git a/arch/x86/include/asm/entry-common.h b/arch/x86/include/asm/entry-common.h
> index 7e523bb3d2d3..fb2809b20b0a 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -73,19 +73,16 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>   #endif
>   
>   	/*
> -	 * Ultimately, this value will get limited by KSTACK_OFFSET_MAX(),
> -	 * but not enough for x86 stack utilization comfort. To keep
> -	 * reasonable stack head room, reduce the maximum offset to 8 bits.
> -	 *
> -	 * The actual entropy will be further reduced by the compiler when
> -	 * applying stack alignment constraints (see cc_stack_align4/8 in
> +	 * This value will get limited by KSTACK_OFFSET_MAX(), which is 10
> +	 * bits. The actual entropy will be further reduced by the compiler
> +	 * when applying stack alignment constraints (see cc_stack_align4/8 in
>   	 * arch/x86/Makefile), which will remove the 3 (x86_64) or 2 (ia32)
>   	 * low bits from any entropy chosen here.
>   	 *
> -	 * Therefore, final stack offset entropy will be 5 (x86_64) or
> -	 * 6 (ia32) bits.
> +	 * Therefore, final stack offset entropy will be 7 (x86_64) or
> +	 * 8 (ia32) bits.
>   	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	choose_random_kstack_offset(rdtsc());
>   }
>   #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>   
