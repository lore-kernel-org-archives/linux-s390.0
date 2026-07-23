Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8D3984908D9;
	Thu, 23 Jul 2026 18:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832494; cv=none; b=psOcLehWBKsLUgJX/HVC6oSUyciqxWb2Bc0D/EWZUsqUKHZ+27L8V1KNiblyNLye3J7z3uEKkBSgrkwzZZVZM6HiD5NAAK8AnKd5eCWheZD1o2FcaKJMkJ4lsYOW2WhHsLRWJH+IBeTukIvCZUxu87G1QWrd9tmFRn5L66caBCM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832494; c=relaxed/simple;
	bh=jyLwEcW/T7WQs2pLxx0/qAEFrirRqv7o62uFv16dDNo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ScdcWT9itMUZT04irJprp4x+f5ICHugVLAhKgnMReIsvc5efD9qVzW9iBmHqqur3M/HOFA1bEUfFCotRS4R5yzX0cLcLAHVfFNEY/q7N5NOhuc9+TN6V4UUDojoIzeAf+/3ogKxbtVYe08v0HYuTMy2tseS8F/bSda08ovqzmOY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NT6mkQ71; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NT6mkQ71"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 816BE1F000E9;
	Thu, 23 Jul 2026 18:48:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784832482;
	bh=zSBle4D7orWD3cy2vTjl5RHEYRJKsyrkvlxiU9TdbvM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NT6mkQ71AOl5VAibnEJG1ZgJI1bcN6AOrk0JPnbFDqYW2/+qKtlW1QKUNTNspPSGj
	 Gn1UJRi5qe3kE+HiSlrAdW7HHjdXJASmxGdeSMYatr2RglWNhu0EwL9BoU+xCj0w1A
	 RM82mWsex1j7ZYTUxsgAWtPHAU5APfwl6z0RgBWdGZoBtLMXba13LNT9hePJ/OjJwU
	 k2EvVfBPoRYRK8xG0wYVb35KsfjzM0oIcvGHTlXqw/Aorzgakf2dHqgtaiTUrNeWyq
	 1FjR60U0cGa1jX36vhqKCSi5N360fugonxrhz1Y62Pns7lZ6V4C5JHn4SD4bPzWhsu
	 pprTAI25RL0og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 6/6] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260723183440.3271-7-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-7-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:48:02 +0000
Message-Id: <20260723184802.816BE1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [Critical] The AIBV size calculation underestimates the required memory f=
ootprint when the bit vector has a non-zero bit offset, allowing an unalign=
ed AIBV to silently cross a page boundary and cause host memory corruption =
via hardware DMA.

Pre-existing issues:
- [High] Guest AIBV and AISB pages are unpinned without being marked dirty,=
 leading to potential silent data loss of hardware DMA writes.
--

--- Patch [6]: [PATCH v5 6/6] KVM: s390: pci: Validate AIBV and AISB before=
 pinning guest pages ---
commit ce58b81776049069915a6d5914d02bc982861691
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

The AIBV holds one bit per MSI-X vector for a given function. If the size
of the AIBV exceeds a single page boundary, or if the AISB address is not
8-byte aligned, the request is rejected to prevent unsafe pinning of the
guest pages.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index ca8ef76bcf6b3..25185d04ca28e 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

> @@ -271,6 +271,15 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  		return gisc;
> =20
>  	/* Replace AIBV address */
> +	size =3D BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
> +	size +=3D (fib->fmt0.aibvo / 8);
> +	npages =3D DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE=
);

[Severity: Critical]
Does this calculation underestimate the true byte footprint of the bit vect=
or
when aibvo is non-zero?

If a guest provides msi_vecs =3D 64, aibvo =3D 63, and an aibv GPA with a p=
age
offset of 4081, the calculated size is 15 bytes instead of 16. The npages
calculation yields DIV_ROUND_UP(4081 + 15, 4096) =3D 1, which incorrectly
passes the npages > 1 boundary check.

This would result in KVM pinning only one page, but the hardware could acce=
ss
the 16th byte, writing to the first byte of the next unpinned host physical
page, which could lead to host memory corruption.

> +	/* AIBV cannot span more than 1 page */
> +	if (npages > 1) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	idx =3D srcu_read_lock(&kvm->srcu);
>  	hva =3D gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
>  	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);

[Severity: High]
This isn't a bug introduced by this patch, but does the unpinning of guest
AIBV and AISB pages in kvm_s390_pci_aif_disable() need to mark the pages
as dirty?

The pages are pinned with FOLL_WRITE in kvm_s390_pci_aif_enable(), and PCI
hardware modifies the pinned pages directly via DMA. When unpinning these
pages later in kvm_s390_pci_aif_disable():

arch/s390/kvm/pci.c:kvm_s390_pci_aif_disable() {
    ...
	if (vpage) {
		unpin_user_page(vpage);
		pcount++;
	}
	if (spage) {
		unpin_user_page(spage);
		pcount++;
	}
    ...
}

Without marking them dirty, if the host's memory management subsystem
later reclaims or swaps out these pages, the hardware DMA writes could be
silently lost. Could this lead to lost interrupts and guest malfunctions?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D6
