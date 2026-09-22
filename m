Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C48045616D3
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 15:52:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092369; cv=none; b=kENs1TjuR0oBQMgLypl6KrZ6YxqNnIkl1ZEqKyVRpCSntMlSvMCdYNiXuoBbT4ft1WxqeZzzumxAbwsUGz4SDWfUgs2eQVstmrXzz5t/sj0bAYWXW+sDB4d5hCmJg2o9b9dDUEoiyDBbHU82OGRkiG1nHSmhlAWAfuQzPlmpy8Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092369; c=relaxed/simple;
	bh=magqmf1W8HjyLGooJP5XWK+Edjhg207/kPru+WZ3v3A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hlvjBpdY2qC2w4VuWvFohoRWapcMvOHYfQfdUQ5qPSrvBS8OGlyG1eZ4g5mAQ/0+4LkzHsvmYQovVsda/BQCciON3WbJKTkcBj+Pb8hVjvAPI2PyA1u2i0CejXytsdgC2PRV1uDhuHKxzNZxrYLiavID/hoZOe5d6ki8xTGO2fE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=bu6U9DbZ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="bu6U9DbZ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2A9FD1F000FF;
	Tue, 22 Sep 2026 15:52:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092368;
	bh=magqmf1W8HjyLGooJP5XWK+Edjhg207/kPru+WZ3v3A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=bu6U9DbZjuXcbC9IcgzP1fvBoTCBGpF4JYZFfEyYzJzRfdTlteYczgdTxcBqF4wT+
	 jUrkuigFOzbH7Hvb1NtnPQnGNpdpiKRF4xiD6pDZb/EbTooaGADkDdVIDZN++MiWCt
	 u1GSteEnLhEp9EMbTOZymH3n6dsYVleKc1yFGH0MJotq735b8FT00cp+2wGhWESqmq
	 xXaL24VrsTDelyv2GfpHrwCRBETS5cJC/fxJj9krJ1rVvA2XTmKZISsbJYxyOc8y1V
	 CjLhk5MXTmsGB+YmdBu1rwnay+mx4mfsRte9al2o9J/P6KgKPzDXrKSj4RHi5518WD
	 AT00/wEnzcH/A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-9-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 15:52:47 +0000
Message-Id: <20260922155248.2A9FD1F000FF@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> sun3 and coldfire are already supported, however motorola requires a litt=
le
> more care.
>=20
> Here, custom table removal logic is required, so
> CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE is enabled for m68k-motorola.
>=20
> Firstly as part of this change, the page table level must be communicated
> to the underlying __tlb_remove_table() implementation.
>=20
> Take advantage of the fact that page tables are aligned by more than enou=
gh
> to permit setting TABLE_PTE or TABLE_PMD in the low bits of the pointer,
> and store this there.
>=20
> Then update __pte_free_tlb() and __pmd_free_tlb() to pass this through,
> then have __tlb_remove_table() decode this and pass it to
> [ ... ]
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D9

