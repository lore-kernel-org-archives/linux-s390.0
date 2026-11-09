Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794263313;
	b=tPeHnMRLPMcu5A5tHsNdD6OB/TMtNnz9pmY4l4jOnY9wj1ve4bQJgA8vJwTljZiJVIdn
	 iGZkQozytX1tHQ5jzkhgQ7fKv+LV5mpBRFwDKOyOjsky44NkMqHy7DESi2WZcIVbygI4O
	 X9lsAUVNqfV7gOcE0x14zLjcgkL3IGRyr/A+9VPj+alWjfYBjnlqxGC2JYO+DWMX+kJHO
	 ArnRWUNPtXhNE2DBlQ2gEtmcEsIlBBiqyQ0gkrMezhjkLKFJ+qQkUokzOiZTWvwmze/we
	 JOjPaSTh2tzVNTDvV4R13efopPjpWDpEoR46KktgFx1t1Rref43VX8hxmZOOkBisSkw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794263313;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ISCYEiC9B8DO/rQN9QHSJk4ySk+GSwr3H0fIaTsL0eU=;
	b=fQRWT3BY2eDc6GM1jGktGAcPmuQ0e/4jQ8IzznUVIz3CTK1FrPtycNQC4bYAQM5AFYXn
	 wLiRuU2AmqT5H5QnC7Y9k7ts2BiYE72bBINrHC2OWKtL5Ptw2k9kLyUUUXErdTm5zoLAw
	 4VOS9oJIkWwwCTOPgyx4hie/XHscz41VK2mpRiyV9wpGOliBdBM5eODJUMEsDD5MrjFzw
	 P38OWuq7TC5goPZlq3lnLzHyzQx+a2jwaQdrhhkzeBpba4Y8ypXfn+kgEOGYHXB7uQ35Y
	 mcw6t7L1Mxs6Ul41y0LPzIZKa8SmybgVf/v3UjdIPtxdYXqjU4r4GAMJnfJAZ5CjG/w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNSphNH3;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 83BEB606A331;
	Mon,  9 Nov 2026 22:28:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=FNSphNH3
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B62DD1F008A4;
	Mon,  9 Nov 2026 22:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794263313;
	bh=ISCYEiC9B8DO/rQN9QHSJk4ySk+GSwr3H0fIaTsL0eU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=FNSphNH3weyI4HVeNpdkxYmAYJkUoJ0pz38VjCtTjEwsPUUXOY1SQiewnRqFr4yE4
	 ziWiLxjFlRTFMTSOhusOHEYZtuNCC1oQ+FY+kgvgLlUacJC8MnUQM+IsLKsBYrtHBI
	 Xb1n9D7n8doEWnc5LZSRzJ8PKeyapDCFm7892DzmsQZPq4wW4XQWAa3s4PSWK7Zh6H
	 vY1ceFnz8Vd6DnxZbQGFx9Xr+k787zd16P4FkIwre2DdMzTSkZcbiRQVsoZadA+dfO
	 J5YTFSKilF5eVjPUyRD6USjrNzFw4sz0t67zPU/v25WccvGnPw0nT5fYgxi6oTtUEt
	 Z5+L+ivWPy3cg==
Message-ID: <sashiko-outbox-205736@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 10/12] KEYS: Pin the backing kernel module for a key
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261108222719.304712-11-jarkko@kernel.org>
References: <20261108222719.304712-1-jarkko@kernel.org>
 <20261108222719.304712-11-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 09 Nov 2026 22:28:32 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Add the owner field (populated with THIS_MODULE) to struct key_type.
>=20
> Pin the module in key_alloc() and keyring_restrict(), and release it in
> key_gc_unused_keys() and keyring_destroy(), which are wires to the keys
> and restrictions.
>=20
> Reject module owners still in MODULE_STATE_COMING so that the failed
> module_init() paths cannot leave behind referenced keys.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261108222719.3047=
12-1-jarkko@kernel.org?part=3D10

