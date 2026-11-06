Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926451;
	b=ZUmjWqyOv6c8nLMTsY+VhbdqufDDM4aNTrK19K0OQoYL/jg42GNqm0AKaRJORsiUd9oi
	 N7hCgYdSSkYYMQzcO+WcK/iHe0sQPd+nPSjn/LMMSMIHoZmtpjZR8o9yMqQ4c+4vEH8nk
	 IZOJaoN0msJyCK+xF2SQrAQ0xlTlYFjsdkOpHE23LMSX63TX52g6K17ISMB7s8qDyR9In
	 ZvYBZl7nHOvraXObPpJ958ZuTNqdLm9j+MwBk1YkkoZasI85jyQfuh9cd62XyHIzl1JNW
	 bXXitz09VmhKZw/QV5HH/s10/1DbuZpV7C0doAbSL/056ZClvmIms3hK53vv1YIUZew==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926451;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=PMEbTVTresFJt3v7kxA+XMB+c4Cigbl0qfO+3lR3EWk=;
	b=dWPxZAH1wVOsgfu60toxClo4+cBHO4U71Om5kisoI3tvEZljZ9/lwTeTz2iPwIETWT21
	 DmvMYuqSuhqT8iMrDzCE6qKi15mA8zeeuf+46JQKZqzjdnVA5BZXgjHpR5PYV33Dswz7W
	 Xey4R3ZzT13t0P6lRnHAz/CSXDzPSD+gF9KK/6PrLAMjBDKwymlzEzlav2eW0Dtyts0Xl
	 tXtT/jQeAkXAn86zLWoDBz4iMXHGlOBPXF834rVEUUscwVuTi2y3p64ZJ9kpXV3JFBfOx
	 bMMg9o74dThqa4110QQteFlFmVTiFW+TowxXw9HD/OLvxMJDpR9cnmAKv+WhtWfh+5w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvYFuQE+;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B65CC606A329;
	Fri,  6 Nov 2026 00:54:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=UvYFuQE+
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB0031F008AB;
	Fri,  6 Nov 2026 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926450;
	bh=PMEbTVTresFJt3v7kxA+XMB+c4Cigbl0qfO+3lR3EWk=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UvYFuQE+FdUTn9bUd6Wq4KlqgbHpXTzq+JaIpfrHVs20RgFrdBsaK3GN6iAf9bEdV
	 JplCEqJPfa6+PBotTQBZ4xoiEua2fdVIrf+qqb4ThBBtfnr1DmDwQ7idYdknnmlQt5
	 b2ReNEVJvjOkEnEDiOB7HbUZ2py2esB3zVKAHNrzZeuMiTyIGWC6Zs35errCUzaIuy
	 FOLgAlqwxI+QZ9qnj6onmFpDkeLYyJ23lkBzFCti8DgCmrTiwUJPhvkO9pqddgO5hK
	 D+5ps7tcQhQiDRb8FI+SMjkwrTivIs57ZreY7liSdMfariKt45PcYFYUH8x69sKwn6
	 W6ljGpqX1wiXA==
Message-ID: <sashiko-outbox-200461@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 06/11] KEYS: trusted: TEE: Disable sysfs bind
 attributes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-7-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-7-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:09 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Suppress sysfs bind and unbind attributes on trusted_key_driver so that
> userspace cannot unbind the driver and unregister key_type_trusted while
> the trusted module remains loaded.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D6

