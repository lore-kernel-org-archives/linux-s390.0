Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795116591;
	b=otWL837teX1BQnxVLpJ7IQF+0VV0tB0u9vQF7nPMlBHbQfv1lnZ7WXaH7GRH3HhkSpH8
	 cqKZbSNxouns4xMkiz2n7xQ9VpbrzFoXyu4qToErujpHuwJLdQeTSwP4C5VAfZu55slHl
	 83m4D27dhAHSziJ8c6fZ5vZG4DHVDIHChkn5zBekPy6vxwq2+iEHhVHdih3TG6GGEYTQH
	 MPGdBSOEhSgrp5q/5vTX+KhmaVSeOQiqnUQR+4EvTv6dpz6h+pEpinccvG3L7o0VlaIoF
	 NCrGHV6MMdQCMYZzzrEpT/6+n0tWHBEelj1RkrpAB/oOZvgS3JtdiO88ZTs5GoKMrWg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795116591;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=iRgK08fUMa356gDCh7+eebgK7ti3qV4KIQceNAM7BpQ=;
	b=IwK2cNkopFaJva7VU9CPmztZo50mCJvSQxiYlYSn/wzkS/glz9nimFnINZ/Lg9P7OZoW
	 Gqt8YDLBBF2L9XzcR27YDLFNfLFjCq6EYEvgzv25uv8CrqZixs7ZZxRXaw0buSMsihFaO
	 bCJRdy26mnWYEL29YVetj8e1ywqo31RiyBPAZsC+YBUOez+DMcewT2NZFpsUn91v7+CC6
	 doa8OnqCchi0hQAWiomjdLsUoyT2nWMLaAuGjiNRB9oeGX9Bw05XoaRwm6TdL5y5cDW3W
	 mAp+PsoG/aNYsK/oszqEBXKRyDrY5NKKiyOyxhb93tfBBY+EJ2z4Phj5eWSeI5GOJHw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isbiWMTn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9E4C260A380D
	for <linux-s390@vger.kernel.org>; Thu, 19 Nov 2026 19:29:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=isbiWMTn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6C731F000C6;
	Thu, 19 Nov 2026 19:29:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795116591;
	bh=iRgK08fUMa356gDCh7+eebgK7ti3qV4KIQceNAM7BpQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isbiWMTnVC1So2cJi1T3ID8K6PYF8tSO42kyM3CaSniTvJHgzgoLPsYw1IjahS10I
	 rI6YqupBnl4wyjZcBhwF3S4ux0Uqqq7XcXXa2ggLiZ1lzeot7rJtwu8OHbNlmYIdNZ
	 TYkE4XQkzd8DmypVv8t60rlZNTIV6QNiJTsmwfTgM/a4HSrJ//CDiZcjNF8Tz7feWH
	 IcEjirI6d/9dhhA3Hd6AFBqTYD59MI5Ji4WiZwqfXWsDIh1CcmCQIPUe2Qf9dos+1W
	 zQUeGflP6++01A1zV0mK1LrMFtFHC44Vl7iqQ5evWWdCGOFo8yej3D18IAQLELWajS
	 2Yb78yPyNr6xg==
Message-ID: <sashiko-outbox-223918@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 7/9] ubifs: sysfs: Use kset_create_and_add() for
 ubifs_kset
Reply-To: sashiko-reviews@lists.linux.dev
To: "Ian Rogers" <irogers@google.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261119192520.1983406-8-irogers@google.com>
References: <20261119192520.1983406-1-irogers@google.com>
 <20261119192520.1983406-8-irogers@google.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 19 Nov 2026 19:29:50 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> ubifs_kset was a static struct kset using a custom ubifs_ktype that
> had no default_groups and no .release callback. With
> CONFIG_DEBUG_KOBJECT_RELEASE=3Dy, unloading the ubifs module while delayed
> kobject release is pending causes a use-after-free on the static kset.
>=20
> Replace the static ubifs_kset and empty ubifs_ktype with a dynamically
> allocated kset via kset_create_and_add().
>=20
> Fixes: 2e3cbf425804 ("ubifs: Export filesystem error counters")
> Tested-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Reviewed-by: Zhihao Cheng <chengzhihao1@huawei.com>
> Signed-off-by: Ian Rogers <irogers@google.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261119192520.1983=
406-1-irogers@google.com?part=3D7

