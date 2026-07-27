Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7AB8B3E63A4;
	Mon, 27 Jul 2026 10:18:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147493; cv=none; b=LsxZE1VL+3EmWeLlEiRUwHP+qNycSdfkCagFcPkN8gnFh65AXyd3geZucSVH+1sWtdsotLPfrFtf7g7WSo/kmAgtv/94Yb6xHQa1BaTHdcsV3AoPKCj7n7YNs1UvoO0a/lXmTwK8dkxi6pEx7h+XkCJLsc13ZL+/rLv8tbeW7qM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147493; c=relaxed/simple;
	bh=pyNteccbh3cEGG21E1ZII2mb7J5Rkl3iLr9uhS6PJZ8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EWr4lsSv/NS5mivv0S+ukOWlzV7z94btanc26eFcyW28QjbNqHBuWYVf2I6e99qWIJBjwWJjce5EkhBdhKLTztcQRE3AAwtyoHzfILbXWe2xQKMdGgggJRfVPhUZx985p5qABBK4Kj5v6VerPjRUcjyvmjAdy1rV0S4qZWocUWg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyvmzfMZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyvmzfMZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A1B21F000E9;
	Mon, 27 Jul 2026 10:18:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147492;
	bh=/6Qi63aAcgPRh84ELrxQO66GC90D0IO84z7eQpViPlA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyvmzfMZVEL8LlQDof5Hh7zR7V3SJZLb+FFP8/HTbvPLOU0vYx4XprPjcUDxA53Oa
	 bp22xoeo96ZD0UJcj94ahWX7KYjjVlKl60ngmxRpK6QHWlGzEdkS3ldgOUj6DQ6iyT
	 IdnPLwFi2OdORn+S+xKrya3xy+6YZaBynmgAyYeA2Av9UwYkH27uG7zRGIUeL3sKih
	 fAsHsZgW0XUVaXKpBbKG7eo2AIgkQBGEFctMU8vxgeHGxRQ3l3ZKoaxiNAv5CR54ea
	 Z9jt1/qmziBE2G3CNDCIn2fHBdy2TeOfCFUbuFm2dMgJ1p6G+9sdMGMMpqdwTDhQv1
	 KpLAepde6gDhw==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 6/7] KVM: s390: pci: Validate AIBV and AISB before
 pinning guest pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727095720.9150-7-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
 <20260727095720.9150-7-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:18:10 +0000
Message-Id: <20260727101811.1A1B21F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing NULL check for `aisb_page` leads to host memory corrup=
tion via a garbage physical address in `gaite->aisb`.
- [Critical] Missing validation of the user-provided `aisbo` allows an out-=
of-bounds bit flip in host physical memory.
- [High] Missing software state rollback if hardware configuration fails in=
 `kvm_zpci_set_airq()`.
- [High] Missing `kvm_s390_gisc_unregister()` on error paths leaks GISC ref=
erence counts.
- [High] No check for already enabled AEN allows guests to leak host resour=
ces via repeated ioctl calls.
- [High] Failures in `account_mem()` and `airq_iv_alloc_bit()` return a fal=
se success to userspace and leak memory accounting.
- [High] Missing NULL check for `airq_iv_create()` return value leads to ho=
st kernel panic.
--

--- Patch [1]: [GIT PULL 6/7] KVM: s390: pci: Validate AIBV and AISB before=
 pinning guest pages ---
commit b6f9e911464048e2480c6dd2f890285a31bef43d
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Validate AIBV and AISB before pinning guest pages

