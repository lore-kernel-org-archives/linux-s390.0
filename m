Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8FDBA3BED4F
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 10:04:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788170652; cv=none; b=gJMET5CMiY6Wh0rRzXQdYxtBGyMF71WG5sCt8AD7p9QOtcDSnPgcKc2/hbcl+yZUTT7dC/7FFmGl/K4BWH1N3H54wepxYAxWYwGWwW/ymcn+Sb1WNKcCk6oJMA5LgMix0dSIsBlAQiCrf7+ZqV9o+8islqowHXgeeYEKhFg8BHQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788170652; c=relaxed/simple;
	bh=eKWkHHk9sXMxUPo8fBPD1x+U+rqh9Zgtb0QV730u63U=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=i27RG7cni1nmj2azYPxMcuTgNmuO4Ngfo5w1BfAprrL5nl9Ig7C21O0f3m4dM+70+ZaNFg85gMEfhc60R1ARTrxTXgY0QXSETbMIt+LJWYwcuh3O28p0H4TetgCJOrj6jC8E2MJ+N72oK/gwloGsLgXFo8PlXxa75IoNa0zrmII=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=iSts4nqQ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="iSts4nqQ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C07041F000E9;
	Mon, 31 Aug 2026 10:04:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788170651;
	bh=eKWkHHk9sXMxUPo8fBPD1x+U+rqh9Zgtb0QV730u63U=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iSts4nqQ6B91RFCONDfFykJLdeRmTJwrZxYAGF/+RqJayITRFpXwt2HxubmqphTx7
	 ZCvep7VPgR+ml4PS4lAshLvAqrOjIyAjzeJfcFSNQUonvBMHH4DbzMDPXJXf/iumbt
	 dhKyTbgvHTAE6/pJP1wbh0qtNsMA2ZOnauOoGm+1zR1HNoF7GR2RKzpsArV9g9o+Lz
	 XRY3TcwXe5TRlhhKjAeOEBZJJ15YEfqfwk1A4znUjs2FB+E1jXVstz/PM79IyFOrhS
	 FID5puf7DAT9qYXaWrV6NpfhAzpAzV4Lm1nUtqioqHFplLYUVHA2wXtePkI7wOnMqJ
	 DBG0S5SY/26Fw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 7/9] s390/crypto: Fix wrong return code to engine in
 asynch callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260831083838.3703-8-freude@linux.ibm.com>
References: <20260831083838.3703-1-freude@linux.ibm.com>
 <20260831083838.3703-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 10:04:10 +0000
Message-Id: <20260831100410.C07041F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> When crypto_finalize_hash_request() or
> crypto_finalize_skcipher_request() explicitly completes a request, the
> do_one_request callback must return 0 to indicate successful
> handling. Returning a negative error code causes the crypto engine to
> assume the driver failed to take ownership and triggers a second
> completion via crypto_request_complete(), resulting in a double
> completion. This pattern occurs in paes_s390.c 4 times and once in
> phmac_s390.c.
>=20
> Fixed in phmac_do_one_request() and all four paes do_one_request
> callbacks (ecb, cbc, ctr, xts) by returning 0 after explicit
> finalization instead of propagating the error code.
>=20
> Fixes: 6cd87cb5ef6c ("s390/crypto: Rework protected key AES for true asyn=
ch support")
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083838.3703=
-1-freude@linux.ibm.com?part=3D7

