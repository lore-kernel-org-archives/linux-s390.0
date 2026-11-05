Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793895698;
	b=fhQ1D3JQDYPQNNFrXqkVZKJnKqqgRJLGeJbIpBK2TW2QAkopmwSzayUCwE7ONshoJoNq
	 W+TBut7l2b21bfhf/1umSmR9XiW02mqlhQFfq71c7D7lIarAk33ae1IrycAU3u0o+f4uj
	 AmdVv1jOlSSbyB3W4qs8uu3YISvvxRawd+Ky1/EV8pon2FLYdvKVnXcabNAQdzZmrlHmY
	 D4cBcmGCQwoC35mokET5EEvmHdYlJfhltMi5jx6uwyP57l9KqdQ8zvSpk2DoDCBEX4ZHl
	 XzmCPEBqcbrUBAOOVG+s3UC2WpoIABVNyJgsjjXDDvl2FsW5FlSwuV6nBxqpe2hxTjQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793895698;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Tp826uvpjXnnLZqGpsS8jA2PX+wqYRiQ1BYa9qSTzvQ=;
	b=cNBIUJtg6UAkHdNuFc6/ZkyWGXOuo3p+RoqXy/RG5JYfZSW/wfSjp7BF6Mezev6DhYA+
	 fiWKSROYdYsSr/h5hZHQntDjjiDkMho0A9lIR9p1+d0g8+klm9ljVMzANoRHIVttsfodV
	 1vutsCEr13PnIz91QDLoVBkrNnluBcf0n+QMzuqZX16p1Ydk0wKpk5oCogg1Sx0Hztj6b
	 p23bAjDHUb2qEHlJ/ykCee+fXVmReKbRz3K3OX9Nzqoqv8P85nk/GwnhtmJA1FtJKZ5W8
	 0N0ek+PBxrpkAWlmcmXgpLZ78U4N2zs7HVX78ERhaOk5DG1InF21mtWy99S4Fzcgk+A==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geuWONDM;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F7E5606A332
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 16:21:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=geuWONDM
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 510431F00919;
	Thu,  5 Nov 2026 16:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793895697;
	bh=Tp826uvpjXnnLZqGpsS8jA2PX+wqYRiQ1BYa9qSTzvQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=geuWONDMBdJobelfk57zOe5B4q2T72m8cCohAlyKwkHjfyH0VSZ0lA4cWmyWTbiEk
	 i1g8BXWSHGkAwoCjddqkBzDxWUF0o/ZQ6r0SZ4yNaSsSvDpEtHbmyiF82vpySRXFOo
	 YG6M2d+QnHwgr7NXmt+brm2o8gfMVsvNOTbZi+rLHW/kF2bwzN7PefF4jRgf4oGjq8
	 qHSi7o40s7OtOxi0GFB9Ru/8w6OHk1YWpAsTTjKTrXaKxbQ2+kFQY5L+kCcfe61xm7
	 g2AMp2xFE8GVB03Lc6RvPy/mCbPgD7lxox7nIkiyQ6s7nFVb8NGrdy/1pWYxAyMLby
	 bOPcPuMe5XZqA==
Message-ID: <sashiko-outbox-199473@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 2/5] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105153705.208516-3-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:21:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153705.2085=
16-1-imbrenda@linux.ibm.com?part=3D2

