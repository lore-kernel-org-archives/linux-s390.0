Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 549862D3225
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 02:06:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792375569; cv=none; b=UhexJMpilL/z/QghGr0QtkcShYm++MAUesz6TZ56uCS5vVdTTwLKpiyoInlIF0l7aRzTPx7d0FeX7ZzLdCt2M8eiSNtud32upjdYOXP5fgUjPewjGdKxP8RTcAY4Rzx6QOmkFegqbx0VneMQl31TJB31fw113slqL7GA+bFbw78=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792375569; c=relaxed/simple;
	bh=iWDVUptBX0Vz6amr3J/N4hv5tAR7FH88zP0nsrp5Wys=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=R3UIJZzk2nyWQr76YaxISTIPr3G/xqZex0HqcS5WTDxbTRywTd8Wqq0ePLvAYHX7D4jdEWtwyEvGDYcZz1va5xI921lfHvGGthyYwd+i58gA7PWMySXXCQFwAloV/yHBdJUdvM1Qfoi+ou5MyrNlpR5ngnQH+nRf4knBINo/GLM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=QaRsBGQx; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="QaRsBGQx"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AE1161F000C5;
	Mon, 19 Oct 2026 02:06:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792375568;
	bh=GEOuxovZb85iuTyvqD6fsGs4smYgbmTwoTmSxiglgNM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QaRsBGQxCztxtIMFO3EWMvjjeoSGNMygAhrpBWZHGff3S9Om6WDa1j9qgrz4vcawP
	 fneyxP0+PICT+guhxqT0MNKCYSpdmEWZcobimBnhWIWiZ5vwh3E+h3p01sgpjfH4d3
	 3Z7Ifphl16qaWbhSSq2uV2nvbV+C+TlanuZF0H949eAYQ6iKQ0g1kE6+nlcyi7XPKA
	 C3u2aSvwUEravfieaXvllKjYVR9bYPL0EZ8L6MfCJwAJ0G0ea0NdW3R3emSdy5/j4c
	 QobOEOPWxScRHFu+34qZoF2Lq8GwGpOrR/yhSgbqBSOrVlAqSamHcZesvYKwThNawi
	 11ggkg6CY5rJA==
Message-ID: <sashiko-outbox-176516@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/2] kasan/test: cover load_unaligned_zeropad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
References: <20261019-bug-word-at-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com>
 <20261019-bug-word-at-a-time-zeropad-kasan-v1-2-f21a3ed6a477@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 02:06:07 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
> does the word loads of the dcache name compare and of path name
> hashing.
>=20
> None of the KASAN test cases reads memory through it, so nothing
> noticed that KASAN did not check these loads at all.
>=20
> Add a case that reads a freed object through load_unaligned_zeropad()
> and expects a report. Skip it with hardware tag-based KASAN, since
> arm64 turns tag checking off for this load:
>=20
>   kasan_load_unaligned_zeropad, x86_64, generic KASAN
>   without "word-at-a-time: check the first byte in
>   load_unaligned_zeropad()"                                 FAILED
>   with it                                                   PASSED
>=20
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019-bug-word-a=
t-a-time-zeropad-kasan-v1-0-f21a3ed6a477@gmail.com?part=3D2

