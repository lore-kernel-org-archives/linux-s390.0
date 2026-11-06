Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793980274;
	b=BKRwi/ng5AWeo7KM0F32aHZXaKzD+XgXIYW1b8EmmwfzCzq9Ux5MmiM3xUWemOViSAsP
	 qPpE2BXEa21qRmKU9KLyIIr8Ew3pAxtKWfAn6EmKxMjlESV4jLKOIhUgLPbEpcKUQVxkT
	 9pHES3YUlcwTyAQt9y3CFMbge/lfJDA9wUedKxrI7pZF4N0o6NVjlGBrvjlBVI6j3t2xY
	 RZ6wdsOHl5ugsKRxJhHUDARJRTsdF+ojJ8x0aARQNkwoI6y4ANUV/92GboAGeYCa4ox7w
	 bRZ433A0r3l4rByiZar2hJmLCWGiZs49+4WnrmWs8sX350dp227FKYfYqjgTB3rS5Dw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793980274;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=bSZWYp0UihqgN9a4jfrpdKUc5oX3RPbf4Am9U1bGvf0=;
	b=ygGl/3wJMjDDL8HsAwaaQF/a24A3a5alhL+xXAAkbcW4z2FzvHWcqZiT5NXUmU4UYpSc
	 ZS3fM2yuE9FUFvNnOMutrB82IeMou+y7nx2bHHeza7dtKCBCgkWd3LikeSnNvSBntffW9
	 qV9w4X0F8lOwWajvTNilzLoBlYA7e8fKnArjNiv9F/xkdlL/galp36dq21x84gc91h8t8
	 NQA8DTVxY34Mz7lJJqm2tHrGkvPUz0VoDQ4Ou9pV3ORcbj2DsJ9bqqRQu5pfHMQIwWLFV
	 vYXKmdZLFrWzH7yvqkuqQ/8G+oH1H1QWocqNYezcWzJ4Xkp7VDUpyRkxm7RyBs+D8Mw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSw5Aa1q;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 17FAA606A338
	for <linux-s390@vger.kernel.org>; Fri,  6 Nov 2026 15:51:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lSw5Aa1q
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4B7E31F0089F;
	Fri,  6 Nov 2026 15:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793980273;
	bh=bSZWYp0UihqgN9a4jfrpdKUc5oX3RPbf4Am9U1bGvf0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lSw5Aa1q4mLi6tL5ndFzHiObz7yFWQWcSkj3bCWb3zYUA/4tD9tYouQ7jt38yMh3e
	 8XYKLQ874FtNo4EUpvz1CSlDi/t0gt4p9suUSKcVdNofx88VsfrSVVxd5irhzh2ZZf
	 9fXGWEqGPwW4guebdLKuNRGDn3683s/5MDnrseh7v6wT6mLWFX37ysj6gNqXKiS7Tu
	 Iy6WYrJPOeojL0FtxfPFxbviTkle/OrzdMJ3KriW0DtzwcdJ85KTPD3wUBDkPwln8A
	 AriXKR6qsyoQ17gotWfzMmc60n3pAJ+Hhxg7Kt/WAiAWbFSFBPdKyMvVdrk8ueJWzB
	 pXtZ7Xsc/WTSw==
Message-ID: <sashiko-outbox-201737@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v12 10/14] s390/vfio-ap: Transition device migration
 state to from/to STOP
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261106152259.1360651-11-akrowiak@linux.ibm.com>
References: <20261106152259.1360651-1-akrowiak@linux.ibm.com>
 <20261106152259.1360651-11-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 15:51:12 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> VFIO_DEVICE_STATE_RESUMING to VFIO_DEVICE_STATE_STOP
> VFIO_DEVICE_STATE_STOP_COPY to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Terminates the data transfer session of the vfio-ap device state
> between the source and target hosts. Release the migration file
> state (ap_config buffers and file pointers) so that a subsequent
> migration captures a fresh AP configuration rather than serving
> stale data. Since the vfio-ap device does not virtualize a DMA
> device, there is no internal device state to incorporate into the
> vfio-ap device on the target, so return NULL since no file stream
> is needed in the STOP state.
>=20
> VFIO_DEVICE_STATE_STOP to VFIO_DEVICE_STATE_RUNNING
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has been cancelled. Release the migration file state so
> that a subsequent migration captures a fresh AP configuration
> rather than serving stale data.
>=20
> VFIO_DEVICE_STATE_RUNNING to VFIO_DEVICE_STATE_STOP
> ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> Migration has not yet been initiated. No migration file state
> exists to release, so just return NULL.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261106152259.1360=
651-1-akrowiak@linux.ibm.com?part=3D10

