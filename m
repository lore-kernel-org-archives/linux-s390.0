Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0CA9C346A0A
	for <linux-s390@vger.kernel.org>; Thu, 20 Aug 2026 14:31:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787236268; cv=none; b=Ov0GBzzkHO9RuOgmWXISvnGXy5+AaeYXcsxZDtzLdHcw67zmgRctZs0vKkvYAFIc9bJ+s2mK7r61aIJ0ocnW0fKsnutIl+PHaXTZfvpIS+Mub8oDYVkOq8UqxJuEMpTY55hSYW8XzIwJWVfv8eIzR9tjVRP1t55bZ60HpCcLMIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787236268; c=relaxed/simple;
	bh=hNeRK5dRX0O6rtEvs47b+eC3SqsXkqfFozCAkKGRxkU=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=EM4Dcm/SU0oYbqzZxRdCfEAyVFEoljx18IiqAH2A4mfgxnMen3T4bukaR9+EeOZN2v/X1AGv63o6nrK8LlbgbOmlTykTEew/KitOcLXOzivippBlf56YuQykO1DIwjrzVUQhyBKcDGmtifIMhvPHBe7iXlx8GGrDU1EYuM/z44s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MmvTaJ5O; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MmvTaJ5O"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D63591F000E9;
	Thu, 20 Aug 2026 14:31:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787236264;
	bh=hNeRK5dRX0O6rtEvs47b+eC3SqsXkqfFozCAkKGRxkU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MmvTaJ5OcqeXNJ/C7aBCFBVkyjAJGgGlcpF1qcUV6jHjbwRK4zgnSUZ/ECg/IAoVO
	 QRvlNsR1KUHNHbgX7FgHR/UwEcWczZqvY1ET5e1rUmXMSiV5+y7xVoyRElV5fkQvdn
	 9Zw+IB3x4ZeBFhdIGboWrbkS4qlBmq5yEUiqUoWposWCUvBMXZdLn/N3aYRthRgJ4Y
	 cXqvd6SY/Fxdyb7w1QmlraP2137oABL0LaviHeRkFl0PcGIks7RDETwmGYkjIrbqiV
	 lEN+cGptk/tkjT5zR1crinv1LOTiUAdmk2UgeiNarqIogFOdClhcSB0lbQe0Vv54uK
	 leyiHHtl2nH1w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 5/8] s390/crypto: Fix handling of EBUSY in PAES when
 req is pushed to crypto engine
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260820141957.19091-6-freude@linux.ibm.com>
References: <20260820141957.19091-1-freude@linux.ibm.com>
 <20260820141957.19091-6-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 20 Aug 2026 14:31:03 +0000
Message-Id: <20260820143103.D63591F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When a request is transferred to the engine via
> crypto_transfer_skcipher_request_to_engine() there are two return
> codes signaling a successful transfer: EINPROGRESS and EBUSY. However
> the correct handling of EBUSY was missing and has been added as a
> return code indicating a successful transfer to the crypto engine.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260820141957.1909=
1-1-freude@linux.ibm.com?part=3D5

