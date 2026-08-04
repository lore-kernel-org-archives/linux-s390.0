Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82E1B386C18;
	Tue,  4 Aug 2026 12:23:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785846230; cv=none; b=mf42rYyxfxMRmcuBspP/o2VmUDJM0H7MlC1KjYOw1F8dKRo0PHzeTA7VSZ5PU7XykGcMbiCusl4IevWN4hxC9VhvCkriZHSz8dk+bKimW/MRG8V8/iZIhVoJ0zMifgtIoeQRgO314wu8ye/GR/FyZ/fOcHXcTa3fVD1dhPAU834=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785846230; c=relaxed/simple;
	bh=HgSit/O1Iwic2lx8MKclS7LChmzmr0gyl+AiWvr+1Aw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=sjWkD9ku09nKWF+p64NaMhPqBhTU/SRD91mSM/Ncrh1eFcq8xuKkkWvQ+H08xAb1l7G0ANRw0mWNHzGh3XFff9JNz6s6FaL1dupW0QjOtGACw+FNGi2FEig4SY2hHkFdC3XhbMQSitVV8V0INPRmy9+AAbW0nAtnjcF7Ap1DNso=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jz6PI/ia; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jz6PI/ia"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC6E51F00A3D;
	Tue,  4 Aug 2026 12:23:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785846229;
	bh=2KQXGRcKEg+TweibH2l3N8b15Hx4fsIJOaOhHMa5qDY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jz6PI/iawhNWY7K60RXBx7DqXo1XuEmEInNOmsPpbUTM+xCDGkF6OZ7SW2MgZtcHN
	 0bv8dh0VW6MNgJbJjNdoV5SlNvJNrPpXRqKoyY5eCugX6JRscsatBa9RU0HtUo/lrg
	 agoSujMLN9xWNbcFjihpvUxdwCTnyuiM7ItZ9VdTbNcjPQuwk8MwUZNvlkzN8zz6ZW
	 ep9hD8reXjZdlLHG2NGJ5lIhf006AqTboatVpzj12Y7wEejXOXupYvBEt5mJtwMFXl
	 9rnP9m/MYIpDyvln7OACA01EahCd7uvnqxfSloaPqLfur6OPQVgvhARwIQMEj9FTxU
	 eEvh7m/iE50Vg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA
 types
Reply-To: sashiko-reviews@lists.linux.dev
To: "Paolo Bonzini" <pbonzini@redhat.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, dri-devel@lists.freedesktop.org
In-Reply-To: <20260804120529.1730187-5-pbonzini@redhat.com>
References: <20260804120529.1730187-1-pbonzini@redhat.com>
 <20260804120529.1730187-5-pbonzini@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 04 Aug 2026 12:23:48 +0000
Message-Id: <20260804122348.AC6E51F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Write faults on write-only `VM_IO | VM_PFNMAP` VMAs are incorrectl=
y rejected, breaking guest writes to write-only device memory.
--

--- Patch [4]: [PATCH v2 4/6] kvm: apply VM_READ/VM_WRITE checks to all VMA=
 types ---
commit 254a4090eb1ddc66d1d90350bb0e3ef36a2ee158
Author: Paolo Bonzini <pbonzini@redhat.com>

kvm: apply VM_READ/VM_WRITE checks to all VMA types

This commit moves the VM_READ and VM_WRITE checks to the beginning of the
fallback VMA lookup block in hva_to_pfn(). This standardizes the error
return codes across remapped and regular VMAs, eliminating inconsistencies
in how RO faults are handled.

> diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
> index 45e784462ec6e..576bcb21be3a6 100644
> --- a/virt/kvm/kvm_main.c
> +++ b/virt/kvm/kvm_main.c
[ ... ]
> @@ -3008,20 +2997,29 @@ kvm_pfn_t hva_to_pfn(struct kvm_follow_pfn *kfp)
>  retry:
>  	vma =3D vma_lookup(current->mm, kfp->hva);
> =20
> -	if (vma =3D=3D NULL)
> +	/*
> +	 * GUP failed.  It could be an inaccessible mapping, a pfnmap one,
> +	 * or the page might be absent.
> +	 */
> +
> +	if (vma =3D=3D NULL || unlikely(!(vma->vm_flags & VM_READ))) {

[Severity: High]
Does this unconditionally reject write-only mappings?=20

If a guest performs a memory write to a guest physical address backed by a
write-only host VMA (e.g. VM_IO or VM_PFNMAP mapped with PROT_WRITE but
without PROT_READ), get_user_pages() will fail and fall back to this lookup.

Since the write-only VMA lacks VM_READ, this check will evaluate to true and
return KVM_PFN_ERR_FAULT, skipping the VM_IO | VM_PFNMAP handler. Could this
prevent guests from writing to legitimate write-only device memory, such as
command ring buffers or write-only PCI BARs?

>  		pfn =3D KVM_PFN_ERR_FAULT;
> -	else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
> +	} else if ((kfp->flags & FOLL_WRITE) && unlikely(!(vma->vm_flags & VM_W=
RITE))) {
> +		/*
> +		 * Exit to userspace for PROT_READ mappings in a writable
> +		 * memslot, as this is part of the API.
> +		 */
> +		pfn =3D vma->vm_flags & (VM_IO | VM_PFNMAP) ? KVM_PFN_ERR_RO_FAULT :
> +			KVM_PFN_ERR_FAULT;
> +	} else if (vma->vm_flags & (VM_IO | VM_PFNMAP)) {
>  		r =3D hva_to_pfn_remapped(vma, kfp, &pfn);
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804120529.1730=
187-1-pbonzini@redhat.com?part=3D4
