Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EA7AEECB
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262090; cv=none; b=u9nu2lNavkGiNN2gor0IblHAkbqPQdUWl2OKq+AQH+jq2qS4FRL9aXI7rS4k5pBoZFpFWD9bjct8IIsClMUfLwF/yztMJ9cgxxni9Egqm4+q2qzlWXRs9omtEAd1riHojHChYev2wSm0mHKVpUHMD3XSwaGHbBntnyxwFlcIGfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262090; c=relaxed/simple;
	bh=Xa6swYJwX1OTdTdCwNmjXcHKaNAssu5ykr+iWFq3zFQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=NWRBc+GDzuZnyUIdtt1Qku9don8upbT2+L3fgsHHmNYRjPFq8dXU4RMT75NbLUATetqx3EZGzwC5aBzUK6adoibn2UtROeZgwLI9qK4Xjkw9QfTRs4Tk7YCNBEg9BbaOJBir7hNU1AWL9k0eSywURYt3EPxwlA0eHeNhmTlA8ko=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=lFd5yCtd; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="lFd5yCtd"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA021F000E9;
	Tue,  1 Sep 2026 11:28:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262089;
	bh=Xa6swYJwX1OTdTdCwNmjXcHKaNAssu5ykr+iWFq3zFQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lFd5yCtdSBXJn+gN+/VoOOK7Yw/rcXuMOPYeyo0mueY+1AiGdUV8tUHDV9VjzEZfu
	 p7uIce6iwV02jgi4FF37blyUbNiXFvHzFvIZnEnhks72Cq1s2NNcDpwjxiJlLP8AuF
	 4IbrUi6vVLgZM8ljLOsJ6Frc/1kNdaR1IoAt5WyT1QliRK489Na1pT6i/+VwHvXwXm
	 fJ055j8yoxSEXhmIvpPY8Tua8+CfGU6A0Ugk88Xco/METN/PBZZVdkLJoOt/fAsVAd
	 du+upuj/1hi3DBgqMUs7PSzOW8RQG23vf8PLpUtP5vp6SDHJ4mYNEoTuY8r6bakOrm
	 Ng3rrm4A+V0Yg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 05/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for arc,
 microblaze, xtensa
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-5-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:28:08 +0000
Message-Id: <20260901112809.0AA021F000E9@smtp.kernel.org>
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
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D5

