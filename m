Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 54C1141A4E2
	for <linux-s390@vger.kernel.org>; Fri, 21 Aug 2026 08:54:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1787302489; cv=none; b=D1eoGRb1mLXC7PRxGxevGyDZ4UgSfctPfGzdV3Csa+7MDt7QfWYvJxh5Kw+IqlIvS+ECI3BqkpQRLQhy9PF4Nv0Eg5BYG2K8t0vt7LoklNXWLy43NO7EH0hz/SfL5BXkU9ISomu0L+b8mW50IB0gLnb/IBTClX32H3zWS848jyc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1787302489; c=relaxed/simple;
	bh=yWPkqWSLcka+Ho1cuA+zZCNAp0VX1tYapst+/XTRN7Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=o/EVxLmjddPmwsO5UFDe5689ohUk7aSEEsELo5nWxYcUbeSEhFlDHfq1Ieu9FjGvbHjEuc5IqQyskOUifXtk5aX6Qa135S35flesm8Yn976C5Dc2P9z5C1TwTJgdwD8CJ6RqhciFFYmhqdndNnAaaJmLYD9F4rz2oTTOKpDUQtg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ac5xRewp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ac5xRewp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BD62A1F00A3A;
	Fri, 21 Aug 2026 08:54:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1787302488;
	bh=yWPkqWSLcka+Ho1cuA+zZCNAp0VX1tYapst+/XTRN7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ac5xRewpH1eQ3O2GQGxBdxbAxJglOHxsFFALCz/r71IJt40ECOUWaTnyfjQ2JfNpC
	 fJa1oXM6UkPgidbi+2fpSxpUFiqk+1aLfp1jvxt7HGXLy2RF/bzJ7ux88azPnrvACH
	 SXHm622k2iXNOtxxcFIsYJ3uBW3exz/lnQCoc/a6RkNPjONGOYpSSviLhczPc7ijym
	 YayHSpKvDMC2Ji5y3qgc/gfQRGSnLGJTHntj4sCFaxnjglv8gsuiKkKAEO0FmE0Rk9
	 ck9yssYsR4UzDHMy0tHnsnx/Ov83EtOoOgXO/wOGaVTAbjRXIRybA/Q9uLVtE1J5jX
	 tYQtu2yraOjJQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 7/9] s390/crypto: Fix wrong return code to engine in
 asynch callbacks
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260821084648.23222-8-freude@linux.ibm.com>
References: <20260821084648.23222-1-freude@linux.ibm.com>
 <20260821084648.23222-8-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 21 Aug 2026 08:54:47 +0000
Message-Id: <20260821085447.BD62A1F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260821084648.2322=
2-1-freude@linux.ibm.com?part=3D7

