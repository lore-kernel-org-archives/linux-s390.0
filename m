Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6566440E8D6
	for <linux-s390@vger.kernel.org>; Tue,  9 Jun 2026 12:20:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781007613; cv=none; b=tUF+u9hifzxBCXJWDSCEil0/QQ44419xCmuoUTsjKeMKFbRjW8UO5Z9BaCw0GHwvwJmliiJoliGYkioT017PhJfzk3mj6Klb7fU0qAAm8xjdRQv0Dydx56kZK/EAjPp9e7zbfpLm+dOogwra1Q30nGStm4pNBv6pvdhZNEVx/NM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781007613; c=relaxed/simple;
	bh=O3kNmnSdP1zmFrcXjM6X6RY637PSBOdH23e+BfROvis=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=RcxzCkkzFRce0ynbsSxBWseHZ71dD+efZmPM02iKtHoDHBtQtee+C/ch+v1PZrFJ9c7FSGLX9ODrUd9u656m3NfN6pIOq/D2XQHXe0uAYcLJgPca4+WHJBW9YS2iDwWKf/y18V11MPovRhCZxkooLc+I+JYE0cHbs3CUBDBwOKE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com; spf=pass smtp.mailfrom=baylibre.com; dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b=lV6MjRlJ; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=baylibre.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=baylibre.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=baylibre.com header.i=@baylibre.com header.b="lV6MjRlJ"
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-490acbb0f89so36744145e9.0
        for <linux-s390@vger.kernel.org>; Tue, 09 Jun 2026 05:20:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre.com; s=google; t=1781007610; x=1781612410; darn=vger.kernel.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=O3kNmnSdP1zmFrcXjM6X6RY637PSBOdH23e+BfROvis=;
        b=lV6MjRlJK14tlMhZtNpeaUVaK3GjahAGLH4izakVxZ78XLXADwekafWbwWG9e0oy+F
         Q2lWOXZcZf44+dMx912TEQ9wLLv1CYDcuUGQhP03VpkXyTXtac4VHLb4OtMEeMsvDBYY
         pBUnyEBCPKavfRxrUeV5MFmSCvEvQzp47FG+Ut3mvn9as0zPRhue2pSVkVOQ5P2+hsW3
         V57SNhMDnOGwmaSwlWh1DUHiNhwroVs7O+nO6Zz0j7T7V2ieBPOdJvzqr5ptJnDIKy+u
         3Ix6toyQ497yp4gUOKXnoCPai3jhc2lhbcjrs8uEhJ+QyE4wOoyzt0uxdYXpJHIzH5cA
         zDpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1781007610; x=1781612410;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=O3kNmnSdP1zmFrcXjM6X6RY637PSBOdH23e+BfROvis=;
        b=S8AxD89Ohg0tmzBujElqsQHhlY1hYX8ud+2m406urYhlcw0qBzXk9Re42bvp3XzHfO
         bekNPQs4fqM+jcKE3Mgho3yB8o3xPvyJqm+OkFU6hB4c/siOfgVPEZayPya9zxMtkI3s
         lc34ZH+8EHYeuW1FVa8isa3oav2iSyWkZfC9HWGcfZ1eS4xLa6bTqJwnsptexPGiT9YZ
         kGUa74PVS39kNZroLpiMAM8wUI7HG0A9sqRo7CHV3c+pPxXkbygEd5eH5lbsh+kBLSD8
         WM8KzioVt5Vk0ku7m3Y2hyj4fOn6UEk4tSkfNR44yV18KgIdo8m9a1YzG0OF44qmc07S
         iAIA==
X-Forwarded-Encrypted: i=1; AFNElJ8LHqMufMrg3W/YdZfidyfpgcZflwNN4i77lZI8kOqs8iafKN8hCKRDiGSO4/Yf2hgMOUByM6atWsWU@vger.kernel.org
X-Gm-Message-State: AOJu0YxBRrmr08sfM3QLD8K7oBkJZRMiT0fBbJO7B2rrDbCMPiTOzAlX
	XvPRgoZXCU6JQ2hCiHBgE1GyhWL7qjLMS72XnnmmphZlEyFZbdM1TLOQmnTu4UBMYkvP/gsd71x
	s0hWg
X-Gm-Gg: Acq92OG1uNlIT7D0os6OKyMVZKEUP+Bhmf2Vb/gv6AvTdxGlFKfSuv8trKdsY+mtj1P
	8pYa8MR8ZgKc6ZUJJcfIPKRurQnulbX6Fvlb+ZU5QPE/0ZW4xx3ANJa9fHOhu2s+Q4MjyAVBDaA
	iccIqgNOW4PNmk/Gacj0w4aj3I5TaIylkD+rwxHaz35JHzRWPnlAZ5ml3ZEFZHGYbo8Ur/TfQAV
	pR3NhT/ck2v313VZWpuKjopZiDjFIz4CpnZIU41PzCzWTdYb3PKbJtJ98RJdYZNpxlcceHD2ss2
	BQD3nxikbfseh67LBfD8Nu/Xi1wMA223YXVzY9+cGs38mqfLJ3FyriFzUOG4Tb2mdQHpXf3HbR7
	rOac36AIrhJxmq4C5E0GftVswX1Oa/4zz/rAY8csbABOcD6hbxKJSok3O22BcpulvFTEjrfMPBx
	C7gMO+xigMd/t2X+tUGwBg33JPkFPBqZdnXp4BXhM=
