Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793969289;
	b=UrED4B0+Op9ABTp9g4aJRae9AvyLMHkifmmRtGzdlOJIoVJTSByMWP5Ql7r8A2cuhC7M
	 xDgQNPor6iwnZFOWdrJb/Qhs+RPop6XBQUUWwgGFahAx2Xzq8iQ+98K5JUndpSljany1s
	 jg0ljCiC8cpXTF5YueLiuztdxcPHETFmuxlMbbDemI4bns6RoVgiQGBgYIV9mSPuRqBDF
	 kSAyZPq6sKaB0EeL0Thwdfr0idOYQRcJYtyqQFotMyvH+BJSHSdCBoiWOnMb2yr6R5Fm5
	 d+iWyTVZGpaNWYrQ5ko8VPgEfaHXVUlX/LLalA91Gz7NVY1BBeK92nW/rUr6mCf2/ng==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793969289;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=MhwEQoJtNRZJlmrEs1A89vUyPLNxq1vGL/oAu4Qw9nQ=;
	b=w90bhs3I8LV2yjVP1yEG7fud0TzNTHYMYDUjTQ/YfI3D+TyKaWC7M2VnlIE4/VGYVX/J
	 ZQEBF+GJl19uh6uiVHuFr/eL9Lz9iz6C8ues2Y+xpMhLLoPj2ih+8a0+gQ9l+SWKbbQ1u
	 j4zsjbdXGA5rR0XgcrsDOBURyI5XIuGW9/bR04nfjp10nSB3u+jjgaIM3haYlphW0p4OS
	 MLgFI0/5WqutS1QyJqZe1JPg0u5XpcWxh98i4K3h5I4l3Dh6OCiMuTtm8azRMLMcuFwap
	 JI4yMJjpRRzXUoACqlaXSFYesUaTkz+mEIGwY34VqpsTLRHXoVyf7NRuMJQqHpB84qA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEZC1ajG;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84FA9606A329
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 12:48:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=QEZC1ajG
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0E0B1F0089F;
	Fri,  6 Nov 2026 12:48:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793969289;
	bh=MhwEQoJtNRZJlmrEs1A89vUyPLNxq1vGL/oAu4Qw9nQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=QEZC1ajGvVl/McDsnQEB5p6zWU7QRsRfYMtkhohfy+zZZy2hKpyxACVOkrK/yl9pp
	 R07GnYnToOfcYaDoGxWVNlVu0XmG52uPZYghGk4qglLzf+Lqa4ZOaHJVNkkas+XrvS
	 3KBeIZaesGeJYY40RbWDAtbu4QKxrzMDqKwZEPVuvdQayVC+cM0G335boFnOC1ml13
	 rXR91kpL8zW71pSmtMe0xz9oTSaOccMfoiegpEzdFtsZoE8YWcQxqa3G8BJP4oLPRQ
	 8aS0+GgSDFNmMYQeHa7lFMI3Kr6/W2MPdQbjnv6HrsTeBoCk7NSBx5Xq4rERSrr2fz
	 dtC27kmxGEtcQ==
Message-ID: <sashiko-outbox-201413@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] sched: Decouple PREFERRED_CPU from PARAVIRT
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mete Durlu" <meted@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106-preferredcpu-v1-1-3f0ca4944f8b@linux.ibm.com>
References: <20261106-preferredcpu-v1-1-3f0ca4944f8b@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 12:48:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> PREFERRED_CPU mechanism does not rely on any feature introduced by PARAVI=
RT
> but PREFERRED_CPU still gated behind PARAVIRT. Any architecture that
> would like to enable PREFERRED_CPU mechanism has to also enable PARAVIRT
> and bring additional changes to accommodate PARAVIRT's requirements.
>=20
> As an example, s390 doesn't enable PARAVIRT config for hardware virtualiz=
ed
> Logical Partitions (LPAR). The steal time is accounted for the LPARs via
> architecture's own steal time accounting mechanism instead of the common
> steal time infrastructure PARAVIRT supplies.
> For s390 to enable PREFERRED_CPU, PRAVIRT and its required stubs are
> just unncessary.
>=20
> Based on the discussion between Yury Norov and Peter Zijlstra over
> Yury's original patch [1]:
>=20
> Introduce a new config flag HAVE_CPUTIME_STEAL to indicate that the
> architecture has steal time measurement capabilities already implemented
> and to signal that PARAVIRT is not required.
> Remove PARAVIRT gating from CPU_PREFERRED and add HAVE_CPUTIME_STEAL
> instead.
> Select HAVE_CPUTIME_STEAL for s390 and powerpc-pseries configs.
>=20
> [1] https://lore.kernel.org/all/20261101192203.6979-2-ynorov@nvidia.com/
>=20
> Reviewed-by: Yury Norov <ynorov@nvidia.com>
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Mete Durlu <meted@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106-preferredc=
pu-v1-1-3f0ca4944f8b@linux.ibm.com?part=3D1

