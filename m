Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792773660;
	b=ziBGN7ONGeVSSrxDgzIXDTwQIHQTs8sj+yuoMhGCAn68O4x1fA5JcDCGTqr3B5OOW2ne
	 EFgg9zBpFvrrlgTnXyCDD9sb3e3g+x/ze1hqw308EeTKw9m4HWIZX4313ffZjolPxTEbi
	 DtrZm9tr7HwAeB7GAV0Ed0B3H941fZq9zu9kcH85AZUJBWbrVihvAZi1rnpJMDaSYYzmC
	 eJrEOembZt8n6o8lk8J+z4bZu79gSSQk55qCxGaX5DCpBDsoQYESDo2Yd6xdoYc8QPj+t
	 2hIBmX+ZTVMyLmL0icHFK27TjyxrJoNjSW/TwiDnJTGMYzaP9CMBFabwJS2xFGHfHKw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792773660;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=sdb3pDWYdoqUO33ZyRXNo2z83h0kYHSq/cflcYQ76AI=;
	b=DNSvkyRrrEdm0ZGTEgsWfuucl+GzhhKujQ08zfyOovk4YCDLDxu1R6m6O8NjEBvPfg+R
	 BvKrqMCNyqnwojJn4Sqf1CcPqrI+PKlO10sJ/btCZKYTllcofx4hjlJp9P2ltR6dGUCy4
	 MlB3P3FDG7UbcSSc+CEnhx5k6V7QbGTzYnb6gDhsNZTlr8ct6GwHVHZ//39T/L2QGG/lq
	 0U4kFmwFZP/oUh6K9eYfIBBR+ByIzHEv5iSbcoV8vkhXaCZkNqiWSz2U+Od6010JOeUON
	 r6U8IwY13N3rliMVJIuUHua/UNB9P0UXVvXLKuop5TUkiHfh4Df/IBO4wCLXX9s6UOw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByEHlYME;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1F542606A31D
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:41:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ByEHlYME
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A56021F01825;
	Fri, 23 Oct 2026 16:40:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792773660;
	bh=sdb3pDWYdoqUO33ZyRXNo2z83h0kYHSq/cflcYQ76AI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ByEHlYMEXIFBMs611bvkzoyb6ZLS4GNjvhPytfsAzUEOylmgQvCWiiQbGwknMZG9Q
	 yh6W/hLjkUADbJi113Obfa6/VVTm21ttlQoHJMZj6SeVZinEbGVFTxO+1OaP615LCT
	 QAakyI2K7g4RW24fpqGaoygssiuxzB6YEzJvBYZQ0RX0yyy+2cJsD0FqFRCXdscNhd
	 MM5sYrEx9Ff8jxB/cyS92I9aRI+08cHywqRPzptRKwVzE3ejgK7mIPS6aTbLyxTdGr
	 9eURddHWTVBI3koDYwlF2VOeujREcTqqSW0e+8ojHCEXQIQuIL8QNEf3SjyNdv5QwB
	 agXYxmQBJcmeQ==
Message-ID: <sashiko-outbox-182961@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] KVM: s390: Move prefix marker from PGSTEs to
 PTEs
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-4-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:40:59 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move the prefix marker from PGSTEs to PTEs; this is a preparation for
> PGSTE-less guests.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D3

