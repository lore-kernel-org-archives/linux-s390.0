Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 17B9F222570;
	Mon, 17 Mar 2025 09:28:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742203736; cv=none; b=u/oqC6rR1ZcABQwIgogEh3f/7zpHUCrDEM11qKBod/1ptI+EwZ7IrkXpLfD1ECjUvVClU3r/OTMuEIL4tAzXszvOd/bng7a/T2rldoqr/vAqtEHihQsHmBHe/zU4ljRKSLXGpyb7LyZCk3K9xOYdX03asZPfx4z9wX2e3tk/t6Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742203736; c=relaxed/simple;
	bh=12f2cJnOY4QhppoXQT5hEoVPJ3WVgbGxJKf5/TUNUOc=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=QjHwYye26+z30SzXoF5ygf1c0AmTiYRphYB/8dWySyeoH4Pbe5DCALajsnkFegeVsVGug/FWdfHllWqgApR3Fzeyo/tntITaq9FWbB9kdh01ng7Y/VFm+a4V/bjDfUVgohuR+kI6dI7lFRp47f5pVYM/yEDd5zbIMIeRy4azbi0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 1E81913D5;
	Mon, 17 Mar 2025 02:29:02 -0700 (PDT)
Received: from [10.57.84.137] (unknown [10.57.84.137])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F070E3F694;
	Mon, 17 Mar 2025 02:28:49 -0700 (PDT)
Message-ID: <16c12c3f-f2c2-45fa-9db6-4dfaeb002059@arm.com>
Date: Mon, 17 Mar 2025 09:28:48 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH 2/2] arm64/ptdump: Replace u64 with pteval_t
Content-Language: en-GB
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org
Cc: Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Steven Price <steven.price@arm.com>,
 Madhavan Srinivasan <maddy@linux.ibm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley
 <paul.walmsley@sifive.com>, Palmer Dabbelt <palmer@dabbelt.com>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Peter Zijlstra <peterz@infradead.org>,
 Thomas Gleixner <tglx@linutronix.de>, Ingo Molnar <mingo@redhat.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, Marc Zyngier <maz@kernel.org>
References: <20250317061818.16244-1-anshuman.khandual@arm.com>
 <20250317061818.16244-3-anshuman.khandual@arm.com>
From: Ryan Roberts <ryan.roberts@arm.com>
In-Reply-To: <20250317061818.16244-3-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 17/03/2025 06:18, Anshuman Khandual wrote:
> Page table entry's value, mask and protection are represented with pteval_t
> data type format not u64 that has been assumed while dumping the page table
> entries. Replace all such u64 instances with pteval_t instead as required.
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/arm64/include/asm/ptdump.h | 8 ++++----
>  arch/arm64/mm/ptdump.c          | 2 +-
>  2 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/ptdump.h b/arch/arm64/include/asm/ptdump.h
> index e5da9ce8a515..476a870489b9 100644
> --- a/arch/arm64/include/asm/ptdump.h
> +++ b/arch/arm64/include/asm/ptdump.h
> @@ -24,8 +24,8 @@ struct ptdump_info {
>  };
>  
>  struct ptdump_prot_bits {
> -	u64		mask;
> -	u64		val;
> +	pteval_t	mask;
> +	pteval_t	val;

Given Ard's suggestion of using "ptdesc" as a generic term for PTDESC_SHIFT (or
PTDESC_ORDER, or whatever we ended up calling it), I wonder if it would be
cleaner to do the same with the types? We could have a ptdesc_t, which is
typedef'ed as u64 (or u128), then pteval_t, pmdval_t, ..., could all be
typedef'ed as ptdesc_t. Then for code that just wants a generic pgtable
descriptor value, we can use that type to indicate that it can be at any level.

Thanks,
Ryan

>  	const char	*set;
>  	const char	*clear;
>  };
> @@ -34,7 +34,7 @@ struct ptdump_pg_level {
>  	const struct ptdump_prot_bits *bits;
>  	char name[4];
>  	int num;
> -	u64 mask;
> +	pteval_t mask;
>  };
>  
>  /*
> @@ -51,7 +51,7 @@ struct ptdump_pg_state {
>  	const struct mm_struct *mm;
>  	unsigned long start_address;
>  	int level;
> -	u64 current_prot;
> +	pteval_t current_prot;
>  	bool check_wx;
>  	unsigned long wx_pages;
>  	unsigned long uxn_pages;
> diff --git a/arch/arm64/mm/ptdump.c b/arch/arm64/mm/ptdump.c
> index fd1610b4fd15..a5651be95868 100644
> --- a/arch/arm64/mm/ptdump.c
> +++ b/arch/arm64/mm/ptdump.c
> @@ -194,7 +194,7 @@ void note_page(struct ptdump_state *pt_st, unsigned long addr, int level,
>  	struct ptdump_pg_state *st = container_of(pt_st, struct ptdump_pg_state, ptdump);
>  	struct ptdump_pg_level *pg_level = st->pg_level;
>  	static const char units[] = "KMGTPE";
> -	u64 prot = 0;
> +	pteval_t prot = 0;
>  
>  	/* check if the current level has been folded dynamically */
>  	if (st->mm && ((level == 1 && mm_p4d_folded(st->mm)) ||