X-Received: by 2002:a05:600c:a012:b0:490:b9c3:6c49 with SMTP id 5b1f17b1804b1-490c2610c3bmr324897475e9.29.1781007609391;
        Tue, 09 Jun 2026 05:20:09 -0700 (PDT)
Received: from localhost ([2a02:8071:56d1:2de0:559d:eec2:887f:c200])
        by smtp.gmail.com with UTF8SMTPSA id ffacd0b85a97d-46059346676sm619248f8f.26.2026.06.09.05.20.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 09 Jun 2026 05:20:08 -0700 (PDT)
Date: Tue, 9 Jun 2026 14:20:06 +0200
From: Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@baylibre.com>
To: Arnd Bergmann <arnd@kernel.org>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>, 
	Gerald Schaefer <gerald.schaefer@linux.ibm.com>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, "T.J. Mercier" <tjmercier@google.com>, 
	Sumit Semwal <sumit.semwal@linaro.org>, Maxime Ripard <mripard@kernel.org>, Andrew Davis <afd@ti.com>, 
	Arnd Bergmann <arnd@arndb.de>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Andrew Morton <akpm@linux-foundation.org>, 
	"Mike Rapoport (Microsoft)" <rppt@kernel.org>, "David Hildenbrand (Arm)" <david@kernel.org>, 
	"Liam R. Howlett" <liam@infradead.org>, Claudio Imbrenda <imbrenda@linux.ibm.com>, 
	linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] s390: export memory encryption helper functions
Message-ID: <aigESvhKIU07k9l9@monoceros>
References: <20260526102113.2594501-1-arnd@kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
	protocol="application/pgp-signature"; boundary="dubgwsucnivsoo7n"
Content-Disposition: inline
In-Reply-To: <20260526102113.2594501-1-arnd@kernel.org>


--dubgwsucnivsoo7n
Content-Type: text/plain; protected-headers=v1; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH 1/2] s390: export memory encryption helper functions
MIME-Version: 1.0

Hello,

On Tue, May 26, 2026 at 12:20:37PM +0200, Arnd Bergmann wrote:
> From: Arnd Bergmann <arnd@arndb.de>
>=20
> The set_memory_encrypted/set_memory_decrypted functions are exported
> on x86 and arm64 but not on s390, which leads to a new build failure
> because they are now used in a loadable module:
>=20
> ERROR: modpost: "set_memory_encrypted" [drivers/dma-buf/heaps/system_heap=
=2Eko] undefined!
> ERROR: modpost: "set_memory_decrypted" [drivers/dma-buf/heaps/system_heap=
=2Eko] undefined!
>=20
> Export these the same way we do on the other architectures.
>=20
> Fixes: fd55edff8a0a ("dma-buf: heaps: system: Turn the heap into a module=
")
> Signed-off-by: Arnd Bergmann <arnd@arndb.de>

That problem still exists as of next-20260608. Even though there is
resistance to this approach, can we please apply this patch to fix the
build failure given that we're already at -rc7? This doesn't have to stop e=
fforts to get rid of that
export for all archs.

Acked-by: Uwe Kleine-K=F6nig <u.kleine-koenig@baylibre.com>

Best regards
Uwe

--dubgwsucnivsoo7n
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEP4GsaTp6HlmJrf7Tj4D7WH0S/k4FAmooBOsACgkQj4D7WH0S
/k6D5gf9EPM9VKSnkqo+GvhKcXDlncwbRnv5U2sM5xqHZIo7rlxJdJxZsvvCJNoz
bKHLNlOpdNhiWUWRDdffZTgSyjslzJzeq9jd92IwwxOlmPVuV6uM6DKlPgOzriPT
QoKggCaFrj6xpLgnuSHPRpYr+BFm3XVgQXDf/XWJa1DVa13Xr8ALRQpqMtWZTwZf
jYmAQ0E5OTH1HWhtgcJhENGKWMhDUCeIznWU4eXlR76RgFk8NlkdOtsKK608Jot+
uqq6ngv6+eoSSfN2Ve2VqitNg2sKOsVSltAsi5q6nJqofttaxzww0PtYmy3m6Btz
GBoK/ixuHv86bmVVlp0mWNTkBtu+2w==
=dwHs
-----END PGP SIGNATURE-----

--dubgwsucnivsoo7n--
