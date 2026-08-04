Received: from mail-pj1-f70.google.com (mail-pj1-f70.google.com [209.85.216.70])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4A9CE3B5304
	for <linux-s390@vger.kernel.org>; Tue,  4 Aug 2026 21:15:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.70
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785878144; cv=none; b=TDC37S8xvk5rCQQyGgyPPZzTKY+nUMN5ZEKwEm10rYAZv+3sBKrJp3lhAn5HZ3seigRqyCziNURNmQ5grqZgj2O41oQKo/uTMu0wi+XHGo4j5kkoQnHjlKG7KnVPfEVeRJkGJzg3QFPY7YNpCoB4QJo4w0BD7Q99gtHvIgPHQqw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785878144; c=relaxed/simple;
	bh=V24gjxcUr3ORAZpKWAzvSMyLvHPceaEPhTg/9RjdeKU=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=Br9G1CEDv1hCvPLeKoHF3UafSB6EFRvCdeEgV+ncQ2R95V+fd7IvswXmFsOdrRO2JCBLRGtJqQWlqp3UF0xGWDOlATQi0k0sNzgeei6HMSAsLJeoohGBoNa5V4yHNWuvXMEIT/VRTC4wflBPC4h6ZFqrWSY+1NOcI9aLga0UgEc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=qx0u21El; arc=none smtp.client-ip=209.85.216.70
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--seanjc.bounces.google.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="qx0u21El"
Received: by mail-pj1-f70.google.com with SMTP id 98e67ed59e1d1-38e22137fb3so331501a91.0
        for <linux-s390@vger.kernel.org>; Tue, 04 Aug 2026 14:15:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20251104; t=1785878143; x=1786482943; darn=vger.kernel.org;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=rHQOfCFF6yaKH9HqGSLDO98Dtf8szKrkpDeyDbaXUEA=;
        b=qx0u21ElGri4nA2vtySnKHwHC39X73+BhlvETjTiUPqw/eyhsSzTzaIk4UWBWMy/QQ
         0R84MhhLIDWt1n8qBRvFWLvn/3e9JEPGZzxOdEgSQI6Jo9m8QBqKVXtql8vtQpvIaf4Y
         YATaQMOx3qW2ghW1yd6lOyqY9rImE23O5/MI2gNaLC3/Gtlyh9ZEKL2b16OIAB80okOD
         bJvENobethFWPIDprRqPfArFi37jqbYzb7CDZursr34M7KHWJP32r32ex+RwYKtuKikY
         RRLLkkXfoGlIyg3p/rnjdxkElkcwlM6cbmcUUpuPze6Sj6ks256u/rf3m1aR4Yz/efyl
         8k+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1785878143; x=1786482943;
        h=content-type:cc:to:from:subject:message-id:references:mime-version
         :in-reply-to:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=rHQOfCFF6yaKH9HqGSLDO98Dtf8szKrkpDeyDbaXUEA=;
        b=DO7UV16bs8kl+ys/lL6uL+Wb4F6T5RV+iUV1EHp2TbRBLStiNQdwZLc2znT6HROdpB
         aTDnT7aqr174hgekt458PXAAzSpiL5yVz/Ag72bqXS5rrb+bm7ZTcf4WQHvTiDarLWjT
         ZxzRXzKWmjpoTXob7DS7eWFHO62NQ5Be4EO95ckdf52Z3pfimDYVtKNAKcCF4vUY1kBy
         19H48EzS+orQnX1p+J4e1+VbpwFjq7VGN1TbJmHzvECwuDp3/divqJRNApbtRrow4+I8
         lWglz42g+n7jaqJqyaUYapeYg6bfUEcr8q8tkQKEXNFrsLi5fz4sAU5R11GWw3yHTQfE
         Zb5g==
X-Forwarded-Encrypted: i=1; AHgh+RoGLZP2i9gvZXDhlm3BswHoZCbtsDaRayIt6w8KquLGMxJLYnuKLMn5m5v+gbWJz3qxIrGvjYgp7Q4s@vger.kernel.org
X-Gm-Message-State: AOJu0YwWokG2kcRf6WO9jPqHw9V9dXrD00Bvtgol4VM8IHQn5cv6fod7
	oL7dZi1fJ4QDpl+EamNAGtxJDfCO2axlkAhskNDjNgO0Fm+utlz3PV0X3n+EAitsjQBwfiXgI0t
	BLgyFig==
X-Received: from pjot9.prod.google.com ([2002:a17:90a:9509:b0:38e:1db:751c])
 (user=seanjc job=prod-delivery.src-stubby-dispatcher) by 2002:a17:90b:540e:b0:38e:6a30:4bbc
 with SMTP id 98e67ed59e1d1-3903c681346mr1785320a91.21.1785878142058; Tue, 04
 Aug 2026 14:15:42 -0700 (PDT)
