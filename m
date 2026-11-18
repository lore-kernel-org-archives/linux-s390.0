Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013542;
	b=1JFC+QBBftSt0X85KTIqrF3QXfafI4D6gm7/jsonRGVRrzkRqBI8JlWDYmAx55T3Wrd0
	 JjOo/yAf1OmzKHAclK9z5c4tST2j1YzQ9QsfcIT6XVnYH4WoJbSAlbS8oJcnhxxeUY9Fc
	 WQke7/4z/mInayG8UEJbob5G9R/OaL9E/phwZ2lIb4VA/Rt9O8Ew5fkSt0ArXneQLbK47
	 Mu2CZyJRAfmDBhTcsYLPlMppbx+Ykff5hBOUFapp6exaRtJ7ul1eeACCz5AXP4KzTJSMn
	 yb4xSj4WSmdKNXacmCXK19HTa9D97TkYGCqyudEgJwnJ7fyxnh7G7ipglrTcYkir7KQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013542;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=4UQhhRD+EmRWppPu8z8UCoTLBHiMXdlROmpJEykPlFc=;
	b=X13K7ern0vhJTav7kz46YMR7AMj1cPojiHtgZmFBWZlIHA+GQpSbhSZzsOFXf0b/uKEe
	 3PpA7mXsZI0hqhkQfcCiMDhIzlJPzsz/yw59EkKiNfUlrCoyw0d+qgcx4/9pS3Y/9qkO3
	 PKspGSqpzwf4wtoCP34kPXGAq/cJsDcYYas5GbRUnNn574sBS8N/++YfTWbRrw/fa/HRr
	 /kb16WWOXbdAl0KMp1cQyCItrQLnAHWCPySvWpaZXRJ1wWNUcIDkgUKF2GYo0S7UjNS7/
	 r8gtwS+lqtlSzKP+wOtnfkUjzUVRLsfet0Cka08k+HECDLPTj5zcjJVTNQPqtjd4i+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3GaFlNw;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 41E74606A31C
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:52:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=e3GaFlNw
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4E5271F000C5;
	Wed, 18 Nov 2026 14:52:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013541;
	bh=4UQhhRD+EmRWppPu8z8UCoTLBHiMXdlROmpJEykPlFc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=e3GaFlNwzQ4gp0auqnqisZZSbpc46CsG+ZGcblf5jzUASwXvbML/RidKLdppGPv2m
	 pMeB1R70X1+K6/9X4N/lsrpQPj1CtlQ5ZhZAC7rlcfjNF8AWrcCreuEAsAKSRqnP2e
	 +E48hhguK/qCSYMquBuy1oCFzcTv0FPipeY/b5mAAHSLIsa4IK9nsiYmxafLRjumsd
	 SMvGT3oh+g26wbHBFwfkbiq3IEVPJv4U+lSCbXhQY2675S3lmTYuybXcEUEqp6fxl/
	 5Q/QJ5oLzUuFOh1hJMEtluSutdW5zO6ADFUi5CnG4SbYlQ6Zd4gJsdd9M5Wwjq8feL
	 nJcUV84bhFsJw==
Message-ID: <sashiko-outbox-221260@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 8/8] s390/set_memory: Add __must_check to set_memory()
 primitives
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-9-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:52:20 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> All set_memory() callers in s390 architecture code check the returned
> value. Add __must_check to all variants to make sure no new callers
> which don't check the return value are added.
>=20
> This is the s390 version of commit 2abbd6d5fbe0 ("powerpc: Add
> __must_check to set_memory_...()")
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D8

