Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794180430;
	b=FE95zdxWX1Atlx/d8q5C6hbVKkRoWBH5OjyBF5VxVxSiXUiYH7LoxkL/Z4hPlaMu7WE1
	 gBBaZwK9Q4Jd2nqrdVxXxuNGxhRcEACMHLS1IrXkXSjPnq0fkQcX0rgDSW59wikRqaynJ
	 0RWCAACaQl7SWTQinETrwKt7islCGXZccb49ipdUsZ1E51vyCfkiLdpJwtr23FyxFNhGc
	 H2nFRQP4bFQe5OAfit8ncIfHMxTu/y4B32vlMOU8f3U07W4c6NEbRs04YdZXAqWzZPaXk
	 0dm1mXh0vDmIqJ17DVtTIC2SlATLGSch8ykcp9taea9UzBkrDFbXbDAetJ84oLp0p1A==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794180430;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=AMPMZjynVD/iqDeBmWQCmAacyaM0TxoBTkPvBrtDm3c=;
	b=viUgtlgvz968YvSmSeEekCdyXxQF0MjtLBDuamuDmH6ZZ5S0qX+yU7CRBxBPzNMUGPNc
	 HcF5zqbyWAYfjjyRDIv1JOGlzQp++afnOosF2oztN3xodvvPQoA1qpmjvPNtl6q291Gi8
	 bDpyFtL4lPxsune7yK0k9hBrUUg4Q35xiu90oqqKWjxONOBdxIHCSHMUNCrvFpWzqAjsF
	 cHgv17Kc0PA5GV6fu8/XYwp4NcMwUEiv+59dA5wkzidVIfrblIuk4Pl+oV1UTxDE3XIfX
	 dxVyeCcEr8ttq6M0XCOUZVVyU2JdrMwpHCS7BtP+IqnhwN/Cit428nQ+Ho5cKYD0waA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuEj2J7L;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0DDEB606A31C
	for <linux-s390@vger.kernel.org>; Sun,  8 Nov 2026 23:27:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=KuEj2J7L
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 42A651F0089F;
	Sun,  8 Nov 2026 23:27:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794180429;
	bh=AMPMZjynVD/iqDeBmWQCmAacyaM0TxoBTkPvBrtDm3c=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=KuEj2J7LkcR09eWWj0H4pp3Wng5fato6MMMnGWTYIYN9nnfegH1IEWaqXdIMa4RIc
	 3tJSIa2/CFf0JTb6ajGEcUl8o+kksi/lbjLR+VLHLD1J7/d1XS4oaxwNDZEAN9OkEO
	 Z2So4YHObdR/q+YwC0SCVhVhvLrksj1Kc0Blldb3d+PMwE6/DHTgtrqxlbZ0HhJHnw
	 QkYD4h8T2Unu9M6TvDh6Dz/Og9hB8aAH9Jh/XtcBI/fWC6NnSv3NBtFInbMgvTrm/Y
	 1yFAAxUHAtMk7scQDGPT/6WjmIThIDYwBhGOvwN0hRvTtx1k/kmqo5a58VBkLC0anZ
	 4YmFLHA4FNPGg==
Message-ID: <sashiko-outbox-204162@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 9/9] kobject: Require explicit initialization of
 struct kobj_type::release
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108223913.3624571-10-irogers@google.com>
References: <20261108223913.3624571-1-irogers@google.com>
 <20261108223913.3624571-10-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 23:27:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Documentation/core-api/kobject.rst states:
>=20
>   "One important point cannot be overstated: every kobject must have a
>   release() method, and the kobject must persist (in a consistent state)
>   until that method is called. If these constraints are not met, the code
>   is flawed. Note that the kernel will warn you if you forget to provide
>   a release() method. Do not try to get rid of this warning by providing
>   an \"empty\" release function."
>=20
> Annotate struct kobj_type::release with __must_init so the compiler
> diagnoses any struct kobj_type initializer that omits .release.
>=20
> For the remaining legacy struct kobj_type definitions where the kobject
> is static, per-CPU, a permanent firmware structure, or embedded inside a
> devm- or parent-managed allocation rather than freed by kobject_put(),
> explicitly initialize .release =3D NULL with a comment documenting why no
> release callback is provided.
>=20
> Many of these legacy sites are not safe with CONFIG_DEBUG_KOBJECT_RELEASE
> (for example when backing memory is freed, zeroed, or unmapped on module
> unload while delayed kobject cleanup is still pending). Fixing those
> lifetimes is left to follow-up patches; this change does not alter their
> behavior.
>=20
> Link: https://lpc.events/event/20/contributions/2392/
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108223913.3624=
571-1-irogers@google.com?part=3D9

