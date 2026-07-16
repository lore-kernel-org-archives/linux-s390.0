Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A04672571C7;
	Thu, 16 Jul 2026 18:06:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225217; cv=none; b=h0nwX8QSBNIWIKiqe06J1y4ykIphaVAQhFJH6cabJqPk5/YAz6irA4E0pVrd9ScZjaOoBAgSzSomrsfpi1EoEZdHrP3noT3ZKZ8r6qakzlout3asYedO0UnQj+VgXph5FPWndtQZlpd8ksD1JiQqBhrFGp9Iz1FgCl3yFXVPeA4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225217; c=relaxed/simple;
	bh=XQKs1ru7cmOD1MmTLBGz9IjfgtyNKVroxD57eg0v86I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ehdSMlAiFe9Tjisv9e1R4zUpEdvIMh7X1YxW1/v1JcDz6lmsgxdIdxZ2J69oW8sHDgkxgbmNDjMvIpoUFgEDUzxfiWFS+EhrdCtbfB0ur4bDQpzPnQN6Gjoy8WL2E0Jbb3KPgbMdUT2A1GzgZA/Ujzu8/j25JFfv+9L5dScIbNw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MQKq8axf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MQKq8axf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4A6D1F000E9;
	Thu, 16 Jul 2026 18:06:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225216;
	bh=bhY+USyPbFOvtz87c4eR2uauWUYVm3lvDJkgBv3KSTs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MQKq8axfn8sj5oGWtiDbSCHZkODB5zrsEEpN+DpKEgDeo33gUjVUw4PhkuZ8gU/Oa
	 K88DAlXI+LgQuGRRk1AetXrZV4To81jZSCHlia/nl1NXNi86FNI7YKROZy0ZIqO49O
	 2tl+5KE766uwRgVaLt7HBhy2yEU+lCgRHPnVk7RxSqaUp/7hA3VvPrizYM9OmS6RMS
	 u7JpB7zM17uO145JYdiDNxkztaPDd1aqUeQYQmlaXbM9iY3ngSMnnpl4vxfR4PFdWx
	 Y5u3BuVl37t9izj8QVQIPHbFfHcNyfoaBnvnYxsBYeLWgnqyMIgJJgpnCMwn45ijqO
	 XT3Hefv+frQ0A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 3/4] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260716175241.1039-4-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
 <20260716175241.1039-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:06:55 +0000
Message-Id: <20260716180655.E4A6D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Guest-controlled AIBV can cross a page boundary, leading to ho=
st memory corruption.
- [High] Missing cleanup when kvm_zpci_set_airq() fails in kvm_s390_pci_aif=
_enable().
- [High] Missing state check allows unbounded resource leaks via repeated K=
VM_S390_ZPCIOP_REG_AEN ioctls.
--

--- Patch [3]: [PATCH v2 3/4] KVM: s390: pci: Fix NULL dereference on AIBV =
allocation failure ---
commit 6cf8d654914206b2e0a5d8af6cb9a7272f96c280
Author: Farhan Ali <alifm@linux.ibm.com>
KVM: s390: pci: Fix NULL dereference on AIBV allocation failure

This commit adds a check to ensure airq_iv_create() does not return NULL,
preventing a subsequent NULL pointer dereference in kvm_zpci_set_airq().
If the allocation fails, it frees the previously allocated AISB bit and
returns -ENOMEM.

> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -240,6 +240,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  				   bool assist)
>  {

[Severity: High]
This isn't a bug introduced by this patch, but is there a missing state
check here before proceeding with the allocations?

If the ioctl for AEN registration is called repeatedly for the same PCI
device, this function appears to unconditionally pin new memory pages,
allocate new aift->sbv bits, and overwrite the previous pointers in zdev
without freeing them. Could this lead to exhausting aift->sbv bits and
leaking pinned memory pages?

>  	struct page *pages[1], *aibv_page, *aisb_page =3D NULL;
>  	unsigned int msi_vecs, idx;

[ ... ]

>  	/* Replace AIBV address */
>  	idx =3D srcu_read_lock(&kvm->srcu);
>  	hva =3D gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
>  	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
>  	srcu_read_unlock(&kvm->srcu, idx);
>  	if (npages < 1) {
>  		rc =3D -EIO;
>  		goto out;
>  	}
>  	aibv_page =3D pages[0];
>  	pcount++;
>  	gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
>  	fib->fmt0.aibv =3D gaddr;

[Severity: Critical]
This is a pre-existing issue, but does this calculation safely handle the
case where the bit vector crosses a page boundary?

The code pins exactly one page, but the interrupt bit vector size depends
on msi_vecs. If fib->fmt0.aibv is provided near the end of a page
boundary (for example, offset 4088) and msi_vecs requires more bytes than
what is left in the page, will the hardware and host software read or write
out-of-bounds into the adjacent unmapped physical page?

[ ... ]

> @@ -346,6 +351,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	/* Save some guest fib values in the host for later use */
>  	zdev->kzdev->fib.fmt0.isc =3D fib->fmt0.isc;
>  	zdev->kzdev->fib.fmt0.aibv =3D fib->fmt0.aibv;
> =20
>  	/* Issue the clp to setup the irq now */
>  	rc =3D kvm_zpci_set_airq(zdev);
>  	return rc;

[Severity: High]
This isn't a bug introduced by this patch, but does returning directly
here bypass the required cleanup logic?

If kvm_zpci_set_airq() fails, returning rc directly means we skip the
free_aisb and unlock labels. Could this leave the pages pinned, the
accounted memory incremented, and the aift->sbv bits allocated, causing
these resources to be permanently lost?

> =20
> +free_aisb:
> +	airq_iv_free_bit(aift->sbv, zdev->aisb);
> +	zdev->aisb =3D 0;
>  unlock:
>  	if (pcount > 0)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716175241.1039=
-1-alifm@linux.ibm.com?part=3D3
