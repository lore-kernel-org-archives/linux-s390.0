Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793169517;
	b=Hv9MpT68Oend/gqANqFewWdZUz0k8PAJ3kY4TirHGb9H8H1VxN4LSUKK7D9SiUM0q7wd
	 1AD44JjR75VdvOkArQwXDbO6j4uK7xKar9lnoeBnlqw8MiTp0RrYA2u1+zsfNoBx2lfcE
	 sBPAz7nbxZIPPDHDm25meBOjSt5b4nObSC3czkDshnhm8CpFC5wCBzVMCKkTQOO7yJZko
	 vH8u15vQbyBHrGAKCHyWt6gUVRaW+dJWfEizioiMOBNKDBGS0XT2fV25G5E5FTWuYU6Ka
	 2jh29nbp3PW7Iz+B1kr5U4vaYsV1wBbtXvz9BxP//1qKF4wkKDewS4gpSZ9/PASQJEw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793169517;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=FWLD5GjCqBr5xu1FmAfFVF8P5w+Tb9cNjY/RjAdSzVk=;
	b=ueQsE6T7faIaT6RAuNq3AQpWSD0EkmOxOd8c8wgXpwOFLB6jrS5/lcHZB3rIB6D2qNjT
	 o0Cye3IrxK8xIn6GYy0UYEh/CMkNgSIysYot/ZdRF3SPd0PG6TcejENwpFSSonE+t67cV
	 960GkIhU/lBEuvfySdC8zIU4RRZ/5ZKVEkRwdhm9/3/ESlNvCb7Qoz7qUPOjAHU6NjSgj
	 FFGt6rmGWhyWo5JHSWyvLj5CTdgbWFgT52ndXWw5igf3T80XU5Sv0kqepHc4fCNxBHZPN
	 k7fvvKj0TNyxVXT3n7OQtctqv9iqebidlSv+Qz6c7tMAcKgaWn8lgE62eKu8YLTx1Jw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvW+lXlt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 60881606A31A
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 06:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FvW+lXlt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B752C1F01825;
	Wed, 28 Oct 2026 06:38:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793169517;
	bh=FWLD5GjCqBr5xu1FmAfFVF8P5w+Tb9cNjY/RjAdSzVk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FvW+lXltw0D7BnDtcI0yE+Q00ffQWQQuc41BsiTQH1aPsZhFioKFiVz+ZuDL9IP13
	 CJWx3gThLjfOeuPJIUCzV2Y9QbE6oFP8ErcCwsLvH26bwsHlOmKYfCv7DldYycrQMP
	 wb9/wHKfVzRrQrVaiz3FmcyNSpZvRRnIazAUaeYAUeD31G2OyB062DAdKMHh/4RJLL
	 5RKLbCU32ci1BvQ1Vyh6uHOx2OHd/biE4WnAJY2V/LjbDxyP9qRfvJYrFbDKTP3C3W
	 plEdE62ByUJ7N4/Z1hqwO/x18WiIqLRZxSsL1oE+fZ5hzKmrxxTx5QEldIxjpt4e/i
	 DKIb2VncEYoMw==
Message-ID: <sashiko-outbox-187565@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC net-next] ppp: remove BSD-Compress support
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qingfang Deng" <qingfang.deng@linux.dev>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028063452.25812-1-qingfang.deng@linux.dev>
References: <20261028063452.25812-1-qingfang.deng@linux.dev>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 06:38:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> The BSD-Compress decoder assumes that accm is 32 bits, but declares it
> as unsigned long. On 64-bit systems, consumed code bits survive the
> left shift and corrupt the next code. An x86-64 PPP-over-PTY loopback
> test reproduces a fatal bad-code error on the first compressed packet.
>=20
> pppd normally requests Deflate in preference to BSD-Compress when both
> methods can be negotiated. If BSD-Compress is selected and encounters
> this fatal error, pppd disables compression and logs:
>=20
>   Lost compression sync: disabling compression
>=20
> The link remains up and traffic can continue uncompressed.
>=20
> The core compression routine has remained unchanged since Linux 2.1.67
> (1997), and the decompression routine since its introduction in Linux
> [ ... ]
>=20
> OpenAI Codex assisted with the commit message, cleanup, and PTY testing.
>=20
> Link: https://lore.kernel.org/netdev/20240812084312.14127-1-r.smirnov@omp=
.ru/
> Signed-off-by: Qingfang Deng <qingfang.deng@linux.dev>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028063452.2581=
2-1-qingfang.deng@linux.dev?part=3D1

