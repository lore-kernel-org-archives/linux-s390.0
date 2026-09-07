Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9075E45C718
	for <linux-s390@vger.kernel.org>; Mon,  7 Sep 2026 10:33:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788777234; cv=none; b=ouumrtSOhGkxpc20sGRgjhpTvbEZFNgWWXjwXsf7l3QJc5yJyxnhi9ZsDSIZOIY1wgLIESt5uynwMY64tmSS7ICBUvggmE043RouQMZFVpK8O3gd+5Ui4QtIbndzXC+m6aiQAhle2hYlSlriwcRPwgDtMEnqgtgaryTfigJPGiQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788777234; c=relaxed/simple;
	bh=RN6iD8IAMyYQ/eigRVBAqSDd7nhFaAPE3OJK0bjRbS8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ERor+Zc7xoFTM5Oe/u98rTc2GIHfO8BAHs6o9v2pH554WKOfeEFDI5JbVEy1S7BpDhrvvFs5PHvsOBMFgIQSMNRztwfQPPdPp4sBeCuIO2J8jtX29kAPQap8VptPIT7/QiZK1AiqRSNjWWwBJv0RiNd/7NHevNjniE+M6RUmTcI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=J5+yIuZD; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="J5+yIuZD"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C662B1F00A3A;
	Mon,  7 Sep 2026 10:33:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788777233;
	bh=RN6iD8IAMyYQ/eigRVBAqSDd7nhFaAPE3OJK0bjRbS8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=J5+yIuZDLZkiNr8H9Q1IoLEV1thKW+6SOhjPGYqtJHYQkm6R7V9qGonxcp92ydxMf
	 v3sGiqE0gcWRj6yQuJG7myE0jAJZe0g7QiehwiYTg1yp9dDPlxfpRnUpbMj864fCb9
	 nif3pm9a69XF27INcCAGEEiXahRT0bL3qOvHE3+CowTu/Qh/Uf6UpWuB/XomfzMruY
	 i/rr+FtuRp70FK2JPmu4agvx2F15K2Te1PVsaIrgrwsxmAl+0/qz/VUpRLAgnfkBV5
	 CNd/4XGOB8mRVVSaJ23cwlRZ7aP2MBhjBioUV9E2zzuOhVTtlss784vdX7hqr08qz1
	 tPDypueogkGyA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 09/13] s390/qdio_main: Use kzalloc() for the QDR
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TWlrZSBSYXBvcG9ydCAoTWljcm9zb2Z0KQ==?= <rppt@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260907-s390-cio-ready-v1-9-ca7f39806234@kernel.org>
References: <20260907-s390-cio-ready-v1-0-ca7f39806234@kernel.org>
 <20260907-s390-cio-ready-v1-9-ca7f39806234@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 07 Sep 2026 10:33:52 +0000
Message-Id: <20260907103352.C662B1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> qdio_allocate() allocates the queue description record (QDR).
>=20
> This memory can be allocated with kmalloc() as there's nothing special
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
> Assisted-by: copilot:claude-opus
> Signed-off-by: Mike Rapoport (Microsoft) <rppt@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260907-s390-cio-r=
eady-v1-0-ca7f39806234@kernel.org?part=3D9

