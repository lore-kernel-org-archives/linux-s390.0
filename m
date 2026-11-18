Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013426;
	b=0ZAzlrasUprmqjavqrEsCt0yIGynhGEUCDzTLrXMz0bWVYYGyhf2QvM+nfHmc4LPwOYB
	 VxXCKx/z2oVyAkylyKRTMObx2DOSst7c25FiqEhKnw5qU1v7SB3NweQPoEv1DK3uvf9Jk
	 FFLLToVuyrJ+v3B1+/dFP2PWj5Y74l1RRMpCMT0p+O/wEssZmhzB5Uq8O9qpKX5fweVkK
	 h36y2Itu8rvboKFCWtWlRQVtvU5X1i0Jy0000qhHl67gQ8nlvRKBVi71D+jZ2CWatBOdY
	 J0myI/+TKWNKQ6gXLlT+iZHbA9+IQKwue5bn1iiB/TGmR+4m+ZUGhpegHr2d+t4bY5A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013426;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=rhCd3NjqofU1Jbau3moJlCumzYgZVhHXlIhGCSMGJh0=;
	b=xnOLmuOiOj1aB/2AtOYvvFV/Lnv4NDb6QOFU/cARLuZhUChsd7Ec0sWBd1oDGVXTTWFi
	 /b67vb58XLS7tTBQ0XECZ2J8NdD6ks1X46c1kV9Tu8OM+hXV2lL3lDoQHkscfciuFusiI
	 YqXUxUrwVfW+/3YJz0n8+/liL/vflunlWTs992nM8Wg1HhT7uBgE5c5fwKVTMNPLv+L8X
	 n5eNrU0F1vzJsRqzrjmzOm2LVXXgvK3y+lyA/hKRv1nIDhuV08KCR1JdAggLOePs/7NwL
	 Il7TBp+xBUl/pnlkyJquvmA5hsKiet4ak5pTHAT9adsOos+PwiJVm7XZBVyq8ZKbbgQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="f4h8g7b/";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 23B02606A320
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:50:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f4h8g7b/
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55B9D1F000C4;
	Wed, 18 Nov 2026 14:50:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013425;
	bh=rhCd3NjqofU1Jbau3moJlCumzYgZVhHXlIhGCSMGJh0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f4h8g7b/aofwEN+kq9QXNnT9l32piPROwkQlYIr/9vx7r3ge+m3NWBLFy4k3DtggU
	 UbVWGHgA0s/oq98i1MY6XliVIhKExhy5nRUCsecumq7xSXPL5japXigw5sRjk4xPjq
	 fWpoSiazClLnXPTlT7TcrCK7UmXUqRN0EY9+cJIMPIw9maIlYgksIKB2bGTvFOiTfM
	 YmkqxfrThpxkX7zHjgFo0TB7UPMcdpNLnyS16vJwmB9lwfhfNJad5ggi97DOCe37Oj
	 Vvwc0d5MugsLgWPDe8PTR9jAypFqr4IpMr6qu1s1c2x/qQoz0emn0NN+7EOzDUHmMU
	 naPIEW5PIRrqA==
Message-ID: <sashiko-outbox-221256@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 7/8] s390/mm: Add error handling to vmem_map_init()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-8-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-8-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:50:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> If any of the set_memory() calls in vmem_map_init() fails just panic.
> This should never happen, and would lead to a broken kernel mapping.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D7

