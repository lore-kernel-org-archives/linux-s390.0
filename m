Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B25FB2153D8
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:30:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236232; cv=none; b=EkXsZPCKgsDRRqyXB5JxZfpNnju2hH5z2jft4fIfPmb+IstegOJ+FA9q7ZIH1k8s90CGVsAG5euEhO2v6Tf09DkRrYgtp6rq5PWCEKHsVLs6A6RoUKWfa9d+lY0E/r5RjWEfphQm+bSo0dGM4USaSs+nycAGigOkVXEkkcOsBLE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236232; c=relaxed/simple;
	bh=MgAu/AU+AlkAhG2qRKQi+n8Bj76E0Q7tfgjs0QAIW+E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cwrOM6fOT7RtVxPjpbKb3u7C2LtjI5mX8PdVBDmeg9JiD9Ji9jwM6dMjnXaDQPrhaQAQJPFu+H3omJtnt0f/bzGgBIIzm+qB7tou9tfYnVOHYzFSsku+tzsdJz4weho6eyQIuyBLtEATcUrynjGJe/aZGvln8Xc1IsIWshemWWY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DRysiQVF; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DRysiQVF"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 046301F000E9;
	Thu, 20 Aug 2026 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236231;
	bh=MgAu/AU+AlkAhG2qRKQi+n8Bj76E0Q7tfgjs0QAIW+E=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DRysiQVFe3G6c3k4eXXQHALfjE/5neyq1mlreNZy2EEXQe7MXyx2SvrRvVyW+0Zcf
	 yVsXlmGFLsoLmO1hJfW8RlCfoEWbMYRietbcJhmQK/oHqfrqm8nWTBBVT+iqdrMhDq
	 l38Kr0N9RvRvHY3gtEapTADMvAKKDzQO5Rp62IGEDSoHObP5tKHupz0pSV4agYf/yQ
	 UiU+kx4+ZgJK6L2s5ZDrEZkjaTtMeY4ww3qEPaGqOP2pqS/trh1JuCs36MLSX17QSv
	 LNsLmFlh/YrBcYjYr9/E1CR+2131XtmicVEp4EN5b6A735IpeXrV2zHj5q3mAUNPs8
	 iXQiplbBdDt0w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 1/8] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820141957.19091-2-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:30:30 +0000
Message-Id: <20260820143031.046301F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> All the 4 PAES cipher processing loops were not checking the return
> value of skcipher_walk_done() immediately after calling it. This could
> lead to error masking when both the walk operation failed and a
> subsequent key conversion was needed (k < n condition).
>=20
> Add immediate error checks after skcipher_walk_done() in all main
> processing loops (ECB, CBC, CTR, XTS modes) to ensure walk errors are
> properly propagated and not masked by subsequent operations.
>=20
> With that comes a slight rework around the skcipher_walk_done()
> invocation. It is now necessary to check if the walk has already been
> finalized (walk->nbytes is then 0) or not to avoid double
> de-allocation of resources held by the walk.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D1

