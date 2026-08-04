Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 503822BB17;
	Tue,  4 Aug 2026 12:30:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846618; cv=none; b=rplQusFvHbFGGtJrbwpcIzZbKANlLt99MFcnXnovGxg9qJSJWISnngBMbt9uaSzmWRtunRanKFrNleRXZmOW6e4oGrZQk93s3sGF8mXVgHTSGoJUA6UQkbrOss8JfDnUGTw0ufQpwGXRM8epygSkckWkIl/s3PmHxK/q55Agl18=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846618; c=relaxed/simple;
	bh=qS5Zopki3VAAUhDWMRXelmQti9f2wXDrmesUVlo3Pao=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UrQNxrNvmsf2V92A5L1QHcf2ZKtCL8orlG7rA5OV/jJdFq46SqwF4RwwbHuQJOp0nryEyDZ6YSLh1Ai5YEAo/+I+eXX23v2C21Z+xnmA4DobKgwQC3H+MY/qjDkCwPuUQc4J2gLCk/3AFqJDr9ssc64RKYN754KZnzU1fF3Vuag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=K0enCvpu; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="K0enCvpu"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 411CC1F000E9;
	Tue,  4 Aug 2026 12:30:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846615;
	bh=h6uTgvbzsfHztun3X6lhFFLMxhJuej9DVPBNS+33W74=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=K0enCvputhz/9LjsEu/IrIpuMarE7Ts377TNOShUIBV/rtGiKKiGOGEj329XPHSEn
	 JCkDuu1LDJlLg4WqZaEgEmfWfJp7fCMHH9+MsXOKuIvOrHaE7fzAxy0KiULU+zQEO8
	 ZoHWzSgt5fUrN7y0Rz6VuG6omM8W0kVnywlXNEGKcfvfFOvFo+HHcA6m5/n17ydWMO
	 FjYlSDj5c/v8kPylDYgYXqPFZv7G1NDQfgukNgbdxvkn54wxrIrzbM+iMEQsVP7nuZ
	 LMeVOx0NNP8BU5jDsh9pmQtx+/3aHrtNCUHnT4WM+68ZNecT+d80QVqhx4vQqB0RHL
	 0c9pbIyM6RL9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: dri-devel@lists.freedesktop.org, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260804120529.1730187-3-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-3-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:30:13 +0000
Message-Id: <20260804123015.411CC1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `.huge_fault` handler `drm_gem_shmem_any_fault` does not v=
erify if the PMD-sized huge page fits entirely within the bounds of the VMA=
, allowing a VMA boundary bypass.
- [High] Incorrect page offset calculation in DRM shmem fault handlers caus=
es the wrong pages to be mapped.
--

--- Patch [2]: [PATCH v2 2/6] drm/shmem_helper: use vmf_insert_pfn_mkwrite(=
) ---
commit 6ce5b52de7395aa4c0a50d399649686c52e613a9
Author: Paolo Bonzini <pbonzini@redhat.com>

drm/shmem_helper: use vmf_insert_pfn_mkwrite()

This ensures that KVM or VFIO correctly see a writable PTE when
they request one. Otherwise, a guest write to an unpopulated
PTE from a mapping backed by a DRM GEM BO triggers a VM exit
with EFAULT.

Link: https://lore.kernel.org/kvm/20260729072044.25796-1-slp@redhat.com/

> diff --git a/drivers/gpu/drm/drm_gem_shmem_helper.c b/drivers/gpu/drm/drm=
_gem_shmem_helper.c
> index c989459eb2159..c81be3e973173 100644
> --- a/drivers/gpu/drm/drm_gem_shmem_helper.c
> +++ b/drivers/gpu/drm/drm_gem_shmem_helper.c
> @@ -589,11 +589,25 @@ static void drm_gem_shmem_record_mkwrite(struct vm_=
fault *vmf)
>  	folio_mark_dirty(page_folio(shmem->pages[page_offset]));

[Severity: High]
This is a pre-existing issue, but does this page_offset calculation
correctly handle the requested offset within the GEM object?

When userspace mmaps a sub-range of a GEM object with a non-zero
offset, or unmaps a prefix of the VMA, the core memory management
sets vma->vm_pgoff to include the requested offset. Because
page_offset evaluates to vmf->pgoff - vma->vm_pgoff, it calculates
the offset relative to the VMA start, ignoring the requested offset
within the GEM object itself.

This can cause folio_mark_dirty() to mark the wrong folio dirty.
The same calculation is present in drm_gem_shmem_any_fault(),
which could lead to mapping the wrong physical pages.

>  }
> =20
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
>  static vm_fault_t try_insert_pfn(struct vm_fault *vmf, unsigned int orde=
r,
>  				 unsigned long pfn)
>  {
> +	bool write =3D vmf->flags & FAULT_FLAG_WRITE;
> +	vm_fault_t ret =3D VM_FAULT_FALLBACK;
> +
>  	if (!order) {
> -		return vmf_insert_pfn(vmf->vma, vmf->address, pfn);
> +		ret =3D vmf_insert_pfn_mkwrite(vmf->vma, vmf->address, pfn, write);
>  #ifdef CONFIG_ARCH_SUPPORTS_PMD_PFNMAP
>  	} else if (order =3D=3D PMD_ORDER) {
>  		unsigned long paddr =3D pfn << PAGE_SHIFT;
> @@ -601,27 +615,15 @@ static vm_fault_t try_insert_pfn(struct vm_fault *v=
mf, unsigned int order,
> =20
>  		if (aligned &&
>  		    folio_test_pmd_mappable(page_folio(pfn_to_page(pfn)))) {
> -			vm_fault_t ret;
> -
>  			pfn &=3D PMD_MASK >> PAGE_SHIFT;
> -
> -			/* Unlike PTEs which are automatically upgraded to
> -			 * writeable entries, the PMD upgrades go through
> -			 * .huge_fault(). Make sure we pass the "write" info
> -			 * along in that case.
> -			 * This also means we have to record the write fault
> -			 * here, instead of in .pfn_mkwrite().
> -			 */
> -			ret =3D vmf_insert_pfn_pmd(vmf, pfn,
> -						 vmf->flags & FAULT_FLAG_WRITE);
> -			if (ret =3D=3D VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> -				drm_gem_shmem_record_mkwrite(vmf);
> -
> -			return ret;
> +			ret =3D vmf_insert_pfn_pmd(vmf, pfn, write);

[Severity: Critical]
This is a pre-existing issue, but does the fault handler verify that a
PMD-sized huge page fits entirely within the bounds of the VMA?

The core __thp_vma_allowable_orders() skips VMA boundary checks by
relying on the driver's .huge_fault handler to enforce them. However,
drm_gem_shmem_any_fault() does not appear to check if
vmf->address + PMD_SIZE <=3D vma->vm_end before delegating to
vmf_insert_pfn_pmd() via try_insert_pfn().

Could an unprivileged user create a 4KB VMA backed by a PMD-aligned GEM
object, and fault it to install a 2MB PMD that overwrites adjacent VMA
page tables?

>  		}
>  #endif
>  	}
> -	return VM_FAULT_FALLBACK;
> +
> +	if (ret =3D=3D VM_FAULT_NOPAGE && write)
> +		drm_gem_shmem_record_mkwrite(vmf);
> +	return ret;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D2
