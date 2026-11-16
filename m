Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794828244;
	b=LXBYR/+s5bDehflSjIOLUz/OA8hbKemNRzPVGxXM9InAgY375gOpL+qQ1KTi7iJR7wYq
	 wThC0FjzTLZNhc1m/XNISQ1A7IrdKJ3fStqC3RlIFyKySXLXLwKZn0YI0UhYp7eBvrSRd
	 lMTmrzQiOohnpXYMAGifNlcHC8iw8stciy78FZql9x8sOVnbz0PQxEolepMz8LBgOgx7I
	 hkbIvAkG+2ZnvIpDr/BUw10XcnEd6KceXV3CfVghHh/1Dy3QfRGcXrUR7GexOjCiQvEyO
	 Cl1cMt0XgtmQecCNeMRx9aiFJMMMLVbxBGRu/vt1ak1dihjZMKfuqBE8nh/d2qyiQ0Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794828244;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=BW/X4qSDqxQXxz2fuj2tcTzjnCEkuMaRmeG2SvdfjFM=;
	b=rMJO0hlLHz7njvgkZGP9RnEmj9PRnaw6Rp8mRyOsY613ITM3Y+VyAREgw9ER3BQkAH1E
	 d8PAMljkWXoIqlKsCOeTIkeDO26tvNCj05CK5+h4MDcSagDmoFiZUXCYBmkksKg+p8sOl
	 vuI8AP1VWy3jBC09zI15YaTLqZd+zOy/yPPnaPFZan6H72CaUl4ISzEN+uLLC/gDEQ+l0
	 1DhqL06WGvpXEPxZXx4ynzyDGcWPBHsoE77ssAf/qazvBUCbUhgR/B+s8bv6O75Q1PIQ5
	 Slx04FWMBa25fmfjdKcE3DPytIrQqnPavZfndqQP2n3BgYBC2yI+k8ATAB3wHMMKMJw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjJnBV9O;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D4833606B1A1;
	Mon, 16 Nov 2026 11:24:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=HjJnBV9O
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE49C1F000C4;
	Mon, 16 Nov 2026 11:24:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794828244;
	bh=BW/X4qSDqxQXxz2fuj2tcTzjnCEkuMaRmeG2SvdfjFM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=HjJnBV9O/rYQWDqkm+6/EZzKQIsoJAqA3yXdfO+N6/lJyWbR9iPkbQJAhkbXWxO89
	 99ydvX1vN7P1n+hcAkngnpxlWL3iKgHGnqRx4GJRjilh2V4EF3mUKmvCrzKCtAzJFl
	 puD+FJrMmbyMrNs/7bb82hTmYapNjPQlu9HAATMdx2NomyUHBCJRMpTzxI71Cy4Xip
	 frhwbA2+5hk0sfdoRjja9gMVlKaR1/ahxW+ihwKdSuRUAEylCqMJ7bJckWclWvwhx6
	 uQpxaOdAG5yyyChb6kwGtpYypRbdxOC6I0+s+96woljLDlAWppC9F5ehi01f44fhRM
	 wHwgZXSu86f8w==
Message-ID: <sashiko-outbox-216911@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v3 01/44] loop: refuse backing files that aren't
 open for reading
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261116-work-loop-pseudo-v3-1-8cbbea1cf34f@kernel.org>
References: <20261116-work-loop-pseudo-v3-0-8cbbea1cf34f@kernel.org>
 <20261116-work-loop-pseudo-v3-1-8cbbea1cf34f@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 11:24:03 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> loop_configure() takes any file as long as it implements ->read_iter().
> Loop itself never checked whether the file was actually opened for
> reading. Buffered I/O went through vfs_iter_read() which refuses files
> without FMODE_READ. Direct I/O has called ->read_iter() of the backing
> file directly ever since loop grew support for it.
>=20
> Since commit f2fed441c69b ("loop: stop using vfs_iter_{read,write} for
> buffered I/O") buffered I/O calls ->read_iter() directly as well. That
> commit was about O_DIRECT handling and the FMODE_READ check went away
> as a side effect.
>=20
> So whoever can set up a loop device can read a file it was only allowed
> to open for writing. Open the file O_WRONLY, configure a loop device
> with it and read the contents through the loop device.
>=20
> Refuse backing files that aren't open for reading. Loop always reads
> from its backing file so a write-only backing file never made sense in
> the first place.
>=20
> Fixes: bc07c10a3603 ("block: loop: support DIO & AIO")
> Fixes: f2fed441c69b ("loop: stop using vfs_iter_{read,write} for buffered=
 I/O")
> Cc: stable@vger.kernel.org
> Reviewed-by: Jan Kara <jack@suse.cz>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Alexander Mikhalitsyn <alex@amutable.com>
> Reviewed-by: Chris Down <chris@chrisdown.name>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116-work-loop-=
pseudo-v3-0-8cbbea1cf34f@kernel.org?part=3D1

