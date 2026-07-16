Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E81D17082D;
	Thu, 16 Jul 2026 18:05:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225135; cv=none; b=Fe0Xtcuf4iD2rqhXiQVf386cQ6gnEcddBbHEWjlm25FiturI0BZykha3er57st21DjIp4siyERv/wCjbHRt7+UFQ2QvuWU4uGzB3tLpF+OauyI+crvq7LhQ+jk4g83Od2Pi0A+nzpUJwVWkFdGhJZ8PX3NVSO3Wrr97Z4EAS8Rk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225135; c=relaxed/simple;
	bh=cQJyuK6K8ywZTzhFad6durtHt67MP1+6n+6GEXCW05k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tj/yNcm3ycO99wnaH2NM/ePJV/hsuFWn9JISE+YYJs88u2KPp5RrT2UVJh0bD+iDITWq2Pw+JIElhks4l650POdMLm9TzRMhHMa9cfnzr1hDf/X/i609YRuI4SQwTh8TqKa97K0lRnB2XOJ199q4gOFf4ty2/SdkQv/mfaau2Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bJVgdfsn; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bJVgdfsn"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 395DF1F000E9;
	Thu, 16 Jul 2026 18:05:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225133;
	bh=f8gmC5isiyfadw0i387kPSgrpvyHEhu6Xks+kgun+TE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bJVgdfsnu9784gxQatahlJ6UV4AM5YPQwffz8BpF73z0ThMdmcywbMDIT0p0OmTLI
	 MSNBekkGGtS+afzc5/90UQc9KkMZnyETxvjxlG8HArSUUugR1xIE5Thw1+hookDdxo
	 cjeQwBC+mJXpfyI/AV0YdGlWNJScUoRqidTGaEEFgu+t8Ui4BdK1Fn0ehV94qeAOGQ
	 u/iwxKgWrJrN+A3mohEYS9B82m9zoI53dLhl2mgIvRf7z57njKSqQo3F52/9nrN0/6
	 +EOymZilPEtd69dv9iS6yr/YVBRV2Hr1wl+vx1nqci9VcTfUw9L/Mae2+iKQiY5oCK
	 LvMwE6UZvpWaw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/4] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260716175241.1039-5-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
 <20260716175241.1039-5-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:05:32 +0000
Message-Id: <20260716180533.395DF1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

New issues:
- [High] The newly added error path for `kvm_zpci_set_airq()` failure uses =
the wrong ISC value when unregistering the guest ISC, leaking the guest ISC=
 reference and potentially corrupting the host NISC reference count.

Pre-existing issues:
- [High] Missing state check allows multiple concurrent `KVM_S390_ZPCIOP_RE=
G_AEN` ioctls, causing memory leaks of pinned pages, `mmgrab` references, a=
nd exhaustion of global `airq_iv` structures.
--

--- Patch [4]: [PATCH v2 4/4] KVM: s390: pci: Fix resource leak on IRQ regi=
stration failure ---
commit 9f5448d2e142dd7c73a306c74cf6bad6443d3218
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix resource leak on IRQ registration failure

This commit adds cleanup code in kvm_s390_pci_aif_enable() to free the
associated adapter interrupt resources and unpin any pinned pages if
kvm_zpci_set_airq() fails. It does this by adding an error path that
resets the state and falls through to the existing cleanup labels.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 85f4fb5d36b38..f85d856b58c65 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -345,11 +345,29 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,

[Severity: High]
This is a pre-existing issue, but does kvm_s390_pci_aif_enable() lack a che=
ck
to verify if interrupt forwarding is already enabled?

If a userspace process repeatedly calls the registration ioctl on a single
KVM PCI device without deregistering first, the kernel appears to
unconditionally allocate new resources like pinned pages and airq_iv
structures.

Because the pointers to the previous allocations are overwritten without be=
ing
freed, could this allow a user to exhaust the host-wide global adapter
interrupt table bitmask (aift->sbv) and permanently leak pinned memory?

>  	/* Save some guest fib values in the host for later use */
>  	zdev->kzdev->fib.fmt0.isc =3D fib->fmt0.isc;
>  	zdev->kzdev->fib.fmt0.aibv =3D fib->fmt0.aibv;
> -	mutex_unlock(&aift->aift_lock);
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
> +
> +	spin_lock_irq(&aift->gait_lock);
> +	gaite->count--;
> +	gaite->aisb =3D 0;
> +	gaite->gisc =3D 0;
> +	gaite->aisbo =3D 0;
> +	gaite->gisa =3D 0;
> +	aift->kzdev[zdev->aisb] =3D NULL;
> +	spin_unlock_irq(&aift->gait_lock);
> +
> +	airq_iv_release(zdev->aibv);
> +	zdev->aibv =3D NULL;

[Severity: High]
Does this new error path unregister the host ISC instead of the guest ISC?

Earlier in this function, the guest ISC in fib->fmt0.isc is replaced with t=
he
host ISC:

    fib->fmt0.isc =3D gisc;

When kvm_zpci_set_airq() fails, the code now falls through to the out label:

out:
    kvm_s390_gisc_unregister(kvm, fib->fmt0.isc);

Since fib->fmt0.isc was overwritten, wouldn't this decrement the host ISC
reference count instead of the guest ISC reference count?

This could corrupt the host's alert mask and potentially disable interrupt
forwarding for other independent PCI devices sharing the host ISC, while
leaving the guest ISC reference permanently leaked.

> =20
>  free_aisb:
>  	airq_iv_free_bit(aift->sbv, zdev->aisb);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716175241.1039=
-1-alifm@linux.ibm.com?part=3D4
