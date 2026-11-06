Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976765;
	b=qDtRgA1FeoCTNjBsenO2crfgXXbmLAw6YRWjH1jlLjIzmbWlRThfnG3tuSRqLvdyG154
	 p3fKfFINwKZufVUi3ddhak2x0m/31TQksPO60HWfBiXadSXNGa+P6ATTf3p59xzs5hNMJ
	 7jwtv9ekO5Td+39ee/sRX/J5qjBIh0anJSNcQoutmc8yjkHLyAw0yOeZU5gY8abRZR/Z4
	 wv7aS6cHbLez+0fEwBql0+4Jfl8FN36FweFttVWsi99Ng5iJL6GcEspBWGrtdEQ+N26vh
	 9tCHXmx5TXd8h3undr8dSH/hYZjFJHykCgVfWT82Z99EgJZQZufvMCSiZPN7rstx1qg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976765;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=M8tJsSMHJzIVCPZxCZ9fpSuR5SowzFaoW5T1Pu8mOxA=;
	b=RxaGhVRlqSxcTyupwDERXgCDCWgOWNOinzAxCsJedWqubG5L7KUHmJwUvS/cVwJcxEM3
	 wN2mkljRplAyk57TlBkmPfrwAxgrziUDdNu8dKvZGkqzhw/PvQiW6AIqCJghmdK3JD4sp
	 xgMD50KIb6X9k5yVyNMaCR8FxhQe4aXt3tIih0uOt0opNfVkwrPgN0EL+8Cmyv4klLQys
	 ibEGT+AD4JtcZ4DxDr3myfYXXLBtPJ0EfgQSktKGOGFOnmxnsejOQT7dHAvOkM1Lx7R7/
	 JGvEeAYek0rZkb3AAMeGQl5dYFMbqw2iLCkXE/72gifPkSQnOwsWpegIudT6C8XXVTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwKdoe24;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0559C606A326
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:52:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fwKdoe24
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6BA241F0089F;
	Fri,  6 Nov 2026 14:52:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976764;
	bh=M8tJsSMHJzIVCPZxCZ9fpSuR5SowzFaoW5T1Pu8mOxA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=fwKdoe24GECErmxBt8wspGbWd/P07YqluFgj98QkAeQgT0UeF4+tMmPtEyOFK1SZ3
	 rjK81lGchDqnFyAnVJ8iTTH6OndjLxmK/YvbNqV6wStYE5cRQykPN+Ls+tIy1vsCnn
	 P0T/4wBHNXnc1aqiysNYfCx2y1FLyz/iSI7j7Yi0oWXh44Cr7oYxCjok1VH4aFtRmS
	 i6Fi7v8tV1ETO5QhhLij2WwKA0fczvUa8JiODtnEG4l3hWuQh7D/NmA2PFu8DF3eAP
	 Imvm6q7uEWW14HDzTPxV1D5NJTrCJT3AZHqbBIWu19H4DDrOj7FU970HMHVyqLiMzx
	 lXheFZAQZ/i+g==
Message-ID: <sashiko-outbox-201622@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 12/15] lib/lz4: widen LZ4_DECOMPRESS_INPLACE_MARGIN
 for the fast decode loop
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-12-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144309eucas1p2a9bfcc1cf81779d473fb073e7d9139b7@eucas1p2.samsung.com>
 <20261106-lz4-vendor-upstream-v2-12-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:52:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> erofs decompresses a pcluster in place when the slack after the output
> is at least LZ4_DECOMPRESS_INPLACE_MARGIN(compressed size), upstream's
> (compressedSize >> 8) + 32.
>=20
> That holds for the fork, which overshoots its output by at most 8
> bytes. Upstream's LZ4_FAST_DEC_LOOP, which the next patch brings in for
> x86 and arm64, copies in 32-byte steps and can overwrite input it has
> not read yet: of 172410 valid streams laid out as erofs does at exactly
> that margin, 3660 fail to decode, none with the fork. The worst needs
> (compressedSize >> 8) + 33. Images mkfs.erofs built did not hit this,
> but nothing in the format rules it out.
>=20
> Use (compressedSize >> 8) + (compressedSize >> 15) + 36, which takes a
> 4K pcluster's margin from 48 to 52 bytes. Upstream's lz4.h defines the
> macro too, so undefine it first.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D12

