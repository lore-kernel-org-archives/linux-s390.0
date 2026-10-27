Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111732;
	b=c4IuqPUBNDEal4kG+M5BkRi8k4+JrJvs80moqYQJ0Ys8wQIXS7CNiOcQuW9mV3XBDzo9
	 yJ2Xnloc1gKzn3Q8XPCJKrx93NJSkVrIL4l09Usf9yImUdj+L92AceCcies3qPdnn//0D
	 gxep1itvRehNhKeITugXFZoo1As45YvnQruOdahiZNf8CmidnDqXHoYtDe4TkqKk4CMVk
	 4aBZ49C0Evbzk1Vt5so5wVM7bQ/a2y0f6HgXpDzplJKvvZEWPNegviFGZo0RzqZLTdhGS
	 H+gjZ66GyPyw7SY6KSGs3QW+3VR2zrXqmHcm5Z3RH2uvCVgWkjQH5XN2isUhGEFiyeA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111732;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HqhTIwDk+3B+0jlO30vQXKV2LixJZzkgKod6E34Oyx8=;
	b=hpbpTCK7QN/ib7LX9iCijbLJsaE9sM5rIuRqlcpG3R6OxW6KB46ItLaaqdqHA2bu8vhz
	 sSt8QBIecgA7mXwy2gXP+NJtuwHvjwyFUTuMsNw/TUm2l5gN/AhjVSK83T30v9m4PvGah
	 Hc65K2EJK7Qg4uSDwjdnDqBqf/1mkdKJSug2WkPoLnuAOsUYvJPY/fdoLN/xq8bK3WoeZ
	 C5gAqNyU1sSUS7kxSpnhYF3Y2cHqeLXfbxh7xfQELuUYME8Ljf5dLe6+FWVGsrJCFx8ew
	 hXr7vjs8MiGZcK2ivCQVpbVq3rPV5/euqjC1rbMuABEPo+YJ09ABzWd2xhqKJCxRqZw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb6NcrtY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E7FDF606A31A
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:35:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Vb6NcrtY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7DE381F01828;
	Tue, 27 Oct 2026 14:35:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111731;
	bh=HqhTIwDk+3B+0jlO30vQXKV2LixJZzkgKod6E34Oyx8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Vb6NcrtY5jRVo9eKQhOKgVBHW1Zhimx7ZMP51yI1uTX0TPXdRhKnp2uFSlcrlMhMi
	 ol+czc6LJvSHsNmUW0be/4o3slPxI2eTKyvQgPNSql0J2d/F3biyHy70WnZSORqsf0
	 JW++foJ4pJBHNdXclkaUWfz/m/+luZ/HvFbmh2xYwZlqYs/sY29/6ae8v/m6XfT5+4
	 h+nY7EW8jOhf40+N9zoQb4iutPZwzNj7rbUyk/Uoflh8+K6/OV6siK4tdVJMaloica
	 Et9Z/UKImR1a9PkuNrFqpFFggMr+a0/yJb52T9OQ84dVBJ00+3fGw1fqxyfpVbGS5z
	 S7DozgunUzfiw==
Message-ID: <sashiko-outbox-186731@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 03/10] s390/bpf: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-4-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-4-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:35:31 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex in bpf_arch_text_poke(). This way s390 uses text_mutex
> like most other architectures.
>=20
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D3

