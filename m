Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E2327280CD5
	for <linux-s390@vger.kernel.org>; Tue, 22 Sep 2026 16:01:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790092881; cv=none; b=MgfowTsg19FR/TgWfgUL/RNJwLMkgBtvtGPKSjBZHHA0nazAhpcKQb0WkO4a7OaZzvCjWNiqnSoDwfsAIyfCN/or4LDto8y+ebqHoxBl26QfPqCYEb2DxioZpmAqxsXFizym14eASiSXUS75CoQ0z+Pd11OT7nhF4XOOiL0zh2U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790092881; c=relaxed/simple;
	bh=jBisn8Gp94cq84F3B3YSVxIqWWbRry1gqdQldhLYD8A=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=G5dXjkqpGCch/J/Lm42k5PcVB0VStYHOVONNT23Cw8lel3+gCywI4IqsLoZDPGHdeFxTTmkdznt9aKQv7jSDwj3jB1ZXntQeaQnFAqIqxFvN08mK3Nom/HWA/pylbX05deFkATjq1+xAB9IMsgUtn0EpdJi0jBRdUyfxfjI6fnI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Mg9twF1F; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Mg9twF1F"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E098C1F00899;
	Tue, 22 Sep 2026 16:01:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790092879;
	bh=jBisn8Gp94cq84F3B3YSVxIqWWbRry1gqdQldhLYD8A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Mg9twF1FAEmJHvXXMkbBEKtOX3MRvTUgEcZ0qm7Kcqi3yV2RniWsn4CxK8xAp7Rbx
	 su7PvduFpT9vDQAFH4+CP0clZf/nAGFEbPjymJTRZv76HC3x4hxiW4J9wRN1GfpG46
	 Zckw4v1HYTXjwMyZw8n1ANngPh8VeYdKHOFVY09mAQ+XqcSq/MniqSP5ieRTxHY7Fu
	 nxL5M28Vb1SgfrLhdkF7mkyXMQko+Dm3QVVXC/F3rdtB6khQkR3H8BBEu+urHom+Rx
	 UEkoRUY/TERdg2oSLPpu/NU6CP24yrhFCQq04nRnzmf+ZqdzrQ8phP0PjweJ7GUaCM
	 d8sf1PD2YMhhw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 11/12] mm: make userland page table freeing RCU-safe
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
References: <20260922-rcu-pagetable-freeing-v4-0-fe1ad1f1e303@kernel.org>
 <20260922-rcu-pagetable-freeing-v4-11-fe1ad1f1e303@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 22 Sep 2026 16:01:18 +0000
Message-Id: <20260922160118.E098C1F00899@smtp.kernel.org>
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
> upon page table walkers to ensure that the page table entries are as
> expected.
>=20
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260922-rcu-pageta=
ble-freeing-v4-0-fe1ad1f1e303@kernel.org?part=3D11

