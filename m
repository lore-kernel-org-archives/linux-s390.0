Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792535755;
	b=jk3IXAOLDyjOWKckklA3yWq+7xONIWxuicCPpw5X3AExhb91dbDR4TWCNqDE7n6rSVSB
	 zTw4WTHMGlf3goURZBYHaXlfgiK7Gjbzu9d30NMa152P7l4Ye6Nvq56mT54ab8mlZhbSA
	 vZyMq5n1Gm3Vci0GV/ANykXFAsZtNnNommHqxoHYVnwDChMQsPhZmKjzU5wjihtvTBqH+
	 5e7ZQr16Xq5GXc0fBCCpnIS69yeJMcClYaae8JLvHUzDeB9CA+tDOKDn40D6LMKyUaX/D
	 b5ySPXHnXB4oUphkjuJ6F6C3fBILUZ771CSrKDUvh2PIHfbhWghYpYN9Pl4LjbzQwiw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792535755;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=UbhXAz7LAgUeB39L8oQqNSaTS2qvWb9WftqUk331kdo=;
	b=DQMuB/sIL1gQX1vRurfxrMVJMc7TrPF71DqYvjXQot9u/Ns7gRHrCp8HcvgxXqodVdEo
	 2jPbBiXtoEKJB6w1bHSCnAX/vzmmMMHHy3EXhAFaF8SaFsokhIzkluT9lw8OywAW/K/yP
	 nNuFllVKjNId2eQlzf4EkAnm31RHc7K45zuCZLWaweLHZGImGdUkd1KY7/Yreijbz5+xT
	 3XQuLLdb/hTAU5cYWKioB+xzHVi9hv9hCDuxYZI1KR5cuOk53XH5xV4tFSQrPbDmFKGlR
	 cSlPSeDxHXiJR0p829nA26kR1H5QKKvwzou52dYFNJ3Ajq+DwVT0aqYR6Q/tBo5B+NA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6KyMXQp;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C3631606A319
	for <linux-s390@vger.kernel.org>; Tue, 20 Oct 2026 22:35:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f6KyMXQp
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F3B8B1F000C9;
	Tue, 20 Oct 2026 22:35:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792535754;
	bh=UbhXAz7LAgUeB39L8oQqNSaTS2qvWb9WftqUk331kdo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f6KyMXQp3mZ1cPXrQ3PzSOXnugzsUSLc/X3S+x2c2qxdStrsZtEn4cRryrnizxLlf
	 wrmrqcSpSlhhFDoGkjdqobkNgxV36RVcgC6j8qP3LsbW4/X3elaN/h/xK97Kx1ipoU
	 e9xtLQ9vw2gM3aRh+hKhRKU3Ox5XW5Ptdsucc0eo9J3+WgRpS/xRNBB02ung8et06j
	 8IQfquhdgZswJ35QgMWB44Koi/8LpVAk877LF7DXX2eqpygO9fytvglrZpMCGahdkb
	 atfvSreQQvnD9iLD+zU8C0/JiZN2bY9rkCUt9WFqx+k+8N5jjeUoZm3FYIK8bMueZG
	 5DICrlO9MIHsQ==
Message-ID: <sashiko-outbox-179548@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 2/5] s390/pci: Reuse FMB buffer across enable and
 disable cycles
Reply-To: sashiko-reviews@lists.linux.dev
To: "Omar Elghoul" <oelghoul@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261020212427.2561-3-oelghoul@linux.ibm.com>
References: <20261020212427.2561-1-oelghoul@linux.ibm.com>
 <20261020212427.2561-3-oelghoul@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 20 Oct 2026 22:35:53 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Allocate the FMB once upon first enable and keep it for the lifetime of
> the zdev instead of freeing it on every disable. Track the enablement
> state in the new statistics_on bool, since a non-null FMB no longer
> implies that measurement is enabled. Defer freeing the buffer until
> device teardown in zpci_release_device().
>=20
> Drop the alignment warning after allocating the FMB buffer due to it
> already being guaranteed by the kmem_cache.
>=20
> Audit the only consumer of the FMB (pci_perf_show) and update its
> liveness check to be aware of this change.
>=20
> Signed-off-by: Omar Elghoul <oelghoul@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261020212427.2561=
-1-oelghoul@linux.ibm.com?part=3D2

