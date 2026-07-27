Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 092C13F5BE3;
	Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146949; cv=none; b=BIl8vHNkqeNZ0LSMb+MLBtsPNfskpZT+xlQFAyfn7KOin61UNttXy7VkHYvriTLYnughBV/46pnEcAcY4GdARzgRT8WHS3tsU635mSSGUlchHMG7bP6snnww4j8VVstRnTnm500kF/X1oyVOdHpdOll8eM1zsg79+82bdeP+SIM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146949; c=relaxed/simple;
	bh=aPYVcYBSugq0wZSTaHUVJjEGu14XmSSGAQEev360Brk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XbZ3mj+M7oekJ8kcaYKPuhUxsYS7Ic3ifU8sSauKYRvTNQY4BjlxfwUq48IYrkcllpBmpBaLqJKXfbRt78Yi52Xz9P91G1Jp0DQRh5jydjfYewGv6sj8/eouktqvnExFlNv7Cy4z5X7XSw/dN+dP7UqQHDAfEcuo0Qw+PbX5Wj0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mKBYbTDh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mKBYbTDh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8414B1F00A3A;
	Mon, 27 Jul 2026 10:09:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146947;
	bh=Ns1zqF85rjZgy8bnE+SltCak+Dkj71WiF0NTXVauUSU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mKBYbTDh1F/nPZOz/TGofGokA4ZzfUmWTg9bUid4tNK6f+FkKmbZsQ+ZJgFlKsuSR
	 D2jR9/D1d0as6ApBlw1bJeN0o2ZLWzlKq8cQ9Rf63Ol1Tcd6SDpDuo+r4bLYcQM+a8
	 aRB8xoK5qBrQiR8XJoIN/FEZfVuVtWA5IXebhzayrr6AJKIcHok1MAX+8gw+HPv8z2
	 GyQFYzYy1+1k1VyWCWG89mkwMBUZRSpQXDCzFqj2B6URGCgwONQUg/qZnK+KZm6lij
	 FcNX3N088Ya0qa7vO0tDlu+HHt/kYYCZKi1HyGBphuxecaiqCg3901Z5cFjrx7rUp6
	 fAo4/QN/rd66A==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable
 without AISB
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260727095359.107671-6-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
 <20260727095359.107671-6-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:09:06 +0000
Message-Id: <20260727100907.8414B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing page boundary check allows unprivileged guest to trigg=
er out-of-bounds hardware DMA writes.
- [High] Missing error code assignments cause silent failures and memory ac=
counting leaks.
- [High] Missing NULL check on the return value of airq_iv_create() leads t=
o an unconditional host kernel panic.
- [High] Repeatedly enabling AIF on an already-registered device causes sta=
te corruption and massive resource leaks.
- [High] Kernel resources are not rolled back if the PCI hardware configura=
tion (kvm_zpci_set_airq) fails.
- [High] account_mem() and unaccount_mem() perpetually leak user_struct ref=
erence counts.
- [High] The guest ISC reference count leaks on error paths, leading to a 3=
2-bit integer overflow and Denial of Service.
--

--- Patch [1]: [GIT PULL 5/5] KVM: s390: pci: Fix handling of AIF enable wi=
thout AISB ---
commit d999e1412ad1f5b8348f25eacbb5dfb9be451bb1
Author: Matthew Rosato <mjrosato@linux.ibm.com>

KVM: s390: pci: Fix handling of AIF enable without AISB
   =20
This commit modifies the KVM s390 PCI interrupt forwarding (AIF) enablement=
.=20
It ensures that when a guest registers IRQs without a summary bit (AISB), t=
he=20
guest AISB location is explicitly set to 0 rather than a potentially invali=
d=20
physical address derived from a NULL pointer.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..dc748cde4703b 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -300,9 +300,14 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
> =20
>  	gaite->gisc =3D fib->fmt0.isc;
>  	gaite->count++;
> -	gaite->aisbo =3D fib->fmt0.aisbo;
> -	gaite->aisb =3D virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
> -							      ~PAGE_MASK));
> +	if (fib->fmt0.sum =3D=3D 1) {
> +		gaite->aisbo =3D fib->fmt0.aisbo;
> +		gaite->aisb =3D virt_to_phys(page_address(aisb_page) +
> +					   (fib->fmt0.aisb & ~PAGE_MASK));
> +	} else {
> +		gaite->aisbo =3D 0;
> +		gaite->aisb =3D 0;
> +	}
>  	aift->kzdev[zdev->aisb] =3D zdev->kzdev;
>  	spin_unlock_irq(&aift->gait_lock);

