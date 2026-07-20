Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4746931195C;
	Mon, 20 Jul 2026 18:25:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784571960; cv=none; b=u0KQVW6+wXz8Hw25ES2vfIUZ5var2Uk5LIoWRvSasdgYrcyT/u5uXgcH5v0swZlsG/ZskrhJKQ+k5drdbP53VDzKZFzvrZCz1unMeEreqblCgn3J7eDbssKm3u2N30RFpoDiDW/2h0yWXV7W6j/GxKTF6ZA5ceyrKvGOH8cS35A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784571960; c=relaxed/simple;
	bh=e1ldAoRhj2FKS+IwFeJw3IfxVQZI/HMV7JVapLmIv1w=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ltH7XKH0Rx9yigXWBDfc+zcaA6ucnvM2gNeSChbng4pbQHBtIu0+F/8uFyUd/WmToZ0GHSBRxEt6o3To/pAwBi+JRfcNszCVOM5YIXT49eHePUlv3uF7j4V+me0ctIDriXQcjVOeSJkLk8oM/setHtyWyxBOnIql963lNaAQmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lmWmuQMp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lmWmuQMp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A29C91F00A3A;
	Mon, 20 Jul 2026 18:25:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784571958;
	bh=Bl+VSkYGSQtFrRs9H01oozN4gcXgtC8DJ1Gd2TOCg6I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lmWmuQMpWjB8xpW21pjyQeIHKrL0VUfJxgw1Bk0Nl0vKs6SKW6r86mQfTst6DmZXh
	 gTcjmZfwCUvSch8XGx3gf16rOIllUW5ux//ejNwEqmL8UyFUzeCZIG9IrQl0o+smn1
	 2YrPrY5DcHezXq9wEn/0UmalaZ0P28eGeZnXFLRF+HMed18+mKs16ZpBzxXx8Z8RTP
	 aSGujn03CMDbj+jIQDDcXhwdqJSeLM9fVYaNfbafgf+iTT8FNnasfJo08v78lr3bpV
	 nYoLRn2KKFIX9xyrYw7ZaMsH8cdsk7j5Zd0Kk1jr5AN2mmnNqvRQJJeKepmWtg9ie8
	 qdnlmANiANetw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 3/4] KVM: s390: pci: Fix NULL dereference on AIBV
 allocation failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260720175819.1723-4-alifm@linux.ibm.com>
References: <20260720175819.1723-1-alifm@linux.ibm.com>
 <20260720175819.1723-4-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 20 Jul 2026 18:25:58 +0000
Message-Id: <20260720182558.A29C91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Unbounded resource and memory leak on duplicate AEN registrations =
due to missing state check.
--

--- Patch [3]: [PATCH v3 3/4] KVM: s390: pci: Fix NULL dereference on AIBV =
allocation failure ---
commit 9b0515651fd32d61d1da226af14173f1630435f4
Author: Farhan Ali <alifm@linux.ibm.com>

KVM: s390: pci: Fix NULL dereference on AIBV allocation failure

The airq_iv_create() can return NULL on failure, but the return value was
never checked. If it fails, zdev->aibv will be NULL and fail when
derefenced in kvm_zpci_set_airq(). Add a NULL check and free the previously
allocated AISB bit and zdev->aisb on failure.

> diff --git a/arch/s390/kvm/pci.c b/arch/s390/kvm/pci.c
> index 9fdb6e383b189..85f4fb5d36b38 100644
> --- a/arch/s390/kvm/pci.c
> +++ b/arch/s390/kvm/pci.c
> @@ -310,6 +310,11 @@ static int kvm_s390_pci_aif_enable(struct zpci_dev *=
zdev, struct zpci_fib *fib,
>  				    AIRQ_IV_GUESTVEC,
>  				    phys_to_virt(fib->fmt0.aibv));
> =20
> +	if (!zdev->aibv) {
> +		rc =3D -ENOMEM;
> +		goto free_aisb;
> +	}
> +

[Severity: High]
This isn't a bug introduced by this patch, but does kvm_s390_pci_aif_enable=
()
lack a state check to prevent duplicate registrations?

If a guest VM or userspace process issues the KVM_S390_ZPCIOP_REG_AEN ioctl
multiple times for the same device, it appears we proceed through the
function and allocate new resources without freeing previous ones.

Could this result in overwriting pointers like zdev->aibv and zdev->aisb,
along with overwriting account info in account_mem():

arch/s390/kvm/pci.c:account_mem() {
        ...
        kzdev->user_account =3D user;
        kzdev->mm_account =3D current->mm;
        ...
}

If the pointers are overwritten on a duplicate call, does this permanently
leak the host resources, including previously pinned pages,
mm_struct/user_struct reference counts, and airq_iv structures?

[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260720175819.1723=
-1-alifm@linux.ibm.com?part=3D3
