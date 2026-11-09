Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794215119;
	b=rPVvkI9ugfoi6VyrD3OJsFfrz7nuPhcKFVTQikhKPHFToukS8qJ+vKqkED5Xb8vzPrnN
	 Jjw75fYYHLckE2p4FyFI/50iGRg0t6m1vCRjyy+BL8lptnKfRG0a8hGpWfWYL3q6nfD4f
	 bCv85G8okQunW00fkE+RgHxvoVvaJuWcSyRltCra1wgiHADCCYo70qbyzPRqoCVDO3Hxg
	 zM1qggnzO6BtFUG31xJigH9Ewq9baOyOfoIZN439QJ3WSSYGl7o90lCTRYMLuaL537jcJ
	 ua6YjRKBob4tDR3CgC0WqwCKxFN2Vcsl6tIRvt3SVEzdP/K1lr+CzieS/CzI0kManUw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794215119;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OA6TwxMc6W9q9+S5imS4PQ/gir7fW38iZEnAzwrPNyY=;
	b=MQ6rCkbis7hEbdlCR9VNpp3zGKfv+wxuWVOAKJ+fpl5CpmfD4A5FUiYONTLv1rQe4Z7i
	 bZA7NnqcfvdSoAwTEUgNZONlHSEUzMR2yrTcvovWsUXWLKaecsdGUinG6jSde+XL5ZiIl
	 SRE6nYg5DXlCqJH8G0g08RwejrEQbHg1HQv/tPzEL3gtp/996yhB/9opOuprInjbFtxwa
	 WD1/2KA9L3j/Y+GmdQjpVMui5BWBBEf8KUJTa5TJ9BYTHU9yhaLNikh9+qf9iB9+Dftk3
	 KCDaEq4W0tvi/wp9PF79Z0Zzb1LaVBtTu4tYNFUXyLOKyhlEXXALIqt9ntiGKQABDmQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9hqo1I5;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CB81606A331
	for <linux-s390@vger.kernel.org>; Mon,  9 Nov 2026 09:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=n9hqo1I5
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E42381F008A2;
	Mon,  9 Nov 2026 09:05:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794215119;
	bh=OA6TwxMc6W9q9+S5imS4PQ/gir7fW38iZEnAzwrPNyY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=n9hqo1I5Ja1PIn4t9hXBj9K3g/4kodM/E66NZWz8xoo6P528W2YDcE6QF+g8GD/1u
	 ERHxmFT19QsV1gvS6lrMdfSPCb/vzrmJCdZZYv9DRB7fxj8My15nUMWGMvIJ7FxGim
	 2EqhO3SLOd/5jR38Bwv9t8m0mKkqR8oq+9PiKfzMaQoERc259yDCZ+bQ5uoaAiOzhd
	 gXDFG2C8PJRfwz2JQOKhhlDykb509kBeEbfENnJbt2RE865ZuMOB6GgRE3EgvgTUrt
	 Nm8/wYoX9BAW/NyQSUb1EMIeVgUb1hA33jcSNNUgKVCuI13Tkf0dLt6YSIi5c9Ysyx
	 SjgrfD0EZ/SDQ==
Message-ID: <sashiko-outbox-204654@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 02/14] s390/sclp_config: Replace get_zeroed_page() with
 kzalloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108-s390-sclp-ready-v1-2-3e7c90eb6676@kernel.org>
References: <20261108-s390-sclp-ready-v1-0-3e7c90eb6676@kernel.org>
 <20261108-s390-sclp-ready-v1-2-3e7c90eb6676@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 09:05:18 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> sclp_ofb_send_req() allocates the SCCB used to send an
> "Open For Business" event notification to the SCLP.
>=20
> This buffer can be allocated with kmalloc() as there's nothing special
> about it to go directly to the page allocator.
>=20
> kmalloc() provides a better API that does not require ugly casts and
> kfree() does not need to know the size of the freed object.
>=20
> Performance difference between kmalloc() and __get_free_pages() is not
> measurable as both allocators take an object/page from a per-CPU list for
> fast path allocations.
>=20
> For the slow path the performance is anyway determined by the amount of
> reclaim involved rather than by what allocator is used.
>=20
> Replace use of get_zeroed_page() with kzalloc() and free_page() with
> kfree().
>=20
> Link: https://lore.kernel.org/all/635405e4-9423-4a25-a6e7-e03c8ea0bcbe@re=
dhat.com
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108-s390-sclp-=
ready-v1-0-3e7c90eb6676@kernel.org?part=3D2

