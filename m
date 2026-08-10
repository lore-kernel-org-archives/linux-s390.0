Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41F99360745;
	Mon, 10 Aug 2026 19:04:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786388680; cv=none; b=EMwe1VCQdj7OhKyMspPtZ93hkhhBTSv24RZh+20NeRBw3nKG0yrq+DrrHWqkQdKMfN1qRXr3/2eNCyVlQKj7SonS1RTP63F/I6yrb1PoKgcDb6/4LC9L/VsnQgRfKbVTVQNF6Y+oz73gTj6D6hRKyFAGWd8W2JqU+F4eud52KLg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786388680; c=relaxed/simple;
	bh=k+kkVUn5IwVjUDegOkkA0Y2hsLUnkK7QGZmZ9gpm2xI=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=UGnijEyuuzB9b/QEBRtwbzSYBIQk5bd/SVrefENDPvl8i8F6v4yjQL/amkLs9/Hda6mvIzSc8gvVWFbf/FlPXxxcrZ1w2+q8AbAre5PhVao1Lvt/0OM8XT08k8SQWjMwcIGTdMCQFsRdqBf4Nqj5fFiAjZkSZKL0P4TnbOTp7r8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ThqtMLTh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ThqtMLTh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2D40D1F000E9;
	Mon, 10 Aug 2026 19:04:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786388677;
	bh=wCWAj/IB9/Y4w78qXxms7OwhGGfziyuHvO5KgFUv6B8=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To;
	b=ThqtMLThm+JlEs0PWr88/r5aPvTGagXV2EKv/oViLQAObOt0udqTMeol0dQhLMROo
	 GE83nTTxQt0GVcmHG5HC74dRHD4A5TiCYFZmZNv17w3adt7NyIawV0XM+5MGAcGTnb
	 mnRE7CnuNoNAHvLnGU5Csrytb+LBKXVb05iAHSP3c/O+X9k7uTElfgKFTJJRD40X3n
	 OvIL1WOKHEh3XArTCbuWhgK5ee4sKuBXqTQewUFv0XKtXk57ADjX1sVDcqE7AgX7Yo
	 9uE2mXlgG6OMBp+Arc29zsNHLf1ie3dl9Zn+NFh2jXXLvUNq8HxKaNCMOLYgr4ET5/
	 Jvt+utrbeR0iw==
Message-ID: <4b90323b-27a6-42c9-a11f-b57a5c097b62@kernel.org>
Date: Mon, 10 Aug 2026 21:04:29 +0200
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v2 1/6] mm: export vmf_insert_pfn_prot_mkwrite(), change
 variants to inline
To: Paolo Bonzini <pbonzini@redhat.com>, linux-kernel@vger.kernel.org,
 kvm@vger.kernel.org
Cc: Alex Williamson <alex@shazbot.org>,
 bcm-kernel-feedback-list@broadcom.com,
 Boris Brezillon <boris.brezillon@collabora.com>,
 Christian Koenig <christian.koenig@amd.com>,
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>,
 Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org,
 linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>,
 Peter Xu <peterx@redhat.com>, Sergio Lopez <slp@redhat.com>,
 Sean Christopherson <seanjc@google.com>,
 Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-2-pbonzini@redhat.com>
From: "David Hildenbrand (Arm)" <david@kernel.org>
Content-Language: en-US
Autocrypt: addr=david@kernel.org; keydata=
 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
 qIws/H2t
In-Reply-To: <20260804120529.1730187-2-pbonzini@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 8/4/26 14:05, Paolo Bonzini wrote:
> Right now, users of .pfn_mkwrite() have no way to create a PTE
> that has gone through maybe_mkwrite().  Because vma_set_page_prot()
> will have cleared the writable PTE bit, users of fixup_user_fault()
> will see a read-only PTE and have no clue that the page needs
> a *second* fault to reach its final status.
> 
> Handling this in fixup_user_fault() is problematic: the information
> about the presence of *_mkwrite is only recorded in vma->vm_page_prot,
> which is an opaque pgprot_t, therefore only follow_pfnmap_start()
> knows how to retrieve it.
> 
> There are actually some preexisting functions that suggest how this
> is supposed to be handled, namely vmf_insert_page_mkwrite() and
> vmf_insert_pfn_pmd().  Fixing the drivers requires similar variants
> of vm_insert_pfn(), namely vmf_insert_pfn_mkwrite() for the common
> case where vma->vm_page_prot is okay, and vmf_insert_pfn_prot_mkwrite()
> when really all parameters are needed.  This makes it possible
> to fix drivers that use .pfn_mkwrite together with
> vmf_insert_pfn() and vmf_insert_pfn_prot().
> 
> Since vmf_insert_pfn_prot_mkwrite() is the most general variant
> and all the others are just special cases, turn them into inline
> functions in the header.
> 
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  include/linux/mm.h | 81 +++++++++++++++++++++++++++++++++++++++++---
>  mm/huge_memory.c   |  2 +-
>  mm/memory.c        | 84 ++++++++++++++++++++--------------------------
>  3 files changed, 114 insertions(+), 53 deletions(-)
> 
> diff --git a/include/linux/mm.h b/include/linux/mm.h
> index 485df9c2dbdd..01184a4bdd6f 100644
> --- a/include/linux/mm.h
> +++ b/include/linux/mm.h
> @@ -4544,16 +4544,89 @@ int vm_map_pages_zero(struct vm_area_struct *vma, struct page **pages,
>  				unsigned long num);
>  vm_fault_t vmf_insert_page_mkwrite(struct vm_fault *vmf, struct page *page,
>  			bool write);
> -vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma, unsigned long addr,
> -			unsigned long pfn);
> -vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma, unsigned long addr,
> -			unsigned long pfn, pgprot_t pgprot);
> +vm_fault_t vmf_insert_pfn_prot_mkwrite(struct vm_area_struct *vma, unsigned long addr,
> +			unsigned long pfn, pgprot_t pgprot, bool mkwrite);
>  vm_fault_t vmf_insert_mixed(struct vm_area_struct *vma, unsigned long addr,
>  			unsigned long pfn);
>  vm_fault_t vmf_insert_mixed_mkwrite(struct vm_area_struct *vma,
>  		unsigned long addr, unsigned long pfn);
>  int vm_iomap_memory(struct vm_area_struct *vma, phys_addr_t start, unsigned long len);
>  

