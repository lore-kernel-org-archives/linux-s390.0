Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851857;
	b=UDB9PLzok+OoSy6v1epgMJtS/8pZZSJP3VE4lN+Q8YJFzc7e+3pG+IfTkr/VtZbKpNFa
	 aEFLWswsgj45ObZPj6RGR9GdDpW4IyYIWjRrYrGQTuZFBDHG8vssTyNecPeTgvgNIMr9Y
	 +uh7erf3vJDC6d0oUPAJmK4G9SvIeohdf3MLMS0E4Ijo01+94pCV4VdBY91TY6X5+HEtI
	 IKqvwMdtcWNWJuNBVEBwJz8US3rtJR82s/teU89NQ31eF4/aC3Bg0sn2vFnVB+0bYlXIC
	 ebWH7q4PIXJvrQSwAMBbf8o0IWbUvitrZ7X6eTk5NzJGlG+Cx2IqGZXPAgtrY1BhhtA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851857;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=XAGpPxBFX9iRyjA5B4vBb4iWQ72se81dK2FK0VGXv9I=;
	b=xGn6K8mfYyMgsChE9S9jaIdi83Eh5vTocSoSJkdmVE9eDhmF4k2cTfMkc57WR7CyOpnN
	 x5oGrcKwlaoIpKVMCJdSumorDOLKRt+wvMzZYpc/xax19yfpp4NXuPm+qKG4TNE/9TgCo
	 dZh+MXlTkUKi0N4od6Ish1+9bStyc9xGZKR3sg9/XsX+v7NCbAlbsLoxVhFUg2sP9TA0/
	 qP5vkXKP0h60BbcjPkS4/Fw2ZrT0134ZIF3jRfnFzftN11BQiDVbt1LnD0vhHlnOo71Gb
	 FRDK5Zmdo3opebWQXtkVzj4GlcwCODC3/aDhXfTgkvB787cwGPVXgsYf0+z5diuzZng==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1uwiL65;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3F03A606A339
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:57:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=f1uwiL65
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8D2951F000C4;
	Mon, 16 Nov 2026 17:57:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851856;
	bh=XAGpPxBFX9iRyjA5B4vBb4iWQ72se81dK2FK0VGXv9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=f1uwiL656/Yb/apE+yPFuwZIr0iXacflinYE15YP7qX+sCA0bsZxPNO2qAhpHJwvc
	 h+brNVn2Tly8tVycspKua5Gob1fnIg1OuUcbUwcj6A8wbuuJr8hI7+Lvu8h0znCtkp
	 Hrz+CXqdF0gdczr1JKRrgKfBrFyDi/CDltzq7EzZg5ifOZP4klqDdEr9CR+9OUFYs0
	 WCD/feeMnGzjB9TxGxLlsieHOsaKcmNFhgi6orZmLCMv53g3IqsVvpjxKfqMP6rnI3
	 fKXSgRhfINbc+LdbVxJFl5P32k9uqwmpmlhTRIYSAZIIa4kHsZ6Mx4asC6glyX/Y0L
	 q4nojEaZb8idA==
Message-ID: <sashiko-outbox-217468@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 01/15] s390/cert_store: Hold keyring->sem while reading
 the keyring
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-2-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:57:36 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Jarkko Sakkinen <jarkko@kernel.org>
>=20
> invalidate_keyring_keys() does not hold keyring->sem while calling
> keyring_read(), which is contrary to what keyring assumes from its caller=
s,
> and can lead to recurring bugs.
>=20
> KEY_FLAG_KEEP alone does not protect from e.g. the following call path:
>=20
> 1. keyctl_keyring_move()
> 2. key_move()
> 3. __key_unlink()
>=20
> Address the issue by guarding the critical section.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D1

