Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792423574;
	b=P04LNnnPjJtmjxx5jRrqydef3tdAAG/SxQAcIMjabz+UWFYzq9nVTWawJxuyPE9ATYC1
	 3SI7+z//3IHtuMyXjNMAuU0UdwphRaUlPptMVuWVBlSAFM0KWsaMRSqwRgmZ53ey0N0jO
	 uhpNFRxb76Fr3B2dYerQVgZveFJDNF/xSLufN76RaW0T01ifgTvG7hlFLIsV1GXLKSy6N
	 Aswrwj6jDpNRLJnk9P37L5J9SsmA8+pNNtRBqAOYShDmWTfOEbjhz8eANsjYpBVehAf8I
	 YOjH7eWGqLEbzkzCA4Gr4NWNeVqfRBlnx/d5YwyItRpzaQtJhcSz/67Y6Jpxy+mHT3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792423574;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ms2/2VLKz9mqB5VAuyDrGZ6Jd7VLtXYKS4vnvc+bkUE=;
	b=cY0DYIQK+gQtHOsFOto8xKLEQFWGvUcAz9bdeTsW1xinCILobJAoXlpLJH3kpuTlVcNS
	 TqwHZnLdjKAoGx/QTELU+odc21v7hUy9IuZ3PxUfOtTZpDlZrB9kUizinC6Se4O/WHElO
	 U1uXK+GxpzDfVyas01BT98LUKEpYSm7+sXD3uw9M3SD1CLWNmrF+0CSs9lCPAvF5ez0Z3
	 b+/P0WuHs1JbBybucQw/Mc/OXMMoKikP0B3ZByB+sE/S8zy5BauOHyw14jDkGBuC31D9p
	 w/E6e8eFjm05d54PrHA+Xq0b/2Pa2lzB8pSkqwIX2HT03mfRpzSL+ci2SDdpWLO8eIA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQYKT6Dp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1029460B1F15
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 15:26:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FQYKT6Dp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F1C41F000C4;
	Mon, 19 Oct 2026 15:26:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792423573;
	bh=Ms2/2VLKz9mqB5VAuyDrGZ6Jd7VLtXYKS4vnvc+bkUE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FQYKT6Dp257tcyIMCgU8/y7f+yKZm6lGteyrC2SkGmlNiNVl5YimzyWaum0hNZB+E
	 +ZiU2QOrMgMYzGrLjdEdiWN1/E48ibAu3lPWeAzL9CwhYNXy1xfaA7mgTtdChSQry3
	 8z8lmDnp0L9inJV18elRkIrv5f28OnWXKm0/PsKrlMLI4kGBl9++YbdM7eFsifO2ir
	 W+3EFr6S8tWZVkf8GOH0B0u0K2TDCi4ucuwnNNxwNGRwT21PcWizuup55BMmP3l6fx
	 VTTWz2ZLuw/3zIzP0eOVTknduWT+uXcNqBPnzEAs4J6YQPzsoBLUaDuoboZxc1e4MR
	 sI77fK7u51kmQ==
Message-ID: <sashiko-outbox-177723@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH AUTOSEL 6.18] s390/mm: Add missing mm check to
 do_secure_storage_access()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sasha Levin" <sashal@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019135441.1420968-512-sashal@kernel.org>
References: <20261019135441.1420968-1-sashal@kernel.org>
 <20261019135441.1420968-512-sashal@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 15:26:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Heiko Carstens <hca@linux.ibm.com>
>=20
> [ Upstream commit 7cf227b2707ed0129018c283ffc8f893945586db ]
>=20
> Similar like the normal exception handler the secure storage access
> exception handler needs to verify if mm is not NULL, which may happen
> with kernel threads.
>=20
> Reported-by: sashiko-bot <sashiko-bot@kernel.org>
> Closes: https://lore.kernel.org/all/20260717132345.539A11F00A3A@smtp.kern=
el.org/
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> Reviewed-by: Christian Borntraeger <borntraeger@linux.ibm.com>> ---
> Signed-off-by: Vasily Gorbik <gor@linux.ibm.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019135441.1420=
968-512-sashal@kernel.org?part=3D1

