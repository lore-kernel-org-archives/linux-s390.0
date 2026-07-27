Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 01DD43DB31F;
	Mon, 27 Jul 2026 10:13:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147220; cv=none; b=UzmZgqKM9n0Ooe0AigK6jgBf1xtyOaBOguCw86bipWqoTGIabImAqpvWG24avdoWz+pC/8R3qt2fOaBl9hlG2UVfm+w7xV1sEe296QbmGkV5WjQuGXAyy7Lgj+DKh7ufkGUUXXbauhUPqQGfflTDK4dZV2MoL2/2tt3T6xWGlyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147220; c=relaxed/simple;
	bh=JH1gjpL/W2dCiEENarPnPPyavBZTZuhIOO5kPOAVOOs=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZSBhx56wtGE43ljblRAEdzKOYd5z/ArbNQO3wbmxAcm2Ijsv0SV8a+l5qNRNblh+Y+r7FiRU9ue3BiKxVlmc8muwOUfFYCJC1RjPR/GcGS4+eOoUmB16h/zZT3GBWINWNRpGCp9AENGnTyMc9zAq8ZTGBjnUuaYDG0JoVtCpKEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=i2wQ9U0I; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="i2wQ9U0I"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 473401F00A3A;
	Mon, 27 Jul 2026 10:13:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147218;
	bh=IVQWuaAnE60IIrm3oesd+3lA558t5oCEAMErRZm81DI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=i2wQ9U0I9ofCzg52Hgn7671avQ2Wq4rtQJqtbrB7sKBtKwLoMM1PwKv52002NJH98
	 OYBJmbkG6gDPqfrzr8An3QdM2rMYICAJ9Suitd6ky9UzHK0BZ3m1joxYb2szHmSIrv
	 cK/gTVML87W/g9axLt/T3lMwS0nAMz/bUHbD9yARlzz0IMIONcQJ7ECoygnbI2hCSg
	 cAd8nHetWOKEbkZp666Z/X4ShIYXRvep3yWzXkipS2tyZSkc1A+qyqJeqU0KtPcVaC
	 HQq9KzMKW1cCbDQ2bB1pXHF4JUqVNWK42fimBm2W07KD//ayZLVJBAhelPYq+Hyndu
	 co8iCd+HhAXiQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 1/7] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260727095720.9150-2-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
 <20260727095720.9150-2-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:13:37 +0000
Message-Id: <20260727101338.473401F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] kvm_s390_pci_aif_enable() silently returns success (0) when accoun=
t_mem() or airq_iv_alloc_bit() fail, leaving the device non-functional in t=
he guest.
- [High] Missing NULL check for airq_iv_create() return value causes a guar=
anteed kernel panic on allocation failure.
- [High] The helper functions account_mem() and unaccount_mem() permanently=
 leak user_struct reference counts and inaccurately uncharge teardown threa=
ds.
--

--- Patch [1]: [GIT PULL 1/7] KVM: s390: pci: Reject adapter interrupt forw=
arding if already enabled ---
commit 834c3470cb709cfa95cf6f7b8315fe450f54610b
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Reject adapter interrupt forwarding if already enabled
   =20
The MPCIFC instruction doesn't allow registering adapter interrupts without
first unregistering. So reject any request to enable interrupt forwarding
if its already enabled for the zPCI device. This also fixes overwriting and
thus leaking resources when the ioctl is called multiple times for the same
device.

Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disabli=
ng interrupt forwarding")
Cc: stable@vger.kernel.org

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..02ec50a01fed2 100644
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
>  	kvm =3D zdev->kzdev->kvm;
>  	msi_vecs =3D min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
> =20

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pci_aif_enable() silently
return success when account_mem() fails?

If account_mem() fails, it jumps to unpin2, but rc remains 0:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	/* Account for pinned pages, roll back on failure */
	if (account_mem(pcount))
		goto unpin2;
    ...
unpin2:
	if (fib->fmt0.sum =3D=3D 1)
		unpin_user_page(aisb_page);
unpin1:
	unpin_user_page(aibv_page);
out:
	return rc;
}

The same happens if airq_iv_alloc_bit() fails:

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	bit =3D airq_iv_alloc_bit(aift->sbv);
	if (bit =3D=3D -1UL)
		goto unlock;
    ...
}

Should rc be updated to a negative error code before jumping to these clean=
up
labels?


[Severity: High]
This is a pre-existing issue, but could airq_iv_create() return NULL and ca=
use
a panic?

arch/s390/kvm/pci.c:kvm_s390_pci_aif_enable() {
    ...
	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
				    AIRQ_IV_BITLOCK |
				    AIRQ_IV_GUESTVEC,
				    phys_to_virt(fib->fmt0.aibv));

	spin_lock_irq(&aift->gait_lock);
    ...
}

If airq_iv_create() fails and returns NULL, zdev->aibv becomes NULL. Later,
when kvm_zpci_set_airq() is called, it might dereference this NULL pointer:

arch/s390/kvm/pci.c:kvm_zpci_set_airq() {
    ...
	fib.fmt0.noi =3D airq_iv_end(zdev->aibv);
    ...
}

Should we check the return value of airq_iv_create() and handle the failure?


[Severity: High]
This isn't a bug introduced by this patch, but do the accounting functions =
leak
user_struct references?

In account_mem():

arch/s390/kvm/pci.c:account_mem() {
    ...
	struct user_struct *user =3D get_uid(current_user());
    ...
}

And in unaccount_mem():

arch/s390/kvm/pci.c:unaccount_mem() {
    ...
	struct user_struct *user =3D get_uid(current_user());

	if (user)
		atomic_long_sub(nr_pages, &user->locked_vm);
	if (current->mm)
		atomic64_sub(nr_pages, &current->mm->pinned_vm);
    ...
}

Both functions call get_uid(current_user()) which increments the user's
reference count, but they do not seem to call free_uid().

Additionally, unaccount_mem() might be called in asynchronous teardown
contexts where current points to a teardown worker thread instead of the
original VM process. Does this lead to inaccurate uncharging of the
teardown thread?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095720.9150=
-2-borntraeger@linux.ibm.com?part=3D1
