Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 80B5F5427FB
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:52:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871927; cv=none; b=bEaHjMgKF4a+kWVvFGV1S/bqtInOyUC5hjWzkYKqusTBYfZFN1j+kaZUYgbCGUcYydJB2opqw/hseD9iZg6R/eLKbrLE8+xtb3eTS/nJCKayPPAomYwk9rGNDZzC3GurSDCkQ4CaN2wMXQdJpPJ/nhmk9NtGaS9WjkTbdnYUYF0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871927; c=relaxed/simple;
	bh=rSZ8tKrEC08ITkpjzNS9l4ebnviOJUufaC3/CWJpahI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XjOFLJhURrQyAkM+TpoaedXwk0RvcBpnAcETkTN6Ujehji4SDY02AdQ0Pug8/c00w1U5lgd3AwVfoJEfin7NgyQKrD1j0D4HNJG+mPqh8UlwfJ1sR60z6C1/QCv7yCohSMl1Zi0HJJQ8UPphlUHkz2xVyLkU/pbsJXDI6Rfglp0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hYABtu6T; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hYABtu6T"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 177821F00A3D;
	Tue,  8 Sep 2026 12:52:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871926;
	bh=rSZ8tKrEC08ITkpjzNS9l4ebnviOJUufaC3/CWJpahI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hYABtu6T3zyVtGfrFIIDWUi18QR4g7It4s5CuG+RF1vcR0gpReChCdc4q5EZycnD9
	 fRh4CtnBtnGODdZY/ABU277UymZ8nhOy31gKpRtW08w+VnMuIBBlqXWD62wzYikjmK
	 RlEsRCYb3J8jX9EmxCEEGm20Afwy2d3c7EQUYhDaoTD9NUr0fFPvtGdQNs+mAC5Ard
	 5qdBCFgch9pNS3dMVJp14afoHrxxaHyZ63IRIGUN4P3Kcgz09SaSVYoUB/VjRQDCY6
	 wgnCB1qpvw8WBL5UCj+VOMJvcZLDrKqxUALbqRVvrPUF/ISL8NCfLd+wKMBz+SN8Gj
	 nX9k+MfTymzIw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 11/12] mm: make userland page table freeing RCU-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-11-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-11-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:52:05 +0000
Message-Id: <20260908125206.177821F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Now every architecture has been converted to support
> CONFIG_MMU_GATHER_RCU_TABLE_FREE, this configuration option no longer mak=
es
> any sense to keep around.
>=20
> Therefore remove it, and remove all the dead code that existed for
> !CONFIG_MMU_GATHER_RCU_TABLE_FREE architectures previously.
>=20
> Additionally, CONFIG_MMU_GATHER_TABLE_FREE is no longer necessary, as all
> architectures instead use CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE when a custom
> __tlb_remove_table() is required, so remove this too.
>=20
> A number of architectures only enabled CONFIG_MMU_GATHER_RCU_TABLE_FREE if
> CONFIG_MMU was set, however the mmu_gather logic only actually does
> something meaningful if CONFIG_MMU is set (mmu_gather.c is only compiled =
in
> this case, for instance).
> [ ... ]
> This is all that is guaranteed, however, so naturally it is still incumbe=
nt
> upon page table walkers to ensure that the page table entries are as
> expected.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D11

