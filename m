Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3B91742C4E8
	for <linux-s390@vger.kernel.org>; Wed, 19 Aug 2026 09:28:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787131688; cv=none; b=oPaLmPI/Oi+t0XjRRJT+P6/Y9IuhbTLlSGcwNTcP7m5pItZVGmKVJB0FF//c05WRA5XR5L/WvP0+5Be4cTMHdVdNOlj84HWPOs14Dq52DLcJX89J2IBt9L5+SyEwmbfQa+yUv/3jJzeyqYSC4xYwQusD0oEQhgmLRFKXjwxRAiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787131688; c=relaxed/simple;
	bh=rh5mMkNPfuX7nhuDG4oUJILkb/cmSuelaPA09A9aTrc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=MmtB05xu9w5cuAPjfnJDrr2TOyXRsytzxUCEnPKK6wFg8DCl+1liYubg3H04HxDjm2eQFsbiWzJ4qtLDgQwmf8pFKwONWSgB4Seo89lUIhdtleDAiJxMcYXdqLrbpaowtlba1LFNibxfNq6zpsWFmZjqH1m8maeW9PPdDfP3xn4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lfDr/FJ8; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lfDr/FJ8"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3BAE71F000E9;
	Wed, 19 Aug 2026 09:28:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787131683;
	bh=rh5mMkNPfuX7nhuDG4oUJILkb/cmSuelaPA09A9aTrc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lfDr/FJ8IX6L1s/2bufNzbKfPF/eQQFMyQP0w58QgcCtqHLft1sW3inm+jxYNjsnY
	 7CbUF3bajmoNQQ+c+qdfsEyuXb8RQGnjgH7zMOJmsqNv4EfBs1p0BuF1pJB5AZNl+/
	 4mhvVuq0lRWdrANUnUrm1iUKAYVDoa9yQpuh0Mb1g3cmcGcjqcZReWYKr3JkDVZo9a
	 hD0Sa5XYkHoGM3rwBOhXOnBPNVN93ogGvU5jgKUBoDdyZ+e7H1zTIkMfKTXmPxi3GX
	 /cbI4i9tJITv8//lUCM6wkgYi2a680baiOURZzvFEA50HFaCrMfjG2QjE46E2yQOwv
	 FWilI66UL7epw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/7] s390/crypto: Fix wrong return code to engine in
 asynch callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260819091734.7331-8-freude@linux.ibm.com>
References: <20260819091734.7331-1-freude@linux.ibm.com>
 <20260819091734.7331-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 19 Aug 2026 09:28:02 +0000
Message-Id: <20260819092803.3BAE71F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260819091734.7331=
-1-freude@linux.ibm.com?part=3D7

