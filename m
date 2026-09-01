Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 46E2837D118
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:18:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788261499; cv=none; b=iNmlZ9K05GaDfLdRTsgIHDX5VcYhorxkpekhlF+K8Ed1VBgzkh/3A2/4wGyy4H1oaBVE4yLshByRx1c4gshwKSBIN9FhC8iUd1AJICR3TEBExvjGIJrdpOdkORwG/o6UnFiL/5up6Vx1JkaYJmzupsdKywZf4NMf4xlL0g4We6c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788261499; c=relaxed/simple;
	bh=mjdsRXYGDi9rn9+moQt9xrIuTZ4f98XCgkv+wqfinSk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=XKcW8Qy9RANQXGZSxz/09AR/XYCJogLLSInXoIOLDWa57WMLZkSRapkUiofpxStvDVrMEqu+YQbMpfPBsdLeRfDC26jikhC4xl3EOqOgWg87dYh7RqNu6xWNRoQia4pgEOpK63eDNu4yLAmAbMk5zwVL2QPxzo6xVgnn34FLZl0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=eI2MB4Gs; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="eI2MB4Gs"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 592C11F000E9;
	Tue,  1 Sep 2026 11:18:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788261497;
	bh=mjdsRXYGDi9rn9+moQt9xrIuTZ4f98XCgkv+wqfinSk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=eI2MB4Gshaz2z4wgyzbrVOYMia3lr6HsoP7LDiG6afkoWxjMlnwS9zctbkJJnVQ0z
	 +4B7uQNeDN8yGIDlErpMBQoXKGuEBp6gn++s1A7F4pgFu3RVUwPZE0l7mS6YBG2Jrf
	 YayKCsBjqEJ1M9KAV3dIw2fTJXa22/2U1ooqPm2xIgUHMY2BGD5L0YT6RYwF4eXV9n
	 SAUssE5NzZQHQld50fgTXNMIDBaYFVshlaj9EaWuBv6s9c7RzhP1LCVjdb7B+582GG
	 Z6+/H4OW3jrKmPVnpLj39CIRRJjsDADPzrA7TfDUpK8XpKKfj8CRS8SQ37NeG2UD3L
	 dtEELNj0fCxRQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU arm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-4-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-4-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:18:16 +0000
Message-Id: <20260901111817.592C11F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Commit a0ad5496b2b3 ("arm: mm: enable HAVE_RCU_TABLE_FREE logic") enabled
> CONFIG_MMU_GATHER_RCU_TABLE_FREE (then named HAVE_RCU_TABLE_FREE) for SMP
> arm architectures with LPAE enabled.
>=20
> Regardless of whether CONFIG_ARM_LPAE is enabled or not, the same page
> table freeing functions __pte_free_tlb() and __pmd_free_tlb() are used.
>=20
> Non-LPAE PMD page tables are folded into the PGD and freed by
> pgd_free() (PGD freeing is not part of mmu_gather page table freeing in a=
ny
> case), so this is a noop in this case.
>=20
> Since commit 358d1c39c82a ("arm: convert various functions to use ptdescs=
")
> both LPAE and non-LPAE PTE page table freeing uses tlb_remove_ptdesc().
>=20
> Thus all page table freeing is performed under RCU with
> CONFIG_MMU_GATHER_RCU_TABLE_FREE enabled for LPAE and non-LPAE and thus it
> need not be gated on LPAE.
>=20
> A UP arm system can set CONFIG_PREEMPT_RCU, so a future pure RCU page
> table walker requires MMU_GATHER_RCU_TABLE_FREE to be enabled on UP as
> well, even if concurrent GUP fast is not possible there.
>=20
> Therefore, it is both safe and desirable to set
> CONFIG_MMU_GATHER_RCU_TABLE_FREE for all MMU arm architectures (nommu does
> not perform mmu_gather operations).
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D4

