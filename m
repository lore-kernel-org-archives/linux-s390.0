Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CAEC15221D7
	for <linux-s390@vger.kernel.org>; Tue,  8 Sep 2026 12:45:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788871554; cv=none; b=jgJrueQ/IkCGHhj7N6OcF54WCe9Ti42g9U8o+UVqUOngEVHWRNRSMV4m59ine6IO3QFINpXx9SBgGvY68e2qdfk1jIYqxTj4O+/egFuEDCAA4WT2/Lx5rNRKl1hyr2N9CnKcUSkCorrdH/sUe2FH29hAGl0SxsW8VzcylKzLg2Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788871554; c=relaxed/simple;
	bh=p8/Oq/lkvCXy89JOdcuLu2C3en5Lv1aieSlQW3Fyz2s=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ej5c0HRpRcVOkEeNEqoii4aGZBLkGmmsWetM0zuu4bfQiGdrOluUki8VKdqtYB3EAF0VOLIWn7GUOAksoLpsYpeDdQ/tdK/NDIT9GlwqOwjFlvaIlTCJNh8B8bX0YHFsebv9xC4IInaKv477/6D5Curkei4hCnf0RI9O9OhlyXI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RkOSla3S; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RkOSla3S"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E4D831F00A3D;
	Tue,  8 Sep 2026 12:45:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788871552;
	bh=p8/Oq/lkvCXy89JOdcuLu2C3en5Lv1aieSlQW3Fyz2s=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RkOSla3SbAgo5y+GGqv4s9EY5HdQg8SHecyKll8r9cmRHfH07ZI97e3PPIOa3NokS
	 cBI4OKaix1sjTcMoj5eQ5PNGsT2G5gDgrDWdNOqohhbwE2uSkP7sIm7v4EVvx59Xoh
	 H0p2NsNPtt0Kw1IwZ2GhIJn4xLbg+FfGdMAK7Bmn+TCX9IVpHApcy+VUMO2aE0OQVZ
	 sNEJ+xUBPCP4c6erSoUN7SyfPR6mBuUdLbowD3YO655XIhA7P8aoSLd30T0RCO4ZA4
	 ascSWCzwG1fi/F+xTs2viJMAFq3rK0swbYi4rrzv2DBksYCLwNwe+nxp9hksGs/0ol
	 xZU6L5k8Vai+Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260908-rcu-pagetable-freeing-v2-8-1f60b64e878e@kernel.org>
References: <20260908-rcu-pagetable-freeing-v2-0-1f60b64e878e@kernel.org>
 <20260908-rcu-pagetable-freeing-v2-8-1f60b64e878e@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 08 Sep 2026 12:45:51 +0000
Message-Id: <20260908124551.E4D831F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Currently, non-x2 sh specifies CONFIG_MMU_GATHER_RCU_TABLE_FREE allowing
> RCU page table freeing.
>=20
> sh-X2 is problematic because it utilises slab-allocated PMD page tables,
> and thus tlb_remove_ptdesc() cannot be used in these cases.
>=20
> All other sh variants are fine as commit e3ecf7c7d082 ("mm: pgtable:
> convert some architectures to use tlb_remove_ptdesc()") already converted
> page table freeing to use tlb_remove_ptdesc(), which does so after an RCU
> grace period when CONFIG_MMU_GATHER_RCU_TABLE_FREE is specified.
>=20
> Resolve this issue by firstly specifying CONFIG_HAVE_ARCH_TLB_REMOVE_TABLE
> for sh-X2, so the arch can provide its own __tlb_remove_table()
> implementation (called after the RCU grace period).
>=20
> [ ... ]
>=20
> This forms part of an overall effort to switch every architecture to this
> mode.
>=20
> Signed-off-by: Lorenzo Stoakes (ARM) <ljs@kernel.org>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260908-rcu-pageta=
ble-freeing-v2-0-1f60b64e878e@kernel.org?part=3D8

