Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457893;
	b=tYkvH2D6d9KicxSZQM0fFgZtAXdc1UHjcAIXfFNUyDTEWNAeHioxhuVMbfgCwUiD2FA8
	 vq8HEDue3jpga5HPFHvZjKYRT2TmP6z16LbUM5TgUgK66hEwmDEeqCsDnuQJ0pwsDazlS
	 ZoeOno1YrmZnXkwOghbXz57YDcn9E8qP+PbzEiUFdPJM0hsp0cgVvKMeij6WrZGSAjAIe
	 qcI8yfrfh9hfpjnDwNPC1683sY28TpW6A3SgX449OnrvHCHiVTbfaILWwoIH4M1hIp+Bf
	 MGnAKys8VoOeJAW1Ib5ZqNZKOAcd2kMrECgCUtkVFcZ9J6Xd8Q4fE00fzx1hT3/NsMw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457893;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=oYknBPlZJYAgECq79x9f8uE4Xy57U1QXOVM+BLoL/wM=;
	b=kXR4Fy6LAxmV/tKlCVLmexY0tkON+nyt9OpEhfTh+SraQ/EOU+dPfBVePoAu5nKEN14n
	 ZM7w1gD2NzrYOonV/IUYmmdUP5IG9T37rQOjci5wPlC1P5O+dJpi7EVy3wwE/oJKtxUeq
	 HSTV3REN9zsv/sHKa7N5cGc6bE9JgJ1CherhsYXw4tgTF12BIuJE0On0gSBbEfcbJ2mte
	 SGl+WDex9d2jTiBMkunRfe5BSbh8hJMX4Q/fzT23WiFBNlxMAusC/NLjBJ1DJxNr3XULh
	 JboCIWf4cBk2WFZuFHYroIxgaCuHnEXKOtATDx8b2sF2UvW4HpIIX6wCQxMUTtVCtQQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cN0dxhKO;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5510A606A895;
	Thu, 12 Nov 2026 04:31:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=cN0dxhKO
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D0A511F00A06;
	Thu, 12 Nov 2026 04:31:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457893;
	bh=oYknBPlZJYAgECq79x9f8uE4Xy57U1QXOVM+BLoL/wM=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cN0dxhKOOEx/6gVFIa1Oe/mC6JKe6MVSmzHwvfXP84q+v0hXkXQB4wcYsJuOYIwPS
	 ZkPwS/NKb8689Cfeb3odBDcw0/4BeX6zo5I9mF7pP7JIT4jaA8gMJn2McZK0i9azlJ
	 w+aLdqohGX9K2h0Y1PQP5EfFwFM/e0gWvwUu3+NAnGeBrl+xVfKzQJzl5JP5ITQGLj
	 XrSJvXP840jmxgU6NRQ2Nf08iHRwmV/GULbKQGmyUpqbdCBnLwb7a9KVdGgk87gw9K
	 nJSlafAYBGXhT4Oz3hHCbn9snUqx9NRnwmR5AMSvgq6N/2pajebnE1g0WqV/Ozxqdh
	 PQhtezqIYdiPA==
Message-ID: <sashiko-outbox-210353@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 07/13] KEYS: trusted: TEE: Synchronize session
 lifetime
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-8-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-8-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The parent TEE device can remove the client device while live instances
> keep trusted.ko loaded.
>=20
> Guard session context state with a mutex, publish pvt_data.dev before
> registering key_type_trusted and sanitize pvt_data on probe failure and
> removal.
>=20
> When an active TEE has not been bound, reject seal, unseal and get_random
> with -ENODEV.
>=20
> Cc: stable@vger.kernel.org # v5.15+
> Fixes: 0a95ebc91305 ("KEYS: trusted: Introduce TEE based Trusted Keys")
> Reviewed-by: Sumit Garg <sumit.garg@oss.qualcomm.com>
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D7