To not inflate mm.h too much, can we just try removing all details that can also
be had in vmf_insert_pfn_prot_mkwrite() doc, and refer to that?

> +
> +/**
> + * vmf_insert_pfn_prot - insert single pfn into user vma with specified pgprot
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + * @pgprot: pgprot flags for the inserted page
> + *
> + * This is exactly like vmf_insert_pfn(), except that it allows drivers
> + * to override pgprot on a per-page basis.  For more information,
> + * see vmf_insert_pfn_prot_mkwrite().

For example, I would keep this statement here for all 3 variants.

> + *
> + * This only makes sense for IO mappings, and it makes no sense for
> + * COW mappings.  In general, using multiple vmas is preferable;
> + * vmf_insert_pfn_prot should only be used if using multiple VMAs is
> + * impractical.

Can we just move that for vmf_insert_pfn_prot_mkwrite() and document it when
pgprot != vma->vm_page_prot ?

> + *
> + * Context: Process context.  May allocate using %GFP_KERNEL.
> + * Return: vm_fault_t value.
> + */
> +static inline vm_fault_t vmf_insert_pfn_prot(struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long pfn, pgprot_t pgprot)
> +{
> +	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, pgprot, false);
> +}
> +
> +/**
> + * vmf_insert_pfn_mkwrite - insert single pfn into user vma, possibly writable
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + * @write: whether the PTE should be installed writable
> + *
> + * Like vmf_insert_pfn(), except that @write allows installing a writable
> + * PTE even when @vma is under write notification.  For more information,
> + * see vmf_insert_pfn_prot_mkwrite().
> + *
> + * Note that neither .pfn_mkwrite() nor .page_mkwrite() is invoked, so the
> + * caller must itself do whatever they would have done if @write is true.

Similarly move that to vmf_insert_pfn_prot_mkwrite().

> + *
> + * Context: Process context.  May allocate using %GFP_KERNEL.
> + * Return: vm_fault_t value.
> + */
> +static inline vm_fault_t vmf_insert_pfn_mkwrite(struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long pfn, bool write)
> +{
> +	return vmf_insert_pfn_prot_mkwrite(vma, addr, pfn, vma->vm_page_prot, write);
> +}
> +
> +/**
> + * vmf_insert_pfn - insert single pfn into user vma
> + * @vma: user vma to map to
> + * @addr: target user address of this page
> + * @pfn: source kernel pfn
> + *
> + * Similar to vm_insert_page, this allows drivers to insert individual pages
> + * they've allocated into a user vma. Same comments apply.

I know that you are moving this doc, but some things stick out:

Wouldn't it be better to also refer to vmf_insert_pfn() instead, like all the
other variants?

> + *
> + * This function should only be called from a vm_ops->fault handler, and
> + * in that case the handler should return the result of this function.

Isn't this the same for the other ones as well?

> + *
> + * vma cannot be a COW mapping.

Isn't this the same for all of them?

> + *
> + * As this is called only for pages that do not currently exist, we
> + * do not need to flush old virtual caches or the TLB.

Isn't this an implementation detail?

> + *
> + * Context: Process context.  May allocate using %GFP_KERNEL.
> + * Return: vm_fault_t value.
> + */
> +static inline vm_fault_t vmf_insert_pfn(struct vm_area_struct *vma,
> +			unsigned long addr, unsigned long pfn)
> +{
> +	return vmf_insert_pfn_mkwrite(vma, addr, pfn, false);
> +}
> +

Apart from that LGTM.

-- 
Cheers,

David
