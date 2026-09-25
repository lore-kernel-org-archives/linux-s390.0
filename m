Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A10274F0524
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:28:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368084; cv=none; b=NbhRqlVkkTxczmHkv7WnrmJTN9QzQ6Ba+oj7mv09I6BpG3WjA3O99rzcI7VQCsTmCg2RB2j0WmJRp7rXI0PEsgQKRBDxalNOcLWuqEfshPEzddln5fTDCaA25P6MkaiZ1YejEBcJaayWdildLCgWwID+r6kovsvDJR+2GPIh53o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368084; c=relaxed/simple;
	bh=VPjW0RQcs+AsWOeXWvkt1rNvlQJG8tPoPuO9NYdcRd0=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=jzVGmmSyx6uQ5IIYQzBJ4un5MyuDITRIpwa1AblCaqUW1kSAQSAjxOcI2UMVftY8uUcdYRRdmYwRjy3t1dLlb+3Ukd+ieWdfvuWreZHbVsqHX5gmDuRBTO3QmkFrvePS7t7AAKl4UD3CoXM8NTckTG5ll2a1PzZZmmZxwHyzqgQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GzZ2acVm; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GzZ2acVm"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1FA3F1F000FF;
	Fri, 25 Sep 2026 20:28:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368082;
	bh=VPjW0RQcs+AsWOeXWvkt1rNvlQJG8tPoPuO9NYdcRd0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GzZ2acVmc2+Dqgo7YLsB+TXu3JCCkHmAj4UQ/M3Ue0smtMMaFbtvioSjLuZR4aOI+
	 TgQWBAt/0E1rJN2TxylIn5VKbOIjOPziE+xYEBU862/7zBhn+3VPqbWizCXW6WZDx9
	 wTm3iAXLH/FNJR76KSu1Ojn2V+5pa+gyCB40GlEmjaHNxvV5nKJsSJq3st83dkhxwD
	 quE7RBFVAMa3Eb8DumOxtaOX8365VhWo2GQ9cCPXKvejxHt9VLlh/umbDF9kEp8vS0
	 4u94HYqcx5PmeSb4WrNJViibqGn1eFl5LFd3pYKwkMsvx1zqqOcy3BPnbo1oVKoZ2V
	 HYBITNQviYzaA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-9-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-9-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:28:01 +0000
Message-Id: <20260925202802.1FA3F1F000FF@smtp.kernel.org>
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
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Tested-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D9

