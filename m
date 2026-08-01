Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1EAC64322F9
	for <linux-s390@vger.kernel.org>; Sat,  1 Aug 2026 11:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785583298; cv=none; b=Lsaaaqw6dt+CeE2d2XRrV7jfPcb9tUBO+sp3HQJo5pyzi0HaHkcNaitj+MrCGH+IlByDRAjuVQwDFyNKLJg9+yojtF7hY9ft0mg9u2hYRHL6/AQkAGCSbHMkQA+1AGUpcjlPQVdyf9iuBJvosEAiJodVWKtATSEb/yk9mLK8bQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785583298; c=relaxed/simple;
	bh=luAN385EhIvDEehRIWtBjbZ+wiEFUxSgirL20TlZbdc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=rzheGz2uuZmacUI0BgJ1OA//szPwm6+I46M7UDzn4D7eTOHqOLlarOiDOhrR62vDA2+yhzoJZhUzpLr1GMG0KkdleQU7/X+Y+tIrbRtVaf7lnPjyq0T6/gm2z11iZfBDjeoA5lg8tSISnl/Ehp7FKsPXQB0vkAXj5GOD4D1slR0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=YGginJ2/; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="YGginJ2/"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D16B1F00ACA;
	Sat,  1 Aug 2026 11:21:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785583283;
	bh=luAN385EhIvDEehRIWtBjbZ+wiEFUxSgirL20TlZbdc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YGginJ2/Xnn5TTiuTUhoOJP+5SwH/g6Q1qnPkiauwLtKK49B9XodtgfkgBCSDPupr
	 ZWVX5xRY55428iUd+dmQzj+zlo9ndfpcFleSQVZDLsZcpK6eKlYTQeu4sVUL6X8N/F
	 J8Uw0KJKr4f9JkfQLCcq2p+a2CzwQzKiQKy/p/ZoSlv3PRVZ8wRR75rxHon8eLrxAS
	 KPWoZJgqt5zovwQyPvojKKts6g0wzln1B8t1PFSxpTdZW+FF/azJ73uhcCKiTv2G32
	 djubYnT/qrY05U6xMd7PQjjSHbe/4N2EY9D15FT8gMG9lALS1+gW6/dAHn3EHm7Ngh
	 5lJLTIOGBRo7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 02/18] s390/dasd: Propagate partial completion length
 across ERP recovery
Reply-To: sashiko-reviews@lists.linux.dev
To: "Stefan Haberland" <sth@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260801111008.3391031-3-sth@linux.ibm.com>
References: <20260801111008.3391031-1-sth@linux.ibm.com>
 <20260801111008.3391031-3-sth@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 01 Aug 2026 11:21:23 +0000
Message-Id: <20260801112123.6D16B1F00ACA@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> dasd_default_erp_postaction() copies the timing and device state from
> the finished ERP request back to the original request but drops
> proc_bytes. A request that was partially completed, an ESE read of a
> not-yet-allocated track returns fewer bytes than requested, and then
> recovered through the ERP chain loses its partial-completion length.
> __dasd_cleanup_cqr() then sees proc_bytes =3D=3D 0 and completes the whole
> request instead of requeueing the remainder, silently returning zeroed
> data for the part that was never read.
>=20
> Carry proc_bytes over to the original request like the other
> per-request state.
>=20
> Fixes: 5e6bdd37c552 ("s390/dasd: fix data corruption for thin provisioned=
 devices")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jan H=C3=B6ppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260801111008.3391=
031-1-sth@linux.ibm.com?part=3D2

