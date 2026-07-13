Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CFE2D34B662;
	Mon, 13 Jul 2026 17:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964481; cv=none; b=dmdpik1/fsUyVXSgzOyhW1riJPw4OCWR31rTqJ6RLO+JDdwGk72qjb3FcAogIjpdcvW5MWOfD9KHHTN+Rp7d/Pd5+vtdwPwVMXpJC2tVnBfteBNpmSs9Tj8WuzMui6A2KpMJQs/2MVtnht7hXtjpxZotyCFNcXGyW8R6cQ6tt30=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964481; c=relaxed/simple;
	bh=Juqf3TV4fmWEtbSf+yn79ZmjrqSnz0We9voeEZPZPFs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mxS5W+DcwFVIqzoeSifEWBNSEvrSaipVTers7ugk2QPIB9tS1Eicddbhbf043xPcmHuqa2eSOXmilv7BZOJMv6enSGiwfSbjS6syXxNYPqyVcMrRADgIbmFODVOBBbIhmy68YooDWVS/iS8Gf76BZSo+tzohgQAikOCnKxNkaxA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EToX/E5x; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EToX/E5x"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177F91F00A3A;
	Mon, 13 Jul 2026 17:41:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964479;
	bh=n6dkrR9/CgBiDSSbSxZXCKR9klaIT8oF28SscpghPno=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EToX/E5xZ/AbkdDESIazFzzSbL+SCjxSPCPIvYf1BlGiC6Fn5oOaG56aKRC0x0tnH
	 K/GaoomF/fvvXz2qxl7+a/Up4+GMNAqqygqUa3F/hfE/n/2VzaTEw2fbpYZSxCz4h8
	 0SwbN8zDJ8ZVecYYQfeQfcdxUSoHuW5olcF5iU7rWiu4VAlgk7rWMY4i6Xv5xvXf/e
	 71sMHfu+shyHKfDmjZSXnWVcSsSEJUEtMQonOM+ZPONUr8MZ1AzePqFZKjhB4WS4yk
	 QBybvsYIChHoAlR3W1OvayJr25pbRoHTTWIXFTCWWSNBh57crh1fIjTYCiwu87vHS8
	 Bw6x1u3iCZQPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 5/5] KVM: s390: pci: Fix AIBV and AISB spanning
 multiple pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260713172600.1284-6-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:41:18 +0000
Message-Id: <20260713174119.177F91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [Medium] Multi-page pinning relies on a single host virtual address (HVA)=
 translation, which fails across KVM memslot boundaries.

Pre-existing issues:
- [Critical] Hardware DMA and kernel virtual accesses overflow into unrelat=
ed physical pages due to lack of physical contiguity.
- [High] Repeated registration ioctls leak pinned memory pages and `airq_iv=
` structures.
--

--- Patch [5]: [PATCH v1 5/5] KVM: s390: pci: Fix AIBV and AISB spanning mu=
ltiple pages ---
commit 4f8b3d86d13ac2b1f9a5979bfc8a008742cfc9de
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix AIBV and AISB spanning multiple pages

This patch modifies KVM s390 pci interrupt forwarding to pin multiple pages
for AIBV and AISB structures if they cross a page boundary. It calculates t=
he
required number of pages and pins them to handle unbounded sizes or varying
alignments correctly.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 9a16a2eac65b8..5fe07181f3d6a 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -229,13 +229,15 @@ static inline int account_mem(unsigned long nr_page=
s)
>  static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fi=
b *fib,
>  				   bool assist)
>  {

[ ... ]

>  	/* Replace AIBV address */
> +	size =3D BITS_TO_LONGS(msi_vecs) * sizeof(unsigned long);
> +	npages =3D DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE=
);
> +	if (npages > MAX_AIF_PAGES) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +
>  	idx =3D srcu_read_lock(&kvm->srcu);
>  	hva =3D gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
> -	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
> +	npinned =3D pin_user_pages_fast(hva, npages, FOLL_WRITE | FOLL_LONGTERM,
> +				      kzdev->aibv_pages);

[Severity: Medium]
If the AIBV crosses a page boundary that aligns with a KVM memslot boundary
where the adjacent memslot maps to a disjoint HVA region, won't this pin the
wrong host memory pages since we only translate the first GFN to an HVA?

[Severity: High]
This is a pre-existing issue, but if a guest repeatedly invokes the
registration ioctl for the same zPCI device, won't this leak pinned memory
pages by overwriting kzdev->aibv_pages without releasing the previous pages?

Similarly, when zdev->aibv is overwritten later in kvm_s390_pci_aif_enable(=
):

    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));

Does this leak the previous airq_iv structure and exhaust adapter interrupt
bit vectors?

>  	srcu_read_unlock(&kvm->srcu, idx);
> -	if (npages < 1) {
> +	if (npinned <=3D 0) {
>  		rc =3D -EIO;
>  		goto out;
>  	}
> -	aibv_page =3D pages[0];
> -	pcount++;
> +
> +	kzdev->aibv_npages =3D npinned;
> +	if (npinned < npages) {
> +		rc =3D -EIO;
> +		goto unpin1;
> +	}
> +
> +	pcount +=3D npinned;
> +	aibv_page =3D kzdev->aibv_pages[0];
>  	gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
>  	fib->fmt0.aibv =3D gaddr;

[Severity: Critical]
This is a pre-existing issue, but if npinned is greater than 1 and the user
pages are not physically contiguous, won't providing a single base physical
address (gaddr) cause hardware DMA accesses to linearly overflow into
unrelated physical memory adjacent to aibv_page?

Also, later in kvm_s390_pci_aif_enable():

    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));

Does phys_to_virt(fib->fmt0.aibv) similarly cause kernel virtual accesses
to corrupt unrelated physical memory if the pages are not contiguous?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D5