[Severity: Critical]
This is a pre-existing issue, but does this lack of boundary checking allow
out-of-bounds hardware DMA writes?

Looking at kvm_s390_pci_aif_enable(), the code pins exactly one page for the
guest's Adapter Interruption Broadcast Vector (AIBV):

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
    ...
	gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
    ...
}

If the guest supplies an offset near the end of the page and a large number
of MSI vectors, could the hardware DMA overflow the single pinned page and
corrupt adjacent unpinned physical memory?

[Severity: High]
This is a pre-existing issue, but does this error path leak the guest ISC
reference count?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	gisc =3D kvm_s390_gisc_register(kvm, fib->fmt0.isc);
	if (gisc < 0)
		return gisc;
    ...
	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, pages);
	srcu_read_unlock(&kvm->srcu, idx);
	if (npages < 1) {
		rc =3D -EIO;
		goto out;
	}
    ...
out:
	return rc;
}

If pin_user_pages_fast() fails, the function branches to the out label but
appears to omit calling kvm_s390_gisc_unregister(). Could this lead to a
32-bit integer overflow on gi->alert.ref_count[gisc]?

[Severity: High]
This is a pre-existing issue, but do these error paths silently fail and le=
ak
memory accounting limits?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	if (account_mem(pcount))
		goto unpin2;
    ...
	bit =3D airq_iv_alloc_bit(aift->sbv);
	if (bit =3D=3D -1UL)
		goto unlock;
    ...
}

If account_mem() or airq_iv_alloc_bit() fail, the function jumps to cleanup
labels but returns rc, which is initialized to 0.=20

Additionally, in the airq_iv_alloc_bit() error path, unaccount_mem() appears
to be missing entirely. Does this silently leak the locked_vm memory
accounting?

[Severity: High]
This is a pre-existing issue, but what prevents a guest from repeatedly cal=
ling
KVM_S390_ZPCIOP_REG_AEN for the same device?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aisb =3D bit; /* store the summary bit number */
	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
    ...
}

If userspace calls KVM_S390_ZPCIOP_REG_AEN multiple times for the same PCI
device, the function appears to lack a check verifying if zdev->aibv is
already set.=20

Could this blindly allocate and pin new resources while unconditionally
overwriting the existing pointers, permanently leaking the previously
pinned pages and airq_iv structures?

[Severity: High]
This is a pre-existing issue, but does this code risk a NULL pointer
dereference if airq_iv_create() fails?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
				    AIRQ_IV_BITLOCK |
				    AIRQ_IV_GUESTVEC,
				    phys_to_virt(fib->fmt0.aibv));
    ...
}

If airq_iv_create() returns NULL in out-of-memory conditions, the result is
assigned to zdev->aibv without validation.=20

Could this lead to an unconditional host kernel panic when
kvm_zpci_set_airq() subsequently dereferences it via airq_iv_end(zdev->aibv=
)?

[Severity: High]
This is a pre-existing issue, but are kernel resources permanently leaked if
the hardware configuration fails?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Issue the clp to setup the irq now */
	rc =3D kvm_zpci_set_airq(zdev);
	return rc;

unlock:
    ...
}

If kvm_zpci_set_airq() returns an error because the hardware rejects the CLP
instruction, the function returns directly. Should it use the cleanup labels
to avoid leaking pinned guest memory pages and GISC registrations?

[Severity: High]
This is a pre-existing issue, but do account_mem() and unaccount_mem()
perpetually leak user_struct references?

arch/s390/kvm/pci.c:account_mem() {
    ...
	struct user_struct *user =3D get_uid(current_user());
    ...
}

Both functions call get_uid(current_user()), which increments the reference
count. However, neither function appears to ever call free_uid() to release
the acquired reference.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095359.1076=
71-6-borntraeger@de.ibm.com?part=3D1
