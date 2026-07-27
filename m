Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77A203F1ADA;
	Mon, 27 Jul 2026 10:11:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785147083; cv=none; b=agUlswdPttJ+m0FZE1AifLjFcA4QuCbalqRROhn9JwWqXNxUBMz+XYJxnhWtK0uHk8Nt/VzurZWb7VcaXVjYAwyXwE99M9oqSTQhUjZEDlw35estSQ8MosOoATcO8Biu0GGOAbqSTF/G2IHOjaeC/hTWaEjrMmoHaR913YTp4Ag=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785147083; c=relaxed/simple;
	bh=RemC+Oy85XC7x+PfhApaAIyMD67wbyvJz9RY7kGZGrU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Gk1ENNpbttFmccbQnF5KxrOPky5R/3Qpy/82k5cDBfXNfWxJg/FEVx4+Igq5QwAwEhHVMqJnd0PDGhs0Z9DiR55FSlfX1Ce/dH+HSCNsyX75v9bv99tdBJ8S3cFck7mrjkc0w5EMZhRVJnDD8Z3JVgUkZPqNOjh0xnWikQV7enQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Qr/ZJEHW; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Qr/ZJEHW"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C86F61F00AC4;
	Mon, 27 Jul 2026 10:11:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785147082;
	bh=Z0hwz0TblpcGkCP9OHRwgKzRLPCEuM5HSIx56YGwHPM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Qr/ZJEHWDJiH5uDbsGqR1a9iBiIjs8J/NLJf8ul80FBkLFPPBTcs+6V5Hv423fuCm
	 1E62c8E8eD2Xkya9BqohPDszuoLJQ6fkNUHSuB1N78FRvktz86N0e8UjE1+jlUvRQW
	 kbagy2M4C/hrm77zVsc3KVRCrk6PrayuaQVtPeYeCutr8CkCjStcN/Qe4s/Ux7CyR2
	 kbsKdqM6EsWED4R/2Ah90oeK4SsqQZ3CvEOCJPQKKsODnsw9iK3nUL5aemXQFZlANF
	 m3R7NPkvWcq56KnbUzxfpFdZCKKi089gJnngRTqn6L5kgQhRF5aDjL7wGbFYJgVFBg
	 8Puob7L9YV7JQ==
From: sashiko-bot@kernel.org
Subject: Re: [GIT PULL 2/7] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Borntraeger" <borntraeger@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org
In-Reply-To: <20260727095720.9150-3-borntraeger@linux.ibm.com>
References: <20260727095720.9150-1-borntraeger@linux.ibm.com>
 <20260727095720.9150-3-borntraeger@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 10:11:21 +0000
Message-Id: <20260727101121.C86F61F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

New issues:
- [High] The patch introduces `mm_struct` and `user_struct` reference count=
 leaks on the `airq_iv_alloc_bit()` error path.
- [High] Calling the `KVM_S390_ZPCIOP_REG_AEN` ioctl multiple times sequent=
ially overwrites `kzdev->mm_account` and `kzdev->user_account`, permanently=
 leaking the previously acquired kernel object references.

Pre-existing issues:
- [High] Missing NULL check for `airq_iv_create()` return value causes a gu=
aranteed NULL pointer dereference.
--

--- Patch [1]: [GIT PULL 2/7] KVM: s390: pci: Fix memory accounting for pin=
ned/unpinned pages ---
commit c8a84dcb0557ca0ba1070398f64a0a7a9a08e82b
Author: Farhan Ali <alifm@linux.ibm.com>
Date:   Mon Jul 27 09:57:15 2026 +0000

    KVM: s390: pci: Fix memory accounting for pinned/unpinned pages

This patch stores the pinning process user_struct and mm_struct when
accounting for pinned pages. It subsequently frees these resources when the
pages are unpinned to resolve context issues.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 5b075c38998e3..c2f5085a0f5f1 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
[ ... ]
> @@ -190,33 +190,54 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zde=
v)
[ ... ]
> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_p=
ages)
>  {
>  	struct user_struct *user =3D get_uid(current_user());
>  	unsigned long page_limit, cur_pages, new_pages;
> +	int rc =3D 0;
> =20
>  	page_limit =3D rlimit(RLIMIT_MEMLOCK) >> PAGE_SHIFT;
> =20
>  	cur_pages =3D atomic_long_read(&user->locked_vm);
>  	do {
>  		new_pages =3D cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =3D -ENOMEM;
> +			goto out;
> +		}
>  	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pag=
es));
> =20
> -	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	if (current->mm) {
> +		mmgrab(current->mm);
> +		atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	}
> +
> +	kzdev->user_account =3D user;
> +	kzdev->mm_account =3D current->mm;

[Severity: High]
If the KVM_S390_ZPCIOP_REG_AEN ioctl invokes kvm_s390_pci_aif_enable()
multiple times sequentially, will this unconditionally overwrite
kzdev->user_account and kzdev->mm_account?

It appears that if the device is already enabled, the previously acquired
references would be permanently leaked since unaccount_mem() isn't called
before assigning the new pointers here.

> =20
>  	return 0;
> +
> +out:
> +	free_uid(user);
> +	return rc;
>  }
> =20
>  static int kvm_s390_pci_aif_enable(struct zpci_dev *zdev, struct zpci_fi=
b *fib,
> @@ -275,7 +296,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>  		goto unpin2;
> =20
>  	/* AISB must be allocated before we can fill in GAITE */

[Severity: High]
If airq_iv_alloc_bit() fails later in this function, the error path
jumps to the unlock and unpin labels:

kvm_s390_pci_aif_enable() {
        ...
        bit =3D airq_iv_alloc_bit(aift->sbv);
        if (bit =3D=3D -1UL)
                goto unlock;
        ...
unlock:
        mutex_unlock(&aift->aift_lock);
unpin2:
        if (fib->fmt0.sum =3D=3D 1)
                unpin_user_page(aisb_page);
        ...
}

Does this error path need to call unaccount_mem() to prevent leaking the
mm_struct and user_struct references acquired by account_mem() earlier?

[Severity: High]
This is a pre-existing issue, but is it possible for airq_iv_create() to
return NULL under memory pressure?

If it fails, zdev->aibv is assigned NULL a bit later in
kvm_s390_pci_aif_enable():

kvm_s390_pci_aif_enable() {
        ...
        zdev->aibv =3D airq_iv_create(...);
        ...
        rc =3D kvm_zpci_set_airq(zdev);
        ...
}

Could this lead to a NULL pointer dereference when kvm_zpci_set_airq()
attempts to access airq_iv_end(zdev->aibv)?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727095720.9150=
-3-borntraeger@linux.ibm.com?part=3D1
