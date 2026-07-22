Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 127AE345EB5;
	Wed, 22 Jul 2026 17:25:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784741117; cv=none; b=soiH0erQXSGt4VWkjPnqZfqLWZmlHUb95OzzjVNpNFD6R+iuW+7mS2uj1jzOQJd+qyXb4o33xBSvfgHDUyO7YsNxfRR61Mg3WctR2R67Bfe0qlTlp+RSNv5MMw0yfb0N8IBvZMEVRVzXyunmXJoeK4NvfSYjK89uA40a6aEeS1o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784741117; c=relaxed/simple;
	bh=YQPXW1IPDnt0O4umgpEAmR9dV30/s4Wr10jIj4E/qJY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NipkpNIsWAhQpS+M4kxGvebPBnhc3Efn+5rK5qy9CzvvmEjndoPXqRsYtwRLoDmWir7M8Fgg1vM6BzUVTGHj8/vsHLAzgGJfa08WMB8D19zqZzv7LB3gdSIKo2MPlEHR17aNChJCNtdj4IKJgbNnDZoMPr0lu76JYArkYK4BdRM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Nc+hg0qj; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Nc+hg0qj"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4D2821F000E9;
	Wed, 22 Jul 2026 17:25:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784741114;
	bh=62J3wdTCZUd+0YmdAo8fIxO/wz52G/aiW1UTDj4ouMc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Nc+hg0qjTTGIxTwvmqgLpvVWmVtnrt9U6cSWilIdbNviUzMvkwII0wCOBJDdwWPSO
	 2Jzy2Irh41ze/ap9xW9HVJCenVGB+tbbAxHCzdhgwZC4/1ZSwNFKKjm69NK3dkQyyK
	 QKOvlqIOSIg0HVpvVYsHCXCz0xmOK58OaijRLJTJ1x+rgXOpKyWWWNN9rXvW8P8Fd1
	 h8f/79fHwgLKf5pWHS3SIKFHcwAkYG5ae2UbHxNZKkmMMZjpbH47QBoIc8OYOl3I+j
	 B4rGm096PNjkH9xaN6hjsb80tCOcuSl4CQPkdxIBU8TAzMKZCIw6rR+nfLD5vepFdG
	 piuDwlX7lviUw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 1/6] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260722170621.1686-2-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:25:13 +0000
Message-Id: <20260722172514.4D2821F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 6 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Missing NULL check for the result of `airq_iv_create()` in `kv=
m_s390_pci_aif_enable`.
- [Critical] Missing page boundary check for guest-provided AIBV address al=
lows an out-of-bounds write into host physical memory.
- [High] Reference count leak of `struct user_struct` in `account_mem` and =
`unaccount_mem`.
- [High] Memory un-accounting uses the current thread's credentials instead=
 of the original ones, causing counter underflows.
- [High] Complete cleanup bypass when `kvm_zpci_set_airq()` fails in `kvm_s=
390_pci_aif_enable`.
- [High] Use-After-Free of `zdev` structure in `kvm_s390_pci_zpci_op()` due=
 to lack of reference counting.
--

--- Patch [1]: [PATCH v4 1/6] KVM: s390: pci: Reject adapter interrupt forw=
arding if already enabled ---
commit 32372cae1fd4bf986fc6da1a214da1e85e7be6ad
Author: Farhan Ali <alifm@linux.ibm.com>
KVM: s390: pci: Reject adapter interrupt forwarding if already enabled

This commit prevents registering adapter interrupts via the MPCIFC instruct=
ion
if they are already registered. It avoids leaking resources by rejecting
requests to enable interrupt forwarding if it is already enabled for the zP=
CI
device.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
[ ... ]
>  	list_for_each_entry(kzdev, &kvm->arch.kzdev_list, entry) {
>  		if (kzdev->zdev->fh =3D=3D fh) {
>  			zdev =3D kzdev->zdev;
>  			break;
>  		}
>  	}
>  	spin_unlock(&kvm->arch.kzdev_list_lock);
>  	return zdev;

[Severity: High]
This isn't a bug introduced by this patch, but is the returned zdev pointer
vulnerable to a use-after-free?

The pointer is retrieved and returned without elevating the device's refere=
nce
count via zpci_zdev_get(). If a concurrent hot-unplug occurs, the PCI core
might remove and free the device.

