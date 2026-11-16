Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851569;
	b=ea2ayUfC02wgboMXdreOMFCLvV1MSkYz25Rcazr3wtohcauleZ4QVqeLEzjMMUsvD0mZ
	 TSp7XL3krpjLzCXrZCCd1cV0z/ZZfIWbvV5fMoctEd9WtinRoVluXmjcyYidtiJzhWOM5
	 1yBipOj+d6Jne3fV143Zbwgp0lAzF4yhCP5MnAmBIdrTjOWLig1DmWQ3lR07HOS1ZaVwd
	 kStLm1KBhOxv3/uz5wnIInAq7F/5slzNI316yPFQcjisHIhCa06x62Lkneff7CozVueNj
	 Tn5uUwSWx2awHOvll2sVXBvITn8LEwufK4OzIIcHNIWMxaToYXakXx1LKUK2QCdTZAg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=zpJrPJIvyiuuDq6qCaSbbga45aC/MfJ2qmpxgF5p8do=;
	b=4g8OlJ5MmvU3xCAL5mQy5yufuKJP8xK6SSvcDNXwLj4XtrR8REA8p4LOhE1lBLlR9cmK
	 GYYJSLXg/BEYN3llUnjxFjOq/bh4xO/lMfIWSn5fanfmTHayVit9ChVlEa9Kk1JVwKmhY
	 ZtfsunNrisA6sRnJ/HabdzIENYe7vh3/3QBYxMuQmF67K2Qm2LO7oDUbPzrFtultQedem
	 4DnIn7gVw6cqNZajPxIZHKtskwy5S0/YNai5pWXatQfo0uw7Xh62n0xqeSHpbC5Fp4zke
	 gA6yLfMilTzP9XoCsn4lDbrMK55dd6lEI+NIZliZqKVId4z980OeGRyZUO1OiDQOqHg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDPphFGf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 583C4606A8AB
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:52:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=TDPphFGf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E22D51F000C4;
	Mon, 16 Nov 2026 17:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851569;
	bh=zpJrPJIvyiuuDq6qCaSbbga45aC/MfJ2qmpxgF5p8do=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=TDPphFGfg6+mw7kDAFq/rlLHK7EzTePhNBx9VrH3PTq0XbDuuUU60yqGBfSKpeqJH
	 gsifIPnx3dYrDFgxsNHPasmWI1dEjDfrYLhl/tspAZddICEzh9SnbWRGIQ4Y7s1dTw
	 E3yQqq2ins1VjaqgdGeH5vQYPmoEUWd78W+InoJwgW0socl0gxNvtYM4eYbYPjSILf
	 1NLbWw5J66Z5lTod714ban1NCDOBTbBVlsoIbvJvr1mHiEjppJ6DDeDk3v51H7CjQs
	 tSfPdSlHbIGhvAk51rr7d+LvJwhxvznz70hX9tucZ1exTjeI8+fBM0LpLtOikESii/
	 OvQTITqSTeQ/w==
Message-ID: <sashiko-outbox-217447@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/15] s390/cert_store: Check key_lookup() return code
 in invalidate_keyring_keys()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-5-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-5-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:52:48 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> keyring->sem is released after writing the key serial numbers into
> key_array. Keys corresponding to those serial numbers may have been
> removed before key_lookup() is called.
>=20
> Therefore check the return code of key_lookup() before dereferencing it.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D4

