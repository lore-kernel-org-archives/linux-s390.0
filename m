Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CDAF748A8C2;
	Wed, 16 Sep 2026 21:49:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789595371; cv=none; b=RpfZ73AO1kdUfvgNiyOo2IpWT8Pg8nU0ev9tx0yU8ZnsrTZJLHl9OtEbIHAJXmHNoeqcgsI05s3rx17Dmk8lliUSdlq1FXKMuegVupzTR+sMJxtwoddCqhcZsz5YdryfdHm0fOq5pPzifxTVZSISD67PkXHOnCdC/gNFO2bYT0c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789595371; c=relaxed/simple;
	bh=zGADq9EsEWSJYPpofiLfFa6hiJMx+ogPKD592DHOae0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=aFVAS8dGkHFWH/7hhI+fpQy2JBbuc/tmegiSlTF/CGk2KMqSanwHbWTLzkubnjd8uc2Q3530Qwtqmv3Rd/9PjGBmGl7PlG6FG6Rq5DIVg6eeZC0HEik1vEVW9kbRwqxCNgJ2rPuw02lhqIEbXocSBMbP6P5MZw01QPY37shdFoI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=dR+smk90; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="dR+smk90"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E2B711F00893;
	Wed, 16 Sep 2026 21:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789595358;
	bh=Xl4DRmGjNtLX+7vuwsWvvJPK81CMe55Q4AYQ8T4DC0U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=dR+smk90CGZoNtHr13S+v3AgC6F4YolpnIv6jE0ZCY71aszyFBFZTUvgpPaIc1Krs
	 gd58Gs3zntP8wBBOSsMaIRuYCZHkdvNdsDuLh0WaeZw1VNAAw9zKGUz2Y0zMnn/IBY
	 NWub8ioBEdP+0c5HnSKRA89egZluxHGzd5a+FbhLqcRXcZ45dfizUgNVzfsvMMAubv
	 pjniIJRVVuz/undtCdLkUCeQwwmftUFmcP+pTLQN8RYiAb+mDb8XKKkhaBjHHSk+ax
	 P6XbysZapHMr9G3SLZrMMRVMCo42vpggX1+lBw91m2p95LvR28Eu057szXmDfOAeS6
	 nLAXqCd/bk5uQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/4] s390/pci: Reuse FMB buffer and preserve state in
 device re-enablement
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>
Cc: kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260916213222.233-3-oelghoul@linux.ibm.com>
References: <20260916213222.233-1-oelghoul@linux.ibm.com>
 <20260916213222.233-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 16 Sep 2026 21:49:17 +0000
Message-Id: <20260916214917.E2B711F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] s390/pci: zpci_fmb_reenable_device() unconditionally enables FMB
--

commit 7c558501997618a3d6ef7ed7b44346ed809628a3
Author: Omar Elghoul <oelghoul@linux.ibm.com>

s390/pci: Reuse FMB buffer and preserve state in device re-enablement

This commit introduces zpci_fmb_reenable_device() to check and ensure the
function measurement is enabled. It avoids freeing the FMB buffer during
disabling, allowing it to be reused when re-enabling measurement. To track
this, it adds an fmb_enabled flag to the zpci_dev structure.

> diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
> index c055a9ad09724..5d1f5b75bff5e 100644
> --- a/arch/s390/pci/pci.c
> +++ b/arch/s390/pci/pci.c
[ ... ]
> @@ -224,13 +229,39 @@ int zpci_fmb_disable_device(struct zpci_dev *zdev)
[ ... ]
> +int zpci_fmb_reenable_device(struct zpci_dev *zdev)
> +{
> +	u64 req =3D ZPCI_CREATE_REQ(zdev->fh, 0, ZPCI_MOD_FC_SET_MEASURE);
> +	struct zpci_fib fib =3D {0};
> +	u8 cc, status;
> +
> +	lockdep_assert_held(&zdev->fmb_lock);
> +
> +	if (!zdev->fmb_enabled)
> +		return zpci_fmb_enable_device(zdev);

[Severity: Medium]
If FMB is explicitly disabled by a user via debugfs or by a guest VM via the
VFIO FMB feature, will a subsequent device hot reset silently force FMB back
on?

During a hot reset, a sequence like zpci_hot_reset_device() ->
zpci_reenable_device() -> zpci_fmb_reenable_device() is triggered. If a gue=
st
VM or user previously disabled FMB, zdev->fmb_enabled will be 0.

Does returning zpci_fmb_enable_device() here unconditionally enable it agai=
n,
overriding the user or guest VM configuration and going against the commit's
stated goal to preserve state?

> +
> +	fib.gd =3D zdev->gisa;
> +	cc =3D zpci_mod_fc(req, &fib, &status); /* Disable function measurement=
 */
[ ... ]

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260916213222.233-=
1-oelghoul@linux.ibm.com?part=3D2
