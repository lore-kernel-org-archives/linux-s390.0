Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 78516421F18;
	Mon, 20 Jul 2026 18:42:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784572961; cv=none; b=HJDeQwRsBIXuFxcER+NX3uQDHsp/4NcWchrSPugKfXKYfhLU7A3UDyBhLcEug458ugEPk7CrK/fV4/c0qNjehUuUU0PDnZfrS7hWogaoH7fjV6012ZYqHOWyeujMPc7/NSKvnFOTndztMBPvXy9fEQitKPq/MfVw+vsd8IpxRgM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784572961; c=relaxed/simple;
	bh=xAQoyntkn6VoRiPL7K50TEeKKBvL7HhKwzubcmRZUGs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=csV/kdni5ahVdSsW06aYI9c8k6T70n0DVI9uvJ3suuobQebT6VjMAh6XFfOrua5hnDx3MrJvoQ95gDuC4nvVK5pwzetD0CQzx+yZetHQK6QogndqvVQIGb6Wjs3AdQ5SK4EJgMkgDto6QsDmo0KA89kSgKoSimyvRAZNZmQTJ4U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=m45HMh52; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="m45HMh52"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DA83B1F000E9;
	Mon, 20 Jul 2026 18:42:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784572959;
	bh=GsHL20C++90QvQcqwNRHg9z/K/51HkOPqP9GlFFcnMY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=m45HMh52VEU8c3HBQ3bucA7UehwkmVs4ab21ASk3zIA1BpvhYq3rsCPMHbf5egcn7
	 wPAXK6kIhDv16NkUwbqMaqabk0DX/kxfRMWTaZqan98V1zeMrUUIo0LsMVZ/E2dWnN
	 0AVAXiddvgPS+WaVDjmtEdyRuFcCjpGlmOqjbuP/PRVlvA4iFTvdd2f0iUhMgN6+Id
	 rblErJ8eq3tZwmsWFNxYMfhmPWCyZIgyYs6/zV5yOqiVduNAUHKlFXy03ljh/febhn
	 scZkXuO7XXqf8WKR3XGsBNudE9nzxAuN6P2yIV9nlWoWHT5P4HUPMFzsDwnbZb/r0L
	 IvlaY4kAJmniw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 4/4] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260720175819.1723-5-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
 <20260720175819.1723-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:42:38 +0000
Message-Id: <20260720184238.DA83B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] The `aisbo` (Adapter Interrupt Summary Bit Offset) provided by=
 userspace is not bounds-checked, leading to a host kernel memory out-of-bo=
unds write.
- [Critical] The `aibv` address and `noi` (number of interrupts) provided b=
y userspace are not bounds-checked, allowing hardware DMA to write out-of-b=
ounds into unpinned host physical memory.
- [High] Missing check for already-enabled AIF allows massive resource leak=
, accounting exhaustion, and subsequent Use-After-Free on double registrati=
on.
--

--- Patch [4]: [PATCH v3 4/4] KVM: s390: pci: Fix resource leak on IRQ regi=
stration failure ---
commit 54ecbcfac4858add9c2dd09fc30b8b84a8fbfca3
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix resource leak on IRQ registration failure

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 85f4fb5d36b38..d328bbd0dd997 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -337,19 +337,32 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pci_zpci_reg_aen() prevent
double registration?

If a malicious or buggy userspace repeatedly calls the KVM_S390_ZPCIOP_REG_=
AEN
ioctl on the same PCI device, kvm_s390_pci_aif_enable() unconditionally
allocates new resources:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    bit =3D airq_iv_alloc_bit(aift->sbv);
    ...
    zdev->aibv =3D airq_iv_create(...);
    ...
}

Because it doesn't check if AIF is already enabled, it blindly pins new host
pages and overwrites the old zdev->aibv and zdev->aisb pointers.

Could this permanently leak the previous allocations and repeatedly increme=
nt
the memory accounting on user->locked_vm until it exhausts the limit?


[Severity: Critical]
This is a pre-existing issue, but does this code bounds-check the DMA length
against the pinned page?

kvm_s390_pci_aif_enable() calculates the physical base address for the
interrupt bit vector using a user-supplied page offset:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
    fib->fmt0.aibv =3D gaddr;
    ...
}

This physical address is passed directly to the hardware via
kvm_zpci_set_airq().

If the guest places the base address near the end of the page (e.g., offset
4095) and zdev->max_msi requires 2+ bytes, will the hardware DMA cross the
single pinned page's boundary?

Could this silently corrupt adjacent unpinned host physical pages?


[Severity: Critical]
This isn't a bug introduced by this patch, but is the aisbo value from
userspace properly bounds-checked?

In kvm_s390_pci_aif_enable(), gaite->aisbo is set directly from the
user-controlled fib->fmt0.aisbo:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    if (fib->fmt0.sum =3D=3D 1) {
        gaite->aisbo =3D fib->fmt0.aisbo;
        gaite->aisb =3D virt_to_phys(page_address(aisb_page) +
                                   (fib->fmt0.aisb & ~PAGE_MASK));
    }
    ...
}

Upon an adapter interrupt, aen_host_forward() executes an out-of-bounds
bitwise write operation:

arch/s390/kvm/interrupt.c:aen_host_forward() {
    ...
    set_bit_inv(gaite->aisbo, phys_to_virt(gaite->aisb));
    ...
}

Since gaite->aisbo can be up to 255 (a 31-byte offset) and the guest offset
within the page can be up to 4095, the calculation (offset) + (aisbo / 8)
can reach 4126.

Could this cross the 4096-byte page boundary and perform a bitwise write up=
 to
31 bytes out-of-bounds into the adjacent physical page?

>  	aift->kzdev[zdev->aisb] =3D zdev->kzdev;
>  	spin_unlock_irq(&aift->gait_lock);
> =20
> -	/* Update guest FIB for re-issue */
> -	fib->fmt0.aisbo =3D zdev->aisb & 63;
> -	fib->fmt0.aisb =3D virt_to_phys(aift->sbv->vector) + (zdev->aisb / 64) =
* 8;
> -	fib->fmt0.isc =3D gisc;
> -
>  	/* Save some guest fib values in the host for later use */
> -	zdev->kzdev->fib.fmt0.isc =3D fib->fmt0.isc;
> +	zdev->kzdev->fib.fmt0.isc =3D gisc;
>  	zdev->kzdev->fib.fmt0.aibv =3D fib->fmt0.aibv;
> -	mutex_unlock(&aift->aift_lock);
> =20
>  	/* Issue the clp to setup the irq now */
>  	rc =3D kvm_zpci_set_airq(zdev);
> -	return rc;
> +	if (!rc) {
> +		mutex_unlock(&aift->aift_lock);
> +		return rc;
> +	}

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175819.1723=
-1-alifm@linux.ibm.com?part=3D4
