Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E8781A9FAF;
	Mon, 20 Jul 2026 18:18:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571520; cv=none; b=ZKomcp4r/G2gmr89Q6TA8vXSE3GAuFU05ZtSjtI5MiFguDwUHS4ktP0PSS8ZQhg/kZ1ofKm0ZAqQODPzXwKwRTW7Qzj4vWD16WYccW+Dcn4Uu9BXB7oyHY5lkP+reuy3CZtk+MjI6/SFEsxrA45pxHh1dMJMUTSc8uamZxc+inA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571520; c=relaxed/simple;
	bh=yuU2KQbcIPTjX1UisikOGOMxaVN3NO9TYCTzJ2H7oEc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qB3c0vg7MO9ULdVw1YAgC85sMWqUhgZkSA+NLLMWxqqoPA22SMgl1MR3Da0A28YGIpeZqgJxVytwDPf63FL98IcYJwquI5e6xygm7mPS6mRt9sHrJsRpU7Nr9SPGR9ZmdnqcrbXceGw+T7tdGxsgWB3aSw8zyZkgP49B2vzkIC4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=X/mDkUPz; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="X/mDkUPz"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 984FA1F000E9;
	Mon, 20 Jul 2026 18:18:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571519;
	bh=9NZxQQsXMZP8bIT1sGEagFyzy2bq22khBgCebqKy0Aw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=X/mDkUPzz/KzWXyk3tiHMWTX0KKwdD2hq6iHtPdo2X9INwewUgAcHg6nw0Nj2rWo9
	 e8to8NYEsnquuCglKheVyNkuWl6G76aq+Ure6wa7UH9Y9oQApvMhQgEde6Pa1BvJs9
	 1xi+w/hVwugoOpQzzEbZUAVprxSTdyQ2CPPbtEPedszcmu92eFl7JLaeRqbQ6mi9y3
	 prSMarCUvjA/NZKUrQPLKc0lObPfaHJsM1rFKl/wka7n4xS/3F1XAywNe/dKKrR4za
	 XspE0sXnINcVW4if6obrwKhQNsZL4Ej71cVvDV/5BFhnzEKnyyaIYUCO8Kjw22iel/
	 BQ+TWBliGE+Cg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 1/4] KVM: s390: pci: Fix memory accounting for
 pinned/unpinned pages
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720175819.1723-2-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
 <20260720175819.1723-2-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:18:38 +0000
Message-Id: <20260720181838.984FA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] Repeated KVM_S390_ZPCIOP_REG_AEN ioctl calls overwrite kzdev->mm_a=
ccount and kzdev->user_account without dropping previous references, perman=
ently leaking mm_struct and user_struct.

Pre-existing issues:
- [High] kvm_s390_pci_aif_enable returns silent success (0) when memory acc=
ounting fails.
--

--- Patch [1]: [PATCH v3 1/4] KVM: s390: pci: Fix memory accounting for pin=
ned/unpinned pages ---
commit 200dcce54ba1446ee99b11172f6ae91eeaacea27
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix memory accounting for pinned/unpinned pages

This commit changes the memory accounting functions to store the pinning
process's user_struct and mm_struct directly in the kvm_zdev structure.
This ensures that unaccount_mem() correctly decrements the references
from the original process context, rather than the context of the caller
performing the unpinning.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 720bb58cabe2e..dd17f8a7b4734 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c

[ ... ]

> @@ -190,33 +190,51 @@ static int kvm_zpci_clear_airq(struct zpci_dev *zde=
v)
> -static inline int account_mem(unsigned long nr_pages)
> +static inline int account_mem(struct kvm_zdev *kzdev, unsigned long nr_p=
ages)
>  {
>  	struct user_struct *user =3D get_uid(current_user());
>  	unsigned long page_limit, cur_pages, new_pages;
> +	int rc =3D 0;

[ ... ]

> +	mmgrab(current->mm);
>  	atomic64_add(nr_pages, &current->mm->pinned_vm);
> +	kzdev->user_account =3D user;
> +	kzdev->mm_account =3D current->mm;

[Severity: High]
If userspace repeatedly calls the ioctl that triggers
kvm_s390_pci_aif_enable() for a device, can this overwrite
kzdev->mm_account and kzdev->user_account without dropping the previous
references?

Looking at kvm_s390_pci_aif_enable(), there doesn't appear to be a check to
see if the device is already registered before calling account_mem(). Calli=
ng
it multiple times would execute mmgrab() and get_uid() on each invocation,
unconditionally overwriting the pointers here and leaking the previous
mm_struct and user_struct.

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
> @@ -275,7 +293,7 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *z=
dev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(pcount))
> +	if (account_mem(zdev->kzdev, pcount))
>  		goto unpin2;

[Severity: High]
This is a pre-existing issue, but does this error path return 0 (success) to
userspace when memory accounting fails?

In kvm_s390_pci_aif_enable(), the return code rc is initialized to 0. If
account_mem() fails and returns -ENOMEM, the code jumps to the unpin2
cleanup path without assigning the error code to rc.

This seems like it would mislead userspace into believing the interrupt
forwarding setup succeeded.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175819.1723=
-1-alifm@linux.ibm.com?part=3D1
