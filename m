Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 250E4341057;
	Wed, 12 Aug 2026 11:28:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786534113; cv=none; b=JKnUhd/95YLf8AvRpfsSazP2wll464j6lL0U+8Lep9yhsIanh6PqRebIWLJJ6kGLHmxLkd5VirLx3KOgv1YVt/Qw6rZPMGC4tVg/kFt37dWzWb6tA5LYaB0JhNq3HpJC5zWLK1xW35FVmAXswS5oj1L8vmnWWThTyndAUVqpiQQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786534113; c=relaxed/simple;
	bh=rCD/g927eY7TdUOKNub1rEc+CxwjFfilYGPKehry8A0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=VoYUdlRSr7pVi7ZQoTrC5fNWL2gC+dLj0o8bd6RrgGUMppxcvJP2lGx7HgHVIY4o7q2MdPUei3pIoNF6lO0LngT9ftiXhKElJ4RaFgauDZzxc0QGqRddIM9MMCvH6/lZpetxL9y7ok0iz+kREDtf3xZAe8laPFXq7chm94834LM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=R770ZzSz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="R770ZzSz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 022BA1F000E9;
	Wed, 12 Aug 2026 11:28:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786534111;
	bh=EG+9d2areJevimTNoL+CVRXPlsVq0h4r/7sK+coGE+g=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=R770ZzSzgdG86/NXMage81wzUFeS0CV8TJN+FTy3GqkZs91oKKb+UMP3HprpsS0ll
	 0Wg7pTbwr86EN5F6uluXTEl+Pj1fSitU/XvpIx9ciPNyYlETh2LqI/+D2gDsppo6OD
	 yB0zB3DtxgJOAm/4vvR0MKlV6fDYEwT1SPtfC+hetiB9t/IGN6ZuTReZewi6NTenyE
	 vAMBpBqNVWCwPI0e2bxOG/EloArZkrD68ZAi1ERAwEkV3Qg0+K0lrcjS0HdYC6p9yB
	 G+Ls0Si3VJrq7ZaFnE4H1CBwSfg75sQl53X9g+96xUtYtDwT8TDmYw2qMhkU3o2aBj
	 CXwwy98HEtYrQ==
