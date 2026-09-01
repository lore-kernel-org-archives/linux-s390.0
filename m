Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E9B8525F988
	for <linux-s390@vger.kernel.org>; Tue,  1 Sep 2026 11:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788262247; cv=none; b=nbOaYwQuCMxrYLUxWUE5HjosLonDFLkVi8saOOqCtIEzKoWK76ptFDV2zeA1jkY+CoFBc0DvcBsyLhy4DJZSIqyoFv2brkxTbRuRmCewC2fLhlhlJaq+IVlImuAndMCuDVTvzIRbImumh994q2wuMLMU3Gk6T5YUWCD2YGLOf+k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788262247; c=relaxed/simple;
	bh=4JPT01SqzfhrnDhFrFrx6xK+ipjLnJYkg//Wu/vTUA8=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=adBxSweUnXGwOvDOED/laSOdoTUWaSXqFVFLS6ivXfpJvr6M2EbtjPbCnKshk+BVH5cLZRprXRZT/HC5mWzjPx9rCb9p4GrHgloGo4Dz06J7mt++HFxlyTw7B1oaNEOAauztKAsBc+tZmIZEnISQws36fUcf+aWQTGbnUMlVljI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ENwGUqrk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ENwGUqrk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F1D01F000E9;
	Tue,  1 Sep 2026 11:30:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788262245;
	bh=4JPT01SqzfhrnDhFrFrx6xK+ipjLnJYkg//Wu/vTUA8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ENwGUqrk0KLbnNnE/QAfV3x7+QqOkERUmKti16bdu7tPcGKCewajzZTDzoarpE1q8
	 HJuMs2QeV9netvO3pJi09XgBxYG4mXNz+0/1LXtDpjzIgX3XTeKVN0OI5J3lw/ST5q
	 ngjaxjVLvY6iVtoop4QTl8WuU0UkL2GlpuZ/1T8R4/KnWaG2mlytfdA8rVRUyHvHTY
	 GzxoGHb2aRytLduk5u3wCTV4e2ZbNdjO44CFhKLkAz6i1JdJcdM4I/fEmLLHrATAul
	 KVIQqaME5qDNcPtoZSI5Nm0pSFeYrgpKlbJzzEJ+AxII3Z4yEI4qa3OtVMFR04qLSk
	 +IWt26rbDq6wA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 08/12] mm: enable MMU_GATHER_RCU_TABLE_FREE for sh-X2
Reply-To: sashiko-reviews@lists.linux.dev
To: =?utf-8?b?TG9yZW56byBTdG9ha2VzIChBUk0p?= <ljs@kernel.org>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260901-rcu-pagetable-freeing-v1-8-5456a81c8212@kernel.org>
References: <20260901-rcu-pagetable-freeing-v1-0-5456a81c8212@kernel.org>
 <20260901-rcu-pagetable-freeing-v1-8-5456a81c8212@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 01 Sep 2026 11:30:44 +0000
Message-Id: <20260901113045.3F1D01F000E9@smtp.kernel.org>
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260901-rcu-pageta=
ble-freeing-v1-0-5456a81c8212@kernel.org?part=3D8

