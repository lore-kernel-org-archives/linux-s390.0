Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793214010;
	b=P7dlphgeLY4rLHPJSBB4ELt5XeM+nNwbBijaWoouyUUb/2V+RNn2L5vYd4DGVKFdUB9I
	 uZGtXqIVT9KaU0iTL/FPnAV2IC6OHrtkDp8JMBp5badFDYMYKogcxuNQmvCZEu/UPhZPz
	 Ybs8Tsk6tRy9M8FhtRRn7W0S/YzrYUpMY6NQX/OyAPPF4qhIRt04MeT7QTjuKdVx8rpPP
	 nroQrYDO5Nmx7Gro/0+cvt+Yrm+u+Pz8uY4yUGQFWqTO9W6WNOtZHOVOJTK0gFIdpoeZF
	 Vgmp/L419xiEEA5Z4yBqS0bs+1ioAcYzURRmTbi+malnkioMiqSppAshzmsma+kqMmg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793214010;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=JFF4dby5OUQ7vLygvlse8RwLwYn7BlZxeADYPPPbd4Y=;
	b=W2tG0zWs8esZDw3g0ciQtIN5XQp8ss8vOLwF1UBDAI5FzMm13wzIO2sHoIFg/MDHzuWL
	 ArArT4FmmwUwf0yuqV2zPq4NXrNz1IhXb0dmFjOh0bWPtTtKX8EDlPbnBGXW5dc9CNzcn
	 lNGjWmA/AmqJJAVxr6mzgQkhPcfqnFUEB+xR2QDdp09oPNYZ1F7g0NWnEcvR0s5ulX69e
	 hJD0+IPTsiY2oxzzo1X0lHuOj6meE9nS4iY1bKRTI9cMjbSGEemnBhJWKKOl2zqFdQLw8
	 pDuLPTiwZsEQszDQb15GExEqYNHDwlyDYC2JLwqwwRKE2kbjfmsn25VsflO2HA3WXTw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omdAVg70;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA154606A335
	for <linux-s390@vger.kernel.org>; Wed, 28 Oct 2026 19:00:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=omdAVg70
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 567E81F031E0;
	Wed, 28 Oct 2026 19:00:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793214009;
	bh=JFF4dby5OUQ7vLygvlse8RwLwYn7BlZxeADYPPPbd4Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=omdAVg70BpFAuEe7YKjSdZa+bRIyd9289DNLdLNq+twaA5pdWSZPq/M6Y6joYs5bV
	 nJyodxji0imKnniW1KJMckM6RnfxpIWeQtACrIyQdNowRaqcZ4nCiotcphxodNY2cj
	 o4y9SF9hGfCLRNR5A5iFzZVqTgpNA+0B2yCX5nSNmMzBmYbIaWRzyk7UtAZ5zLMw36
	 kS+Ih7VQ7GoWaSrV4OkiSm4ZbrnGA9lJ9Nu1yYYykq/I6JZjHOnZTQBc53aFoDm8LP
	 1jnVTNtQY62ftPZbfMgxFEz4lEqsRoInDNeYsMv5KV/+d/DMUCYnMj0zUGm5M1xrmY
	 IX+A7rgwjgV1Q==
Message-ID: <sashiko-outbox-188324@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v4 3/7] KVM: s390: Fix idte_crste() clobber and table
 type
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028185422.272146-4-imbrenda@linux.ibm.com>
References: <20261028185422.272146-1-imbrenda@linux.ibm.com>
 <20261028185422.272146-4-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 28 Oct 2026 19:00:07 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Fix idte_crste() to add the missing table-type bits and the missing
> "memory" clobber.
>=20
> Fixes: 5a74e3d93417 ("KVM: s390: KVM-specific bitfields and helper functi=
ons")
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028185422.2721=
46-1-imbrenda@linux.ibm.com?part=3D3

