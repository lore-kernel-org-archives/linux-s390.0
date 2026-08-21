Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 313213BE155
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302348; cv=none; b=a4eagv6MLDEIC+KUNAklMBmQrVJXyvtxztR3cRfxF1aiYoHSy4drpGVWHndyXIKV0myzWbLJ1+FpIqH293XA3ogty4sdHOF90aiCzbyWeNfg2WAWEvlbrfQV9xlbEq8WUodyC3qY49HQcxQXy4bLJTk3BdKw/Bd69VhG/n355pw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302348; c=relaxed/simple;
	bh=a1yr7dNXuIKM4SBPmcurSdn+nD3yckFFyz2VxWanimw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=onprA019/4cjQ/x7Ujcoj0CrlYMLbBpi8ra67bgpiiuEOX2c9vVVSp/gl4RUPMv4RvSqy78PXQvjIHyLHC7+NVsdqJGNw9mizCjBHcaGD4xF8lzbDVe4i5RFhHaE1K1/I7PfZaxoX51KMxb2ofwU8rhkyRHN1+1o9O+7fevXfGw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UZo395T9; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UZo395T9"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 73C511F00A3A;
	Fri, 21 Aug 2026 08:52:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302346;
	bh=a1yr7dNXuIKM4SBPmcurSdn+nD3yckFFyz2VxWanimw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UZo395T9KL9Ei/E6hyQGaFqpCTW5XiCorrq+kk81qGimIJfVwazsV2wjVoeAiVUDy
	 fjDYBASwRTCzksqhVp3D3RYnIU747tPMOkfzpMheYtRrU+8uDOHhVIWFAuejeUMLsF
	 dOWANKq0Ekw/3QqbemIIl19YbqQZFSpIHf3muGKMu+3sG/vJRYNGAPskeuC9N3afLm
	 MxehlJrHoXGC1H9AHIXYvM8wvm89dsiHb9XokP7y8F5eIZOW13F6Dgb6BPMvuBf1RY
	 9M2ZqPf2twRGvagxYwhw0IyYmmoZ/tVIAyB1MjNwskEeMdvPjtDi6hCzwy5fo6g1Zu
	 41ytvBbrsa2Dw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 4/9] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-5-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:52:25 +0000
Message-Id: <20260821085226.73C511F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The 4 algorithms implemented in paes_s390 never had any cra_flags
> set. So add code which sets the cra_flag to CRYPTO_ALG_ASYNC and
> CRYPTO_ALG_NO_FALLBACK.
>=20
> Fixes: 4ccd065a69df ("crypto: ahash - Add support for drivers with no fal=
lback")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D4

