Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A60A649B203
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 11:42:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790336564; cv=none; b=JjJ7ii8ikxKv7Pgo2OjRsmb1Mv2OpDqCll5AAPEuwmaAk4TAqvLH9D2arLHs/bIoDTJdS6+gFTn40EcVoBEiPxb0SK4GKytHJlU3ojGwqF1UDr1tJu5yLHvHplWwgSB3gfDeRPtGBUQfG6K+p8/AcaZZRjrC0lvyzjMdokFBiAc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790336564; c=relaxed/simple;
	bh=iw8gCGRce+OUb6j2/z9xsNEuqxG8WAtyYgVV3CyO0Ys=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Le0+d6eL9Mv4MTP8u4Xpc1/ldl3XLyrEbkdI9j+cZmyfANR1V6wbs/3pAJ+ZycHzOn/z+uWhAcWUNh9FRoa2woEG0301NL840YMbdnXQejMCz9UCEQbY/ZS/c9Pz+qCjgJv+03vRq6TY8LJkq2KNuktbXgpHXRZDKy4zCujsphM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=n4b1RQLp; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="n4b1RQLp"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 674821F000FF;
	Fri, 25 Sep 2026 11:42:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790336563;
	bh=iw8gCGRce+OUb6j2/z9xsNEuqxG8WAtyYgVV3CyO0Ys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n4b1RQLpOC6YLpUUA9qsmGFxBJSSG231cb4p/fHmQbMbSRphKj51XhYhVoR/V+S76
	 iEtskj6CvbKJ1+FDOZRg2DYYQftUeHhCx8S6QAA01oyjfr0xjRiK2vGNi6tQdmPyDg
	 roCsAhJvj1DkftZpKB57kFt6ekOazKAIhNM1e/heobyFbXDcuBUj9NjBBt5pyp6rPi
	 VNgMpNIzrMKOprhwdaSFqt/9dNKIjlE3EzTc3tCuvQ/e4xw1nq1b2gwxqnHEhMLZRS
	 0DnMeQwV5tGbKQLW085qRjOVEz9yefD7vj5EcM326C7WTa7h5qQKPfNyKJspDkIBqN
	 we+GnCbnQPi3Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC 7/9] lib/lz4: switch the decompressor to the
 vendored sources
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
References: <20260925-lz4-vendor-upstream-v1-0-1c7ffbe21c4b@samsung.com>
 <CGME20260925113504eucas1p25e50de59c02681fc1385220be8acd184@eucas1p2.samsung.com>
 <20260925-lz4-vendor-upstream-v1-7-1c7ffbe21c4b@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 11:42:42 +0000
Message-Id: <20260925114242.674821F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Replace the forked decompressor with thin entry points over the vendored
> lz4.c. The API is already signature-compatible, so every export is a
> plain forwarder. lz4defs.h has no users left and goes.
>=20
> lib/decompress_unlz4.c still includes this file for the pre-boot
> decompressor; the exports stay behind #ifndef STATIC.
>=20
> That include is why LZ4_streamDecode_t is incomplete: under PREBOOT the
> translation unit has both <linux/lz4.h> and upstream's lz4.h, so both
> must name the same type. Both repeat upstream's forward declaration,
> and the file builds without guards.
>=20
> LZ4_streamDecode_t is the last of the three, so LZ4_STREAMDECODESIZE and
> LZ4_STREAMDECODESIZE_U64 go and LZ4_MEM_DECOMPRESS takes over, 32 bytes.
>=20
> [ ... ]
> The decompression speed fix has an upstream equivalent, carried since
> v1.9.3 as upstream commit fe2a1b3707d5
> ("Call LZ4_memcpy() instead of memcpy()").
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-lz4-vendor=
-upstream-v1-0-1c7ffbe21c4b@samsung.com?part=3D7