Date: Tue, 4 Aug 2026 14:15:41 -0700
In-Reply-To: <20260804120529.1730187-5-pbonzini@redhat.com>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
References: <20260804120529.1730187-1-pbonzini@redhat.com> <20260804120529.1730187-5-pbonzini@redhat.com>
Message-ID: <anJWfesPj1C8fzFr@google.com>
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA types
From: Sean Christopherson <seanjc@google.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, 
	Alex Williamson <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, 
	Boris Brezillon <boris.brezillon@collabora.com>, Christian Koenig <christian.koenig@amd.com>, 
	David Hildenbrand <david@kernel.org>, dri-devel@lists.freedesktop.org, 
	Fei Li <fei1.li@intel.com>, Huang Rui <ray.huang@amd.com>, linux-mm@kvack.org, 
	linux-s390@vger.kernel.org, Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, 
	Sergio Lopez <slp@redhat.com>, Thomas Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"

KVM:

On Tue, Aug 04, 2026, Paolo Bonzini wrote:
> The VM_READ and VM_WRITE flags are checked only at the very end of
> hva_to_pfn().  For both the hva_to_pfn_remapped() case and for regular
> mappings, this adds unnecessary cases and inconsistent error behavior.
> 
> For hva_to_pfn_remapped(), the code is relying on fixup_user_fault() to
> detect this situation.  This is fragile because hva_to_pfn_remapped()
> returns different error codes for a !VM_WRITE VMA depending on whether
> the PTE happens to be mapped:
> 
> * if the PTE is present, follow_pfnmap_start() sets args.writable to
>   false and KVM_PFN_ERR_RO_FAULT is returned;
> 
> * if no PTE is present, fixup_user_fault(FAULT_FLAG_WRITE) returns
>   -EFAULT after checking vma_permits_fault(), and hva_to_pfn() ends
>   up returning KVM_PFN_ERR_FAULT.
> 
> With this patch KVM_PFN_ERR_RO_FAULT is returned uniformly.  Likewise,
> a PROT_NONE pfnmap VMA would be mapped into the guest if the PTE was
> pte_present()[1] when the guest attempted to read it; with the patch
> instead KVM uniformly returns KVM_PFN_ERR_FAULT.  Doing the check early
> avoids these special cases and also sidesteps the issue pointed out at
> https://sashiko.dev/#/patchset/20260731160514.1101989-1-pbonzini%40redhat.com.
> 
> For regular mappings a PROT_READ VMA, if placed in a writable memslot,
> would return KVM_PFN_ERR_FAULT instead of KVM_PFN_ERR_RO_FAULT when
> the guest writes to it.  This would cause a -EFAULT exit to userspace,
> instead of triggering emulation as the VM_IO|VM_PFNMAP arm would do;
> however it should be considered part of the KVM API because mmu_stress_test
> relies on it.
> 
> Still, even with this snag about the returned pfn error code, pull the
> vm_flags checks in front so that they are done for all VMAs and the
> above inconsistency goes away for the VM_IO|VM_PFNMAP case.
> 
> [1] on x86, for example, such a page would have _PAGE_PRESENT clear
>   but _PAGE_PROTNONE set
> 
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  virt/kvm/kvm_main.c | 34 ++++++++++++++++------------------
>  1 file changed, 16 insertions(+), 18 deletions(-)
> 
> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 45e784462ec6..576bcb21be3a 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
> @@ -2925,17 +2925,6 @@ static int hva_to_pfn_slow(struct kvm_follow_pfn *kfp, kvm_pfn_t *pfn)
>  	return npages;
>  }
>  
> -static bool vma_is_valid(struct vm_area_struct *vma, bool write_fault)
> -{
> -	if (unlikely(!(vma->vm_flags & VM_READ)))
> -		return false;
> -
> -	if (write_fault && (unlikely(!(vma->vm_flags & VM_WRITE))))
> -		return false;
> -
> -	return true;
> -}
> -
>  static int hva_to_pfn_remapped(struct vm_area_struct *vma,
>  			       struct kvm_follow_pfn *kfp, kvm_pfn_t *p_pfn)
>  {
> @@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
>  retry:
>  	vma = vma_lookup(current->mm, kfp->hva);
>  
> -	if (vma == NULL)
> +	/*
> +	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
> +	 * or the page might be absent.
> +	 */
> +

Unnecessary newline, IMO.

> +	if (vma == NULL || unlikely(!(vma->vm_flags & VM_READ))) {
>  		pfn = KVM_PFN_ERR_FAULT;
> -	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> +	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_WRITE))) {
> +		/*
> +		 * Exit to userspace for PROT_READ mappings in a writable
> +		 * memslot, as this is part of the API.

Can we say something along the lines of "for backwards compatibility" instead
of saying this is part of the API?  Because that's definitely not KVM's documented
API, and we're hoping it's not part of KVM's undocumented API either.

> +		 */
> +		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
> +			KVM_PFN_ERR_FAULT;

Please align the two branches of the ternary operators:

		pfn = vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
							    KVM_PFN_ERR_FAULT;
	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
		r = hva_to_pfn_remapped(vma, kfp, &pfn);
		if (r == -EAGAIN)
			goto retry;
		if (r < 0)
			pfn = KVM_PFN_ERR_FAULT;
	} else {
		pfn = kfp->flags & FOLL_NOWAIT ? KVM_PFN_ERR_NEEDS_IO :
						 KVM_PFN_ERR_FAULT;
