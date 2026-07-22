Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CE6543CE6E;
	Wed, 22 Jul 2026 17:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784740511; cv=none; b=hau5YTRuLOIofLM5lB5tBNQSgRNFBL0OLJs0XrxITl3BuSXpOIxoF/ior1ZM8T41X5EJgBdvONLmSKotPacEGyYEoTMRZGVmidGDWqpmVWYGqh1xNIn8NNqZkFdUdWvhaXovO14/DBGkev5LTvk59kfXXoqkR4sqawsDLxYEYJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784740511; c=relaxed/simple;
	bh=/0s8oj0BE3NFJmToOZyVH0LZknOweTXTpNF9uloaFYo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=idQ5UYmVR+kucg972Imi9+2t5NhjTzRFX/l9EZZ8Nm0piPNPBGjwmr+wnrsdgCQZU63yaO6DeI2G49/5SHq0SsyElGusE0cG7FYNTpKi/UOHiInEV/qkHlpKBS6nsIHDPKTE17Z3j75AoH+7KrNECBKXXkWzICPXddoD5ajlSEg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=NMMH3ETr; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="NMMH3ETr"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DECBB1F000E9;
	Wed, 22 Jul 2026 17:15:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784740509;
	bh=/0s8oj0BE3NFJmToOZyVH0LZknOweTXTpNF9uloaFYo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=NMMH3ETr2b8KHoWXkDutk44g0CKia4YY+y1+IjBMgiOhcvXcbpCQl3i2mQKibxCih
	 p9n/p5oldnqznosE4UHHOCVko5PMXgTiy/j3cPsWnemr+rJr3918IcKR+WJVQiv6eB
	 l1tx+Vayb5kRj9w/jqXbMQgUDf0HnVEewpV68IGj6eMxcq/phDfSm+5tCE3A1D0Stl
	 wNMvcwoFCGO5Pq4NMb1jE2jc7HSg07s7+CBSbzfDSdcElFCP4w6dtRLavFMm1rMrBn
	 S0YfhUUY0DDnbtyswmuYXruHcZ3oqfAiNRVIKH/aLPshFpbKA8E2Aprgm0C1EwFwVs
	 Bbr2t+V5OSkAw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 5/6] KVM: s390: pci: Fix resource leak on IRQ
 registration failure
Reply-To: sashiko-reviews@lists.linux.dev
To: "Farhan Ali" <alifm@linux.ibm.com>
Cc: kvm@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260722170621.1686-6-alifm@linux.ibm.com>
References: <20260722170621.1686-1-alifm@linux.ibm.com>
 <20260722170621.1686-6-alifm@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 22 Jul 2026 17:15:08 +0000
Message-Id: <20260722171508.DECBB1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently if kvm_zpci_set_airq() fails, kvm_s390_pci_aif_enable() returns
> the error code but doesn't do any resource cleanup thus leaking resources.
> Fix this by cleaning up all the resources such as the GAITE, AIBV, AISB a=
nd
> unpinning any pinned pages.
>=20
> Fixes: 3c5a1b6f0a18 ("KVM: s390: pci: provide routines for enabling/disab=
ling interrupt forwarding")
> Signed-off-by: Farhan Ali <alifm@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260722170621.1686=
-1-alifm@linux.ibm.com?part=3D5

