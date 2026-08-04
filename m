Received: from bali.collaboradmins.com (bali.collaboradmins.com [148.251.105.195])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7F4F4376BC1;
	Tue,  4 Aug 2026 14:15:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=148.251.105.195
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785852969; cv=none; b=jbkNL1qT5CX0KJljsSUfjWN2xtUPik9wlY3ioFxq6OpjKdqnis4Dj6HkjXf17burzaGYngXq7NFmx2VpDEYWR5srh/aXhYi5lE1lMiLU2//KdblrZNUyA6ZHQ8p7rms65u0dZdPnFfDdClAFZe02PVBVfxU45FSfnNJiIxjqs/U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785852969; c=relaxed/simple;
	bh=+3Z5rwHR3Npu6BOoPBa6/MBmkSks84W8RMudMGSUNxc=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F/iMuxDeDYqqynThh5koGQd7IMhVGnRuQw+h+1Y6/e8DbsAOdP9GDfeb7j47u0y/DyCkI2l63DUTIoOhgTVPApkn9Dl/oTUOb7zCgjj957vKAg1yYNPMEkbIISYPMWZ6ojwBb1/jtTLaXnbi8nS64z7HyxbRRFkVLbkoH7VjGls=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com; spf=pass smtp.mailfrom=collabora.com; dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b=U9Y+ykcr; arc=none smtp.client-ip=148.251.105.195
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=collabora.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=collabora.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=collabora.com header.i=@collabora.com header.b="U9Y+ykcr"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
	s=mail; t=1785852953;
	bh=+3Z5rwHR3Npu6BOoPBa6/MBmkSks84W8RMudMGSUNxc=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
	b=U9Y+ykcrneFm0SMzgD5Wequ5C+6YI9+5KWqJjq6MLqKcdspZXPBqRSTKLAQbn0Dwe
	 Jh4DlMKtwG72LHsJHkUlb16WIQJUUj+18D9Om/xq2DDIQYHJIqqeqV+cs4S2K8ll0u
	 4Xn8vps1thOfJAuih04f0ajvJ02z0b+dNM7G5KG4vsA9uJkF+UPMtoBzuOl8N0d9/o
	 Axxxz0skaIMlF/q2UUrgx2HHInYAouN6PFta0IFcrqGw7mD/F5MJfrJPa2J0b9Xe+D
	 51C3Oe/EKywkLcUXr5kjR7m7lRQJZFO/08vh07hJlCOSImCykqaB0uJfKf5qoEjrQj
	 v2Cf5nQUhFxUg==
