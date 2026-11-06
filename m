Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976612;
	b=MglwQbTj/1rCSQNicZSGuJEMemOQhvsukKKRm1Qebjiu1SMI6+kh1HNNDfM1nqFJ6C8A
	 PrnTQV8V6XDjMUPW/a8MwVwgjbMAEDod7bWfgSmD03CQSLJS7yHH5erC53K/EFQCUk0st
	 kBRep+5SWKucjJmfaDUiGqBsOyQAlmee52GbF+nzK6thGEbkyMGWxnX9fxVZ6XTGRif5E
	 3Wk1DP8L9iEFNCSaocRbIP5PaMkPFKG9T4A9tEii7U1eyP4M6DU7imJz6D1uluhEN45Xn
	 h5i2Z1Z9HsMAare5KBhQgIMQp2x1Z1yGK/mPtXlZxoF5iBOnraZr9LSN2nml9rqeE6g==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976612;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=p2y5oZqRsggEU7Z2pNep1Wgd3p2oQRGe/lSUu465HqM=;
	b=kYWvf0N3DERAFFOGb64tw/xx1hjmLkGkM/nz10myt3kSnHLjkjiBvo7wyHsa0eOfdex6
	 OuaKeBIo5qPG1hxvd9V6srpAw1wSbZtl/d8XG4medjg1AuoO07e8KK5LXUBxJdOGQZfX6
	 +p0e9nY/KEDO5Q1U77Rsy5/E3RnqzEt4+q3tE9GfVD75QmwmC06+hiD999MuOU7IjB+bw
	 2zC0E1+jRuHw9JsryzDKezIweXZZ9X8MJ6tr+7RHwJeRTLOEHNrj1K47ZITsNtDA6Q+cc
	 Oypwqwz6VilT3XjwVz/8ISKm+D8mnnsKrv6bQlARd/yGVN8mFFMSyLwnX4bDmx3GhbA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+Z2HoxF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 24406606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:50:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=D+Z2HoxF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7E3851F0089F;
	Fri,  6 Nov 2026 14:50:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976611;
	bh=p2y5oZqRsggEU7Z2pNep1Wgd3p2oQRGe/lSUu465HqM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=D+Z2HoxFTaP9sUcrN9G+XoL2H0CR0zfXnYm70X9aWMSVNLsnv1zEGm/tGKi6aw6GR
	 L+OINdWrBrvO+O9pUtn8Wdul9gAXeUVNITT4kttENWqX77FAfO17I3Cj6T+8c+yr/1
	 eA48/Mp9c47jm+7BZ8pkJK5sWfKiEtPaRCS0nZ0nQD61P5oolwvqRLTcIn0rNVrS4y
	 k3dbgIoDhM6m+RMmdZl1DNmrC3WVnbn5jM/moknzXCozWxPpN0PxMbPAJ7br7SD2JG
	 9I9g8TnRGzB4U+znx/9vE2WJHhJyhjrO/WGrEFE6pPwydyGjoRgjXHdHCL572XwcDF
	 m4xiwasL9LdsQ==
Message-ID: <sashiko-outbox-201615@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 07/15] lib/lz4: backport upstream's match length
 limit fix
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-7-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144259eucas1p27d26efbc44beac102c03ec07ebed4310@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-7-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:50:11 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> v1.10.0 lets a match length's extension bytes run to four bytes before
> the end of the block, which leaves room for only a token and three
> literals where the format requires five. The fork rejected such blocks,
> v1.10.0 decodes them: 1f 41 01 00 ff 00 30 7a 7a 7a decodes to 278
> bytes instead of failing.
>=20
> Upstream fixed this in 587ed9557708 ("add comments explaining
> read_variable_length() ilimit bounds, fix match length limit"), on top
> of a read_variable_length() rework v1.10.0 does not have. Both versions
> accept the same final ip for a given limit, so change the limit at the
> two match length call sites to iend - (1 + LASTLITERALS), as upstream
> does. This is one byte stricter than the fork; no compressor produces
> the blocks it newly rejects.
>=20
> This goes away at the next re-sync.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D7

