Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6B5953C3C0B
	for <linux-s390@vger.kernel.org>; Thu, 15 Oct 2026 18:25:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792088750; cv=none; b=O5wg/A7UJyoyCEzz0MiyZE6RVu2aRFVtmeCDow1+iG6VynM5tR9mQPRpnUPtm5j0i57PRpHzNPfWnfnqMtbNpqvv+wlUleurOF7DmfCaorZc7I7UPNCGXqcv8yDFzrjdk0fmANbmBNuFGjt8/K4XXTB/pIU5+58fcgBI50PG4jg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792088750; c=relaxed/simple;
	bh=AEFFiNo/3kGLe5TBL09zaLncp+gTfypnDBvUa7SIFbQ=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=u03jmhr8YlV21LkBWNmdvRaVLlVqwWMKYTkr5VzS/lo7l2BccedrjrDhdAqG8kErICq0jCcfVGS8c9CE1XYQM3o2BwZL07iNQYpjVGN32T/WsmwD2PQUDVTDQk/o64pBTGgX8tKm9xXVMQAaYzQKDOPygc8aYLAQ7CxA0pGpQ7o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jyHsmBLK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jyHsmBLK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1FF81F000C5;
	Thu, 15 Oct 2026 18:25:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792088749;
	bh=AEFFiNo/3kGLe5TBL09zaLncp+gTfypnDBvUa7SIFbQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jyHsmBLKPSZmjeZ9uBC2K9d/mxdLCJ0WC2pzkBOq//72aZxCUdS269OVqfciWzPpm
	 LVQRovETo6B7x1g1UZ3yVKeto6EENJAXGhID7hCsqCcXlAC03+8aDpmSpLG7EPkxHp
	 isaLacs1FSVaxHOuIHyE28I5qvJ/e+3PYuFZwi6J5iP5P6xWq5/wrGZ6l6ZmL02iKn
	 +obrbpBee+iZO9xcxV/Gk16UnAHVQgvj71/KgSPTe6VAqgsDm+4VIBy/SONf4ofyj1
	 OPvVfo0CKb8B502lC+zCaf0qG1naix1DWgzX37h6Wr4NgMpwSjCQEUkrq5Tdu/UD2J
	 g6f/kW1m+ZsbA==
Message-ID: <sashiko-outbox-173285@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH for 7.4-rc2+ 4/7] s390/mm: always clear
 _SEGMENT_ENTRY_READ in pmdp_invalidate()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Zi Yan" <ziy@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
References: <20261015-anon_vma_uaf_fix-v1-0-7b977303b42b@nvidia.com>
 <20261015-anon_vma_uaf_fix-v1-4-7b977303b42b@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 15 Oct 2026 18:25:48 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> pmdp_invalidate() sets _SEGMENT_ENTRY_INVALID, but on s390 that bit
> alone also marks an old (not young) PMD, which is still a valid mapping
> that GUP-fast follows. Without CONFIG_PAGE_TABLE_CHECK, an invalidated
> PMD is therefore not pmd_protnone(), so GUP-fast can grab a reference on
> the folio and, as the PMD value doesn't change until the caller
> finishes, the recheck after taking the reference passes too.
>=20
> Code that invalidates a PMD and then decides, from the folio refcount,
> whether it may drop the mapping relies on GUP-fast backing off from an
> invalidated PMD, like it does from a cleared one. x86, arm64 and powerpc
> already make GUP-fast reject invalidated PMDs.
>=20
> With CONFIG_PAGE_TABLE_CHECK, pmdp_invalidate() already clears
> _SEGMENT_ENTRY_READ, which makes the entry pmd_protnone(), so GUP-fast
> does not follow it. Do that unconditionally. As noted in commit
> 7b4dde5e40ad6 ("s390/pgtable: Add s390 support for page table check"),
> an invalidated PMD that is pmd_protnone() is fine for the remaining
> pmd_protnone() users, which run under the page table lock or are
> lockless walkers that should not follow it anyway.
>=20
> Assisted-by: LLM
> Signed-off-by: Zi Yan <ziy@nvidia.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261015-anon_vma_u=
af_fix-v1-0-7b977303b42b@nvidia.com?part=3D4

