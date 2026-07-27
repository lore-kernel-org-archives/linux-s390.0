Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 063B33ED5A1;
	Mon, 27 Jul 2026 10:08:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785146926; cv=none; b=flzTIEFAmNTj8hw7bOhtFvVnm1vW1RMO5vsPvteGOSmoqED+srqNgWQP38yeP+cC3UB1Vz296slB1vFVi0NxUWm8a2z8HQGafNKvooh0oqwWvLYcJzo2s8eh22t57em2isXUPsiLtlM/0IsGGG9dWC1/K6tDd+SLIK1jIKR1EQA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785146926; c=relaxed/simple;
	bh=meSog5GXpUo3xM3D3ZSeoSapznw5JFGDYF/UeK+be9g=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qmRaoVZDSJzFwGkG3khHvlXgVSEPynwiZqgKSiyDHdoltIn7uGU/eTmvtQpFw87XUF6B1h+AkKyc808QH2IeClsIDNKGK1TW3J4xmCDJPFeLxJHkrr8RPcpAWv6rPAQSM7FBxMzyNVB3Sq3x7IIolAB2aYbCUyDoHX/q3bEX36s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=kvDkGCdA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="kvDkGCdA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 435BB1F000E9;
	Mon, 27 Jul 2026 10:08:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785146924;
	bh=XwSvoa/CtstXYwA7wL1QhU1PyeYp/lQgY1GnMzThURo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=kvDkGCdAGlQqn85WsTNSFs9WovxWL1pGf+gNeUZR8WrwruhPQDAwQYefE4KCvSza0
	 25eoMVODQBFQozBWPoChlCsr6w9V7AoDM6HIuPPDJScuhc35muoCW7Ju2yt9JrJ5PO
	 chqjVg2/LFyhwIE9v5LasDIk8l5JQt85MkyZjquA0BRm7TYHOBzaarz7y8CtAhTBwe
	 b9ZHd646EEdJV4CNRSlS6ndjc+InQCplQ+QIMXXZItlJnDgDua0KEdSaUUH15UxKxH
	 ra1jOWsmEiKf3m2UmcZXrZwdJ2dmIJ3YBDL4I9YxW2vxnVDZN0AQJDesR4FuFHQqM9
	 Gu0vbZAQHbz0Q==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF
 enable failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@de.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727095359.107671-2-borntraeger@de.ibm.com>
References: <20260727095359.107671-1-borntraeger@de.ibm.com>
 <20260727095359.107671-2-borntraeger@de.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:08:43 +0000
Message-Id: <20260727100844.435BB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Repeated calls to the `KVM_S390_ZPCIOP_REG_AEN` ioctl leak res=
ources and cause Use-After-Free.
- [High] `account_mem` and `unaccount_mem` leak `struct user_struct` refere=
nce counts and use wrong accounting context.
- [High] `kvm_s390_pci_aif_enable` silently fails on memory accounting or b=
it allocation failure.
- [High] Resource leak on `kvm_zpci_set_airq` hardware setup failure.
- [High] Missing memory unaccounting on bit allocation failure.
- [High] Unchecked `airq_iv_create()` return value leads to kernel panic.
--

--- Patch [1]: [GIT PULL 1/5] KVM: s390: pci: Fix GISC refcount leak on AIF=
 enable failure ---
commit 2781de8fecc1ddfd2641c260ff20fd3cfb663715
Author: Haoxiang Li <haoxiang_li2024@163.com>
Subject: KVM: s390: pci: Fix GISC refcount leak on AIF enable failure

This commit fixes a reference count leak of the guest ISC in the error
handling path of kvm_s390_pci_aif_enable(). It ensures that if setup fails,
kvm_s390_gisc_unregister() is called to properly release the GISC reference.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..686113be05309 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -328,6 +328,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  unpin1:
>  	unpin_user_page(aibv_page);
>  out:
> +	kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);
>  	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but does a failure in kvm_zpci_set_airq() leak
all previously allocated resources?

Looking at the lines just above this diff in kvm_s390_pci_aif_enable():

    rc =3D kvm_zpci_set_airq(zdev);
    return rc;

unlock:
    mutex_unlock(&aift->aift_lock);

Returning rc directly bypasses the unlock, unpin2, unpin1, and out labels.
This skips all resource cleanup, including the new kvm_s390_gisc_unregister=
()
call added by this patch.


[Severity: High]
This isn't a bug introduced by this patch, but is there a missing call to
unaccount_mem() in the error path?

Looking at the error handling in kvm_s390_pci_aif_enable():

unlock:
    mutex_unlock(&aift->aift_lock);
unpin2:

If airq_iv_alloc_bit() fails and jumps to unlock, it unwinds the pinned pag=
es
but leaves the memory accounted for, potentially leaking the locked_vm limi=
t.


[Severity: High]
This is a pre-existing issue, but do these error paths return 0 to userspace
instead of an error code?

In kvm_s390_pci_aif_enable(), when memory accounting or bit allocation fail=
s:

    if (account_mem(pcount))
        goto unpin2;
    ...
    bit =3D airq_iv_alloc_bit(aift->sbv);
    if (bit =3D=3D -1UL)
        goto unlock;

When jumping to the cleanup labels, rc does not appear to be set to a negat=
ive
value like -ENOMEM or -ENOSPC. Since rc is initialized to 0, this would
silently mask the internal failure.


[Severity: Critical]
This isn't a bug introduced by this patch, but what happens if userspace ca=
lls
the KVM_S390_ZPCIOP_REG_AEN ioctl multiple times?

In kvm_s390_pci_aif_enable():

    zdev->aisb =3D bit; /* store the summary bit number */
    zdev->aibv =3D airq_iv_create(...);
    ...
    aift->kzdev[zdev->aisb] =3D zdev->kzdev;

It looks like this blindly allocates new resources and overwrites zdev->aibv
and zdev->aisb without cleaning up any previous allocations. The old aisb i=
ndex
remains populated in aift->kzdev, which might lead to a use-after-free when
the device is unregistered.


[Severity: High]
This is a pre-existing issue, but can airq_iv_create() return NULL here?

In kvm_s390_pci_aif_enable():

    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA | ...

If it fails due to memory pressure, it seems zdev->aibv becomes NULL. Later,
zdev is passed to kvm_zpci_set_airq() which does this:

    fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    fib.fmt0.aibv =3D virt_to_phys(zdev->aibv->vector);

This unconditionally dereferences the unchecked pointer, potentially causing
a crash.


[Severity: High]
This isn't a bug introduced by this patch, but do account_mem() and
unaccount_mem() leak the user_struct reference?

arch/s390/kvm/pci.c:account_mem() {
    ...
    struct user_struct *user =3D get_uid(current_user());
    ...
}

I see get_uid() increments the refcount, but there doesn't appear to be a
matching free_uid() on success or error.

Additionally, in unaccount_mem():

arch/s390/kvm/pci.c:unaccount_mem() {
    ...
    struct user_struct *user =3D get_uid(current_user());
    ...
}

Calling current_user() might un-account from a different process or kernel
thread if deregistration happens asynchronously.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095359.1076=
71-2-borntraeger@de.ibm.com?part=3D1
