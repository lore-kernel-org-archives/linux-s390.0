Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8757453D0C7
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:44:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871496; cv=none; b=X0HvTyNM/BeynWVZiNvvR9JqBgtZyWjI0/BE2PO6tKCUI+VZLsfUUUgSAN//I3zjSafR6auTcWscAYUeMzvBZ5cVbanxVUuxLm2Kbc7up8epUbe9kj95OcAiJYUF9I6KoTYJ19jp0BbosMs4Rd8OugXMhECaxOHXDzTzfQBYsSM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871496; c=relaxed/simple;
	bh=WameStcwd6pA9h1CRwQIykx7aBUnxVIS5QMHu/zAij0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=W9rXV3c14JV9BFQkjUpsAwX7hYZO62l1ZsbZHYmfBDul+wIlzAUYWE5zD/7J8snF11hhzRaykS4vm8CKY5Vk+PBw6OodGPoV60mFxgpBFJOKvlXyP23sKOu8ec7u1W3w7wyTvxQftv26Pk/IUZnEiLep7rEl5TV6cCv6BO4FAdI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B48E1F00A3A;
	Tue,  8 Sep 2026 12:44:54 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-5-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-5-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:44:53 +0000
Message-Id: <20260908124455.0B48E1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Each of these architectures directly free page tables without routing the=
se
> changes through tlb_remove_ptdesc().
>=20
> The use of tlb_remove_ptdesc() is required for
> CONFIG_MMU_GATHER_RCU_TABLE_FREE to correctly free page tables under RCU,
> so simply update these architectures to use these functions.
>=20
> Since none of the architectures share page tables or do anything unusual,
> nothing complicated is required here.
>=20
> Therefore this is simply a mechanical change - convert __pud_free_tlb(),
> __pmd_free_tlb() and __pte_free_tlb() to use tlb_remove_ptdesc() as
> required.
>=20
> At the point this is in place, all mmu_gather page table freeing is
> performed under RCU, and thus MMU_GATHER_RCU_TABLE_FREE is selected for
> each architecture.
>=20
> Note that CONFIG_MMU_GATHER_RCU_TABLE_FREE is dependent on CONFIG_MMU for
> xtensa to reflect the fact that nommu does not implement page table
> gathering.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D5