Message-ID: <28c24991-590f-4980-a92e-26c89288cae7@kernel.org>
Date: Wed, 12 Aug 2026 13:28:23 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V2 3/6] sh/mm: Stop using pte_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>, linux-mm@kvack.org,
 akpm@linux-foundation.org
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org
References: <20260811042119.3652929-1-anshuman.khandual@arm.com>
 <20260811042119.3652929-4-anshuman.khandual@arm.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 xsFNBFXLn5EBEAC+zYvAFJxCBY9Tr1xZgcESmxVNI/0ffzE/ZQOiHJl6mGkmA1R7/uUpiCjJ
 dBrn+lhhOYjjNefFQou6478faXE6o2AhmebqT4KiQoUQFV4R7y1KMEKoSyy8hQaK1umALTdL
 QZLQMzNE74ap+GDK0wnacPQFpcG1AE9RMq3aeErY5tujekBS32jfC/7AnH7I0v1v1TbbK3Gp
 XNeiN4QroO+5qaSr0ID2sz5jtBLRb15RMre27E1ImpaIv2Jw8NJgW0k/D1RyKCwaTsgRdwuK
 Kx/Y91XuSBdz0uOyU/S8kM1+ag0wvsGlpBVxRR/xw/E8M7TEwuCZQArqqTCmkG6HGcXFT0V9
 PXFNNgV5jXMQRwU0O/ztJIQqsE5LsUomE//bLwzj9IVsaQpKDqW6TAPjcdBDPLHvriq7kGjt
 WhVhdl0qEYB8lkBEU7V2Yb+SYhmhpDrti9Fq1EsmhiHSkxJcGREoMK/63r9WLZYI3+4W2rAc
 UucZa4OT27U5ZISjNg3Ev0rxU5UH2/pT4wJCfxwocmqaRr6UYmrtZmND89X0KigoFD/XSeVv
 jwBRNjPAubK9/k5NoRrYqztM9W6sJqrH8+UWZ1Idd/DdmogJh0gNC0+N42Za9yBRURfIdKSb
 B3JfpUqcWwE7vUaYrHG1nw54pLUoPG6sAA7Mehl3nd4pZUALHwARAQABzS5EYXZpZCBIaWxk
 ZW5icmFuZCAoQ3VycmVudCkgPGRhdmlkQGtlcm5lbC5vcmc+wsGQBBMBCAA6AhsDBQkmWAik
 AgsJBBUKCQgCFgICHgUCF4AWIQQb2cqtc1xMOkYN/MpN3hD3AP+DWgUCaYJt/AIZAQAKCRBN
 3hD3AP+DWriiD/9BLGEKG+N8L2AXhikJg6YmXom9ytRwPqDgpHpVg2xdhopoWdMRXjzOrIKD
 g4LSnFaKneQD0hZhoArEeamG5tyo32xoRsPwkbpIzL0OKSZ8G6mVbFGpjmyDLQCAxteXCLXz
 ZI0VbsuJKelYnKcXWOIndOrNRvE5eoOfTt2XfBnAapxMYY2IsV+qaUXlO63GgfIOg8RBaj7x
 3NxkI3rV0SHhI4GU9K6jCvGghxeS1QX6L/XI9mfAYaIwGy5B68kF26piAVYv/QZDEVIpo3t7
 /fjSpxKT8plJH6rhhR0epy8dWRHk3qT5tk2P85twasdloWtkMZ7FsCJRKWscm1BLpsDn6EQ4
 jeMHECiY9kGKKi8dQpv3FRyo2QApZ49NNDbwcR0ZndK0XFo15iH708H5Qja/8TuXCwnPWAcJ
 DQoNIDFyaxe26Rx3ZwUkRALa3iPcVjE0//TrQ4KnFf+lMBSrS33xDDBfevW9+Dk6IISmDH1R
 HFq2jpkN+FX/PE8eVhV68B2DsAPZ5rUwyCKUXPTJ/irrCCmAAb5Jpv11S7hUSpqtM/6oVESC
 3z/7CzrVtRODzLtNgV4r5EI+wAv/3PgJLlMwgJM90Fb3CB2IgbxhjvmB1WNdvXACVydx55V7
 LPPKodSTF29rlnQAf9HLgCphuuSrrPn5VQDaYZl4N/7zc2wcWM7BTQRVy5+RARAA59fefSDR
 9nMGCb9LbMX+TFAoIQo/wgP5XPyzLYakO+94GrgfZjfhdaxPXMsl2+o8jhp/hlIzG56taNdt
 VZtPp3ih1AgbR8rHgXw1xwOpuAd5lE1qNd54ndHuADO9a9A0vPimIes78Hi1/yy+ZEEvRkHk
 /kDa6F3AtTc1m4rbbOk2fiKzzsE9YXweFjQvl9p+AMw6qd/iC4lUk9g0+FQXNdRs+o4o6Qvy
 iOQJfGQ4UcBuOy1IrkJrd8qq5jet1fcM2j4QvsW8CLDWZS1L7kZ5gT5EycMKxUWb8LuRjxzZ
 3QY1aQH2kkzn6acigU3HLtgFyV1gBNV44ehjgvJpRY2cC8VhanTx0dZ9mj1YKIky5N+C0f21
 zvntBqcxV0+3p8MrxRRcgEtDZNav+xAoT3G0W4SahAaUTWXpsZoOecwtxi74CyneQNPTDjNg
 azHmvpdBVEfj7k3p4dmJp5i0U66Onmf6mMFpArvBRSMOKU9DlAzMi4IvhiNWjKVaIE2Se9BY
 FdKVAJaZq85P2y20ZBd08ILnKcj7XKZkLU5FkoA0udEBvQ0f9QLNyyy3DZMCQWcwRuj1m73D
 sq8DEFBdZ5eEkj1dCyx+t/ga6x2rHyc8Sl86oK1tvAkwBNsfKou3v+jP/l14a7DGBvrmlYjO
 59o3t6inu6H7pt7OL6u6BQj7DoMAEQEAAcLBfAQYAQgAJgIbDBYhBBvZyq1zXEw6Rg38yk3e
 EPcA/4NaBQJonNqrBQkmWAihAAoJEE3eEPcA/4NaKtMQALAJ8PzprBEXbXcEXwDKQu+P/vts
 IfUb1UNMfMV76BicGa5NCZnJNQASDP/+bFg6O3gx5NbhHHPeaWz/VxlOmYHokHodOvtL0WCC
 8A5PEP8tOk6029Z+J+xUcMrJClNVFpzVvOpb1lCbhjwAV465Hy+NUSbbUiRxdzNQtLtgZzOV
 Zw7jxUCs4UUZLQTCuBpFgb15bBxYZ/BL9MbzxPxvfUQIPbnzQMcqtpUs21CMK2PdfCh5c4gS
 sDci6D5/ZIBw94UQWmGpM/O1ilGXde2ZzzGYl64glmccD8e87OnEgKnH3FbnJnT4iJchtSvx
 yJNi1+t0+qDti4m88+/9IuPqCKb6Stl+s2dnLtJNrjXBGJtsQG/sRpqsJz5x1/2nPJSRMsx9
 5YfqbdrJSOFXDzZ8/r82HgQEtUvlSXNaXCa95ez0UkOG7+bDm2b3s0XahBQeLVCH0mw3RAQg
 r7xDAYKIrAwfHHmMTnBQDPJwVqxJjVNr7yBic4yfzVWGCGNE4DnOW0vcIeoyhy9vnIa3w1uZ
 3iyY2Nsd7JxfKu1PRhCGwXzRw5TlfEsoRI7V9A8isUCoqE2Dzh3FvYHVeX4Us+bRL/oqareJ
 CIFqgYMyvHj7Q06kTKmauOe4Nf0l0qEkIuIzfoLJ3qr5UyXc2hLtWyT9Ir+lYlX9efqh7mOY
 qIws/H2t
