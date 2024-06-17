Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 306811C68C;
	Mon, 17 Jun 2024 15:52:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718639562; cv=none; b=RuaCauuaFRRhKxcM3RjQKjOmYowDgB8M+b4RKCDR5kG1BsJs47q317eCSKEDt9iM+gZhT97AevD4WZwV6rCjg7rAHC4CnOvbW15n/L1R6YVKvzQ2bByVEFsQtXjGX3cdET7eYTqYeIjj4waV4aYhsL1aPD51xFW27mnlSk7miis=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718639562; c=relaxed/simple;
	bh=6q1k+tASKAJjoZxu/hiIOiLEZYJBiePlxyUNs5o4lks=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=DfPWKL4n8M5xst5V8++Op8gsqMRZZ1WwlZUzx6DpqB/ecXvQ2flQuNd28LdhYKQNl1mxDckItpIT878YUNgM+1oQW4TemFNkiSSN0oQVLUlCgSbh1TKMoeN7L35JbheN/H51TZOoCc2kXPEOXcHA6BXvpbHmC6mFkGF2nqpV4Bk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0CDA7DA7;
	Mon, 17 Jun 2024 08:53:03 -0700 (PDT)
Received: from J2N7QTR9R3 (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 6C1F13F64C;
	Mon, 17 Jun 2024 08:52:34 -0700 (PDT)
Date: Mon, 17 Jun 2024 16:52:15 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yuntao Liu <liuyuntao12@huawei.com>
Cc: x86@kernel.org, linux-arm-kernel@lists.infradead.org,
	linux-kernel@vger.kernel.org, linux-s390@vger.kernel.org,
	linux-hardening@vger.kernel.org, catalin.marinas@arm.com,
	will@kernel.org, hca@linux.ibm.com, gor@linux.ibm.com,
	agordeev@linux.ibm.com, borntraeger@linux.ibm.com,
	svens@linux.ibm.com, tglx@linutronix.de, mingo@redhat.com,
	bp@alien8.de, dave.hansen@linux.intel.com, hpa@zytor.com,
	kees@kernel.org, gustavoars@kernel.org, arnd@arndb.de,
	leobras@redhat.com, broonie@kernel.org, imbrenda@linux.ibm.com,
	pawan.kumar.gupta@linux.intel.com
Subject: Re: [PATCH] remove AND operation in choose_random_kstack_offset()
Message-ID: <ZnBbr2CAqBGDe2aN@J2N7QTR9R3>
References: <20240617133721.377540-1-liuyuntao12@huawei.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20240617133721.377540-1-liuyuntao12@huawei.com>

On Mon, Jun 17, 2024 at 01:37:21PM +0000, Yuntao Liu wrote:
> Since the offset would be bitwise ANDed with 0x3FF in
> add_random_kstack_offset(), so just remove AND operation here.
> 
> Signed-off-by: Yuntao Liu <liuyuntao12@huawei.com>

The comments in arm64 and x86 say that they're deliberately capping the
offset at fewer bits than the result of KSTACK_OFFSET_MAX() masking the
value with 0x3FF.

Maybe it's ok to expand that, but if that's the case the commit message
needs to explain why it's safe add extra bits (2 on arm64, 3 on s39 and
x86), and those comments need to be updated accordingly.

As-is, I do not think this patch is ok.

Mark.

> ---
>  arch/arm64/kernel/syscall.c          | 2 +-
>  arch/s390/include/asm/entry-common.h | 2 +-
>  arch/x86/include/asm/entry-common.h  | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/kernel/syscall.c b/arch/arm64/kernel/syscall.c
> index ad198262b981..43f555f7cd2d 100644
> --- a/arch/arm64/kernel/syscall.c
> +++ b/arch/arm64/kernel/syscall.c
> @@ -63,7 +63,7 @@ static void invoke_syscall(struct pt_regs *regs, unsigned int scno,
>  	 *
>  	 * The resulting 5 bits of entropy is seen in SP[8:4].
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
> index 7e523bb3d2d3..b28a307f2014 100644
> --- a/arch/x86/include/asm/entry-common.h
> +++ b/arch/x86/include/asm/entry-common.h
> @@ -85,7 +85,7 @@ static inline void arch_exit_to_user_mode_prepare(struct pt_regs *regs,
>  	 * Therefore, final stack offset entropy will be 5 (x86_64) or
>  	 * 6 (ia32) bits.
>  	 */
> -	choose_random_kstack_offset(rdtsc() & 0xFF);
> +	choose_random_kstack_offset(rdtsc());
>  }
>  #define arch_exit_to_user_mode_prepare arch_exit_to_user_mode_prepare
>  
> -- 
> 2.34.1
> 
