Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAD14390C88
	for <linux-s390@vger.kernel.org>; Mon, 31 Aug 2026 09:10:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788167429; cv=none; b=FAKE10ehsynG9iaSyTrqAl6vV5PZE4uw9OLGPnxT4eXuu9Djr0vtTtvVDZ++q3TibMppMpVALP3w0ysGFKQD9vK140ySH7B3AZDEe5Y5s5s5enft3D0olnAUhJj1xJdShVDVextSfS3ceZpb4lsEhp0XiArXtlayOJWK6wkjDfM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788167429; c=relaxed/simple;
	bh=LiZ/gsusLvETIpzmGXH5/ZMG4I1JTNNn18PdEgxQGnM=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lVUepcCZUpZIor6dDWZwOEvw7D4tNwdQPJB8m53yun/1uEqXrN9lIitYJhoZFhMuT/joxLNLGy69UctasVbPBOpLbYOEdlV+IBY1MdjKcrOoaGh8I7PL9DVA+5qRb0IrGUePr+NElU5GQ474YuCyc3pfa2SmLrJpqSbrVbZ+6HQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=gRwmfTUA; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="gRwmfTUA"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E25871F000E9;
	Mon, 31 Aug 2026 09:10:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788167427;
	bh=LiZ/gsusLvETIpzmGXH5/ZMG4I1JTNNn18PdEgxQGnM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gRwmfTUA5oR+NbtfKRiD9bPsr7+fQy3peQnvbKCDcuEh5Rpf5/v5AjGcv+2BEtRei
	 XVI4Iq+oSu2vfx5ZS9nqF/4DxEAXopDtmG8x7QW0SO/rOF1igh3sCu97dG16uiT8yG
	 L22st1NWfPmRgRZs7lu/RE3GCPOn0+9dovdr9lISL1sc4Uiu3xmjNOmJyTVj1ri1xH
	 Em8po5hkr6ebeLz4jqMOWHrSmia/VS7u3hoEiXafiyASXWBdb3Nxp4vTnazOJHQN3/
	 vHVyQQRijVU7Z99WvYxYzl5bdavOlzH9p+PLcQ19Sprv7ovx2Z5UVVuHgMRIVurlO/
	 1slATv/afS+jg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 3/3] s390/crypto: Fix use of mutex in atomic context
Reply-To: sashiko-reviews@lists.linux.dev
To: "Harald Freudenberger" <freude@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260831083735.3625-5-freude@linux.ibm.com>
References: <20260831083735.3625-1-freude@linux.ibm.com>
 <20260831083735.3625-5-freude@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 31 Aug 2026 09:10:26 +0000
Message-Id: <20260831091026.E25871F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

> The AES CTR implementation used a mutex to lock one page of exclusive
> memory for fast CTR processing. Unfortunately a mutex is not save to
> use in atomic or interrupt context. So use a binary semaphore instead
> which is save to use in such environments.
>=20
> Furthermore rework the code to get rid of conditional locking. So
> restructure the AES CRT code by extracting the main loop into a
> separate function and just give in information about the (locked) page
> can be used or not (is not locked).
>=20
> Fixes: 7988fb2c03c8 ("crypto: s390/aes - convert to skcipher API")
> Suggested-by: Heiko Carstens <hca@linux.ibm.com>
> Signed-off-by: Harald Freudenberger <freude@linux.ibm.com>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260831083735.3625=
-1-freude@linux.ibm.com?part=3D3

