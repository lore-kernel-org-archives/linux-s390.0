Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793896055;
	b=n8jCbtPeGe9EeHradS/WU7AONbNpQLa3N6qNX30BAvN51hwskBbm3PuVHUpQsowgPAut
	 EPyycGnMeQt1doEJWLTL/3ySjAaE7u4zTNnY7cnLPvde1PzTF0NutiH0z3hqvgZeWnT5p
	 GRlVEunfpGWc0zRJypBcxGs+Ogh5dApUIxdVWqcLozsipg4ftSvBHlPQu0AkqOc1Wx1sg
	 qM2lZYnuov28z2/tUHrLa+0AxGvQzIByofDtR6v3adQzOt4qJykQLoaVhmNsRsrHjkPxj
	 BE4neX+Jbp/yWXnGwyqeqrQyhf8eXSszKA2UUMl296RalRT4n2VVTTdJ263whfgzWOQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793896055;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bufECInJeGxeRCIZ2e49nsRArgJwLa+Z+FYHyNkLISM=;
	b=NrqdiPIlyyCzuWG9tQycisTnDbUyk08uMDRvZjTXeiTEtV6vOTfcjHnvGidc4CN76huZ
	 hXlk0+bf8Zay2w0vnFzs3YFrx8wUSbl0Gqd/U9fN90/ecZss6qOdBwgPiZoo8qC8VQH+6
	 q23sLyePSpgT+g69wJNOshDBDdgD9kP4CYBHJby6IKD7GOXsNqAXIBtNRswZo31uMo18V
	 +WiC3y97bfGQIcGU0GOcUR00wE44r/X6NPxrULRJcqYyBZU5Td0N4KueNOnjdB+HUUWc4
	 cet2B0QyWrFqgZ2Gl3gCqqd+R+2yRgSAGllroObr6dFt+3kfptgOQMg3oSaNcfEQ/Mg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lss2vJMh;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 51856606A33A
	for <linux-s390@vger.kernel.org>; Thu,  5 Nov 2026 16:27:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Lss2vJMh
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B4601F000C1;
	Thu,  5 Nov 2026 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793896054;
	bh=bufECInJeGxeRCIZ2e49nsRArgJwLa+Z+FYHyNkLISM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Lss2vJMhEyE3VgmWUzEjLvCq5CpYDR4bQGvdTJekt43E+B6HT7VaH5BL6xAowzEI0
	 TkZCIyEqgEnhW4tt4S8w8yOgBWvY3wiwUQiGC2e53pdYSpl5NXZ/NeMPACJQNOpDR/
	 hBoD/yXwYHk2zmBf02YUEKjJfNMF7Bvl44CxhqP1nipo2CChR7Ju1WIFO4y9ogizv2
	 BBakYc2wgJG1NBVx4+epvpzxt5QaZh/lAJ6ngFwrKdVFSaPb7XeeBLTU7VU0g/nJnq
	 DUU5idGlB5p/5syovUZK7x4FQUGZ2p2ebiwN6fGX8ZCPa0yoOMwpPunZZWa2PF8vt/
	 J3HqlFd9QIbhg==
Message-ID: <sashiko-outbox-199494@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 3/5] KVM: s390: Fix idte_crste() clobber and table
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105153705.208516-4-imbrenda@linux.ibm.com>
References: <20261105153705.208516-1-imbrenda@linux.ibm.com>
 <20261105153705.208516-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 05 Nov 2026 16:27:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Fix idte_crste() to add the missing table-type bits and the missing
> "memory" clobber.
>=20
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functi=
ons")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105153705.2085=
16-1-imbrenda@linux.ibm.com?part=3D3

