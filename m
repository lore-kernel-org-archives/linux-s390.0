Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793976564;
	b=yJWBhClDMLoiRAy4G+JDq6XddnIyDM2lwb+5esh6mYSDW8YrnJ17wWevIxo0AQWQz6DS
	 Fff9PNn/Gs6vegN8LBz0PY0mufsUUqIcV1qqaraduLAILYMbmswU9ThJ4i32XRmiGqBZW
	 tS+TNw6W8XoWL3l/PCj+q5RYkn7ba+tzVL/PPo/fjkzRiPxIP1eQLGdqJTdSXloNXyxpJ
	 Ub4Os5PkKP7FiRlBELErgQS2oxmvRkwC4d4l7j15JvV7QXQYw6mhiWc/4KfbTRHJkoYcC
	 OJkbpar5gCRuGRWqtM+kWFeboEZZn/lTj22Hj/dkAz5Y+DHqMMAAbMhyloTbtYhwP2Q==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793976564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=TVLLfzRBqo0PwNJzpWSIQ6Uj+RhC0VCrRqJlrEY5ejk=;
	b=hGUkqrMhnsuWki++vQjBKu6HiPLv0TM2ZuWiwnU/UB3XPk8KYFzuCAyiFPo/63++l4uq
	 JwETjT5vHckN0e0rShKlAqc8DD5Hwy0n0OsX5szf3uiWKxi3+guGBheoMO5wWqPUJYUko
	 QNtZO9zb7ugf4p8PZMl6y3v+IRlypNz6k77JHmMEe/dmGj0EwQTHujF9Z4LdXe2Zk/sg9
	 FiHnzON4UsC28EG/q6L+1ENzdhlIDphgvL9Ii+Jq1geFMjpXdvajXPDtlivxQCX8c+W5v
	 TZtgBwNeokTgojBluGR+JujHLHnKpl2XqUNAbU1C7EMB6gJhZSIg2ZbRikyc4P0tr6w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQdvsdL+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9741606A32D
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 14:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gQdvsdL+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B7391F0089F;
	Fri,  6 Nov 2026 14:49:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793976563;
	bh=TVLLfzRBqo0PwNJzpWSIQ6Uj+RhC0VCrRqJlrEY5ejk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gQdvsdL+M2wTi2bIpiU9kUxQbmfTu2LWXYSXEB+y+3xAER1v/OxdTQL8NFkN75dhH
	 cZFSIb7gKdDidbvZaq4K22lHFJfW0SKJXYm+15nS3x7CFIV3efJ5MWwF+nwhxXeQS0
	 F9yLXORftnZF5SXF9Q6vTwnfIXJhrhgiffnlAv6txQNFK3mkWLdslTQPbbT5tMB0H+
	 qD0GUsPMz0SXpBHfX6YCUqmpu7OoyLhCmj3Fr59SFBiVeRlcrjrrf7YdToLbUzhJJc
	 kM3wIf8pewLJYDP+SnhKS/mOvX1DCSSjMe4jEMBoy7DZgZW2NLQRMeSoyszPcaZy90
	 L2m54U3x6SAxQ==
Message-ID: <sashiko-outbox-201612@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 09/15] arch: boot: put the LZ4 freestanding headers
 on the decompressor path
Reply-To: sashiko-reviews@lists.linux.dev
To: "Michal Wilczynski" <m.wilczynski@samsung.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-lz4-vendor-upstream-v2-9-ee04c3f0d7dc@samsung.com>
References: <20261106-lz4-vendor-upstream-v2-0-ee04c3f0d7dc@samsung.com>
 <CGME20261106144303eucas1p10d145c55d4e168ac6d2d12758125a532@eucas1p1.samsung.com>
 <20261106-lz4-vendor-upstream-v2-9-ee04c3f0d7dc@samsung.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 14:49:22 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> lib/decompress_unlz4.c pulls lib/lz4/lz4_decompress.c into the pre-boot
> decompressor on these five arches. A later patch makes that file include
> the vendored LZ4 sources, which include ISO C headers that -nostdinc does
> not provide, so put lib/lz4/freestanding on the include path first.
>=20
> Only the one object that includes decompress_unlz4.c gets it, so the
> rest of each boot directory keeps -nostdinc's view.
>=20
> Signed-off-by: Michal Wilczynski <m.wilczynski@samsung.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-lz4-vendor=
-upstream-v2-0-ee04c3f0d7dc@samsung.com?part=3D9

