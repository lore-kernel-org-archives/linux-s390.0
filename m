Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 387F236B913;
	Tue,  4 Aug 2026 12:21:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846090; cv=none; b=AqcZmpomYIDVqgMTH7euv+FfhLMnLVSZ8+96ij+6lsNIY1mXkz4kWaQivD/t7gUK2YGgccH+vn3G4FXGP/KrJLgHScCLQdoBsBson3BeDR7cn3jFN0jzHKf5SUN+julbvsQCu4bUUKB25L/YwRjrzgA7hWqMq2m3dQ4H1DgaQno=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846090; c=relaxed/simple;
	bh=XCL9NpbPTUjxmZ1Fc4OINbyssUaMCbHdLP4qT/cwdr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Ogvjoa4+U99cs/a//Nm+kW83fIpyXHou9qVg4E1pmFIlN3ka1dI2F2S0lP5I+Bbpvr2oKDSrr71UEiMLbySYaxqH8nGPimxhZLtuc3mlNHyNGZg4g9MJyfrgyrWw9VYpV0oJNzZA3X50zzgwGibtQHrcu7U1ER5dgElwP2DdcH0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DiuuEZI2; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DiuuEZI2"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 838941F000E9;
	Tue,  4 Aug 2026 12:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846088;
	bh=o55X5EFKDdd4NmpGuUIhEgn6r1Pm62pKmqmPFQ0Ddcc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DiuuEZI2RRusBtL5jmfkXQFLnbUUrLU0bLUQyArSzaN0mkHHiy9OrjIe/uMVn8qte
	 G8wN1I4kOJfD6tRhsIusXlMUL+9OulBHlOsJNVxvP5du1rcQYpZTZrO6RdTFJa9Uc4
	 xvLS4tjGAtC4QTizAb2cyrhdqlWigw4Nkr1Xh7a5dHCjNxuW1wD/LBJMnUafrU74XT
	 eri6NgYlIDeNEYTjlhC+wVZhOxl/xPrLG/qZgO4Pt9Y3+yOQQSYVolT7gwb9JDHStl
	 2lexK1CZU5jgJ8e9buLvtTVZqwk5p/xO5weBTz6ifb4UFhvUHPE5xsxTr6a9hrXh7z
	 ShuMnXGMvqpmw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable
 PTEs when mkwrite is in use
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, dri-devel@lists.freedesktop.org, kvm@vger.kernel.org
In-Reply-To: <20260804120529.1730187-4-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-4-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:21:28 +0000
Message-Id: <20260804122128.838941F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Missing dirty page tracking in vmw_bo_vm_fault() when prefaulting =
fails, leading to silent data loss.

Pre-existing issues:
- [High] Inverted error handling logic in ttm_bo_vm_fault_reserved() hides =
primary fault errors and propagates prefault errors.
--

--- Patch [3]: [PATCH v2 3/6] drm/ttm, drm/vmwgfx: directly create writable=
 PTEs when mkwrite is in use ---
commit 2f0ecb57a3fc3ac93f0458269dd5ea847c608a25
Author: Paolo Bonzini <pbonzini@redhat.com>
Subject: drm/ttm, drm/vmwgfx: directly create writable PTEs when mkwrite is=
 in use

This patch modifies TTM BO fault handling to explicitly request writable
PTEs for the primary page when mkwrite is in use. It also updates vmwgfx
to manually record write faults since the .pfn_mkwrite() callback is no
longer invoked for the primary page.

> diff --git a/drivers/gpu/drm/ttm/ttm_bo_vm.c b/drivers/gpu/drm/ttm/ttm_bo=
_vm.c
> index a80510489c456..3ebde936ce608 100644
> --- a/drivers/gpu/drm/ttm/ttm_bo_vm.c
> +++ b/drivers/gpu/drm/ttm/ttm_bo_vm.c

[ ... ]

> @@ -242,6 +243,7 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault *=
vmf,
>  	 * Speculatively prefault a number of pages. Only error on
>  	 * first page.
>  	 */
> +	mkwrite =3D !!(vmf->flags & FAULT_FLAG_WRITE);
>  	for (i =3D 0; i < num_prefault; ++i) {
>  		if (bo->resource->bus.is_iomem) {
>  			pfn =3D ttm_bo_io_mem_pfn(bo, page_offset);
> @@ -263,9 +265,10 @@ vm_fault_t ttm_bo_vm_fault_reserved(struct vm_fault =
*vmf,
>  		 * at arbitrary times while the data is mmap'ed.
>  		 * See vmf_insert_pfn_prot() for a discussion.
>  		 */
> -		ret =3D vmf_insert_pfn_prot(vma, address, pfn, prot);
> +		ret =3D vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
> =20
> -		/* Never error on prefaulted PTEs */
> +		/* Never error on prefaulted PTEs and never map them writable */
> +		mkwrite =3D false;
>  		if (unlikely((ret & VM_FAULT_ERROR))) {
>  			if (i =3D=3D 0)
>  				return VM_FAULT_NOPAGE;
>  			else
>  				break;
>  		}

[Severity: High]
This is a pre-existing issue, but does this error handling logic for
ttm_bo_vm_fault_reserved() behave backwards?

If vmf_insert_pfn_prot_mkwrite() fails for the primary page (i =3D=3D 0),
returning VM_FAULT_NOPAGE hides the error from the fault handler,
potentially causing an infinite page fault loop.

Conversely, if a speculative prefault (i > 0) fails, the loop breaks
and the error is propagated to the fault handler, which might cause
a spurious process crash even though the primary fault succeeded.


> diff --git a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c b/drivers/gpu/drm=
/vmwgfx/vmwgfx_page_dirty.c
> index 45561bc1c9eff..3099558c0762f 100644
> --- a/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c
> +++ b/drivers/gpu/drm/vmwgfx/vmwgfx_page_dirty.c

[ ... ]

> @@ -484,6 +487,9 @@ vm_fault_t vmw_bo_vm_fault(struct vm_fault *vmf)
>  		prot =3D vm_get_page_prot(vma->vm_flags);
> =20
>  	ret =3D ttm_bo_vm_fault_reserved(vmf, prot, num_prefault);
> +	if (ret =3D=3D VM_FAULT_NOPAGE && (vmf->flags & FAULT_FLAG_WRITE))
> +		WARN_ON_ONCE(vmw_bo_dirty_mkwrite(vmf, bo));
> +
>  	if (ret =3D=3D VM_FAULT_RETRY && !(vmf->flags & FAULT_FLAG_RETRY_NOWAIT=
))
>  		return ret;
> =20

[Severity: High]
If a speculative prefault fails inside ttm_bo_vm_fault_reserved(), will
this skip tracking the dirty page and lead to silent data loss?

Because the primary page is successfully mapped writable before the prefault
loop continues:

ttm_bo_vm_fault_reserved()
    ret =3D vmf_insert_pfn_prot_mkwrite(vma, address, pfn, prot, mkwrite);
    // ... prefault loops to next page and fails ...
    break; // returns the error

The error is returned to vmw_bo_vm_fault(), meaning ret is not
VM_FAULT_NOPAGE.

This check is skipped, leaving the primary page mapped writable without the
driver marking it dirty.

If the process survives the fault (e.g., by handling SIGBUS), could it
then modify data without the driver tracking it?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D3
