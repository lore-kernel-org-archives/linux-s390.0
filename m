Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794602925;
	b=XmfV9HcJoXW5vgAkvsSf5+brA6vnhMpLV19O3EwDgfT0oJaKiUJontGNIBaRQtI34UqH
	 c0hZF/ilr/ZRK5ynKMQBXlBZNJ8k7j5wanUhkwVFxk7tzYKl/b1LifL9hUeSEtTxyUEB1
	 yqbbG7lGq/fB58uCeLbliAJhD/3Ip5hNB/LLMvUFuISXV73XWXZswanfNImPbLBi3YTCo
	 3CxACZtTdVH4lkkdUj5JG931C37HykKJGcnjiKQ3QbvPhWFD5U2krPTip30RFlkLhOiwp
	 nz4oxpka30n94LkSGMDrh/dFLcJN2M6PvMp9Ff5Ruu79Nna4kDKEahuOMVA5Zk2DSMg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794602925;
	h=Received:DKIM-Signature:Date:From:To:Cc:Subject:Message-ID:
	 References:MIME-Version:Content-Type:Content-Disposition:
	 Content-Transfer-Encoding:In-Reply-To;
	bh=HbZ+0LydDJ6rcuj2MEvM/ZyS22hRjkKslj361gDn6Wg=;
	b=QDM9g7Q1vzwBQcBk4l5mCjMrHRAgFzK/SpRNC0TEh5ww7qN62JNkEvMa8imtHk1Mh0Au
	 0Sa5CuM0+7xrvxc/KvdAPeeCYVR05SvH78c/TP1RUe2mAqWoqEZ4yGtNeK+Atr3rAXjXG
	 8Yd6PCoc/2OPPM59r6mJfJ3dWtvtuG1q2mGBeRosruNUTCGnWydBxdnxzy0jpHxfGL9Ph
	 SjkHOclxgb2v0eO4vPrp6IrXorrNQ2FYIaPH/+PF9Tnsv0Rn7FTFs1lwV75fdBoN4G9nL
	 clwhJPv7H6KmP9p6KLcUo2l+ajvs0iPLHBeE5/NdM+XtVF/WehRANHgy1uFIldS4RWg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikPR7pJe;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42C10606A327;
	Fri, 13 Nov 2026 20:48:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ikPR7pJe
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CB9B1F000CF;
	Fri, 13 Nov 2026 20:48:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794602924;
	bh=HbZ+0LydDJ6rcuj2MEvM/ZyS22hRjkKslj361gDn6Wg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ikPR7pJevGBa7Go85rNPXEZVUfBVgf/s0MJkuGJuESAF+idbRbGTE+B84+gCxM8x8
	 vL3li2nBMSJMMM96wmdfIu9JXpkzZji86uJ5QqLuOmaO68XarXA/+S9slrp8X83qZg
	 CFfeMV4/gjVZ21nmSuMOfs8xNVk+hg/FOS/2AqePaBlWCRfe1xE7wVKI9qEu34Z7zQ
	 CZB7C8Jgj43VDP16H7xpvd3SJn4KhnLKJrAXtzvcttnAJLmvfWZSvf7ArDNdbFNDUd
	 BIcWrUDH5dwLvlwlVUmJO9pALbhe70m6DPVhTPU3z4ROHr1eeU6+L8jBP7iit8QWX4
	 k1ZuepTwYyWdw==
Date: Fri, 13 Nov 2026 20:48:34 +0000
From: "Lorenzo Stoakes (ARM)" <ljs@kernel.org>
To: Carlos =?utf-8?B?TMOzcGV6?= <clopez@suse.de>
Cc: kvm@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org, 
	linux-s390@vger.kernel.org, linux-riscv@lists.infradead.org, seanjc@google.com, 
	pbonzini@redhat.com, akpm@linux-foundation.org, david@kernel.org, peterx@redhat.com, 
	imbrenda@linux.ibm.com, borntraeger@linux.ibm.com, frankja@linux.ibm.com, 
	"Liam R. Howlett" <liam@infradead.org>, Vlastimil Babka <vbabka@kernel.org>, 
	Mike Rapoport <rppt@kernel.org>, Suren Baghdasaryan <surenb@google.com>, 
	Michal Hocko <mhocko@suse.com>, Zi Yan <ziy@nvidia.com>, 
	Baolin Wang <baolin.wang@linux.alibaba.com>, Nico Pache <nico.pache@linux.dev>, 
	Ryan Roberts <ryan.roberts@arm.com>, Dev Jain <dev.jain@arm.com>, Barry Song <baohua@kernel.org>, 
	Lance Yang <lance.yang@linux.dev>, Usama Arif <usama.arif@linux.dev>, 
	Kiryl Shutsemau <kas@kernel.org>
