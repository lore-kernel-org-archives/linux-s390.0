Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C352D4FDA76;
	Thu, 17 Sep 2026 18:11:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668699; cv=none; b=KjtWrV9mBr4xHbafHx9D27PnGo4GSxIcRNwbjdlNxvr6Dy1zXab8D0SqJSLw5+j6B3HKVq+KcNuBj+4nH5RLQlZUbLgRg4UB0QALSqLavZkzAY2V7vBz8Oiy/cR2oVrrdaFIVx+hCmtFZxfGVh8b6O2hi6j/opfpsLx6DAkWnN4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668699; c=relaxed/simple;
	bh=TMD2k65kuIFXRf0q/E0tlyDyciozaJKv/LfOROsWlhU=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=oUvexjaZ9OJ/uzqW7BEMJJT5C3GjdtQaHiShw4MYFVPARLZcYV4NI0HxvkkzVG853cQt/zG9TMYIVLujz2NjW7Hq+/bFoi8yGWMfliBzCQwpCz3qUtzVb9ctQ6X4X0Us0sUMYMkE79VKC1Ac2/vcOYiZqM7Xkur3WuPa1cbdI/k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=oz67M4YS; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="oz67M4YS"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4D27B1476;
	Thu, 17 Sep 2026 11:11:32 -0700 (PDT)
Received: from [10.57.7.135] (unknown [10.57.7.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 07D443F86F;
	Thu, 17 Sep 2026 11:11:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789668695; bh=TMD2k65kuIFXRf0q/E0tlyDyciozaJKv/LfOROsWlhU=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=oz67M4YS9vKX95bPOvJjG/6IahhL31r2yGk7O81dt+sjjN414ZuuZ1xCMa2au/gHH
	 rXUcqtwGrQvFQ85FYRDPTsgIv5sPS9YSZzFPZz/TWW1k7YQuQdJ0UPTrn4SrhDiV3s
	 CGukra9E2ILOT0R0PDF2smG+O2IyEGDjkvUSbT20=
Message-ID: <d299f7c5-6c71-499a-b8cd-aa69c4c81dd1@arm.com>
Date: Thu, 17 Sep 2026 20:11:22 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 1/6] set_memory: add number of pages parameter to
 set_direct_map APIs
To: "Mike Rapoport (Microsoft)" <rppt@kernel.org>,
 Andrew Morton <akpm@linux-foundation.org>
Cc: =?UTF-8?Q?Adrian_Barna=C5=9B?= <abarnas@google.com>,
 Albert Ou <aou@eecs.berkeley.edu>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Alexandre Ghiti <alex@ghiti.fr>,
 Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
 Brendan Jackman <brendan.jackman@linux.dev>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Christian Borntraeger <borntraeger@linux.ibm.com>,
 Dave Hansen <dave.hansen@linux.intel.com>,
 David Hildenbrand <david@kernel.org>,
 Gerald Schaefer <gerald.schaefer@linux.ibm.com>,
 Heiko Carstens <hca@linux.ibm.com>, Huacai Chen <chenhuacai@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Len Brown <lenb@kernel.org>,
 Palmer Dabbelt <palmer@dabbelt.com>, Paul Walmsley <pjw@kernel.org>,
 Pavel Machek <pavel@kernel.org>, Peter Zijlstra <peterz@infradead.org>,
 "H. Peter Anvin" <hpa@zytor.com>, "Rafael J. Wysocki" <rafael@kernel.org>,
 Ryan Roberts <ryan.roberts@arm.com>, Sven Schnelle <svens@linux.ibm.com>,
 Thomas Gleixner <tglx@kernel.org>, Uladzislau Rezki <urezki@gmail.com>,
 Vasily Gorbik <gor@linux.ibm.com>, WANG Xuerui <kernel@xen0n.name>,
 Will Deacon <will@kernel.org>, x86@kernel.org,
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 linux-mm@kvack.org, linux-pm@vger.kernel.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 loongarch@lists.linux.dev
References: <20260903-execmem-set-vm-perms-v0-2-v3-0-949b64a9f755@kernel.org>
 <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-1-949b64a9f755@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 11:28, Mike Rapoport (Microsoft) wrote:
> When set_direct_map APIs were introduced by the commit d253ca0c3865
> ("x86/mm/cpa: Add set_direct_map_*() functions") the single page
> parameter made sense because the initial callers (vmalloc and
> hibernation) had sets of unsorted struct pages that required changes of
> their mappings in the direct map.
>
> Since there is an increasing demand for direct map manipulation and it
> is also desirable to be able to update larger physically contiguous
> mappings, for example an entire large folio, extend set_direct_map APIs
> to receive number of pages parameter.
>
> As there is still only a handful of callers, change the existing
> functions directly and update all the call sites rather than adding
> wrappers for single page case.
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>
> ---
>  arch/arm64/include/asm/set_memory.h     | 4 ++--
>  arch/arm64/mm/pageattr.c                | 8 ++++----
>  arch/loongarch/include/asm/set_memory.h | 4 ++--
>  arch/loongarch/mm/pageattr.c            | 8 ++++----
>  arch/riscv/include/asm/set_memory.h     | 4 ++--
>  arch/riscv/mm/pageattr.c                | 8 ++++----
>  arch/s390/include/asm/set_memory.h      | 4 ++--
>  arch/s390/mm/pageattr.c                 | 8 ++++----
>  arch/x86/include/asm/set_memory.h       | 4 ++--
>  arch/x86/mm/pat/set_memory.c            | 8 ++++----
>  include/linux/set_memory.h              | 6 ++++--
>  kernel/power/snapshot.c                 | 4 ++--
>  mm/secretmem.c                          | 6 +++---
>  mm/vmalloc.c                            | 5 +++--
>  14 files changed, 42 insertions(+), 39 deletions(-)
>
> diff --git a/arch/arm64/include/asm/set_memory.h b/arch/arm64/include/asm/set_memory.h
> index 90f61b17275e1..b07fd4e026eac 100644
> --- a/arch/arm64/include/asm/set_memory.h
> +++ b/arch/arm64/include/asm/set_memory.h
> @@ -11,8 +11,8 @@ bool can_set_direct_map(void);
>  
>  int set_memory_valid(unsigned long addr, int numpages, int enable);
>  
> -int set_direct_map_invalid_noflush(struct page *page);
> -int set_direct_map_default_noflush(struct page *page);
> +int set_direct_map_invalid_noflush(struct page *page, unsigned int numpages);
> +int set_direct_map_default_noflush(struct page *page, unsigned int numpages);

I don't have a strong opinion on whether to call the argument nr or
numpages, but we might as well be consistent across archs :)

Aside from that:

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>
