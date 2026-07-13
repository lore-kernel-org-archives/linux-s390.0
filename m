Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E544333A005;
	Mon, 13 Jul 2026 17:43:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783964606; cv=none; b=ccl7TsHBwHT/PYwzgl8ZQwfSKimiY7llxFWshIFqfottZhioJ7XdbvqhJiIoq6stDts+Nat0qXKM85gd7vCaLiCj9CVxl3bMNMJNvYj/wUwtsl2VibpQS8NzCSdfrfFLnwhPJhDAbzjeSyQ1DE3JskcqA0Wmq8EpSVR6aNxRgMA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783964606; c=relaxed/simple;
	bh=b6qSWw3PRoDgqfxecCiTmopGGxKBItqsL5JAktOhe5s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=u2DwHEPXsmKP2Ctj92WH7UJF40O4DjAglZ8Ay2KaPZGmLEn3c4nqNHp1V1LRPDz3CBfxBOlq13O6PHaLORgYJcv7ZIWZdZryOClepll8/l+zMhi4EyG7r5DGHEnzUX8fXSys1FikvbYZZh+lUPYFsKeu3iTg5HooZyGqCi6wrX4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=C16/SslN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="C16/SslN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24BCB1F000E9;
	Mon, 13 Jul 2026 17:43:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783964604;
	bh=T8GnWJtXAV1F34VmsEgqk8B90vb+TbG649Ii0HwT41A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=C16/SslNYPgk56MxTjeQcqElgYyKVT+OvLRDBrYvWIKYoqn6U/p/QCCr5X2hILNIf
	 mgFrFn5eZJuGxfD4IYfktBjBX66eSSvAi/hHmdaeo+ZiTJNyf1Ci/Xtok+seZ8m1m1
	 +XIO+rVIgNiCM5SrjcGmvo5I7hG02cs42XRb6/136Qvg29rDrCo61UB8j1LRYpyFAI
	 PH2INONMv0aao00Q3wikWG2+h2IH9aaF7QyeBf/GM15j87/JdFwGBiFB2CzJb0TeNi
	 N+NfjhXNBZxVUDl65yyQ2LMusfK7XCXHE03pw+K30Y/dtaRQ0713atbhSRkxwRouBQ
	 qlLj2YI6sp6Qw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 4/5] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, kvm@vger.kernel.org
In-Reply-To: <20260713172600.1284-5-alifm@linux.ibm.com>
References: <20260713172600.1284-1-alifm@linux.ibm.com>
 <20260713172600.1284-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 13 Jul 2026 17:43:23 +0000
Message-Id: <20260713174324.24BCB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The error path for `kvm_zpci_set_airq()` failure unregisters the w=
rong Interruption Subclass (ISC), leading to a reference count leak for the=
 guest ISC and potential state corruption for the host ISC.

Pre-existing issues:
- [High] `kvm_s390_pci_aif_enable` lacks a check to prevent multiple AEN re=
gistrations for the same device, allowing a malicious userspace to trigger =
repeated allocations that leak pinned pages and `airq_iv` structures.
--

--- Patch [4]: [PATCH v1 4/5] KVM: s390: pci: Fix resource leak on IRQ regi=
stration failure ---
commit 3065114852ad54412b30b74a97b10b479bcd1a82
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix resource leak on IRQ registration failure

Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
the error code but doesn't do any resource cleanup thus leaking resources.
Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB and
unpinning any pinned pages.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index b3ffb8c255107..9a16a2eac65b8 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -334,11 +334,29 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,
>  	/* Save some guest fib values in the host for later use */
>  	zdev->kzdev->fib.fmt0.isc =3D fib->fmt0.isc;
>  	zdev->kzdev->fib.fmt0.aibv =3D fib->fmt0.aibv;
> -	mutex_unlock(&aift->aift_lock);

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pci_aif_enable() lack a
check to prevent multiple AEN registrations for the same device?

If userspace repeatedly invokes the KVM_S390_ZPCIOP_REG_AEN ioctl on the
same device, could it blindly allocate new structures and overwrite tracking
fields like kzdev->aibv_pages and zdev->aibv?

kvm_s390_pci_aif_enable() {
    ...
    npinned =3D pin_user_pages_fast(hva, npages, FOLL_WRITE | FOLL_LONGTERM,
                                  kzdev->aibv_pages);
    ...
    zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |
                                AIRQ_IV_BITLOCK |
                                AIRQ_IV_GUESTVEC,
                                phys_to_virt(fib->fmt0.aibv));
    ...
}

Would this irrevocably leak the previously pinned pages and airq_iv
structures?

> =20
>  	/* Issue the clp to setup the irq now */
>  	rc =3D kvm_zpci_set_airq(zdev);
> -	return rc;
> +	if (!rc) {
> +		mutex_unlock(&aift->aift_lock);
> +		return rc;
> +	}
> +
> +	/* Start cleanup */
> +	zdev->kzdev->fib.fmt0.isc =3D 0;
> +	zdev->kzdev->fib.fmt0.aibv =3D 0;

[Severity: High]
Will this error path unregister the wrong Interruption Subclass (ISC)?

Since fib->fmt0.isc is overwritten with gisc earlier in
kvm_s390_pci_aif_enable():

    fib->fmt0.isc =3D gisc;
    ...
    rc =3D kvm_zpci_set_airq(zdev);

If kvm_zpci_set_airq() fails, the cleanup path eventually reaches out:

out:
    kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);

Could this cause the host to unregister the host NISC instead of the guest
ISC, potentially leaking the guest ISC's reference count and corrupting
state for the host ISC?

> +
> +	spin_lock_irq(&aift->gait_lock);
> +	gaite->count--;

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260713172600.1284=
-1-alifm@linux.ibm.com?part=3D4
