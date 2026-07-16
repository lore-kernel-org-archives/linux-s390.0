Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7E1D12571C7;
	Thu, 16 Jul 2026 18:06:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784225181; cv=none; b=J02WoBoUcgERaQYt9iRSetmtj/7kgccDC/WIRm2yFlPbs8Zu3V4lsjdPacvECDzHcRxGE0XMqT1EOF0N/g+j8INuTcYy3WqUEk1xZH2h6reGv3CQzlMNoC3P/QUuG+rz99rLpvC0fEs6cU9/oCUSNFPm4jFZaFmJl2ssA9iLxsc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784225181; c=relaxed/simple;
	bh=RYouLnu3Bw8Mqq/rT+3ntKwa53A3fM/CzmsEphvGibQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=anI4SU/Mfr3pxf4V3O1v98iHU7N2w8QDcSRj1xMIn/eAN2JYUuWWs0mHZsUacRt5gLLwMOZCU7PMZOaYTuBRjqbZLOkzxVLp3pkz765DWQ194r/CQ6UBRx22wF72Bd/SMtkL0k2UIlzP3eaHEFvXccRq5gQPkBk5xTBfegtCQ0c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Swy2UzRG; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Swy2UzRG"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5ECA1F000E9;
	Thu, 16 Jul 2026 18:06:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784225180;
	bh=pPV6wSF/Emxd7lw03VLHMNAXZeixz9koAFUZdnVTgJQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Swy2UzRGk2jFYB5ZICej7GmnDpWZxFatkncEKQc1Kvbbd6I4XNFXsfiMDtkXaXsnh
	 tO/3LD/6UTyIq3VeOPwcmHhuZNaY+jpf+g4W3QVam/MkqaiBSlh1apBKFpTuINvTJN
	 AZEKajH5Vpmis0ZEGLAMWZ51M8mC2pe02leVLh8c4tUKd0L8FV5nfEZKmQihqp/ksC
	 +t+z5M1qy8nbw95hA68NVGDQMOEYC1jtdNNbcHOMXorMpVrHvPxBTb4T7Py9I9pmeT
	 zv9DLP3S73Kt5AewOZemPOXYBYQWNB5ngxmyWKgebF+Z11UWcDsElQOmibpL8KlbMM
	 /bKF64lRX+4MA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/4] KVM: s390: pci: Fix missing error codes and
 memory unaccounting
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260716175241.1039-3-alifm@linux.ibm.com>
References: <20260716175241.1039-1-alifm@linux.ibm.com>
 <20260716175241.1039-3-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 16 Jul 2026 18:06:19 +0000
Message-Id: <20260716180619.C5ECA1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Repeated KVM_S390_ZPCIOP_REG_AEN ioctls on the same device leak pr=
eviously allocated resources and references.
--

--- Patch [2]: [PATCH v2 2/4] KVM: s390: pci: Fix missing error codes and m=
emory unaccounting ---
commit d30a6fbb3e26fd01708c6bf05d003dbb34124513
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix missing error codes and memory unaccounting

In kvm_s390_pci_aif_enable() two error paths failed to set error code,
causing the function to return 0 on failure. It also failed to rollback
memory accounting on failure. Fix both by propagating error code on
failure and calling unaccount_mem() in the cleanup path.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index dd17f8a7b4734..9fdb6e383b189 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -293,14 +293,17 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev =
*zdev, struct zpci_fib *fib,
>  	}
> =20
>  	/* Account for pinned pages, roll back on failure */
> -	if (account_mem(zdev->kzdev, pcount))
> +	rc =3D account_mem(zdev->kzdev, pcount);
> +	if (rc)
>  		goto unpin2;
> =20
>  	/* AISB must be allocated before we can fill in GAITE */
>  	mutex_lock(&aift->aift_lock);
>  	bit =3D airq_iv_alloc_bit(aift->sbv);
> -	if (bit =3D=3D -1UL)
> +	if (bit =3D=3D -1UL) {
> +		rc =3D -ENOMEM;
>  		goto unlock;
> +	}
>  	zdev->aisb =3D bit; /* store the summary bit number */
>  	zdev->aibv =3D airq_iv_create(msi_vecs, AIRQ_IV_DATA |

[Severity: High]
This isn't a bug introduced by this patch, but does calling
KVM_S390_ZPCIOP_REG_AEN multiple times on the same device leak previously
allocated resources?

If a user-space process calls the ioctl multiple times,
kvm_s390_pci_aif_enable() appears to unconditionally allocate and pin new
resources.

Will this overwrite zdev->aisb and zdev->aibv without freeing the
previously allocated airq_iv structures?

Additionally, when this calls account_mem(), does it overwrite
kzdev->user_account and kzdev->mm_account without releasing the previous
references, such as by using free_uid and mmdrop?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716175241.1039=
-1-alifm@linux.ibm.com?part=3D2
