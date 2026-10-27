Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111816;
	b=VRaImhd1+mG+dh0c1KZ2DZnEE0Zz2NU+BHIcwOef+qYNi1NgCci0lbFWR2Fts7LCZ98G
	 G6Jsh28tTCe2zSYZuJOhXohDerzj19ilwyli5NwPP/wDOt7RkqJ9S/sjFqGScA2Vcwq6q
	 Z5H9LuDAhmSYHU8lJAI7VBjoR6P91bKwO7lHHu9a1y8QcRtvHfUry39Q8gAn/h43rYufd
	 AG1peES9HlrOCFVkzp97zhgdpYBtU3urNM7+tFqDOi45IZA0DIMfr/7CD3kbk8arMtaqG
	 OqLAYXfTpKNFuUjMiG4jZrcPG4LHRkj44UUhxMS2QdRffIseyk+7+RfSJHEIPddJrow==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111816;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TQyFNBzGZhlrh+A+qBVOFj9zpRAM6S6xceL3Ln2SfLU=;
	b=J78oBbKYThNRG57VQn9hynM31pLgD4ELb39tXtkZsxxdPoSGWVPIyUrKQjBGoITGgwWO
	 /pvztZwQW3gLA958I+FKkG0mEWqUVagH8/PkPj7nqz36UVgEKTdfR7EcAT6WowvOGmgwv
	 Vn2B/agTdrs4/bUR3JOqH5E7bI4ug6tRXYnD5nmdl4KkEqFSXU8Tqf3HhYRY9lJyUvopi
	 pBGk/0CWv7K6Fo3CDDaTPe76rCBAr5zX/0szE/WSnQAEmpG9rcAGiWNii797MoqBjFWX9
	 fGIGRr6nMn6K20rF0rLpUnwfR4r7gFFZMik4sLEjO07OquImbQOipFam52HgetzOqNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2cAqGrM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F446606A31B
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:36:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=G2cAqGrM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D5A551F01825;
	Tue, 27 Oct 2026 14:36:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111816;
	bh=TQyFNBzGZhlrh+A+qBVOFj9zpRAM6S6xceL3Ln2SfLU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=G2cAqGrMCpBciBnbX5TkqfFHHykNOr2ZGNtzXS5iyFBO+oaT+Y1J8g+XBabdZYOff
	 EZyr7rCHhXc5lxlIk6bFhmMht2Jrytkzmd5PLy8qSlwzupbg/rTBV2z/V65vke0iBG
	 lZ7QylwzG5/Gg/AecNWfno8k8FzFp2sHa19ena5HWFMdNEc4PbMHdBguIp/T0jELAS
	 J7tlRgymVhv7EUp1A0zzYdfgXBArkXXxLi0M6OpRAc4PK9MOuL6MDZyPdP8BayB1VU
	 4yVBuvLXMP9xo+AhhjKG81GUciCqgaMHdpzXeUjB2dmSXf4IUM5aMzMpdus8Yw3heQ
	 zFDjY6TCy2+Sw==
Message-ID: <sashiko-outbox-186735@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/10] s390/alternative: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-9-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-9-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:36:54 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex inside __apply_alternatives() around the patching
> loop.
>=20
> Serialization is not required for __apply_alternatives(), however this is
> part of larger series where at the end s390_kernel_write() requires that
> callers hold text_mutex.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D8

