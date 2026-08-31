Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F22052D9EDB
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 08:55:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788166553; cv=none; b=fmGvDuzpawO3uEr55oDvNd7GsAiqMZWi6JlgArFtUCbWZ9ifrWI9MVwQ183CDWwlBBf+HzFwS7qDGaorGDGVI2f0fXWhAIVgGMAXqzmXOaCLvqryKZYqNxAg5r1alpAI4mi2YznGrpWkzXKMCXWTSv6m5h815xkQpmd9RKZ1g6w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788166553; c=relaxed/simple;
	bh=1Pdmzka03gJoCy5U3Vpsy/cdzpdzZSgBW8jdLRs+Y1A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=tdkIUTDVpvViA1xjklBWTmOfnFc7ygzkEDlX2m4ky/gJmJvBw0bedjjYzpuIj/Jjh5jShjYU1XldkatyxYC17NpAbublnnbRQf6PyaqlYWIFHopD1L8jBDiyFnuntmo7VE84n/qwyMESqCiNSoSxVoRUj5px2b4kS1x4T6nRnFo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=StCSz8WM; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="StCSz8WM"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3DECB1F000E9;
	Mon, 31 Aug 2026 08:55:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788166551;
	bh=1Pdmzka03gJoCy5U3Vpsy/cdzpdzZSgBW8jdLRs+Y1A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=StCSz8WMwVxOybZhXAMlyJa54M3G9xOxyGAKsD9RLOAcd5+cXOrKTMF9RsxIJe13o
	 0vFJBu0nPIV6ScpZ/4IGDAQx5pV1OTQ7a3fLRXR/RcZ1a9J4J/SmzkLWK59nPcrtDu
	 4RQ7PkG+XOCiQbFLM/lqI6gIwB0Dlz1V0X8w+86aEPUM1ySCtHuiOBxOlNRuzIy2bS
	 zH9wH8DANICDQZtjst/TNtajW8Xz/0xC991Y3xlTE0EYNcFTxT/14bk/eOzRa0FlKv
	 GLOfi+PgbGqsHDDx7uuL0EUn/5pAFWYYa3OKMq/AABaE2wXXttdXcNOj6BFkize3gA
	 vkF5rdS/ojwiA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 1/9] s390/crypto: Fix return code handling at
 skcipher_walk_done in PAES algorithms
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831083838.3703-2-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-2-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 08:55:50 +0000
Message-Id: <20260831085551.3DECB1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D1

