Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CB7703F4DEB
	for <linux-s390@vger.kernel.org>; Mon, 17 Aug 2026 10:57:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786964279; cv=none; b=mtU9x78ITUQlBWMm11fDemIRDAaxBHKntf5BYCCk3uOtR3C1M13rpnW6QfQTmUNNnRMKfgJoBPSZcl/X+tKzHfZRHl2lJi9jWpM/iA73XP3vdSkbklxCh/D+DGZpFpja6bI+8fhmG/djFuum/ZPvC66wSRP7m4rdS7gEvvarNsw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786964279; c=relaxed/simple;
	bh=hZ5pv1gFwmYybs706uyndXZVlK+zxtDUHkXyzsFqkK8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=cqzahW/BsRkAj9p5f9tRkFKp+eTxzBg8fAwxl92M/7oOe1i/PzufsGP7U8tvJFn317dXOZdZqf2nGL/wtPT4BqwQD4UkMgwhi556vTlvShyg2jIaMXZ+bXLdV5i0mtcdZTcztHboPUBBxWS8bISsORF/uYC+g0KCJU2OrVUo0ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J6LzBp1C; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J6LzBp1C"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C10CD1F000E9;
	Mon, 17 Aug 2026 10:57:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786964274;
	bh=hZ5pv1gFwmYybs706uyndXZVlK+zxtDUHkXyzsFqkK8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J6LzBp1CoDEI2nNSKHvTFsHRfi9CXwSR6TfAH+CCz0QgmuW7SgavriK+JCjDae6lp
	 Euwsg2Xa17sNaZUTTqPRsSafylwJNeFMooIWhQSzAiHuuk6h68qihRUdvSQ87qZ7zs
	 H8VTXS3U9InRcHtyRMH7Us0C1d1Un+7bkV8ryxIxByN7Iwdl8zPE0ZtKV7An+/BV5T
	 twFRDOmT9v5RN9bA1RKqCewk8d3PDLCRe4eLa/uv6ShDuJ81PN91N2rGEbiPmX1uy9
	 fJMshLl9CWJpFSRHARIKYLFUjChxQJQbVJlTW+RKufSIaRwOwXRLEjqfPa2/BAd3Oo
	 yrNwSFXFB4ulA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 4/6] s390/crypto: Fix missing cra_flags in paes_s390
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260817104203.74033-5-freude@linux.ibm.com>
References: <20260817104203.74033-1-freude@linux.ibm.com>
 <20260817104203.74033-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 17 Aug 2026 10:57:53 +0000
Message-Id: <20260817105753.C10CD1F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260817104203.7403=
3-1-freude@linux.ibm.com?part=3D4

