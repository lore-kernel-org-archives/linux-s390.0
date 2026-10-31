Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793408073;
	b=Py01vrxNhyj8i8IxL7iatWbrc7D6ySftPLmJH5sl0Sg+1U1RIT/Fc8zbE7j8gYBYhyut
	 ve6a2YA0v26bwF61sYFJ4Hbd406fSwuFODnK5KpLVAMIzcOikMEQT/5/1tntT/h/H4awx
	 1vMarost0pMrOT3zZANReDzD2RRDfMG5OLpGs5FeDMgC4qBIHsPhSJn+AEDL3qQfiyhrL
	 Oo11jrPLDxafQEUt+znXOytvGuY66bimH3jQgfM4VtqTdwKX+qo1inATrHHlTD5F3hF8G
	 q8E58pAfxt750DXqwfi9/3Nt70wbSyItQIoCQ3F+bQbQP9dkz0tczkD3QFcaLuay13w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793408073;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/VlP8AMtvHIrmpv4Ca8VfEp2DiVAi0o6sxJaGwd3BRg=;
	b=PX4pPZ3UTBc1+WB69ArY9LRy56uBHNwb0aR6AJ4NBqB+xNt1q9WjjnJ920C5Z5uF3hzC
	 U7CbXXy9SPB1HhP1jdlss9I8Z1G3O//1JCPA9C39VzER61n3TUHYe4Ua+zxOnhKjnMtSV
	 6La6Gt3vaXsrerwMQAInT0aTTMCPUZ20CTUBPkObV1GhYSj5yDMgguNo6CSnYQCEEhlKR
	 za9/jPyON2/jiSfN0iHfg2jJ7tVNv7ztDTL9uoMPCxYSbPAe9iQxuejcJWMpR9VotXmTY
	 FGduhzGWW1eM5tzN1fVJ8QG/8uuXEIZ4AZxrg2Kf0e2hzBPs9gtWKYHbLzt56q+CsXw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEnymSes;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8F0ED606A326
	for <linux-s390@vger.kernel.org>; Sat, 31 Oct 2026 00:54:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=WEnymSes
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E8C451F00A02;
	Sat, 31 Oct 2026 00:54:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793408073;
	bh=/VlP8AMtvHIrmpv4Ca8VfEp2DiVAi0o6sxJaGwd3BRg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=WEnymSes6FyoNh2GyCdDF4im6EHat9u9PImJ6m0Gm4pA4mEQFxMRnbiIpLNoUPPSN
	 gWiO4OrRZ1wSAVB3iYGy+s0aWcN2n1y/IZUzwGry93yAKKQoViCrlcNhJmns8kB4wQ
	 ondnCfJHAHVL4r+uek8KqfGeCly2OScTuwPcl4si4SXPNk+g6kJOMZlwmna9tN3nfA
	 0AR6n2fXM5WdCkbnqbIVi3VAxz/MHtZViPEMo9C3HHgjGD5rUcRYJo5qND8rRTfa64
	 3Vl7jNXeyE9SpmnEuKz9g1kqhZMjP/7X7KXEO2cODVFHeJh5O8CedcXdQAESyPZ1jy
	 dtkhGsWCp83nw==
Message-ID: <sashiko-outbox-191686@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 2/4] powerpc/mm: drop powerpc vmemmap_can_optimize()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Muchun Song" <songmuchun@bytedance.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261030140720.1256062-3-songmuchun@bytedance.com>
References: <20261030140720.1256062-1-songmuchun@bytedance.com>
 <20261030140720.1256062-3-songmuchun@bytedance.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 31 Oct 2026 00:54:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> PowerPC no longer needs an architecture-specific vmemmap_can_optimize()
> override for DAX vmemmap optimization.
>=20
> Whether the optimized mapping can be used is now decided in the
> architecture-specific vmemmap_populate() path. When PowerPC has to fall
> back, such as on Hash MMU, it can simply clear the section compound order
> there and disable the optimization for that section.
>=20
> Drop the radix-specific vmemmap_can_optimize() override and rely on the
> generic checks instead.
>=20
> Signed-off-by: Muchun Song <songmuchun@bytedance.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261030140720.1256=
062-1-songmuchun@bytedance.com?part=3D2