Subject: Re: [PATCH v3 3/9] mm/huge_memory: honor MM_CP_TRY_CHANGE_WRITABLE
 in change_huge_pud()
Message-ID: <avd0Cexmmu7kCN45@gremlin>
References: <20261112142039.907090-2-clopez@suse.de>
 <20261112142039.907090-5-clopez@suse.de>
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20261112142039.907090-5-clopez@suse.de>

On Thu, Nov 12, 2026 at 03:20:32PM +0100, Carlos López wrote:
> change_protection() applies vma->vm_page_prot, which lacks the write bit
> for CoW and write-notified mappings. MM_CP_TRY_CHANGE_WRITABLE makes
> entries writable again if a write fault would only set the write bit.
>
> However, change_huge_pud() ignores the flag. For example, device DAX
> mappings are write-notified once soft-dirty tracking is armed through
> /proc/pid/clear_refs, and a protection change then leaves dirty PUDs
> read-only, so the next write to each of them faults.
>
> Fix this by adding can_change_pud_writable(), based on
> can_change_pmd_writable(). It omits the NUMA and uffd-wp checks, as
> change_huge_pud() bails out on those changes.
>
> Signed-off-by: Carlos López <clopez@suse.de>

Is this a real problem that actual people have had?

The why of all this is still eluding me, especially for THP PUD...

> ---
>  include/linux/pgtable.h |  5 +++++
>  mm/huge_memory.c        | 28 +++++++++++++++++++++++++++-
>  2 files changed, 32 insertions(+), 1 deletion(-)
>
> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
> index 780fe849ff8b..943d7e95f426 100644
> --- a/include/linux/pgtable.h
> +++ b/include/linux/pgtable.h
> @@ -1866,6 +1866,11 @@ static inline int pmd_soft_dirty(pmd_t pmd)
>  	return 0;
>  }
>
> +static inline int pud_soft_dirty(pud_t pud)
> +{
> +	return 0;
> +}
> +
>  static inline pte_t pte_mksoft_dirty(pte_t pte)
>  {
>  	return pte;
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index eb913acb03b7..080b718eb7de 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -2833,6 +2833,29 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	return ret;
>  }
>
> +#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
> +static inline bool can_change_pud_writable(struct vm_area_struct *vma,
> +					   unsigned long addr, pud_t pud)
> +{
> +	struct page *page;
> +
> +	if (WARN_ON_ONCE(!(vma->vm_flags & VM_WRITE)))
> +		return false;
> +
> +	/* Do we need write faults for softdirty tracking? */
> +	if (vma_soft_dirty_enabled(vma) && !pud_soft_dirty(pud))
> +		return false;
> +
> +	if (!(vma->vm_flags & VM_SHARED)) {

This is getting annoying now, you're seemingly _knowingly_ writing deprecated
VMA flag API code on purpose.

> +		/* See can_change_pte_writable(). */
> +		page = vm_normal_page_pud(vma, addr, pud);
> +		return page && PageAnon(page) && PageAnonExclusive(page);
> +	}
> +
> +	/* See can_change_pte_writable(). */
> +	return pud_dirty(pud);
> +}
> +
>  /*
>   * Returns:
>   *
> @@ -2840,7 +2863,6 @@ int change_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>   * - 1: if pud can be skipped
>   * - HPAGE_PUD_NR: if pud was successfully processed
>   */
> -#ifdef CONFIG_HAVE_ARCH_TRANSPARENT_HUGEPAGE_PUD
>  int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  		    pud_t *pudp, unsigned long addr, pgprot_t newprot,
>  		    unsigned long cp_flags)
> @@ -2872,6 +2894,10 @@ int change_huge_pud(struct mmu_gather *tlb, struct vm_area_struct *vma,
>  	 */
>  	oldpud = pudp_invalidate(vma, addr, pudp);
>  	entry = pud_modify(oldpud, newprot);
> +	/* See change_pte_range(). */
> +	if ((cp_flags & MM_CP_TRY_CHANGE_WRITABLE) && !pud_write(entry) &&
> +	    can_change_pud_writable(vma, addr, entry))
> +		entry = pud_mkwrite(entry);
>  	set_pud_at(mm, addr, pudp, entry);
>  	tlb_flush_pud_range(tlb, addr, HPAGE_PUD_SIZE);
>
> --
> 2.51.0
>

--
Cheers, Lorenzo
