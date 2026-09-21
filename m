Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BD643457E4F
	for <linux-s390@vger.kernel.org>; Mon, 21 Sep 2026 08:45:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789980359; cv=none; b=g3ztW78J7h8ALGpYd/b/MyKQwggZlK89Pg24uM1nUEaf1RkJWKUKmHSmNSBOpIWZcgt9qCqXLvTKenC7fxUj3uXum14Mw8CHnaiDvupKop2fTA4q5lnz1AJEpseQzVxT4io9VBDDLmOccGA5xS3Xliuy2rmWozRrzP0zjRLRlh8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789980359; c=relaxed/simple;
	bh=QTkxBgXxEdX6RLwKNS8XPMH6qDTKZkDSV/RXtebA2MY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=AzPmhktgvll1kKgV0NZ75s0mznbF2ucwXB0ZarjdJpaBi9MhHK2uWLoffn5PO3H1oWZfphxkMrEZrFEFk18rpBka+7vHD6/i6O1Lj28xRYGY1taaShMnpcMtCRVPzNx4kegYA9tmuKUcrZmTmVL+m9GRmt7werJKyIEYoKT8xMc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DR/7wjjE; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DR/7wjjE"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A5F91F000FF;
	Mon, 21 Sep 2026 08:45:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789980358;
	bh=QTkxBgXxEdX6RLwKNS8XPMH6qDTKZkDSV/RXtebA2MY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DR/7wjjEKfGZe+hQ5O3b0LyujJBdRkB0yRsoOIxBxhyIb+xbpPMT30pnynUbzNV1r
	 2Cj/gQBK2XFQfOkpQV5ZdUqGPaFtxZcwgsEfMnJQUA92ypxsyOGy8Lv15FnawrqLqg
	 u0UZZOdmvCmWfGcy93SC1nBON1xlqQNPYnLCZjPymODMMiyzL4Y8NaVpiFQa5toIap
	 EeqAs0csUm3ydvMCoNLeAYQsRRQoO8ntd+EFhqe+/Kfmr4EXC8eg+N5w6k58tvw0SU
	 Sh7kVlcMzjFBAqvliHg2ZSJ3nhTw870exSxpBFvlL7fjLyiNtNcVgx3BaGa/HSCIIA
	 +qFd/yEqb6i7A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 05/11] s390/percpu/lowcore: Add and use LC_PERCPU
 lowcore offset defines
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260921084005.4022574-6-hca@linux.ibm.com>
References: <20260921084005.4022574-1-hca@linux.ibm.com>
 <20260921084005.4022574-6-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 21 Sep 2026 08:45:57 +0000
Message-Id: <20260921084558.1A5F91F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Define LC_PERCPU_OFFSET and LC_PERCPU_REGISTER offset defines and use
> them in percpu code. This shortens the percpu inline assemblies and makes
> them a bit more readable.
>=20
> Note that because of header dependencies it is not possible to use
> asm-offsets. However to avoid adding more dependencies to asm-offsets
> it seems to be preferable to use the current approach in any way.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260921084005.4022=
574-1-hca@linux.ibm.com?part=3D5

