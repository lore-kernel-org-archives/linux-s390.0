Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 793313DA7F9;
	Thu, 16 Jul 2026 18:08:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225302; cv=none; b=i8rGNL3mmqGv9Cp/E79DeRwbaC/qZB9FCLm7/I90qKCq393XFaxUfpk99cLZJozKdPsXsltf5bl3h0kgyWi/3q0cl11E8ZwyqS3czjbSl1QJSwU+1/c4l5kyus/Jps+LNlXkrSEgjJJUbibbShQcmD5lETs54gxi7eUD4NShX1Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225302; c=relaxed/simple;
	bh=qbYBgeiXQ8CBm/bZPw/JQ9u2a7bdj/xb0VcYxliQT2c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=smcpr9/Hyrt7KD3IfE8MdNW3saF+MFgrAflVhwlnzqDxh5Fp57Zz6KNNYcnIfgOP8cy749UuLHiV1v7lQVyAhML0nZdL+H185oZixWeMnto/krCQZIYG3bv0d+VrYjVQeFJQIZVRCJXsT5hJH6dOLbq4lhShxu+7S7fEQzxUjzo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eue2HDEs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eue2HDEs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7BD461F000E9;
	Thu, 16 Jul 2026 18:08:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225299;
	bh=KNb4Y/PUQZYj0NYXmCyHWJsTdJWI8x2jhTbPt5qhzDc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eue2HDEstqmQvUncb5yqSo/qsNdYrDlkxNFbPZOPWbLWjbqY1BitSQSRMLic8NzEX
	 mK2HBrOKWEotmbeufKXIjYhfzE/taUSDPk1SmNsMMmAwH/yxWnzdLxJnOV8W+pNjAh
	 cJLwBGtZ34x/Yn4EAzOG0IXP7rONg11SoUuBXnHgBynChc1NSv45uKHta12DyNMh2R
	 nBFnXTNPSVU1BFEkwkYjH5a9e0Wqvw650ztS7tmtDljq/DbjGzykv+5xWLT7y33hbh
	 zfA/JILEa06UgrjbQkf2X2QUtDe74Vf1GJMsmItOZOyA9kelD2422+uEISDZExZwMv
	 SEBQucs1sCBYw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/4] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260716175241.1039-2-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
 <20260716175241.1039-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:08:19 +0000
Message-Id: <20260716180819.7BD461F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Sequential calls to the KVM_S390_ZPCIOP_REG_AEN ioctl on the same =
device overwrite kzdev->user_account and kzdev->mm_account without dropping=
 previous references, causing a permanent leak of mm_struct references and =
pinned pages.
--

--- Patch [1]: [PATCH v2 1/4] KVM: s390: pci: Fix memory accounting for pin=
ned/unpinned pages ---
commit cbbebe9ad7b7a6af2ee4a68dd67b2e520770bd20
Author: Farhan Ali <alifm@linux.ibm.com>
KVM: s390: pci: Fix memory accounting for pinned/unpinned pages

This patch addresses a bug where unaccount_mem() could be called from a
different process context than the one that initially pinned the pages. It
resolves this by storing the pinning process's user_struct and mm_struct
when accounting for pinned pages, so they can be properly freed later.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2e..dd17f8a7b4734 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
[ ... ]
> @@ -206,17 +220,24 @@ static inline int account_mem(struct kvm_zdev *kzde=
v, unsigned long nr_pages)
>  	do {
>  		new_pages =3D cur_pages + nr_pages;
> -		if (new_pages > page_limit)
> -			return -ENOMEM;
> +		if (new_pages > page_limit) {
> +			rc =3D  -ENOMEM;
> +			goto out;
> +		}
>  	} while (!atomic_long_try_cmpxchg(&user->locked_vm, &cur_pages, new_pag=
es));
> =20
> +	mmgrab(current->mm);
>  	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	kzdev->user_account =3D user;
> +	kzdev->mm_account =3D current->mm;

[Severity: High]
If kvm_s390_pci_aif_enable() is called multiple times for the same device,
will this overwrite kzdev->user_account and kzdev->mm_account and leak
the previously acquired references?

It looks like kvm_s390_pci_aif_enable() doesn't check if the device is
already enabled before proceeding. If a userspace process calls the
KVM_S390_ZPCIOP_REG_AEN ioctl twice on the same device, the first call
will successfully populate these pointers.=20

The second call would then overwrite them here, leaking the original
mm_struct reference and permanently stranding the initially pinned pages.
If that second call subsequently fails, unaccount_mem() drops the new
reference and sets the pointers to NULL, leaving the original references
permanently orphaned.

Should there be a check in kvm_s390_pci_aif_enable() to bail out if it
is already enabled, or a check here to ensure we aren't overwriting an
existing reference?

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

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716175241.1039=
-1-alifm@linux.ibm.com?part=3D1
