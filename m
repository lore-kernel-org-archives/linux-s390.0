Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793977057;
	b=FJwFED43I4/RKXNh0I3iLLQA6r+0GvJiZsPWxEQF/XQGnkM+Jk17adwT5SmqdnGiA3D5
	 OMJiXc1DYOOCCjb89EHZCO4taUxmnF+0mbhG2DZ0Db6F63x7zamJnRDmYiPSKkulia6hC
	 Ak96ffHG5ar7ycdRPH7VpzhSFfwIFLUToG6omPojHp4GUEDVsfl01hRFV6tew69FZjbiW
	 BHTghLsnVb9B2D5naGf+EHWcONwAp00LlSsnPCvHbEOJYdL0yMdZgpuZf8KAp/l1AxEur
	 PX0RNAgmo0a6e8hR6EFwkXTDGq49br9IAlJzG3GuIDwJymfye7NvWbA0c9XYJ/RNoXA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793977057;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=GNpH46hEHrvyMSEuC9iGAtmOn3/qstUvbs9XClyOlCU=;
	b=cD5JVD68cRoUBBNu9h5AT7Ns/gmav9Rmb1/s3lqTp9VMnNwXlbMKyOLKoS/qYdQZbm4h
	 rPzbjVN8GFqfmCxVAC//CBwC6ulbL6H59yXdndgsjj9U/7BT9jLgGMcq3Lj7V/oocCKsS
	 v09JHMYV4jZiEVzZhvosqcVEhxW+ajotNQjQIgfh+WfZ5Wo0pRhyXWuJbI1l0gstao+6k
	 LFc064aNluRXgIRjzkAQet4MmuMRDJxeqrESfp7qzoQ1CtRjv2PmaVmIclDkOaVq6Ntjy
	 aA3RQA9f9kgEuRVYrgrv/UJxuShNfzUYr/kvfwTfT+u+xugx6T3kwvND7RB8rwtnMQA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVNCdR0c;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 973B3606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:57:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UVNCdR0c
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AC2391F0089F;
	Fri,  6 Nov 2026 14:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793977057;
	bh=GNpH46hEHrvyMSEuC9iGAtmOn3/qstUvbs9XClyOlCU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UVNCdR0crJ7p4eXPAEgEUynnjSuDJFc8NY7+V/g0CWcjtv8rPuAdbTZ+k7KXpm+p6
	 zx2p5QLvWUAH9sUPWBRa9tYPAw1/0mY2A2L+fQctIIBL2bKbmPc1SLfIDlOlXKAaTT
	 zfHknus+Y/U/JfNKBkBvWoiog4vfsvDx1lsdICFY4elupyiBgRXhI6jMFyOB1FD8Wu
	 mz10i3BUAPoS3cibwEtUGZ1T4puH65nKE5FhOJCz/+lzh6ojoqCwXBFLz6NLZMyTnl
	 ZMP1XkW0kQwtEnW87deiK5mcr5LuC50/FGIRhz5NJS6C+5M4EYO7rsO6J0Vzy9/e+H
	 RkpEbmsxSPSJg==
Message-ID: <sashiko-outbox-201630@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/15] lib/lz4: add the build environment for the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-8-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144301eucas1p1882c2f6ac262ef7c10c3e0cabe333a6b@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-8-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:57:35 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> lz4_deps.h makes the vendored upstream sources build in the kernel. It
> gives every upstream entry point internal linkage, so an object carries
> only the codec it forwards, selects heap mode with failing allocators so
> LZ4HC's ~64K optimal-parser buffer stays off the stack, and renames the
> entry points the kernel re-exports so the kernel's own definitions can
> use the real names. LZ4LIB_VISIBILITY carries __maybe_unused for the
> functions an object does not use.
>=20
> freestanding/ forwards the four ISO C headers upstream includes to their
> <linux/> equivalents. lz4_kernel_api.h undoes the renaming; it carries
> its own copy of the exported prototypes until a later patch can include
> <linux/lz4.h> instead.
>=20
> Two settings upstream leaves to the build:
>=20
>  - Unaligned access goes through memcpy() where the architecture has
>    efficient unaligned access, and through packed structs, as
>    get_unaligned() does, elsewhere. Left alone, upstream uses plain
>    misaligned loads on ARMv6.
>=20
>  - On ppc64le, lz4.c marks functions __attribute__((optimize("O2"))) for
>    GCC, which drops command line options such as -fno-strict-aliasing
>    for them; see commit 080b6f407635 ("bpf: Don't rely on GCC
>    __attribute__((optimize)) to disable GCSE"). lz4_deps.h defines
>    optimize() to nothing for upstream's sources.
>=20
> Nothing includes either header yet.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D8

