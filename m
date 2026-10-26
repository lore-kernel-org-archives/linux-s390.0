Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793012829;
	b=LsdeMgj2Rd7yL6IQXB6yDzH1DUNiAdcqbGN4Ap+jXArYOgx7glZmt0LiCiFc04dOIh7/
	 Kncf6/o3pVqQOiHoVzkF4+jYXuA0X0T5fXAKNs3KVCAdh6xVe4Sbt7za9k550gPaTCzj2
	 IguMJ9uKuJ19zLUtHkDhiVPePi4CPOTU3mNOnUhtRZWY8Ijxq8+ndYG/8pCNTV1nklNij
	 IrpAUChnr1XM2OVe+cOfGuM46ULIIVc1d/VLiykpH5BhKcNWa9LUUsr8qRikCFIPujrYn
	 v7hzGacbjS6UJOaWwjRhm5yASzYodGHSTycS0rMjJxyjgIv0SwXmPIqnpIYVx8pJxXw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793012829;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/YJexHwAVv4aIAmDZ29sN7d7dZM0kcQGm9n4ScFRbc8=;
	b=pAIRdUbkwZ1GctgAsLP8eYQ2FM0F6VhHp9/Ugz85cxWAba9+NgaWyN42KYdqsRX9D8FP
	 XukjWaEPx6a0hgOGDUl6mCbWhQEJ4qP5Fb8q4CFHYhYIsr6RYF3EJndbSFVfuyZuOSU0h
	 RD9G+S+IzJtPreDgIxDsH/nAFw72XiBurSG8qYTQM92V1zMF1Z7aOgV9UTNw5z8rNTLNi
	 CY6XRkTPj9KyN3PRet4elukR+WoE/jwk7IjjjNTzGNW9TtvHwGrE/inyV5VD5WfPtYyis
	 svPUtTSpPviLH5rmXzcTPrmNsmjbCkXiRyARuqg3L+QJscrrzWzYQbkj2twIyoXr+Zw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx0ePTLu;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7720D606A31A
	for <linux-s390@vger.kernel.org>; Mon, 26 Oct 2026 11:07:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=jx0ePTLu
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD5161F01825;
	Mon, 26 Oct 2026 11:07:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793012829;
	bh=/YJexHwAVv4aIAmDZ29sN7d7dZM0kcQGm9n4ScFRbc8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jx0ePTLubEKOseVnxXDgWM4DB+ljvV8hQr4yDCVAK5OAPIcaKmC4Omej6mfIbr3Dg
	 duNTL+r0DzrsjrCfiZnfEG5yVAbw10neKTsX549fodURw0PSyJd4q7+Iv6He53nEof
	 ljhyibVmByNHTjVwYBP2RrlFmnQHHkV6d8xYFTA1zZfsgxBG82RoEuhpjL5z83c1Ov
	 vGs6Qrl+HzvRhXXOjsZ70FEPPhkd4S6oyAemDE1Xj0zJCtg4ClkJdhK1BFbVhYmpxX
	 RK0DDblE6Cb19U6D3LmKg1YGohCV9X6iEk2cE0pMzFsPa0z03vn9a8fv2xZWct+quK
	 TywR4cRKJwmDA==
Message-ID: <sashiko-outbox-185055@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390: Use static call trampolines when kCFI is enabled
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261026102952.4153711-1-hca@linux.ibm.com>
References: <20261026102952.4153711-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 26 Oct 2026 11:07:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add support for the 'unoptimized' static call variety, which routes all
> calls through a trampoline that performs a tail call to the chosen
> function. Wire it up for use when kCFI is enabled to work around an
> issue where the prototypes of default handlers such as
> __static_call_nop() and __static_call_ret0() don't match the expected
> prototype of the call site, resulting in kCFI false positives.
>=20
> This is the s390 version of commit 54ac9ff8f119 ("arm64: Use static
> call trampolines when kCFI is enabled").
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261026102952.4153=
711-1-hca@linux.ibm.com?part=3D1

