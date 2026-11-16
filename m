Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851828;
	b=K9quv/I1iOPQeW6dZX7jikGbY4rI4K85JviKItkoTsyqTIuZLVBDeSnFaYb7pLhejQDI
	 A+qCCOIpdnim0c8tNafmTl+lWqf+SqsgAATFQF1qX2AOWOPTDPOoKGSRtDSUUQr1aS572
	 OKvSKtFCtG2qY3cr/wFQzZMJMGddjH5wImW27bdU0+qjTCwJ6v+zw/gdj627lgsIJfmSs
	 GbokDdUW15YpmgrA9nn6ZShDD/kQyYXTTWLhvKA9u9UvmziqolT56E9o03Hcwo4INr/Rf
	 bDLrOb6tGsSxv5LoG5lUpOseFoE56kaFqM26yEjpKy1q3M8mts6bC07noiBT3mZJHfg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851828;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Sg0CWZx9eugpGC/GsLes6zHiJPXOx0B3SVzyiT2W2i8=;
	b=inO4od7jmv7lh9LzA5ffvomomByzdVNQdRIX75uRX9xEkUpViUGzC7YrOmcUhDLB7Ubv
	 gfULYvU3hhKDjfEzcNBJiI2GY6pgmGjHoB2+hlmj6hyEJg+7RZoBQ8bo5A2OuT22mp+cC
	 0tb3r/thgeMnb8TUb5QYi10lM/t/RKAqlR9a48XqAFCrxfbSdHr/ggtKAw2EgwnGEcvpf
	 cFihHqR39+x9ui6fkwoNEptoobjbrArzTJhleSkaUhzr0XKmUycWfQO8mDkUJee7iyGkG
	 1qsoNdeaDu4Tj5GOBAdFpFoVDtp0m8O02LGqJi2x/c5PtOKKEuumSjQuDDKrsNrN1cA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhmVmb13;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56169606A332
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:57:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hhmVmb13
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C450B1F000C4;
	Mon, 16 Nov 2026 17:57:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851828;
	bh=Sg0CWZx9eugpGC/GsLes6zHiJPXOx0B3SVzyiT2W2i8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hhmVmb13pVDtsVevnG5I1rCj9oFGkhnU25QmDbnO6dN50CWdMSQQuWLcoyRho0yY2
	 1yoLAwIhM2ZNs6k6g562QNKsBJaSrxePFMk9mfsaYZvMyL9l03HjvluFkKM7F+Owfn
	 p9XyBbsBqhiI3pYDvBy5qpUP3aJRyw9niOgg9kAIO/P6211wfBCYBHhz1Cg/YRUYhN
	 eQhiSDwL5+5NCo9CwhcvVZGVJQv+yTRXkZ9RnoT3djzQ73cW9oN5nC+bhjCEJoBilJ
	 UmSEYYkLR7bQoN8C/GyRqXgFXAJ+cHqKC5ZKdTQ+hmQPDegwdmTArJoe9/VzyZlBzK
	 Oq0lFIwyw4Npw==
Message-ID: <sashiko-outbox-217466@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 06/15] s390/cert_store: Fix cs_keyring reference leak in
 fill_cs_keyring()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-7-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:57:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> create_cs_keyring() returns cs_keyring with a reference held. On the
> success path fill_cs_keyring() never drops it, leaking the reference.
> The keyring is kept alive by its link to the session keyring.
>=20
> Drop the reference after add_certificates_to_keyring() returns.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D6

