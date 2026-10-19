Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05EB14E36F5
	for <linux-s390@vger.kernel.org>; Mon, 19 Oct 2026 11:19:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1792408770; cv=none; b=CXPnxVSGkKS2UaMdw+GL8Sz4tJHzwVKLgsXmdWKzuFIC1Ks1TZ8eLE+JvxxHlaIEjUZq7JKrlk7j53gZvnJU2h6XYffgVbM+ynk7LByiYOpd+z4mVqCNXHV1lX42c6GQMU7BbOA/BsCBXVVlL1oLjw3zq3jK8BOARcKlVZ4qp4k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1792408770; c=relaxed/simple;
	bh=mBR6M81axyCMlDs6q3aQrcgCBumTiURUKRtUszcakQc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=j88mAs0yWqC2x4JAzXw3bdyVDfgQqYCQ9RTguG6bEn8LEJ0DkxB00gA2ugaZLEaz8nvSlFtH0xkYBt0/bW4dCJDZhwdueybAE0O5NboTytxxQ+GNchz/cTFLyyRmLANXDRh/0ksaJ1qFDHMgt/nleQe9yKmAzBTvpA9MWbNY0yc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=XkmiaEmT; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="XkmiaEmT"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7C3411F000C4;
	Mon, 19 Oct 2026 11:19:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792408765;
	bh=mBR6M81axyCMlDs6q3aQrcgCBumTiURUKRtUszcakQc=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XkmiaEmThzUUCLWqQrbiNmCsmUxnsOVziPKmK5mhHT+r+ZYiTdN0tzsCh7sLPLJY1
	 glBAHuAMWDJoUEIOxNUOL2XZR0l4d2zatbiM9u34oQJzFcJGIsXXIVxnOxRjpE3/lB
	 kSaj7Ue2tpx1v3zWJxgnOfeDptnrUDgqbAXGLZ6o6EBfTdNETfYR5O8t262M4484+a
	 m5xxlMzo/yLE+bu0Qp99fIKcnvBN2A0DJR/SC/vR/qSz9etsLKaxb5SISVgc+Kgjjo
	 yX1zzapVLFbjytq+IpxeE2JKGmBtn7yJHwi1KDOewLi6FKqplKS3CaDBDjyLZAzDAw
	 b3Y0Fncr15QHg==
Message-ID: <sashiko-outbox-177028@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/vdso: Implement __vdso_futex_robust_try_unlock()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261019111233.3372751-1-hca@linux.ibm.com>
References: <20261019111233.3372751-1-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 19 Oct 2026 11:19:25 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> Provide the s390 backend for the FUTEX_ROBUST_UNLOCK fix that was
> introduced for x86 with commit a2274cc0091e ("x86/vdso: Implement
> __vdso_futex_robust_try_unlock()"). See that commit for details.
>=20
> Note that the Fixes tag does not mean that the x86 commit is broken,
> it is only helpful for backporting purposes, so required prerequisite
> code is present if this commit is backported.
>=20
> Cc: stable@vger.kernel.org # 7.2
> Fixes: a2274cc0091e ("x86/vdso: Implement __vdso_futex_robust_try_unlock(=
)")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261019111233.3372=
751-1-hca@linux.ibm.com?part=3D1

