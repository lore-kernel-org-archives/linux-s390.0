Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794596101;
	b=RJEe8fFBeRxC55L10FXupa1LKox0KrJbUxUZ1bwTcG9PG1WVlhosyQJdr+ZbVYUkjhAB
	 CdIokPkW8WDFnksD04h1SZQdTDGJ9Qoij0NRNz2FP7JyEvZrgmJcrK9W4fIuoVt+TCOxt
	 A80txFQMuDdzJ/2B/MX5q6rHKI5XqqsBumK4Pn8P4LuoKor7OFjhNm7MNh88R2Khx03tQ
	 nYRAsPCHYvtARWhAszqgaT1AQ62uVxgqbDOaunhR+CcvSauWoo8SMI4jTCF/wwtdWzZ7e
	 s/MOLYN80InkTG48ck28MzAkenOp4bGPAySSvzZMwwkSLYLck2hVhxjStBS8SrlDIqg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794596101;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=s24pcK/WGa/F4KGA12lwsohScPqZxHR2ovUSubildPk=;
	b=Kzs+/EbrPhePk48wxIWK9uQLReIHLefA73E5VZaqA8eplzc043hBROLMfBsEbzjPAH3T
	 t9HNaKz5OKMaIq1/LZ/D5e4kumPQvhfz+HmzNczW7uNhjdgUaDMMJ2gD6Z5sRtdDrVkA/
	 l11LfVSF010+HSLVLaMgGgQE0pang7i+c6cz7iWk34mejwMF0EufmgstIjP+KXJoY7Ugk
	 eEGKMWl9Lk3iiVQ2sw7b3nUz4gM4CaYZG0emJW5+OYDrzgJFW6HF9GJ46i2+3FgoZ2Kfu
	 TcQWLtyiLxrFMLgr65CrVCeaXK2xPYFcA3ezAvZGt7wAe/cuyous6r74ZE6YWcCt5mQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEStM36p;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 88248606A33F
	for <linux-s390@vger.kernel.org>; Fri, 13 Nov 2026 18:55:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XEStM36p
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A16D71F000C4;
	Fri, 13 Nov 2026 18:55:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794596101;
	bh=s24pcK/WGa/F4KGA12lwsohScPqZxHR2ovUSubildPk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XEStM36pnsEFOqmnOCCV4j1nP/V32We518bGoy1huR3Kjmna9ALEyUPTL6Hze+Khc
	 0UF3qq2F3ZrnFBwJkx0Q6ZM6rncleNisHUzw7JAkFXA8OXzwYhx50Fiyktg/M7XY1t
	 53ltpsBjGKToZ9fROM0UnL9Q9hUJ6Cmx93HsXqjE7VfC7sVWRUGAG+ZC6WMwF41iMV
	 gj4tumvl8tN9PT5HRHgmil4YMJ6BKIuK+7A4V6ekJQn8M2A8zquunLlZSjFCj0gHPa
	 s+GmI0oKn51Utj7uhF14C5YZLZWNn9DEB2fisBmnNns67d5plxsyj6nzSZNF5Xcrro
	 VQ5yUn+7vKb4A==
Message-ID: <sashiko-outbox-213471@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/7] cpumask: add reset_preferred_cpumask() helper
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261113184257.621707-2-ynorov@nvidia.com>
References: <20261113184257.621707-1-ynorov@nvidia.com>
 <20261113184257.621707-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 13 Nov 2026 18:55:00 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> This series adds more flexibility to control the 'preferred' status of
> CPUs. As a preparation, move the steal governor's preferred mask reset
> into cpumask.h to make it globally available.
>=20
> While there, rename it to reset_preferred_cpumask().
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261113184257.6217=
07-2-ynorov@nvidia.com?part=3D1