If the KVM ioctl thread then executes mutex_lock(&zdev->kzdev_lock) in
kvm_s390_pci_zpci_op() on the freed memory, can it lead to memory corruption
or a host crash?

[ ... ]
>  	struct user_struct *user =3D get_uid(current_user());
[ ... ]
>  	return 0;

[Severity: High]
This is a pre-existing issue, but does account_mem() leak the user_struct
reference?

The get_uid(current_user()) call fetches the user and increments its refere=
nce
count. However, the function returns 0 without ever pairing this with a
free_uid(user) call on the success path.

Could an unprivileged guest repeatedly enable and disable AIF to leak kernel
memory continuously and eventually overflow the reference counter?

[ ... ]
>  	struct user_struct *user =3D get_uid(current_user());
[ ... ]
>  	if (current->mm)
>  		atomic64_sub(nr_pages, &current->mm->pinned_vm);

[Severity: High]
This isn't a bug introduced by this patch, but does unaccount_mem()
incorrectly rely on the current thread's credentials?

When kvm_s390_pci_unregister_kvm() is invoked by the PCI core during device
hot-unplug or VFIO unbind, it executes in a system worker thread, not the
original KVM vcpu thread. It then calls unaccount_mem().

Does unaccount_mem() use current_user() and current->mm of the worker thread
instead of the original ones? Could this corrupt the memory accounting limi=
ts
of random processes, cause locked_vm to underflow, and permanently leak the
locked memory quota of the original KVM process?

[ ... ]
> @@ -237,6 +237,10 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  	if (zdev->gisa =3D=3D 0)
>  		return -EINVAL;
> =20
> +	/* AIF already enabled for the device */
> +	if (zdev->kzdev->fib.fmt0.aibv !=3D 0)
> +		return -EINVAL;
> +
>  	kvm =3D zdev->kzdev->kvm;
>  	msi_vecs =3D min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
[ ... ]
>  	npages =3D pin_user_pages_fast(hva, 1, FOLL_WRITE | FOLL_LONGTERM, page=
s);
[ ... ]
>  	gaddr =3D page_to_phys(aibv_page) + (fib->fmt0.aibv & ~PAGE_MASK);
>  	fib->fmt0.aibv =3D gaddr;

[Severity: Critical]
This is a pre-existing issue, but does this calculation allow an out-of-bou=
nds
write into host physical memory?

Exactly one page is pinned, but the physical address is constructed by addi=
ng
an unaligned offset (fib->fmt0.aibv & ~PAGE_MASK). It doesn't appear to ver=
ify
if the required bit-vector size (msi_vecs bits) fits within the remaining
bounds of this single pinned page.

If a guest provides an address with a high intra-page offset, could the
hardware page-table walker or DMA overwrite the adjacent, unpinned physical
page and cause severe host memory corruption?

[ ... ]
>  	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
>  				    AIRQ_IV_BITLOCK |
>  				    AIRQ_IV_GUESTVEC,
>  				    phys_to_virt(fib->fmt0.aibv));
> =20
>  	spin_lock_irq(&aift->gait_lock);

[Severity: Critical]
This isn't a bug introduced by this patch, but does airq_iv_create() return=
 a
pointer that is used without a NULL check?

If airq_iv_create() dynamically allocates memory and returns NULL on failur=
e,
the pointer seems to be assigned to zdev->aibv and then dereferenced shortly
after in kvm_zpci_set_airq() via airq_iv_end().

Can an unprivileged guest trigger this path via KVM_S390_ZPCIOP_REG_AEN and
crash the host system if it is under memory pressure?

[ ... ]
>  	/* Issue the clp to setup the irq now */
>  	rc =3D kvm_zpci_set_airq(zdev);
>  	return rc;
> =20
>  unlock:
>  	mutex_unlock(&aift->aift_lock);

[Severity: High]
This is a pre-existing issue, but does the function bypass the cleanup block
if kvm_zpci_set_airq() fails?

If the hardware rejects the configuration and kvm_zpci_set_airq() returns an
error, the function appears to return rc directly instead of jumping to the
cleanup labels (unlock:, unpin2:, out:).

Could this leave pinned pages, memory accounting, GAIT entries, and airq_iv
structures leaked? Since zdev->kzdev->fib.fmt0.aibv is left with a non-zero
value, does this persistently break the device for the guest?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D1
