Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408073;
	b=lcXraRZ+qvlS5Ia7Fm9y4Sfh/bV+YXFvsUCGn2rqstoYDSetD8p6tPtVRDYakyr+P3fD
	 9Z0EOTeYrTAxekQsUPWZzhAJNl+Em0raUSWZ7RcTIIEnc2/9fC4rhragXdI5Nod2c8zq5
	 Z7/y17/oQ71i0WlvBhqQrM0bkeJ68vCTLJaXqQYWcijsZKL3QsJqwacKfdBDov0rtjvcT
	 XPas7fWO9yyq5ISwIPQDssajEWQjKufND4BZOCD0WX81VjFMHVatoM5Zt8pEqdP+9py7C
	 sFDyBcw+VTWe/0X7fBWw2FcZwc6Hv8NCgZs2KfS0GWdLt2h3IP7MXDVEeyQX5GKgK/w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XZSMwRZbREI3u32HrESP9pk35qDveCOE14Lr3BCPXq0=;
	b=tE/Vir7NjiW4JA4Op7S0F1JBza0hPBY2k2jI68Z69LvLXrLnSak/lJybMZYdH0PqxYTi
	 JCaF1UuaX1kHdMBOxHWN9290A6Z9Z6eew+uWQ3Yc+iXj//lLC8GWHTb9mDZxsiRbDjs7A
	 uSnQKst2Xb7yrRcVMqNwrjjHk9CXMxAxaHwFBNoZ0w8ZmlXGd/H5oh9GfNFKNEun80uaf
	 iEr218heI9BSHdACwmSNpn+tWq4eGjYZjEp+H8FSCFRZKh8ztgBW1reVc56fcEOiC0PFu
	 cuUoNvx9W8ja6sMdLPTDevA083TwDQhSGSiTtnoj7jsgLoWt9CtF7vRJmErtBRhCYUg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="Jp6MBL/d";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F1A4A606A322
	for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2026 00:54:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Jp6MBL/d
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29DA01F000C1;
	Sat, 31 Oct 2026 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793408072;
	bh=XZSMwRZbREI3u32HrESP9pk35qDveCOE14Lr3BCPXq0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Jp6MBL/dKR8kdem+I4yAR/df3LPxc2sK8n50PJHsU2GWbept6GvKWh9WkkoW/98QJ
	 WLW/l8KLFJU85dqFAeaKd2/HjeK5+W9LV1M97SFAXC/TUQQcdH5dGEwOXiHGrcucSZ
	 wgaTYwiA9F9khCCthiYvpqwRYFAEeJZEKGPBwQ9luay8T4zJh5x2nvJk1luSSj0hUj
	 XQeC7Nh/3R8/BSdizR3FahwKP8RLDfu1OArwnBjEBHacCFqshi9mZeBXidFtTZyH/I
	 tZmL3g5qga4kg7VIrfif8NrDTAilNV2GnInWyH7rsrl29l9ymtN9nnneNzeliI8zU6
	 6LwZaL+uAnNrQ==
Message-ID: <sashiko-outbox-191685@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/4] powerpc/mm: make vmemmap_populate_compound_pages()
 static
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261030140720.1256062-2-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
 <20261030140720.1256062-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:54:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> vmemmap_populate_compound_pages() is no longer used outside
> radix_pgtable.c.
>=20
> Make it static and drop the unused dev_pagemap argument from
> its only remaining caller to simplify the code.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030140720.1256=
062-1-songmuchun@bytedance.com?part=3D1

