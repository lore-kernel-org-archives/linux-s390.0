Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794143777;
	b=kBpXy3W6FYtpEiFuEcmVWIojEOm6UXslGHr70GFcbC5/7tB43YNFYWMPJM91UolDuLXB
	 6OyPNfOkyyyMFRzVRzAwY9YxxGCmG/0OYGLOTUXwDNEHeAR4UTi9wxBSb7RWYwREjw+E0
	 hwJeDoX8L878wF/DoiTPzQCjc3IOen3gVy8z7uLwQVcq1CkNT4/wVqiEkc4ewT9Lys/8e
	 EYz1gpsD8Lk1gHDMj3rImgRTO+PTzKVIf/70wvApD21AmJyBk1hEhCj/96CKPTXD582LR
	 55t0r27ZY2j+0i3qM3rL0F5C5ciAF/7ztgydX516APB5PPefcja6xX4GqQKa7OI1zag==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794143777;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=c7fmsKxBEu9XSdetq44EUfIGsTDFd9S52O1w5xWtMjE=;
	b=dCpZvBtGjrxhnWvkz7Lx+42doo69oeLiwD6PzHTlkB4WshH7LwSEMi5AM72auml6ze2J
	 IfUFCKWbW+hXDCe9mOea6+X3U4zsYZXUfbU0xQAliEkxdUXcrRWdh4labhu0+9ee1Om6i
	 sSeltTAAM5BdSnK9EfqyV6vVDWSjxz4rn+7eWeKl2hExyn8VXBb1pZV6QIhjPnp/9F14F
	 I2ThvRIuTpUK2Bu+0DDAFUPWMkAN/5JSnxgXl46T+Sf7lUo2bD+SCHx1OtX1/pgml/R5/
	 VFCU1BcwqkdcDJk7F/RfVt5428K4MQ0JW9y81g/+qsYkqdmUIZDMnDjPQGwoGPBgDSQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqI1p+M6;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B529606A330;
	Sun,  8 Nov 2026 13:16:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=EqI1p+M6
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD4801F0089F;
	Sun,  8 Nov 2026 13:16:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794143777;
	bh=c7fmsKxBEu9XSdetq44EUfIGsTDFd9S52O1w5xWtMjE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EqI1p+M6SNeTdO5Q+O6BbYUzHc3PUP0YdiWcUWiRYg2n8TUVjgEH0qq3+ziLCipyh
	 01qSof6GOD7QjawnDm2oPefQjjI8Zkb9jqel5O3k+N1vB19ANX+GbfxaT2AxNRe/1W
	 TWvWcCcLuZKZlE8XfoSiCSB1YrtRPWp1p57dv0kLBGnmZo9aoFBfuaD6IKPrqaPTFy
	 2uXxhTidoLdXb+uAE/IKAn1/q99Zcu+ashVZwbBzKzCcrrJeylWAfAVdjeYmS4sad3
	 jHsBtqSa79fJ6PYCIezJwi+eJaBXLL21C9hMRvQ206EqK7g6WdHRv690HtI4uibE+8
	 p/GiioXi+/P/g==
Message-ID: <sashiko-outbox-203762@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 03/11] NFSv4: Clear idmap keyring cache when the last
 client unloads
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261107131512.3603168-4-jarkko@kernel.org>
References: <20261107131512.3603168-1-jarkko@kernel.org>
 <20261107131512.3603168-4-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 08 Nov 2026 13:16:16 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> id_resolver_cache->thread_keyring caches id_resolver_legacy keys up until
> nfs_idmap_quit() tears down the keyring.
>=20
> Once keys pin to the kernel module of their key type, the cached keys
> prevent module_exit() from ever happening.
>=20
> Track the active idmap instances under a mutex and clear the idmap cache
> keyring once the last client has been destroyed.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261107131512.3603=
168-1-jarkko@kernel.org?part=3D3

