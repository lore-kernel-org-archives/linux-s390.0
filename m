Received: from foss.arm.com (foss.arm.com [217.140.110.172])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2016D547071;
	Thu, 17 Sep 2026 18:12:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=217.140.110.172
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789668740; cv=none; b=VVgQ46/uIdvyWbtvOFS8xApO7sQlifJ8tj6LK6Cv/fNETTn7WFrtzYqUSWqHs7kBdV06CYe9EQLnCTift2d5MyZgcKHr82+JRKK3kEuAlzgOyNj7UYc/fkh01yKqrWgY++PweibwiNUMMrGpcBG/9yroJ/epwpFcr9bTWU61P8A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789668740; c=relaxed/simple;
	bh=JRotaeYUDA8OKw6fWgN1iioU01GNC1YxBAHOCuSkCcg=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=A+WiMdyH09KRiQQK8rbppLwHH3B0RkDemfNQq32+JBRJUyTrpCtrOjhay/mMk2mDeHUdSPJIDnls0FE0EQ+s0MXc+8Jk64CaVM5AEPw2JdlcJElsbQLa6J8ii7Kxqo2eB08WhdqOEcOmPAPhesKrvdsyaJx+2a0x2bPdLbDh43E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com; spf=pass smtp.mailfrom=arm.com; dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b=mCMXQQCu; arc=none smtp.client-ip=217.140.110.172
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=arm.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=arm.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=arm.com header.i=@arm.com header.b="mCMXQQCu"
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
	by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A6D8D1596;
	Thu, 17 Sep 2026 11:12:13 -0700 (PDT)
Received: from [10.57.7.135] (unknown [10.57.7.135])
	by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id EB6E23F86F;
	Thu, 17 Sep 2026 11:12:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=arm.com; s=foss;
	t=1789668737; bh=JRotaeYUDA8OKw6fWgN1iioU01GNC1YxBAHOCuSkCcg=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=mCMXQQCuXWXGh8CqhS0W7cwhE2pXGdXIab/vrQATUL3/XaFJNt8Xf3XcEukOlMYCK
	 ugh3zQSksUsKim10k1OD4vF/PrNn0SbUDLvpZ5GQyazWmyouKJGKG5+oDmjP89b8Rg
	 7/ZY9aaQUsSH+CtdxVNQuZgcibuXfkywZeR0hrNM=
Message-ID: <19b00695-9f99-4d21-9592-13fad31f85e7@arm.com>
Date: Thu, 17 Sep 2026 20:12:07 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v3 4/6] mm/vmalloc: make set_area_direct_map HUGE_VMAP
 friendly
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
 <20260903-execmem-set-vm-perms-v0-2-v3-4-949b64a9f755@kernel.org>
From: Kevin Brodsky <kevin.brodsky@arm.com>
Content-Language: en-GB
In-Reply-To: <20260903-execmem-set-vm-perms-v0-2-v3-4-949b64a9f755@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 03/09/2026 11:28, Mike Rapoport (Microsoft) wrote:
> set_area_direct_map() always updates direct map alias permissions in
> single page increments.
>
> For HUGE_VMAP areas it's suboptimal. Not only the loop in
> set_area_direct_map() needlessly has more iterations (e.g times 512 on
> x86), but it also causes fragmentation of the direct map that could be
> avoided for the HUGE_VMAP areas populated with large pages.
>
> All pages in an area are always of the same order: either same-order
> large pages when VM_ALLOW_HUGE_VMAP is set and all huge pages were
> successfully allocated, or order-0 page when VM_ALLOW_HUGE_VMAP is
> cleared or when huge pages allocation fails and fallback path is taken.
>
> Instead of updating the direct map permissions for every order-0 page in
> an area, use the area's page_order as the loop increment and update the
> large pages in one call to set_direct_map_{invalid,default}_noflush().
>
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Reviewed-by: Kevin Brodsky <kevin.brodsky@arm.com>

> ---
>  mm/vmalloc.c | 13 ++++++++-----
>  1 file changed, 8 insertions(+), 5 deletions(-)
>
> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
> index 5506b180f5c27..6ed6c160abed7 100644
> --- a/mm/vmalloc.c
> +++ b/mm/vmalloc.c
> @@ -3367,12 +3367,15 @@ static inline void set_area_direct_map(const struct vm_struct *area,
>  				       int (*set_direct_map)(struct page *page,
>  							     unsigned int nr))
>  {
> -	unsigned long i;
> +	unsigned int nr = (1U << vm_area_page_order(area));
> +
> +	for (unsigned long i = 0; i < area->nr_pages; i += nr) {
> +		if (page_address(area->pages[i])) {
> +			int err = set_direct_map(area->pages[i], nr);
>  
> -	/* HUGE_VMALLOC passes small pages to set_direct_map */
> -	for (i = 0; i < area->nr_pages; i++)
> -		if (page_address(area->pages[i]))
> -			set_direct_map(area->pages[i], 1);
> +			WARN_ON_ONCE(err);
> +		}
> +	}
>  }
>  
>  /*
>
