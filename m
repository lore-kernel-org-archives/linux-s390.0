Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F00D502559;
	Fri, 18 Sep 2026 15:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789745674; cv=none; b=b/aLbSE+uSD503kDUHP+ee2ws5VtZkOZICTZrlOIkAVmuHS06jcC1exg2N0aTMXuyfKPKo+gRm1HaTD2YdMrCfBCKQJtj/s1MtOXk9QUiW3VNjkeTsIMiQkEyrb2fQFG967+jwMPpCM+SEPZlYO+IV4MMY59mHjBKaIYQiROLXY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789745674; c=relaxed/simple;
	bh=WP/tYNd5BdIIDhB155NLDhXKjHsBamsQxDwG3V5kG4M=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=L1J/EQQTgO2lvI9dxOHjm+OhFG4wS9vdUgG1dDC6L1IaS10YMR3CwYvrPYTjam04ZDiAtMXS8u+81qx/hBeQyZOg1Gb8dRXV5Qb3JiUliXebr1Xi7am7WFu8TkzCQ5D/MbdpGNb+AMe3vx8UXesWFEHKmd7FT+NRgB0yh3Sk3ag=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=V809Q7I4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="V809Q7I4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD06A1F000FF;
	Fri, 18 Sep 2026 15:34:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789745673;
	bh=TLpS+Vr7eI8c6zu8Npv1Wbbtlq6m9EuLe/fUJskLpBo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=V809Q7I4B6rcEM2yeTCXT2/3HOGv1kSIFOlY+DSqObp6GIaws5kldD3XZJaV1dWVU
	 8u1CSHU0+bXrvdJhsQFuPkgZWcwvcGm0FRKtTJznCN7aIrHJrj66Gp/7KwEdUl2Aej
	 bawJMEbB7vmCKym6HFqKCf+3YLMjqvNKicDwZg7KkfvhfYXh8adUtMK7Bq+5biN2Ep
	 gDZZtRSkP5xr+sV7aYY9g1cwaq9Pe/rZ6ysE9N/88ej9xe3sM7kUVJGxbCQandioqG
	 cTrsGjcqvE8qfSglTaH01zGHVar5pxLp1Awg9QZSb5T6T8lIBhErRQ2XlvlwWcQtTd
	 3UJRFkmfPP6KQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 13/21] KVM: s390: vsie: Lazily keep original scb
 pinned after vsie exit
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christoph Schlameuss" <schlameuss@linux.ibm.com>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260918-vsie-sigpi-v7-13-f39806eaae37@linux.ibm.com>
References: <20260918-vsie-sigpi-v7-0-f39806eaae37@linux.ibm.com>
 <20260918-vsie-sigpi-v7-13-f39806eaae37@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 18 Sep 2026 15:34:32 +0000
Message-Id: <20260918153432.CD06A1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Keep the original SIE control block (SCB) pinned and only lazily unpin
> it on reuse of the vsie_page for a different SCB.
>=20
> - Pinned pages are tracked and will be unpinned on VM destruction
> - Memory pressure is not significantly impacted as the number of
>   pinned SCBs is bounded by the number of vCPUs
> - Reuse detection ensures stale pins are released when needed
>=20
> {,un}pin_scb() methods are extended to track the pin status in the
> vsie_page->flags.
> A new vsie_page_init() method is created to allow reuse for common tasks
> in following patches.
>=20
> Signed-off-by: Christoph Schlameuss <schlameuss@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260918-vsie-sigpi=
-v7-0-f39806eaae37@linux.ibm.com?part=3D13