This commit adds validation checks for the AIBV and AISB addresses provided
by the guest during PCI interrupt forwarding setup. It ensures that the AIBV
does not span more than one page and that the AISB is doubleword aligned.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..efeee49e18ea3 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -246,6 +246,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  		return gisc;
> =20
>  	/* Replace AIBV address */
> +	size =3D BITS_TO_LONGS(msi_vecs + fib->fmt0.aibvo) * sizeof(unsigned lo=
ng);
> +	npages =3D DIV_ROUND_UP((fib->fmt0.aibv & ~PAGE_MASK) + size, PAGE_SIZE=
);
> +	/* AIBV cannot span more than 1 page */
> +	if (npages > 1) {
> +		rc =3D -EINVAL;
> +		goto out;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does the new error path leak
the GISC reference count?

If npages > 1 triggers, the code jumps to out without calling
kvm_s390_gisc_unregister(), which was registered earlier:

	gisc =3D kvm_s390_gisc_register(kvm, fib->fmt0.isc);
	if (gisc < 0)
		return gisc;

Can a guest repeatedly pass spanning addresses to overflow the reference co=
unter?

>  	idx =3D srcu_read_lock(&kvm->srcu);
>  	hva =3D gfn_to_hva(kvm, gpa_to_gfn((gpa_t)fib->fmt0.aibv));
>  	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
> @@ -261,6 +269,12 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
> =20
>  	/* Pin the guest AISB if one was specified */
>  	if (fib->fmt0.sum =3D=3D 1) {
> +		/* AISB must be dword aligned */
> +		if (fib->fmt0.aisb & 0x7) {
> +			rc =3D -EINVAL;
> +			goto unpin1;
> +		}
> +

[Severity: High]
This is a pre-existing issue, but this alignment check also jumps past the=
=20
required unregistration. Should unpin1 or a similar cleanup label handle
the GISC unregistration?


[Severity: High]
This is a pre-existing issue, but I noticed there doesn't seem to be a chec=
k=20
to see if AEN is already enabled on the device.

If a guest repeatedly registers AEN without deregistering first, could the
function allocate new airq_iv structures, pin new guest memory pages, and
overwrite the tracking pointers (zdev->aibv, zdev->aisb), leading to an
exhaustion of host resources?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
				    AIRQ_IV_BITLOCK |
				    AIRQ_IV_GUESTVEC,
				    phys_to_virt(fib->fmt0.aibv));
    ...
}


[Severity: Critical]
This is a pre-existing issue, but if a guest registers AEN without requesti=
ng a
summary bit (fib->fmt0.sum =3D=3D 0), does aisb_page remain NULL?

If so, later in kvm_s390_pci_aif_enable() we execute:

	gaite->aisb =3D virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
							      ~PAGE_MASK));

This appears to perform pointer arithmetic on page_address(NULL), yielding a
garbage physical address. When the device issues an interrupt, could KVM's
aen_host_forward() see that gaite->aisb !=3D 0 and perform a bit flip on th=
at
garbage address, directly corrupting host memory?


[Severity: High]
This isn't a bug introduced by this patch, but does the error handling for
account_mem() and airq_iv_alloc_bit() return a false success and leak
memory accounting?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Account for pinned pages, roll back on failure */
	if (account_mem(pcount))
		goto unpin2;
    ...
	bit =3D airq_iv_alloc_bit(aift->sbv);
	if (bit =3D=3D -1UL)
		goto unlock;
    ...
}

In both cases, rc seems to remain unassigned (0). Also, it appears the
unlock error path does not call unaccount_mem(pcount).


[Severity: High]
This is a pre-existing issue, but what happens if airq_iv_create() fails and
returns NULL?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aibv =3D airq_iv_create(msi_vecs, ...);
    ...
}

It seems zdev->aibv is assigned without a check, and subsequently
kvm_zpci_set_airq() will unconditionally dereference it:

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
	fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

Could this lead to a NULL pointer dereference panic under host memory press=
ure?


[Severity: Critical]
This is a pre-existing issue, but is the user-provided aisbo validated
against a 64-bit bounds check?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	gaite->aisbo =3D fib->fmt0.aisbo;
    ...
}

If aisbo is unvalidated and can be up to 255, could KVM's software handler
blindly execute a bit flip crossing into unpinned host physical memory?

arch/s390/kvm/interrupt.c:aen_host_forward() {
    ...
		set_bit_inv(gaite->aisbo, phys_to_virt(gaite->aisb));
    ...
}


[Severity: High]
This is a pre-existing issue, but if kvm_zpci_set_airq() fails at the very
end of the function, does it bypass the software rollback?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Issue the clp to setup the irq now */
	rc =3D kvm_zpci_set_airq(zdev);
	return rc;

unlock:
    ...
}

It looks like it returns immediately instead of executing the error cleanup
labels (unpin1, unpin2, unlock), leaving resources leaked.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095720.9150=
-7-borntraeger@linux.ibm.com?part=3D1