Received: from fedora-21.home (unknown [100.64.0.11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange secp256r1 server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	(Authenticated sender: bbrezillon)
	by bali.collaboradmins.com (Postfix) with ESMTPSA id 8ABF017E0048;
	Tue, 04 Aug 2026 16:15:52 +0200 (CEST)
Date: Tue, 4 Aug 2026 16:15:49 +0200
From: Boris Brezillon <boris.brezillon@collabora.com>
To: Paolo Bonzini <pbonzini@redhat.com>
Cc: linux-kernel@vger.kernel.org, kvm@vger.kernel.org, Alex Williamson
 <alex@shazbot.org>, bcm-kernel-feedback-list@broadcom.com, Christian Koenig
 <christian.koenig@amd.com>, David Hildenbrand <david@kernel.org>,
 dri-devel@lists.freedesktop.org, Fei Li <fei1.li@intel.com>, Huang Rui
 <ray.huang@amd.com>, linux-mm@kvack.org, linux-s390@vger.kernel.org, Michal
 Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>, Sergio Lopez
 <slp@redhat.com>, Sean Christopherson <seanjc@google.com>, Thomas
 Zimmermann <tzimmermann@suse.de>, stable@vger.kernel.org
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Message-ID: <20260804161549.4cd9a66f@fedora-21.home>
In-Reply-To: <20260804120529.1730187-3-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
	<20260804120529.1730187-3-pbonzini@redhat.com>
Organization: Collabora
X-Mailer: Claws Mail 4.4.0 (GTK 3.24.52; x86_64-redhat-linux-gnu)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Tue,  4 Aug 2026 14:05:24 +0200
Paolo Bonzini <pbonzini@redhat.com> wrote:

> This ensures that KVM or VFIO correctly see a writable PTE when
> they request one.  Otherwise, a guest write to an unpopulated
> PTE from a mapping backed by a DRM GEM BO triggers a VM exit
> with EFAULT.
> 
> The code actually is simpler, because the same logic already
> applied to the hugepage mapping case using vmf_insert_pfn_pmd().
> 
> Reported-by: Sergio Lopez <slp@redhat.com>
> Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/
> Tested-by: Sergio Lopez <slp@redhat.com>
> Reviewed-by: Boris Brezillon <boris.brezillon@collabora.com>
> Fixes: 28e3918179aa ("drm/gem-shmem: Track folio accessed/dirty status in mmap")
> Cc: stable@vger.kernel.org
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  drivers/gpu/drm/drm_gem_shmem_helper.c | 38 ++++++++++++++------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm_gem_shmem_helper.c
> index c989459eb215..c81be3e97317 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_fault *vmf)
>  	folio_mark_dirty(page_folio(shmem->pages[page_offset]));
>  }
>  
> +/*
> + * Because the vm_ops have a .pfn_mkwrite() callback, vma_set_page_prot()
> + * has cleared the write bit from vma->vm_page_prot.  vmf_insert_pfn()
> + * would install a read-only entry even for a write fault, relying on a
> + * second fault to reach .pfn_mkwrite() and upgrade it, but that second
> + * fault never happens for fixup_user_fault() callers that directly
> + * walk the page tables with follow_pfnmap_start().  To ensure that
> + * they don't see the read-only entry, pass FAULT_FLAG_WRITE info down
> + * to install a writable entry right away.  Because .pfn_mkwrite() is
> + * not invoked, record the write afterwards.
> + */
>  static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  				 unsigned long pfn)
>  {
> +	bool write = vmf->flags & FAULT_FLAG_WRITE;
> +	vm_fault_t ret = VM_FAULT_FALLBACK;
> +
>  	if (!order) {
> -		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +		ret = vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  	} else if (order == PMD_ORDER) {
>  		unsigned long paddr = pfn << PAGE_SHIFT;
> @@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int order,
>  
>  		if (aligned &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> -			vm_fault_t ret;
> -
>  			pfn &= PMD_MASK >> PAGE_SHIFT;
> -
> -			/* Unlike PTEs which are automatically upgraded to
> -			 * writeable entries, the PMD upgrades go through
> -			 * .huge_fault(). Make sure we pass the "write" info
> -			 * along in that case.
> -			 * This also means we have to record the write fault
> -			 * here, instead of in .pfn_mkwrite().
> -			 */
> -			ret = vmf_insert_pfn_pmd(vmf, pfn,
> -						 vmf->flags & FAULT_FLAG_WRITE);
> -			if (ret == VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> -				drm_gem_shmem_record_mkwrite(vmf);
> -
> -			return ret;
> +			ret = vmf_insert_pfn_pmd(vmf, pfn, write);
>  		}
>  #endif
>  	}
> -	return VM_FAULT_FALLBACK;
> +
> +	if (ret == VM_FAULT_NOPAGE && write)
> +		drm_gem_shmem_record_mkwrite(vmf);

Actually, if we're making the drm_gem_shmem_record_mkwrite() call
unconditional (for PTE and PMD updates) in that path, can't we drop the
drm_gem_shmem_pfn_mkwrite() call living in drm_gem_shmem_pfn_mkwrite()?

Also, I'm not even sure we can end up with write=true for PTE updates,
because our pfn_mkwrite implementation returns zero, not VM_FAULT_ERROR
or VM_FAULT_NOPAGE. This means the default RO -> RW PTE upgrade
implemented in finish_mkwrite_fault() [1] will take place. If we really
want out try_insert_pfn() to be called for those RO -> RW updgrades, we
need to call try_insert_pfn() from drm_gem_shmem_pfn_mkwrite().

[1]https://elixir.bootlin.com/linux/v7.2-rc5/source/mm/memory.c#L4021
