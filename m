Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 27A0D388378;
	Wed, 24 Jun 2026 06:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1782282889; cv=none; b=Qj4zPN3Sgrh4aD+SesESYqo/rkjqdONAKPJNNleuerjUIs9dI6+WuIcSai8CVHmQdWBnWEwnGkFaiQ2vlhRYoilR//lCFMtzHAPmTro9+k1ltoXMpXNsMjJ4vRVNVITqphHLG0TDWm5htdRvCyC6/ajsrUhanz2ze3tOfEL6fEQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1782282889; c=relaxed/simple;
	bh=vAgk2CQmNZqiOk7byUCYZuuUyfD14eX7WCVxHQwPf+I=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=D9ulq636btwEnhrbtJl17tbY6L30DZZNYwRX6TwTcDkUbugvN7mnsDBfvPtlCKGAw6VkkAxIjTSDBv5T8UjpbP3FuX63Cf9khPbFdI8XbQfE8VVx2wBfq4QIDSGWIT5KlDlu6nxhV8RLcmqyK26yCXEduoHp3Zjx4UN1uY0JYS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LTEVJK2U; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LTEVJK2U"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85DF51F000E9;
	Wed, 24 Jun 2026 06:34:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1782282887;
	bh=wMyoWgaORHUARzaraGZFwZ7ri0xlUF17vM7eoyaGNg8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LTEVJK2U3qsRE9fF8mr3yd9NDKX8qsNnHVSyvIhFohmWMIfNXAgjbrHEGlcPxD3kx
	 pV88Eq5WYOAd5RN2kfujmpv01qHH9ritznBOpl8xoQZ8EjljRnn/oPKt8sVwpQHEm9
	 TjEtcNw9XnY6Djd16nblo4alXKuVJ8jrdT9LgX2XR1ud5Ag50FPy5siiun3UDeKtIy
	 GyQNfU1Y3U6vC3ZOyBumUKNPjJWWDAtWsstQZUB9H6pRQkxmDWa3Ep+gL4niwhvX7r
	 QZoBoL+/qjMlCy2hT8UImKOLOe7087D4tDhz6pBFKFZAowW1aGl3ttACc2VFUkaCL9
	 CvuBKWMTks1RA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2] KVM: s390: pci: Fix GISC refcount leak on AIF enable
 failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Haoxiang Li" <haoxiang_li2024@163.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260624061910.2794734-1-haoxiang_li2024@163.com>
References: <20260624061910.2794734-1-haoxiang_li2024@163.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 24 Jun 2026 06:34:47 +0000
Message-Id: <20260624063447.85DF51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 7 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] If userspace disables summary notifications (`sb =3D=3D 0`), a=
 bogus physical address derived from a NULL pointer is programmed into the =
hardware GAITE, leading to hardware memory corruption.
- [High] Failure paths in `kvm_s390_pci_aif_enable()` fail silently by retu=
rning 0 (success) instead of a negative error code.
- [High] Unbounded resource leaks can be triggered by calling the KVM_S390_=
ZPCIOP_REGAEN ioctl repeatedly.
- [High] Missing NULL check for the return value of `airq_iv_create()` caus=
es a guaranteed host kernel panic on memory allocation failure.
- [High] Missing `free_uid()` causes a persistent `user_struct` reference l=
eak in `account_mem()` and `unaccount_mem()`.
- [High] Permanent leak of `locked_vm` memory accounting on error path.
- [Medium] Failure of `kvm_zpci_set_airq()` completely bypasses the error u=
nwind path, temporarily leaking pinned pages and allocated structures.
--

commit a4932a1950ea471069d9ddad4938cb5cea43c9a1
Author: Haoxiang Li <haoxiang_li2024@163.com>

KVM: s390: pci: Fix GISC refcount leak on AIF enable failure

kvm_s390_gisc_register() registers the guest ISC before pinning
the guest interrupt forwarding pages and allocating the AISB bit.
If any of the later setup steps fails, the function unwinds the
pinned pages and other local state, but does not unregister the
GISC reference. Add the missing kvm_s390_gisc_unregister() to the
error unwind path.

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

[Severity: High]
This isn't a regression introduced by this patch, but while reviewing the
error unwind path I noticed a potential leak of the locked_vm accounting:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Account for pinned pages, roll back on failure */
	if (account_mem(pcount))
		goto unpin2;
    ...
unlock:
	mutex_unlock(&aift->aift_lock);
unpin2:
	if (fib->fmt0.sum =3D=3D 1)
		unpin_user_page(aisb_page);
unpin1:
	unpin_user_page(aibv_page);
out:
    ...
}

Are we missing a call to unaccount_mem() in the error unwind block to
revert the accounting if a later step fails?


[Severity: High]
This is a pre-existing regression, but I also noticed that the return code
doesn't seem to be set to an error value on some of these failure paths:

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

If either of these fail, will the function silently return 0 instead of a
negative error code since rc is not updated before the goto?


[Severity: Medium]
This isn't a regression introduced by this commit, but does the hardware
setup step bypass this unwind path completely?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Issue the clp to setup the irq now */
	rc =3D kvm_zpci_set_airq(zdev);
	return rc;

unlock:
    ...
}

If kvm_zpci_set_airq() fails, returning directly abandons the unwind
protocol and leaves the allocated resources behind.


[Severity: Critical]
This is another pre-existing regression, but I have a question about how we
handle a missing guest AISB:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	gaite->aisb =3D virt_to_phys(page_address(aisb_page) + (fib->fmt0.aisb &
							      ~PAGE_MASK));
    ...
}

If userspace disables summary notifications (fib->fmt0.sum =3D=3D 0),
aisb_page will be NULL. Does this pointer arithmetic generate a bogus
physical address that gets programmed into the hardware GAITE?


[Severity: High]
This isn't a regression introduced by this patch, but I noticed a potential
null pointer dereference:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
				    AIRQ_IV_BITLOCK |
				    AIRQ_IV_GUESTVEC,
				    phys_to_virt(fib->fmt0.aibv));
    ...
}

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
	fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

If airq_iv_create() fails and returns NULL under memory pressure, will
airq_iv_end() unconditionally dereference the NULL pointer?


[Severity: High]
This isn't a regression introduced here, but I have a question about the
ioctl handler:

arch/s390/kvm/pci.c:kvm_s390_pci_zpci_reg_aen() {
    ...
	return kvm_s390_pci_aif_enable(zdev, &fib, hostflag);
}

If a user repeatedly issues the KVM_S390_ZPCIOP_REGAEN ioctl, does this
unconditionally call kvm_s390_pci_aif_enable() and overwrite zdev->aisb
and zdev->aibv without checking or freeing previous allocations?


[Severity: High]
This isn't a regression introduced by this patch, but there appears to be a
reference leak in the memory accounting functions:

arch/s390/kvm/pci.c:account_mem() {
    ...
	struct user_struct *user =3D get_uid(current_user());
    ...
}

Does get_uid() increment the reference count without a corresponding call
to free_uid() before the function returns? This also appears to happen in
unaccount_mem().

>  	return rc;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260624061910.2794=
734-1-haoxiang_li2024@163.com?part=3D1
