Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 370D034BA28;
	Mon, 13 Jul 2026 17:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783965050; cv=none; b=dToD/sP+k1moDtQLLw4CSvuBI3kx9bLOJoRn6MdDuq3RRo+85K1+mRo6tVBeWR+8OO4JO5kPiOF4MhL5j0PboUgeg93LiuItnf0XEGuD73sK4RfAgQf8l0S1ujcnqnV0VFk4WSgwa8IBU3A/TtvxyMGUX+zsNP6MyYmhFD9EmDA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783965050; c=relaxed/simple;
	bh=J9Cd9JsbYBociKxi0u5ZcYhmzbsBtj0CtwT/D54nH1s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Bik2oFe2C4YzcpBwU+RmVQxMfR2sMSV18i7lxa8RXE8PfHJmN4+f4nAAzqmYqgpv3HQu9WE6Aa6Tao9Y6DbIO157/4VIWReiqwre4oOsofzF8SqXVR5fAO4smiBTXxhrv6KyChcC/VFhP8vutFSmGQc6nEWJ7gd4yivP/OBLEvU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iF+fg5PY; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iF+fg5PY"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7614B1F00A3A;
	Mon, 13 Jul 2026 17:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783965048;
	bh=wOcDRDYckEc0sa0JsJPk9/wtlEtj3p53Dfwp+MfkMWw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iF+fg5PY0/MPTHTeWiWAw/jENs5Pqnt3gajxEkmq6G6QrsY4oFBfBE614TeszZ9Q5
	 Q2LG8y8pqXqo6Y7NXvFGi4hOz0ynj/J7nk2Iw0qH/9PonqxUIlrX4QRCilNBEN2cEv
	 zAowiOU1cce5BDR0upezjT2Tw2o2MUNdS6RSA9BQtYRkbRloxDZ9U6eg4cDGGRb8Dt
	 cvG/GuZmazje99hoXqg0ItfCzHL7KCHLab6hQRfFF17g2ZZXA6vOllURZKLpGB3sjr
	 NWB2/pKn8GEsJZBoYCfjnGQh9r+HRFUj9tcnhoABJpzQtIXhcuppIbGUvUdh1HdkFi
	 3JWI53tJROchQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 3/5] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260713172600.1284-4-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:50:47 +0000
Message-Id: <20260713175048.7614B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Hardware DMA out-of-bounds write due to missing page boundary =
validation for the AIBV.
- [High] Unbounded resource leak and potential Use-After-Free on repeated K=
VM_S390_ZPCIOP_REG_AEN calls.
- [High] Context mismatch in memory accounting leads to leakage or underflo=
w during asynchronous teardown.
--

--- Patch [3]: [PATCH v1 3/5] KVM: s390: pci: Fix NULL dereference on AIBV =
allocation failure ---
commit efdcaa0691c30263d9d4c19ea7c5478853d5a3ab
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix NULL dereference on AIBV allocation failure

The commit adds a NULL check for the return value of airq_iv_create() to
prevent a potential NULL pointer dereference. If the allocation fails, it
now properly frees the previously allocated AISB bit before returning an
error.

> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -299,6 +299,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,

[Severity: Critical]
This isn't a regression introduced by this patch, but is there a missing pa=
ge
boundary validation for the AIBV that could lead to an out-of-bounds DMA
write?

If the guest provides an unaligned guest physical address for the AIBV that
crosses a page boundary, does the pinning logic fail to account for vector
lengths spanning across boundaries?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
    ...
}

Could the hardware firmware sequentially DMA interrupt data across the page
boundary into an unpinned host physical page?

>  				    AIRQ_IV_GUESTVEC,
>  				    phys_to_virt(fib->fmt0.aibv));
> =20
> +	if (!zdev->aibv) {
> +		rc =3D -ENOMEM;
> +		goto free_aisb;
> +	}
> +

[Severity: High]
This isn't a regression introduced by this patch, but does this path leak
the airq_iv bit vectors and cause a potential use-after-free?

If a user-space process repeatedly triggers the KVM_S390_ZPCIOP_REG_AEN ioc=
tl,
does this code blindly overwrite zdev->aisb and zdev->aibv without clearing
the global aift->kzdev[old_aisb] reference?

If the device is later deregistered, only the newest AISB index would be
cleared. If a hardware interrupt triggers for the orphaned AISB bit, could
aen_host_forward() access the freed kzdev structure?

>  	spin_lock_irq(&aift->gait_lock);
>  	gaite =3D aift->gait + zdev->aisb;
> =20
> @@ -335,6 +340,9 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	rc =3D kvm_zpci_set_airq(zdev);
>  	return rc;
> =20
> +free_aisb:
> +	airq_iv_free_bit(aift->sbv, zdev->aisb);
> +	zdev->aisb =3D 0;
>  unlock:
>  	if (pcount > 0)
>  		unaccount_mem(pcount);

[Severity: High]
This isn't a regression introduced by this patch, but does unaccount_mem()
incorrectly rely on current->mm in asynchronous teardown contexts?

If unaccount_mem() is called asynchronously (for example, during a VFIO
device removal or sysfs unbind):

arch/s390/kvm/pci.c:unaccount_mem() {
    struct user_struct *user =3D get_uid(current_user());
    ...
    if (current->mm)
        atomic64_sub(nr_pages, &current->mm->pinned_vm);
    ...
}

Would current point to the worker thread rather than the QEMU process that
originally pinned the memory, leading to an underflow of the wrong memory
quotas and leaking the original quotas?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D3
