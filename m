Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D869253D0C7
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:44:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871443; cv=none; b=BhI5RiYJWN8K5Bzgq0X/C9aiWmlGqb/mJKTHA0BHXEu0gO+Grtq5K02pXn1fUD+D0Mw1URczaMpFlSQ4mv0dC3G4yMAu4tEAPpp95dq88y2n4kyYRiCdrNlIAu7ogn2PllOO86r3oHUfziLQxxtlNFCJEY79NG7IJaSO/YY3i8c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871443; c=relaxed/simple;
	bh=8eyOlXVW6KQ0bx0E3c1V3RZp5Kdbb3pVcg7+WVw7lqA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WNI61b28TvwsVRHVkJLstRfA9T1wLg+XOFJQCyz3FClNuUd+hRU0ud/7dSxuFlXNb0K/0uf9BvziNHr2ZXdwBqsKcVh5kUP/7kdirvtpDD+WgnaJqEf+PLPAiXqkJotGGO3uSYU/BmWzW2xJZFQims1yLkBkUMHHeA463X8WmoY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C6101F00A3A;
	Tue,  8 Sep 2026 12:44:02 +0000 (UTC)
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 02/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for most
 2-level architectures
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-2-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-2-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:44:02 +0000
Message-Id: <20260908124402.7C6101F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit e3ecf7c7d082 ("mm: pgtable: convert some architectures to use
> tlb_remove_ptdesc()") updated a number of architectures from using
> pagetable_dtor() + tlb_remove_page_ptdesc() to using tlb_remove_ptdesc() =
in
> __pte_free_tlb().
>=20
> This is meaningful as tlb_remove_ptdesc() allows for RCU page table
> freeing if CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> The csky, hexagon, nios2, openrisc, sh (except X2) and m68k-sun3
> architectures all have 2 levels of page tables, so the only page tables
> ever freed by mmu_gather are PTEs, so this update suffices to ensure that
> every page table freed by the mmu_gather mechanism is freed under RCU.
>=20
> Therefore, update all of these architectures to select
> CONFIG_MMU_GATHER_RCU_TABLE_FREE.
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D2

