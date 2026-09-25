Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9573B4EE86B
	for <linux-s390@vger.kernel.org>; Fri, 25 Sep 2026 20:24:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1790367866; cv=none; b=nEytVC+AsrTOu7BQ0MqD4/tCpmwJxSLx2ICLie5fI996+ibu+oLc96DubMiomQq88sEt6ka+12MveOTF6yVhxHm/dGtR352Sn0lRRy+GR32kUIQ0fkhR3jPQ/IDW/SqRXXCPLe2ZX1qtp53ZziE52iJvBzwrEysD4CiaNmDhiPs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1790367866; c=relaxed/simple;
	bh=RuNjQBlDz18p2Lg/4X3Nuvw/+bJpcmvz7rmeBUi3CE8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=q4BXrHDEG2wC/EDL6BN3uQgBPsgSQiegq1AGVQxp93GcxplqiA14Q+A2Huw7qhMxgl4ta2fM7vJv1Z6C2wlH9QWofRUeHpSZWCU/kAIbPaoIiLDDMopo7kVY/5ZwU3Z4TdEfTIozz8zLdqYo5HZJPqPelU2UIZr1TIm0tMVk6YY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=apGubOsA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="apGubOsA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2E99B1F00893;
	Fri, 25 Sep 2026 20:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790367864;
	bh=RuNjQBlDz18p2Lg/4X3Nuvw/+bJpcmvz7rmeBUi3CE8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=apGubOsA5evK7YuYO0H3sNQC/U2Q5sottuOmNZJSmkNDjYyON5gnA4ymP9An0D2u4
	 fKAbpcyfJ61zaRkbpKONGNTJwivaRDCC9+rkMlmUW4GWEZjFfdhPgvftTmKTrQ3UoE
	 VuQ7Q/Is35EGzQoDJGUOY9blfmSq7dbpPkJfDllag8ijucmgfSpwSWlfMsxG1HHqU6
	 u4w7I1pvlg+wpd/01N2vmb1qfwkTeaknsz0je6GY775uNYd6JWUzIA8/DkU0nyFSD7
	 12M9nmoQTj4rC8Z6F0leGDl4w55iPay/wnMSTvS9BKZmUnfT96aj5ThnTLQ6ysEmfM
	 QPr6Kgn2Gc64g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260925-rcu-pagetable-freeing-v5-5-31e91065fea4@kernel.org>
References: <20260925-rcu-pagetable-freeing-v5-0-31e91065fea4@kernel.org>
 <20260925-rcu-pagetable-freeing-v5-5-31e91065fea4@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 25 Sep 2026 20:24:23 +0000
Message-Id: <20260925202424.2E99B1F00893@smtp.kernel.org>
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
> Acked-by: Kiryl Shutsemau (Meta) <kas@kernel.org>
> Acked-by: Lance Yang <lance.yang@linux.dev>
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260925-rcu-pageta=
ble-freeing-v5-0-31e91065fea4@kernel.org?part=3D5

