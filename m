Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977058;
	b=xNtXO6AJ1iSMwrSoGXaJjmZvQH4wwKes9su9IZF47lyeF06sk6+gQKUmTzVYCNNfA6Gv
	 CCwVydLemomVWFCQ2V5juZBG6HJ6biQSEkluYyRAO0THnavmGEb3hz3FpuwjSqHw/0gYZ
	 WApDazy+d7aA6jiP18T1KUoxruYc/wn+SVrg6au1JDyAEYbm6B0/O9dVcgXISv3SiQX8v
	 jPYx3qiPalPeCA3EowYTjKL/ahsTE0+BzWQE99rNJEJthBcRvUCQ7Zn3wbT49S5LWVJ/8
	 ssxbnex6ubPM+6SjGCfx4wqLa/WH9v1JGqd7LHUbzQOgXDADV+H45SUfIc1NalKu2YQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977058;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/D6oESCycJInzdXg4FaV4SBF1vJG+Lyq14kfXi8eTdk=;
	b=Xqpi6AEQG4ymkUDFKFjMiLm8zB+yWODgIARYvPSrrjFcMDk6VP3sZcY9EJ5at4kZE9dZ
	 HcTg69NMiBpxpXOMq/TgFgr8UXvCKJZW38oB2tyooXu9AnAGpsckCbXMw/XMH8oWTep2u
	 sIdZl+zfcNlsVLIDl/Cw5PWdR0NqIdtst7tDuHciQZ4LqFQ2ibCgTiW6JUuplsg23xGbZ
	 io8/cYiuoCYZiF4weuGTaOyPEAvBlkBX4GXNVJIYTBDonPygjVkt3bXsIzVzAwNKXFaLl
	 +gRcCGXN3RF42j9C7fnhAeMZ4hpuhIy3C/GlVqHDHFsN8pRVzy7Niav31zHbsoAMB/Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoGIkkrj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0388D606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hoGIkkrj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7A5EF1F008A1;
	Fri,  6 Nov 2026 14:57:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977057;
	bh=/D6oESCycJInzdXg4FaV4SBF1vJG+Lyq14kfXi8eTdk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hoGIkkrjg0XGI9Gpo82LRQx0uI+HM2wDtjVURbhJZMxvSkoc9cWmpdBY3cudWyPMt
	 yATGv2PVpcNMMUFPY3OUXlmg1zzZP7Ot+SC/4wK97bjKR7RW1SWdZ2k5VZg6mbDoOf
	 PhJJZYYrWSgeK0BcnUQSxaUhIUQbJXrzPiKyG/LRcbZ0IYTG8IScEBiZYFrEHFDV7n
	 5bU1t6dwKFsYiK+NAyLLoC1iZZargyH0qW0MLKVu2zpCRie+dd9dAbUWzFbOtCdd3O
	 mbQur5lxpK249GfjfK7abnGown1xendX1LgDkPGxmj99AkbS/4cF1fdVxmqm8RW3lJ
	 OD87ZbMnwxi5g==
Message-ID: <sashiko-outbox-201631@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 13/15] lib/lz4: switch the decompressor to the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144310eucas1p1d60fe5c2e0170c49f38a3142bb1d8f94@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-13-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:57:37 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace the forked decompressor with thin entry points over the vendored
> lz4.c; the API is signature-compatible, so every export is a plain
> forwarder. lz4defs.h has no users left and goes.
>=20
> lib/decompress_unlz4.c includes this file before boot, together with
> <linux/lz4.h>, so LZ4_streamDecode_t becomes incomplete as upstream
> declares it, and LZ4_MEM_DECOMPRESS (32) replaces the
> LZ4_STREAMDECODESIZE macros. LZ4_COMPRESSBOUND is defined by both
> headers and gets a guard; the LZ4_compressBound() wrapper goes, as
> lib/decompress_unlz4.c now uses the macro.
>=20
> LZ4_decompress_safe_partial() on a truncated block can now return the
> bytes decoded so far rather than an error, depending on where the cut
> falls; the kernel-doc says so.
>=20
> [ ... ]
>   upstream c5d6f8a8be39 ("fix #783"), v1.9.3
> commit 2d8867f3e083 ("lib: make LZ4_decompress_safe_forceExtDict() static=
")
>   the static forward declaration in lz4_deps.h
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D13

