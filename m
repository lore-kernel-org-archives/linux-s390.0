Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A76A9340A7D;
	Thu, 23 Jul 2026 22:30:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784845847; cv=none; b=Cbcd/S9I3hmUyResgBpZSf2g8cHxTXo34kA5ECbWmT+wTEVr26a8oy+crGzJVoRvnXvhnXdXB57gA5GDR4lsc5pv/HbilOhUGawE9n1nOxjd6K2mebEDuzcG1oQT7dyl8R/LFs6GVeC0kpWSMBIlzd+DX/DN7vd3CDCA2oKdros=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784845847; c=relaxed/simple;
	bh=O2fCIGOVAcG8BQ4rQ1uWhSZNVJerPYx6SL84dli7i9c=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Yy4mJyW0xvuaFsU5yk9f4SWzjXXn3j0nKjv2jdNBiF6fSl0qZ0Ol1PhIwm+S8LhqE/nhpA9ENNFkeab8nquE38kUTAOUQV+UR65fEzqpn7idDCLk2iYKsZ7Qq3CozQgoj1M/2DBgYTjIQ6tLgXYaAmEJVAMFqlhSl3yQrtPX6Rw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=KlTXdaJh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="KlTXdaJh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B45D1F00A3A;
	Thu, 23 Jul 2026 22:30:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784845846;
	bh=EgKYZ3XW7cZ76B3cgV9eQWIWEflhLckt1dAMaymVaN4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KlTXdaJh3RRTc1zqvJiqbnBSwOfiFSiPrgpQUxz6py+sFqq1pd49/g/XP3f0gyQbU
	 WA/TU2JztIEVNuLNk2pDevuIhIsk9TKk+kPaL54KTgDimMAGCsFYDZrfsFediW+lVh
	 vhHlV7DDRKd7KC0aYFDo67kasYdLpAbUgp2MHdZhbVlIud0a3bOFE5T4yCa7vg5VGQ
	 +vMarhawP7o1IgOY3F8sbMa/Jcv8mTirgVPstl5EEDD6kuYaM+AvpXAy/xicOKny5N
	 MFQ+JQBDqRQpMrCK6WmNT7Nm/DD4bZrAP0AunhmduvRpP3OLqHRyAnPV2/4jtXsmWs
	 cx3Wy6pizCgMw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 1/6] KVM: s390: pci: Reject adapter interrupt
 forwarding if already enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260723221409.5874-2-alifm@linux.ibm.com>
References: <20260723221409.5874-1-alifm@linux.ibm.com>
 <20260723221409.5874-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 23 Jul 2026 22:30:45 +0000
Message-Id: <20260723223046.0B45D1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Memory leak of `user_struct` and incorrect memory quota accounting.
--

--- Patch [1]: [PATCH v6 1/6] KVM: s390: pci: Reject adapter interrupt forw=
arding if already enabled ---
commit e0b697cb30b22f286c181b6e14ea16a36c89254c
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Reject adapter interrupt forwarding if already enabled

The MPCIFC instruction does not allow registering adapter interrupts without
first unregistering. This patch rejects any request to enable interrupt
forwarding if it is already enabled for the zPCI device. This prevents
overwriting and leaking resources when the ioctl is called multiple times f=
or
the same device.

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
This isn't a bug introduced by this patch, but does the resource accounting
in account_mem() and unaccount_mem() leak the user_struct reference and
mis-account memory quotas during teardown?

In account_mem(), get_uid() increments the user_struct reference count, but
this reference does not appear to be freed via free_uid() on the success pa=
th:

arch/s390/kvm/pci.c:account_mem() {
	struct user_struct *user =3D get_uid(current_user());
	...
	kzdev->user_account =3D user;
	kzdev->mm_account =3D current->mm;

	return 0;
	...
}

Additionally, does unaccount_mem() use the current task context for teardown
instead of the saved context?

arch/s390/kvm/pci.c:unaccount_mem() {
	struct user_struct *user =3D get_uid(current_user());

	if (user)
		atomic_long_sub(nr_pages, &user->locked_vm);
	if (current->mm)
		atomic64_sub(nr_pages, &current->mm->pinned_vm);
}

If teardown happens in a different context, such as a worker thread during
delayed_fput() (e.g., during kvm_s390_pci_aif_disable), could unaccount_mem=
()
subtract from the wrong task's locked_vm?

Because locked_vm is an atomic_long_t, subtracting unallocated pages could
cause a negative underflow. During subsequent account_mem() checks, this
negative value might be treated as a large unsigned integer, which would ca=
use
new_pages > page_limit to return -ENOMEM, potentially preventing the affect=
ed
user from allocating locked memory in the future.

>  	kvm =3D zdev->kzdev->kvm;
>  	msi_vecs =3D min_t(unsigned int, fib->fmt0.noi, zdev->max_msi);
>

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260723221409.5874=
-1-alifm@linux.ibm.com?part=3D1
