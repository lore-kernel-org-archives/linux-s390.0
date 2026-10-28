Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793203168;
	b=dpSwqAEvkoOwG18Ydpt3kDHO7J4WZQHXS+t0HEkntemdQhBaHS1NwmC773vP8ZRuXwE7
	 39TTU4MVK7SpeRF6RfPsj4Es2TSJw8AKxe3NV6wb8iCSDnFTI30/SLCwjVnDh5pkSK/R9
	 Jbe2Mh4mlq6F1cHPnPZ9xRpv8algUgQL0e1T4YS0+S8qlCzXwBD7warZc7lL4IWVkvP0B
	 R0rXg2KuQZWiWLCA5zpWXvsFnMjLV7CYhVyjEsjErKZIym/pC24Gpviy6akAEqI/TRK0Y
	 4CJ4mnRXG3wqDbgfeS0hpPI+m/HNpwSZxa6k2jWHiV4hw7HUJaPuSsn4r+XITLu9Zmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793203168;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=E2YOks/zwf/Z7rNPXqinOw2gFl73ftKQKl7O0cmHs04=;
	b=kIOz0BDAUMWY3Oqt7bdW3iuA0gt787nWqFkSt20Q1JKj4B+rpnNnGBq6uVLF8BzUFRxi
	 qua15ElvD2sxdXwLub8MFc6Xtf7T307lOFF9080hNhNRWdHluZ3X/stvicDuH+iAF+yAV
	 tAVg/DlM4mooEP8bUSOxcw2nyZEP5D2uVnUEnNWqH5nY1ymiJft3Dn0fYiHXUrNn3GQKP
	 U/oqMzCiQCEKuTJRB0dCQRWdpcCcJhJdqkAY0HuS/k4R9uUPSVFhmDew90GTy4weM/IQn
	 XxE++L29afC1xiHukNZqLJUJTYQ5k9IeIhB1+WQlmSpdKaIcjXjnxBPiQvm8I6/YhfA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0meD2Dj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 569F760A2633;
	Wed, 28 Oct 2026 15:59:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=j0meD2Dj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D9F521F01825;
	Wed, 28 Oct 2026 15:59:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793203168;
	bh=E2YOks/zwf/Z7rNPXqinOw2gFl73ftKQKl7O0cmHs04=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=j0meD2DjMxb8HtItJZa0AFCnUng7tU2lMvspDDjFB0H/K15GeurpuLPfjWGDzBNo/
	 RYOZkGQtdS1vrNNK71zjpQMip0EVK52qe9ueWtOK/V0cFGFVCM/BJOsYl0DtGJdozj
	 JAN9Brmav7+bNVWf5j13TbWXKdfDsoRC6LxnrIkN1YYhaFFVIUENFm9wkhdpc3+b4F
	 19GGo6ggwhi8eYC5WwPREefmQe/P6fhYF1HgB30f0uOgv4zuFiVKJbvjZccC09QweI
	 e6xMIUCocARvN7G8+NhEizKDixfDnUbFjchhZVYwh1FD6LqvxeSWFdy4bdo6TPfofG
	 WBB06wcsgnv8Q==
Message-ID: <sashiko-outbox-188110@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v11 3/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028154352.15108-4-oelghoul@linux.ibm.com>
References: <20261028154352.15108-1-oelghoul@linux.ibm.com>
 <20261028154352.15108-4-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 15:59:27 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: stale FMB enabled state when zpci_fmb_enable() fails
--

commit ab819cd022e48fbcb2d517d97710539b98750e98
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Reuse FMB buffer across enable and disable cycles

This commit allocates the FMB buffer once on first enable and reuses it acr=
oss
disable and enable cycles for the lifetime of the zdev, deferring deallocat=
ion
until zpci_release_device().

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index 5889dd227009b..a7e548a83bc15 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
> @@ -211,13 +211,17 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
> =20
>  	lockdep_assert_held(&zdev->fmb_lock);
> =20
> -	if (zdev->fmb || sizeof(*zdev->fmb) < zdev->fmb_length)
> +	if (sizeof(*zdev->fmb) < zdev->fmb_length)
>  		return -EINVAL;
> =20
> -	zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> -	if (!zdev->fmb)
> -		return -ENOMEM;
> -	WARN_ON((u64) zdev->fmb & 0xf);
> +	if (!zdev->fmb) {
> +		zdev->fmb =3D kmem_cache_zalloc(zdev_fmb_cache, GFP_KERNEL);
> +		if (!zdev->fmb)
> +			return -ENOMEM;
> +	} else {
> +		/* reuse the same FMB buffer for as long as the zdev lives */
> +		memset(zdev->fmb, 0, sizeof(*zdev->fmb));
> +	}
> =20
>  	/* reset software counters */
>  	spin_lock_irqsave(&zdev->dom_lock, flags);
> @@ -235,10 +239,6 @@ int zpci_fmb_enable(struct zpci_dev *zdev)
>  	fib.fmb_addr =3D virt_to_phys(zdev->fmb);
>  	fib.gd =3D zdev->gisa;
>  	cc =3D zpci_mod_fc(req, &fib, &status);
> -	if (cc) {
> -		kmem_cache_free(zdev_fmb_cache, zdev->fmb);
> -		zdev->fmb =3D NULL;
> -	}
>  	return cc ? -EIO : 0;
>  }

[Severity: Medium]
Can keeping zdev->fmb non-NULL when zpci_mod_fc() fails in zpci_fmb_enable()
leave the FMB enablement state inconsistent?

zdev->statistics_on is initialized to true in zpci_create_device(). When
pcibios_enable_device() or zpci_reenable_device() calls zpci_fmb_enable(),
the return value is ignored and zdev->statistics_on remains true:

arch/s390/pci/pci.c:pcibios_enable_device() {
	...
	mutex_lock(&zdev->fmb_lock);
	if (zdev->statistics_on)
		zpci_fmb_enable(zdev);
	mutex_unlock(&zdev->fmb_lock);
	...
}

arch/s390/pci/pci.c:zpci_reenable_device() {
	...
	guard(mutex)(&zdev->fmb_lock);
	if (zdev->statistics_on)
		zpci_fmb_enable(zdev);
	...
}

Previously, zpci_fmb_enable() freed zdev->fmb and reset it to NULL on
zpci_mod_fc() failure, and zpci_fmb_disable() reset zdev->fmb to NULL on
disable. With zdev->fmb kept allocated both across disable/re-enable cycles
and when zpci_mod_fc() fails (or if zpci_reenable_device() returns early on=
 an
error after a prior allocation), both zdev->statistics_on and zdev->fmb rem=
ain
non-zero even though hardware measurement is not active.

In arch/s390/pci/pci_debug.c, pci_perf_show() checks whether FMB is disabled
using both fields:

arch/s390/pci/pci_debug.c:pci_perf_show() {
	...
	mutex_lock(&zdev->fmb_lock);
	if (!zdev->statistics_on || !zdev->fmb) {
		mutex_unlock(&zdev->fmb_lock);
		seq_puts(m, "FMB statistics disabled\n");
		return 0;
	}
	...
}

Similarly, the later commit "vfio-pci/zdev: Add VFIO FMB device features"
relies on the same (!zdev->statistics_on || !zdev->fmb) check in
vfio_pci_zdev_feature_fmb_read(), and zpci_fmb_request_on() rejects subsequ=
ent
enable attempts with -EINVAL when zdev->statistics_on is still true.

Would this cause pci_perf_show() to report zeroed or stale FMB counters ins=
tead
of "FMB statistics disabled" when enabling FMB fails?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028154352.1510=
8-1-oelghoul@linux.ibm.com?part=3D3
