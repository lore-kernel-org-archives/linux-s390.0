Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793562034;
	b=EqWf+V+ZSk0LWOl9Zy7KVbutBvZHlvCyR7qgNXikwOYhOUlxKRq4Gczqv1cSUbEzy/n7
	 qRISzhkLELME2JD3DU4Uv9+3L96GilpFr2dyatGpP/M7Z+PZU7Oz5GoiCAAYnQLQv1sCT
	 r2FX9c5x6BhGMVllt075v47Ns+SidBoKnwwK6LMNu28vWHCBExMYtQjAx1BF40ODh7b6A
	 j3AoZU6ojGjRHQx8dU37smXr+8+zqSCM9ZfAM7LHeFjG9Rvq03aif6MpncJmtahclc7UX
	 oogYCJRMbOTADCR/3vjUxrN1nFAiBa2Y9/RZg4VST2khD0to/p81WoqgdOQLmPKoHvw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793562034;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=pdvFWsApKxmar2eiZLNV2znpzPqmxEHjQ0hK5c3ClXI=;
	b=zJV/el9LN4l9Z5Xnuk6+kHckBnQDE/IBmcJxvV6hUah8kdTTw/L4LJCDyeQ3enKNemAk
	 /PTaXmiwomm4Uzy2EX4v0Ciu0sxNIarPGGWFeVroXrL3I2PKkwP2CHILnBBEqxvoIWyhl
	 E+2GwW0I+V/VgiPcfmyjsXHxxL06yFlZdDsAquqhSIBgl07gmOURixWjwOsTGhAFKILYk
	 dsfalB9gx4ZV5sh/c30pgHT91oemR7M0ApWADR7Zr2T3CoDqshkwWNwoARWOl2MzAKF30
	 ud1BO1tioU4wqGjnY7oS+KNduCIQo+mBHIMOXcGx02dyZslYUH3MOUfI3oQZbyzpmKg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It0gp5ZS;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1E965606A324
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:40:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=It0gp5ZS
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABE961F000C1;
	Sun,  1 Nov 2026 19:40:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793562034;
	bh=pdvFWsApKxmar2eiZLNV2znpzPqmxEHjQ0hK5c3ClXI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=It0gp5ZSxFe/S1/CQK3cqzqjeYAXJBCqWwDPva4s7ZaveJueb876u1uKO4og0+9ak
	 K2d6J0QNWY/oKgb2IxxXjiN/jMmzLy+peLRp++EVNYSO1Uh7QGe5shmGKkkV78XmIR
	 aFz9Bhn9x8u46KSbBqyt6KvZrBt7MG3ROG7A1Cc/m5FATs0EAKPQlpA5UU1BwopcCn
	 /p7VxWmG04QrfiChsOnumoVq06K6N/XzhVU/3xJHQZQgaGwJbX4dST5PCspc9yZkxd
	 shdHDroH/oeX2UaRMt8YLphXnAiBCGSnjfEaprqm2vS6hbMygZ67rcEXJ2u2gQJK68
	 ZPOMuWM9YZrZQ==
Message-ID: <sashiko-outbox-192627@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/6] cpu: Add per-CPU preferred sysfs control
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-7-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-7-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:40:33 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Expose a writable preferred attribute for each CPU so users can manually
> select CPUs for scheduler placement. This allows users to select any
> desired combination of preferred CPUs, except for selecting inactive
> CPUs and deselecting the last preferred CPU.
>=20
> The manual method doesn't imply any preference over automated governors.
> If an automated module is loaded, it may override user preferences, and
> vice versa.
>=20
> Fair tasks whose allowed CPUs contain no preferred CPU can still run
> on active non-preferred CPUs. Other scheduling classes are unaffected.
> This creates an environment similar to isolcpus, except that the list of
> isolated CPUs can't be changed at runtime. Tick suppression, RCU
> offloading, and managed-IRQ avoidance are compatible with preferred CPUs,
> but may require separate configuration.
>=20
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D6

