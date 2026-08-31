Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BFB7A542809
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 15:29:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788190147; cv=none; b=IDwl7pVp6txUjV38Gaa9bwQrS7gcikL87bkglypHURlfYAJPyAyHW30az6+ZC+P6I7DTWMSlP4mufSGGwiVm8Rh19n2NlTey2w5eyAbaUDJTq8rI+/5tEOp+5mKbHmMojhur55LAguOH8l2zb+XRm5nBYrBCKiqVRTflf6xKmhk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788190147; c=relaxed/simple;
	bh=Tdt5MbEm3JTGR/GcGKlKWqdQpvKDQ40PKb2D9Cjr8I4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=FYDW8XBthb+ZdfWTHfWCp9Pr42ttfBQx2AU+TeFIVT+b4zVwqlGU3hMpMF4Tp+6vURCBlwmiOsZx9sbCHe6npBwZr4gkmFp4a2OkbQ9jODdyYXImLyhK3lxhwTJDtTlNF2sezT4JQRsIbQoukANvSm6gJXIHFBoY6s7jYxRCMVk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PcrD5EFT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PcrD5EFT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 11D021F00A3D;
	Mon, 31 Aug 2026 15:29:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788190146;
	bh=BM0cDgi+iHlZckoQJq6G6Rb7aKNfA6+mqAx4cSpDKF8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=PcrD5EFTrC/5VlrySVjTu6aaraS4AkRQDFkpTFkBX6+ypi9SFZE8gNRLmHEYW/Ugk
	 POY0RL7mtNHyfhw2CzWu36OzRRjVcTg0jQi/p7Ps84+1YQR4lr66ukYhaBy9lsg7G2
	 fxop+WBz/PHUWcW1/H1aCUId3Uv083ybqjdZAGiAljx8WMtyAgkIAk44UBlALip/0o
	 7Al5utLyuEiATh9H+yx03dhJnQhWzlBd2mJnB+SKFAo0iQej2Igp1F7siClZtZg2ez
	 8h/eyWkxnzmMycyySYeAnj/fZa6DnGqut90//G0GlsK2S1lAh5suHcBQ55GdTbpCNa
	 ci2Zn0n6O1dPw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18-5.10] s390/zcore: Removed unused variables
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260831133314.4125787-294-sashal@kernel.org>
References: <20260831133314.4125787-1-sashal@kernel.org>
 <20260831133314.4125787-294-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 15:29:05 +0000
Message-Id: <20260831152906.11D021F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> From: Heiko Carstens <hca@linux.ibm.com>
>=20
> [ Upstream commit 0a2aa995c0a1d363b5f0803862e84834e3876ae2 ]
>=20
> allmodconfig with clang W=3D1 points out unused global variables:
>=20
> drivers/s390/char/zcore.c:49:23: error: variable
>  'zcore_reipl_file' set but not used [-Werror,-Wunused-but-set-global]
> drivers/s390/char/zcore.c:50:23: error: variable
>  'zcore_hsa_file' set but not used [-Werror,-Wunused-but-set-global]
>=20
> Remove both of them, since there is no point in keeping them.
>=20
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Alexander Gordeev <agordeev@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831133314.4125=
787-294-sashal@kernel.org?part=3D1

