Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A00EE53D0C7
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:44:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871479; cv=none; b=rAZ2P+Q+HBKBaAZJ9yMSXpgT1K4H/fJKbCux3oSYlYcintdcH43R+ir3Mm88ATugBlIdlXJuZEQVsMGN1dv6mOReJFgR7bIon/CMq/XeRgBpv7AyOG+hH+33iWo5GjDhqQI6iuY96e77fBR2h3fFsfv7cNxVFHROv/zVFVLJAto=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871479; c=relaxed/simple;
	bh=m2ZDgQEymvysf/hShdYDldljTbvXLwijwi2IhfOkWi4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=hDL8q+9makpqt/N80Y9TkYnysj6siXsfqzzixVK5oIsmI7fYhQcqo4Op1753s7b52wCPNZO+AhiMbj9s1QKTxCSvIuBTAylKOy1UpuRQhvGfGsiExQy07j8AohNYu83POU1twSbbhJ3o4exEVH0ZJpUmMihfACBbTNqBxv1Ddjk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=LazzzdRd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="LazzzdRd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B2611F00A3A;
	Tue,  8 Sep 2026 12:44:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871478;
	bh=m2ZDgQEymvysf/hShdYDldljTbvXLwijwi2IhfOkWi4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LazzzdRd1Y9nVQxIvSJeRb1sY1sALZq7IoO0Pi+gTZZsEFPgeWaSnXih8yGxxUM+8
	 A7yXWu669PvOy1kFTv162sjvEzuIOqOEM9EyVReiXLWV2HSj0x8gEbrDbgQK+T2+4Z
	 vq9dyVNpz/QOxoo89KSSm4QowrND98XiYlX/WvlcIdwiKx8r+7bCdif0/uAHEQC+7b
	 UGV0mmH4sTpL79/WkvNGHVt1QEawLakv2dDFuZcGrHLorZ0YuZumaA+x0xLyZ7shFu
	 qVzkbqtnkKM0TguSL6Ks9+vliGtQ/zi++ms5g9UU3hWSjrr+tliua/12nRCT+uAZ79
	 +wuJUZpTUDylA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 04/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for MMU
 arm
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-4-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-4-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:44:37 +0000
Message-Id: <20260908124438.4B2611F00A3A@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D4