In-Reply-To: <20260811042119.3652929-4-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/11/26 06:21, Anshuman Khandual wrote:
> Directly use pr_err() in set_pte_phys() and drop pte_ERROR() which helps in
> eventually dropping pte_ERROR() macro across the tree. In this new printing
> __FILE__ and __LINE__ has been dropped because they are always the same and
> don't really add any value.
> 
> Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
> Cc: Rich Felker <dalias@libc.org>
> Cc: John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
> Cc: linux-sh@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
>  arch/sh/include/asm/pgtable_32.h |  5 -----
>  arch/sh/mm/init.c                | 11 ++++++++++-
>  2 files changed, 10 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/sh/include/asm/pgtable_32.h b/arch/sh/include/asm/pgtable_32.h
> index 5f51af18997b..c8eb9a7a4c4c 100644
> --- a/arch/sh/include/asm/pgtable_32.h
> +++ b/arch/sh/include/asm/pgtable_32.h
> @@ -401,14 +401,9 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  #define pmd_page(pmd)		(virt_to_page(pmd_val(pmd)))
>  
>  #ifdef CONFIG_X2TLB
> -#define pte_ERROR(e) \
> -	printk("%s:%d: bad pte %p(%08lx%08lx).\n", __FILE__, __LINE__, \
> -	       &(e), (e).pte_high, (e).pte_low)
>  #define pgd_ERROR(e) \
>  	printk("%s:%d: bad pgd %016llx.\n", __FILE__, __LINE__, pgd_val(e))
>  #else
> -#define pte_ERROR(e) \
> -	printk("%s:%d: bad pte %08lx.\n", __FILE__, __LINE__, pte_val(e))
>  #define pgd_ERROR(e) \
>  	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
>  #endif
> diff --git a/arch/sh/mm/init.c b/arch/sh/mm/init.c
> index 110308bdef01..b3c7fd84ceb4 100644
> --- a/arch/sh/mm/init.c
> +++ b/arch/sh/mm/init.c
> @@ -78,13 +78,22 @@ static pte_t *__get_pte_phys(unsigned long addr)
>  	return pte_offset_kernel(pmd, addr);
>  }
>  
> +static void print_bad_pte(pte_t pte)
> +{
> +#ifdef CONFIG_X2TLB
> +	printk("bad pte %p(%08lx%08lx).\n", &pte, pte.pte_high, pte.pte_low);
> +#else
> +	printk("bad pte %08lx.\n", pte_val(pte));
> +#endif

I'd avoid that helper if possible, so we don't encourage new users.

Shouldn't we just switch to pr_err() right away?

> +}
> +
>  static void set_pte_phys(unsigned long addr, unsigned long phys, pgprot_t prot)
>  {
>  	pte_t *pte;
>  
>  	pte = __get_pte_phys(addr);
>  	if (!pte_none(*pte)) {
> -		pte_ERROR(*pte);
> +		print_bad_pte(*pte);

Maybe similar to my reply to patch #1, actually print something more useful than
just "bad pte" ? And possibly also just use ptval_to_str().

-- 
Cheers,

David
