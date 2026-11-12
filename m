Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794457896;
	b=1fW1lWaU986EsM76joc9zYy96EExDRByCH0Dns1WS5/vlvp7904LE9OtyYbbHdEBC5tO
	 BOEb6S4XIy4Wwame6EEkp4f0+tS7eJMR0mmp4pb9P+P1IXcftPfii6p7EcE+BcSOyIQz0
	 PB57jPYn289cSnW+szTzN1rlX1+V8Xzn0TQACS+3dLz5PbwOdwrXdtrthOdlInJod4osb
	 HCA0qwMJW8PzucZArbOfw1avXziFS3aiVVcntlBdOGhZ83ToZPbnaIiwvp2L+5YwQo1lm
	 N18dJL7vcfQwEDxHL5aGtk3eEkGhUxP6mSVj50VOBft4/E5fPhNEkR7+Xk6brCNmKog==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794457896;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=3iifU5q/+yHoIF2uG9I2rS45IVX5vDapelCxOlTtV3Q=;
	b=zMoMFXXAUrapuzHpazy/CUTnxEu+Dl8Cls6HVwUNoKmzK9vII4OCKhdS9QiOAcGgkAoU
	 O9UD3wpJfb20KSpr4folimYD1DMFaM/iQmzUxlEx8ghsd6pU8DCRHUxdfNSKtjmyf7jqq
	 uZsWJ5IItCLwVTbOuft/YifAelKSwR4qphryjznVarrOcqBvqOzQ+kmBq54qvCpbvijvd
	 dwBecgoxBDC5FeLQX7yr0Mnt7oUxG57eDsFGMidJRnna2BsX1oHsA61MwTYxMlgjt60dd
	 9GFqR+B2hKySwoDFiHTXJ+zMjuJ8Zpu7SWDz1OayfBJBzbjfpS8o8HMkMLwrdNNF2EA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUdJoSqj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D1945606A327;
	Thu, 12 Nov 2026 04:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DUdJoSqj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5857E1F00A05;
	Thu, 12 Nov 2026 04:31:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794457896;
	bh=3iifU5q/+yHoIF2uG9I2rS45IVX5vDapelCxOlTtV3Q=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DUdJoSqj26wAdIRBP9fTYEXWrPop+nuHeguPNsucR+IKD9Y/RC3LoK3SlD2Lbx8Zn
	 CQJI/F8tMuuolGInwVgMYhXbgE5KP9bubojsDfoHH7ZH6ddRIr30PdJMfe212nwL2u
	 zELtEtEeRESF3GYsoKn5f0Vk+MVEnSSEFeGWilF6jOyA7QlWpI8h9bLTgBprITWdA+
	 Dh62TfO88WDI7AoAwpIZzvDj3uBDWu40EwJ8zP34Aq8tfgiyfmIeTwPpER7xj5JA1F
	 brTfsC5cfI/ZhCmqhArwDund1I6DHBEdG6AZuqRedffKvBnbxM4qd1uv9qDxRBp2/P
	 tVWwwtH3GY/mA==
Message-ID: <sashiko-outbox-210357@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 11/13] KEYS: Pin the backing kernel module for a key
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112040242.247168-12-jarkko@kernel.org>
References: <20261112040242.247168-1-jarkko@kernel.org>
 <20261112040242.247168-12-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:31:35 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112040242.2471=
68-1-jarkko@kernel.org?part=3D11

