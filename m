Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86766199947
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:33:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790368417; cv=none; b=IGomsb3nMjqwxo0x+021umVj0QqZrgr1iGO7QFkyrVtuQ2TkJYrbpjT4gOxTLwuzDCRQyQu7r78ezGNGEUTufzNSktBu609oiTzfFQRFlM5pnbhXgFJXU8BJuCXVZdc00WdZyNoIQfzVv/FUj9vYnpsN0R9gMQnZ/rBJX9WtEOI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790368417; c=relaxed/simple;
	bh=5KzKuUYumcmLK4CHRe7gA2Uz1K+87R7BiTujcR0EsVA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=fnhNEq5FSNBMDvUubNmSwUHv9E1SHOSj0C3nYthbcR3i8qR4/KyvnjykL7crKEvd2+miakoR+/qviZJj+ZwhtjjgBMFu3qe0PTKB1O9Inh4amxmF3+lCzVGjxbBiFbz+XMiIMAz7vgnbV7qcS4UnqGivus3KPDjfjMgfHHsL9Ic=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ghhz95Fv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ghhz95Fv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB55A1F000FF;
	Fri, 25 Sep 2026 20:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790368416;
	bh=5KzKuUYumcmLK4CHRe7gA2Uz1K+87R7BiTujcR0EsVA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ghhz95FvaoVrd3DMisUNPFheVbKMGvwgtRvxYwWjMS6Aujd6yu+YK5zW0/XrS8qaS
	 LdQZKtodoI8m/NAe9rVb16+G0FdXH/lJFAabdtULoPKtE6M3W0K5kw7o8hTimeTg4A
	 MbV8l2sXXqCYsMH3fr+3p7PcSjTEYwHncE9ehpJk2CEHPsvbdizLzPkHpTU04/GhoF
	 xOnxhkhLj2iOYc4hvX3g/ayiPKqwG0bmT3ut+U5vrx+8Ta5fSXknZMSM1vP2pjNAV1
	 lyDLBmAsFtqjeibCavQFFcQ3fy0u0LU5wfkAymP2RaneTJshWwkNd7X5PIh2UftVLf
	 Y/Zt0+qQ2eZ7w==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 11/12] mm: userland pgtable freeing is RCU-safe now,
 remove leftover bits
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-11-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-11-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:33:35 +0000
Message-Id: <20260925203335.DB55A1F000FF@smtp.kernel.org>
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
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Reviewed-by: Lance Yang <lance.yang@linux.dev>
> Acked-by: David Hildenbrand (Arm) <david@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D11

