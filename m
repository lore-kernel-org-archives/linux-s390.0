Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B41704322FC
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:20:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131228; cv=none; b=u132gpwL8MfdwTajq0sDUd1yj4eJ/+BVXVipIGH3EqEaJ0vM4M2PoF1dgc3ND9/65mNpZnx9vB8vW+YGOA8LGryOyUksb5bVo/g/kO4Gf+0lR64ir4xQ9GvrddHmvK7getcMjXrqC0oLT8LXDDQGmFicPUEfBa51E6ciuIvEC2Y=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131228; c=relaxed/simple;
	bh=55K4nfdJXVQ4hw6wnfHT8PicsolYjjRsiAeqgeDfiaQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=mD0JeT+C3/P3yzO9HCIPS7ExagC5I4fKwZQqX+IwsVjGyIxTgAUGpEwETKEVDPJjeWRQv1OvhUm457Jw9CnOn1FrEIkyZAOLqpwHOz42IPfbhhMz/YIoQ+q9XHPJ2khamjKN0qvecH4RsdVh4z3Sr4BBQzjyfa5kofDs3I5PE28=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XX14H28Y; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XX14H28Y"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9658A1F00A3A;
	Wed, 19 Aug 2026 09:20:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131218;
	bh=CZ9FJlYnrwsVVTRMYzJ1qzncuZQYaq8B477y45g6ypI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XX14H28Ydkq8A2pcWY24BtXVVVXbOw3+jSvV1KFmKrapSVRAPATnPkotpyaz3d12/
	 7PmLNiNY+24+czRNm7FPS28TChZNc8+VQ7CYBU5G3Gd2lMiHuy+egcNNUgG0fpzYwz
	 zIjmXxUnbUkbBTf9mdMoPjT4RzksSL/I4/hNnLEMUugl8jTwBJNdErYmynRjbyPj3D
	 5wJ3LMDkj9MVAfxc/9SJBxLQCHiGJrXAZYgXghzGV03rETfWRPwiXID8fAnH9ctoGO
	 TOHkefj21m1RdLNPTuwIIw8WeheUffYJKhH3rims0S+P3USad3E2DLX7XDZkThBoPd
	 PbWt6C4kmOTJw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/7] s390/pci: fix use-after-free race in zpci floating
 interrupt cleanup
Reply-To: sashiko-reviews@lists.linux.dev
To: "Tobias Schumacher" <ts@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260819-s390_irq_domain_fixes-v1-2-826ff27b6e97@linux.ibm.com>
References: <20260819-s390_irq_domain_fixes-v1-0-826ff27b6e97@linux.ibm.com>
 <20260819-s390_irq_domain_fixes-v1-2-826ff27b6e97@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:20:18 +0000
Message-Id: <20260819092018.9658A1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:
- [High] Teardown order creates a race condition that can overwrite a concu=
rrently allocated IRQ vector pointer with NULL, leading to permanently lost=
 interrupts.
- [Medium] Missing RCU publication mechanism (`rcu_assign_pointer`) for `zp=
ci_ibv` writes creates a potential data race where the IRQ handler could re=
ad uninitialized adapter interrupt vectors.
--

--- Patch [2]: [PATCH 2/7] s390/pci: fix use-after-free race in zpci floati=
ng interrupt cleanup ---
commit 2b99a8a1009855b33744de14f0b8b1c8afadae39
Author: Tobias Schumacher <ts@linux.ibm.com>

s390/pci: fix use-after-free race in zpci floating interrupt cleanup

The interrupt handler reads zpci_ibv[si] without synchronization while
concurrent teardown can release this memory, creating a race. The fix
protects the array access with RCU synchronization.

> diff --git a/arch/s390/pci/pci_irq.c b/arch/s390/pci/pci_irq.c
> index c9520a16ca753..94b03d16006ba 100644
> --- a/arch/s390/pci/pci_irq.c
> +++ b/arch/s390/pci/pci_irq.c
> @@ -278,8 +278,14 @@ static void zpci_floating_irq_handler(struct airq_st=
ruct *airq,
>  			continue;
>  		}
> =20
> +		rcu_read_lock();
> +
>  		/* Scan the adapter interrupt vector for this device. */
> -		aibv =3D zpci_ibv[si];
> +		aibv =3D rcu_dereference(zpci_ibv[si]);

[Severity: Medium]
I see that rcu_dereference() is used here to read from the array.

Does the write side in __alloc_airq() also need to be updated to use
rcu_assign_pointer()?

arch/s390/pci/pci_irq.c:__alloc_airq() {
    ...
		/* Wire up shortcut pointer */
		zpci_ibv[*bit] =3D zdev->aibv;
    ...
}

Without rcu_assign_pointer(), the required memory release barrier is missing
when the interrupt vector is published to the RCU-protected array.

> +		if (!aibv) {
> +			rcu_read_unlock();
> +			continue;
> +		}

[ ... ]

> @@ -346,9 +353,12 @@ static void zpci_msi_teardown_directed(struct zpci_d=
ev *zdev)
> =20
>  static void zpci_msi_teardown_floating(struct zpci_dev *zdev)
>  {
> +	airq_iv_free_bit(zpci_sbv, zdev->aisb);
> +	zpci_ibv[zdev->aisb] =3D NULL;
> +	synchronize_rcu();

[Severity: High]
Does freeing the bit before clearing the array pointer create a race condit=
ion?

If Thread A (teardown) frees the bit, Thread B (initializing a new device)
could allocate the exact same bit from zpci_sbv. Thread B would then alloca=
te
its vector and assign it to zpci_ibv[bit]. When Thread A continues, it clea=
rs
zpci_ibv[zdev->aisb], overwriting Thread B's valid pointer with NULL.

Could this overwrite lead to permanently lost interrupts and a memory leak =
for
the new device?

> +
>  	airq_iv_release(zdev->aibv);
>  	zdev->aibv =3D NULL;
> -	airq_iv_free_bit(zpci_sbv, zdev->aisb);
>  	zdev->aisb =3D -1UL;
>  	zdev->msi_first_bit =3D -1U;
>  	zdev->msi_nr_irqs =3D 0;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819-s390_irq_d=
omain_fixes-v1-0-826ff27b6e97@linux.ibm.com?part=3D2
