Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 928E24908C9;
	Thu, 23 Jul 2026 18:49:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784832559; cv=none; b=B7sjDWstcN6c39Y7bLSlCM2/SRDGhCbxJztQyD87+8kNh/Tyhc/uVUgGFYSVCvylgUmGZsmZG8smGv2NiKpwxdDHx9yJFzc9DsIs11BLC9ZIYZOtKF5HVbObY1G4QtN1XDEkEMtHseqaelKlgCNMEdNwmt3+ap8CzS3DxnHGMog=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784832559; c=relaxed/simple;
	bh=LGbXfUuVhelByGwN9LIPplTsFG9DOvowif8ybpBkS4E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ku2LNYOVLcYSLiQ2eyvQMNGVaoosygQcSl81YcXjzw0F+5w1xtLFtmHcLrgRMVlxIEc68MU8kgBzKx0LW2B25C7L3U3V91/YdAPUlurSlSRwr1wjutAIFHvimKsYuIPe1Zf+YfwzHLyJilmi9/tFft9txS+XfJ3Yk3xNIHFPPCk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E9D321F000E9;
	Thu, 23 Jul 2026 18:49:05 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/6] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260723183440.3271-2-alifm@linux.ibm.com>
References: <20260723183440.3271-1-alifm@linux.ibm.com>
 <20260723183440.3271-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 18:49:03 +0000
Message-Id: <20260723184905.E9D321F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing bounds check for guest-provided Adapter Interrupt Bit =
Vector (AIBV) can lead to out-of-bounds DMA writes.
- [High] account_mem() and unaccount_mem() unconditionally leak a user_stru=
ct reference on every call.
- [High] The error path for kvm_zpci_set_airq() failure does not unwind all=
ocated resources and permanently blocks future enablement.
- [High] Failure paths for memory accounting and vector allocation silently=
 return success to userspace and leak process memory limits.
- [High] Missing NULL check on airq_iv_create() return value leads to kerne=
l panic.
--

--- Patch [1]: [PATCH v5 1/6] KVM: s390: pci: Reject adapter interrupt forw=
arding if already enabled ---
commit 94b69f5ee2abdd1f23118fdfcfcf6fd754f160c4
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Reject adapter interrupt forwarding if already enabled

The MPCIFC instruction doesn't allow registering adapter interrupts without
first unregistering. This patch rejects any request to enable interrupt
forwarding if it is already enabled for the zPCI device, fixing resource
leaks when the ioctl is called multiple times.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2e..d2a11cdf6941d 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  	if (zdev->gisa =3D=3D 0)
>  		return -EINVAL;
> =20
> +	/* AIF already enabled for the device */
> +	if (zdev->kzdev->fib.fmt0.aibv !=3D 0)
> +		return -EINVAL;
> +

[Severity: High]
This is a pre-existing issue, but does the error path for kvm_zpci_set_airq=
()
failure permanently block future enablement?

In kvm_s390_pci_aif_enable(), if kvm_zpci_set_airq(zdev) fails and returns
an error immediately, the state variables like zdev->kzdev->fib.fmt0.aibv
might be left non-zero, and pinned pages are not unpinned.

With the new check introduced in this patch, wouldn't any future attempts to
enable AIF hit this new aibv !=3D 0 check and fail with -EINVAL?

[Severity: High]
This is a pre-existing issue, but does account_mem() unconditionally leak a
user_struct reference?

Looking at account_mem():

arch/s390/kvm/pci.c:account_mem() {
    ...
    struct user_struct *user =3D get_uid(current_user());
    ...
    kzdev->user_account =3D user;
    ...
}

It appears get_uid() increments the reference count, but neither account_me=
m()
nor unaccount_mem() ever call free_uid() on success or failure, potentially
leading to a refcount overflow and memory leak when KVM_S390_PCI_AIF_ENABLE=
 is
called repeatedly. Is there a missing free_uid() call here?

[Severity: High]
This is a pre-existing issue, but do the failure paths for memory accounting
and vector allocation silently return success to userspace?

If account_mem() fails:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    if (account_mem(pcount))
        goto unpin2;
    ...
}

Or if airq_iv_alloc_bit() fails:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    bit =3D airq_iv_alloc_bit(aift->sbv);
    if (bit =3D=3D -1UL)
        goto unlock;
    ...
}

It looks like the code jumps to unpin2 or unlock without setting rc to an
error code, returning 0. Could this exhaust process memory limits while
silently failing to set up AIF completely?

[Severity: High]
This is a pre-existing issue, but is there a missing NULL check on the retu=
rn
value of airq_iv_create() that could lead to a kernel panic?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA | AIRQ_IV_BITLOCK =
| AIRQ_IV_GUESTVEC, phys_to_virt(fib->fmt0.aibv));
    ...
}

If airq_iv_create() returns NULL under memory pressure, it unconditionally
assigns NULL to zdev->aibv. Shortly after, kvm_zpci_set_airq() dereferences
this pointer:

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

Can this lead to a NULL pointer dereference?

[Severity: Critical]
This is a pre-existing issue, but is there a missing bounds check for the
guest-provided Adapter Interrupt Bit Vector (AIBV) that could lead to
out-of-bounds DMA writes?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
    npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
    ...
}

KVM explicitly pins only 1 page regardless of whether the requested bit vec=
tor
spans across a page boundary. If the guest provides a physical address very
close to the end of a page and the size of the bit vector requires more byt=
es,
could the hardware perform DMA writes spanning into the unpinned adjacent
page, potentially corrupting host memory?

>  	kvm =3D zdev->kzdev->kvm;
>  	msi_vecs =3D min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723183440.3271=
-1-alifm@linux.ibm.com?part=3D1
