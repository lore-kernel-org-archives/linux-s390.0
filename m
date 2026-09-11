Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 518545867F5
	for <linux-s390@vger.kernel.org>; Fri, 11 Sep 2026 19:56:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789156609; cv=none; b=Ix30pAUskcX+bKBXSJ+cHbu9CstAs/v/yjLoh7MslM9nxI8T1HRT+nIO9uh985uGTvRsCzHtHGj16w1aacGEI7X1AzOX+GVy2QnbvxSF987/efEH4fwjeYD8nLIQCUk7opc0DM++lys1x5odSTs0sbro8qFk3iegZwynoE8QD5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789156609; c=relaxed/simple;
	bh=G1/pIknxk7XRZjRoZ2Lpt9vkYg9lXXsbJr+BfXAxvCI=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ciHv/i9XGJENFr2b9S5VuFsznjbbPR4P4St/nwTnQ8y8gWGetbkBLvzPFdcM6uJnKm0nziXnndQ7LzaUaoOPCHVDTiSUh/HmWk3CJdWk3wHNFb06YumpxUd9zFQchuJyHwEoYzRbt/xr6ceC+Gb2j7kCUgcZD0uZv71cRyMpwB4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=GfgPJe4g; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="GfgPJe4g"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 59F5D1F00893;
	Fri, 11 Sep 2026 19:56:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789156602;
	bh=G1/pIknxk7XRZjRoZ2Lpt9vkYg9lXXsbJr+BfXAxvCI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GfgPJe4gyRCBFgu0/rwmu6Waz9xAYU14voOqhleTEv/mVOlFLgD+WBOqCTsBgDw8U
	 OEFAqntY0oSOEVhBmTnd46F90+Nc0o7ENVFmaGYepQluC5RSLkXEYUBo6SKY4xZ51a
	 45ea4dmPA/WNYebuIDbwKYyoTQAoHb+WEyYVB9Pq9/29YZ/ZAJcXmM+l7BVVIUu3G2
	 u2yUrQR8ObHD5jG5Y/LFX/vrFFbnSuM6SucirBQrejZsrP61Xf5cWtuAghOKqaFttw
	 emi/ugaOVYAHUmRjsOws4csqfYI56dw7bX2z4xtww364UsQ9FImhGxvENSCFnqJrhV
	 wXJRItQhgUFbQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v3 09/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for
 m68k-motorola
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260911-rcu-pagetable-freeing-v3-9-7b8c86103821@kernel.org>
References: <20260911-rcu-pagetable-freeing-v3-0-7b8c86103821@kernel.org>
 <20260911-rcu-pagetable-freeing-v3-9-7b8c86103821@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 11 Sep 2026 19:56:41 +0000
Message-Id: <20260911195642.59F5D1F00893@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260911-rcu-pageta=
ble-freeing-v3-0-7b8c86103821@kernel.org?part=3D9

