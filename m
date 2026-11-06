Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976730;
	b=TrKJAyQma6RfhX4AUsyW0eMxviHeZ7xoW0hctpbf0leexxn9JCk1JJC0XdhDcKx+VVHL
	 W3JP9c73p2+uXme3rk0DfzGlWD9GWu+FmuBd/ieCWNZzZzdezJE78EKeB0+HQM6YdkjST
	 P5kD8lt9MC+f7eW5vrIoqTy2dm//P6yzQWlnm+vZ/FOWjFDLnflOwDSESr97vKAD81YP2
	 gGAR1Zb8gPflDeRn5Z3lchIOnSmHTHK/2jFGBWdfftzAN91uHGw+nBipKF+Hl4XQ9zYIR
	 AsI3XpENmeviYfIj3iAl1c9m/9L2klZcC4CbLdDwrHeDNQiHJOCp1HCVwKDmRhkdFww==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976730;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=aFw1Ww6O+HPginHLPVrajN3hmc2ySwxBY+Cp6d3RJy8=;
	b=rGxHGf1EZud/5UM2T48/FGxXXXP8t7w2r1XYZ1h1HumHQHbovkVd8pQeNluLG4mESo4k
	 p8SBsGAVRKvkehKsZkmrbGJIW/I4vhTOEQjybBus4o2I937KfeA6rB9HtgvolrtjrW7hl
	 1S1zHqJECYFvWGvlsJ5CnKovbxqQt0LJTCYmqq0A0KSHbev59gSMOuqcuLSZfBG4nu6y/
	 nDVav6LA7BD/5U0ORnkRyQui6sXCUcnX8HYTFpll0YFtR0y+SufHnn9bM/clMXpCWolBD
	 riKAq5UMz0lXX6bBB5tXJqAzE4lqoqMans6wcXKF+hOXMDuxl4S0lNTNMW+weigrbmw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRjLn3nf;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD48E606A32C
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:52:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=JRjLn3nf
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 076351F0089F;
	Fri,  6 Nov 2026 14:52:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976728;
	bh=aFw1Ww6O+HPginHLPVrajN3hmc2ySwxBY+Cp6d3RJy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=JRjLn3nfopCful4pwKg4+DdEJiIqI11DWahuV0FPc5JD25Af7KLwrF+hnFr1zOooz
	 FQ0GnBGDaeVsZZ/Cy/AkjTYW4mFuRwtqoBJcYa3ZpViqcTTsx+KHiGBORhkIljw384
	 Xoh/5QTHe6otVJ83hGOESJ0wxMBEfJq6PeZOoUjYTE+4/Ygi7iWC/W2ROE+8KUcFs+
	 Ed83FqIpGO+jOJP91Dslt9iah4zOSpvjoPSEpXhDvamiVEsh0MCSOPPSeUfG4wKo99
	 M5TTMyQt9YfimDFWZ6QRUM3q0qKfcXGaLhmYeX0ChR9ftCZ7WSDU7pyZObOAgQ4/Sv
	 r9DuAnzvj8zBA==
Message-ID: <sashiko-outbox-201621@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 10/15] lib/lz4: switch the compressor to the vendored
 sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144305eucas1p17b3b27d403dc7d13b85cdd9a4bea83b9@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-10-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:52:04 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace the forked compressor with thin entry points over the vendored
> lz4.c. LZ4_compress_default(), LZ4_compress_fast() and
> LZ4_compress_destSize() keep the trailing wrkmem argument and forward to
> upstream's *_extState() functions; the rest are plain forwarders.
>=20
> Upstream's LZ4_initStream() returns NULL for a misaligned workspace,
> which LZ4_compress_fast_extState() dereferences and
> LZ4_compress_destSize_extState() ignores. Check the alignment in the
> entry points, warn once and fail the call. In-tree callers allocate with
> kmalloc() or vmalloc() and are not affected.
>=20
> Compressed output differs from the fork's on a small fraction of inputs
> by a byte or two; both decode each other's output. Compressing 4K
> blocks, upstream is 2-4% faster on kernel source and binaries and up to
> 9% slower on datagen.
>=20
> LZ4_stream_t becomes an incomplete type, as upstream declares it, so
> <linux/lz4.h> and upstream's lz4.h can share a translation unit. The
> macros that laid out the forked structure go, and LZ4_MEM_COMPRESS keeps
> its value, 16416. zram, the only caller using sizeof(LZ4_stream_t), now
> allocates LZ4_MEM_COMPRESS bytes.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D10

