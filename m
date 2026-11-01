Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793561316;
	b=Aa7fxJTwms6pkwjRF6dqTzkdYm6sp2ksvGDIWOz25TBK4feQZvpoBQNbem3l8olkqL0e
	 T8G5FIPkbhSwfYgkEJLtVa05zXMtWNRRJDDhLmm+hLpwTrTHNA5pIWwpi5IVBgdks/0Fp
	 DaBwWSOUcSUnqBHFDngwHnYnRt6dO6sInM6zDTCrBao3EbLU9h4lAl80Hufah6A/4YY1/
	 WllVKgiS8X27YZwd/Q39S3FD5Fr30HUCPf4RJlL0nA2f/yyB2DdlIit7+sIM9oNWbyYFk
	 GB3C7Y9Baa8M4UdvIFKqsHsnbos5o0EaKR60V2nnR/gEaj3qX7gUj/qKeFCz2LbaSCA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793561316;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Bz7vG64vJxJq8a+ERfBqaZIO2oSQviE0icFjG6P1jaQ=;
	b=5tyGTvCkjXcqRPyTfiWRmEl94J5ME4FxTlsUyPZtQrHm6n4ZmCIsb2Wnz/7qkrSx9y84
	 F1S6GYusn2qjuOlMgzfS77aE7+FKkL8K1wHxgi3ZFYyyt5cVDuE17xw5rRIzzOXLZSAzz
	 XDxRioKvjeivYmpW53AaJIQ+R4EgyQAIc+Pwm5q0XG9zgg1vStYRxj5pc2+TdZhW5ex+p
	 pZ9jdZH7M5VNKt2ASx8CBcI+3B7yzOHfjyt6W6VO/fpR6FkrC+8pzniD5vl/r6GYdgK5m
	 syQMTbO8yB0ExuPGTDmC1VqfXPN4shu09f9oRYHmO7cYv/rkrY/nEAlLJgOQMgLXW3Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFwcvbeb;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D9BD1606A327
	for <linux-s390@vger.kernel.org>; Sun,  1 Nov 2026 19:28:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=GFwcvbeb
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 31FFB1F000C1;
	Sun,  1 Nov 2026 19:28:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793561315;
	bh=Bz7vG64vJxJq8a+ERfBqaZIO2oSQviE0icFjG6P1jaQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=GFwcvbebWBq+aMt9K4DL1MYC/NLURymw4CtK/Cf9Isbj/EMiCuZOYWQk2uNmP2RRm
	 W2d0AG8XOgS7HakezeBmLIz7UT0Gqujx8TZSwonAduA8WIUIkrff9igHsBBwSsY4TA
	 DEwfMcWiNvwuitKem3MCs1VcnpaeCrtI4vScyr1yZjpOLd/ZgHKpBVhlU/Rm/1Uhae
	 SUXIHeMvKeMuOVY8sG2NoFUQbW5iRG43p97pvqGZUwO3MRUGHT6h9DjTE8C/ZygeI0
	 CbXm4qxhOxXxbYHT5LQCQomLsGWeDY+Bs0qHpe+H0iNMQgwBl3Ay4InmY5AQQSM1qu
	 /c8Xg63iIY45g==
Message-ID: <sashiko-outbox-192601@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 1/6] sched: decouple PREFERRED_CPU from PARAVIRT in
 Kconfig.preempt
Reply-To: sashiko-reviews@lists.linux.dev
To: "Yury Norov" <ynorov@nvidia.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261101192203.6979-2-ynorov@nvidia.com>
References: <20261101192203.6979-1-ynorov@nvidia.com>
 <20261101192203.6979-2-ynorov@nvidia.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 01 Nov 2026 19:28:34 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The IBM s390 doesn't enable PARAVIRT config for their hardware
> virtualized Logical Partitions (LPAR). However, the steal time is
> accounted for the LPARs, once the config VIRT_CPU_ACCOUNTING_NATIVE
> is enabled.
>=20
> Preferred cpumask doesn't rely on any feature gated by PARAVIRT config,
> and requires it to minimize the configuration space and runtime overhead,
> with the lack of non-paravirt user. Now that s390 wants to adopt preferred
> cpumask, there's no reason to keep it coupled to paravirt.
>=20
> Make PREFERRED_CPU a user-configurable option, even if paravirtualization
> is not enabled, and drop PARAVIRT dependency on the steal governor.
>=20
> Keep the default module selection conditional on PARAVIRT so other SMP
> configurations can opt in without enabling the governor by default.
>=20
> Link: https://lore.kernel.org/all/4605dad5-aab2-49e3-b919-bf9897181834@li=
nux.ibm.com/
> CC: Mete Durlu <meted@linux.ibm.com>
> Signed-off-by: Yury Norov <ynorov@nvidia.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261101192203.6979=
-1-ynorov@nvidia.com?part=3D1

