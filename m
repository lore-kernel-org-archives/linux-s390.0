Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793926449;
	b=kYL+XmbFmfgOQqde9Uns/lVMPajckBkCXAs2Sbb0kMoVkGMyPtmdsVqSAfcPP45kAJvH
	 tnDaNpHj/cXjM3Exf2c+zE7SvHnHopVV3R+Si83LYOnKWZpVw93JR8w5Qu7/kgiu+fX7H
	 wrcpxqaPjZ3DoUJZhI3EQUQtXktsMXJGZGexSM9Qg3Wwi8zHzVdh9AXnv896GNCqdfZEE
	 cBXQum8M8gMXwb4otDhF7QXJ3emxG5F9OfCjIPX+sh71RilBexxm1j5GEF3zVB7zPik7Y
	 6Y3mY4IXcTwDW6yrplq/WlRFD7owIisCloJzY1w60Qy4U+HsUNVvFX1EEn0/rXrekRA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793926449;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=OebrSLQ65etwomxUDseEIJVL9D9Oxa+/lHk1B03ekB4=;
	b=m6C66qmEXGIdbcp+HVKLpPSAcCVn6xqAEF9914Qm1PACtpWL9lbnLZffN2ytqUxlQBQG
	 urMEVLVzcVqydP/2+Z9G4ZwVVTJA6SPomiPmU7x/2GtLGi9hpy5fmDSsmnn9x90AcqFuT
	 AkxnxhniQF4V1Q4f0YY327EoZfCM/RnHKceUBlXBs32kGpW4IxpXG5w/EQPWjmAhTKcaA
	 1BB5n+nf3Ud1Cft7olM246GBZ7l0BbIHdOE0nXgAKsyb0UlATr+KcVyX6u/MB83Iis+C0
	 r1o7gNqTewgSfK2BTtDcElk4rCSzwS0wblpEvzufUG+v1XxXQUY8mlxWBh2p11roTNw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsqMM4RF;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 976D1606A326;
	Fri,  6 Nov 2026 00:54:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=YsqMM4RF
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2354B1F008A4;
	Fri,  6 Nov 2026 00:54:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793926449;
	bh=OebrSLQ65etwomxUDseEIJVL9D9Oxa+/lHk1B03ekB4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=YsqMM4RFCixLf7PQIvgSzfo/FALSaU6cAfxgyO+0D286DVIi6EV2Jtzv2RFlG8aJs
	 LA+0YYZRtPr4LA+PLfQ4edzbi39MteXJIGecigmQNjbjWlnnjBWpcLcwuZ7+5ojcM1
	 g8Bd4Lhbm4TV1HUK3xh9F5V0F0VjXVsi0G1/qmvRxQ6jUuOkkcHuTeAMs3qTNMos26
	 +xkZERNI0Dx9RPuIiLsZV/NnrSnYtEavpuFiswpU7LR5OBiBj4lm+7KnVnYYbxYkxU
	 onY9H9hU0JNf+H1ye37VBz/4G3v9pjBqCm34s2+H/U1wqQwCRd9K8DdH8z4Bp3BzzN
	 oBt0u5tZtcLzQ==
Message-ID: <sashiko-outbox-200460@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [RFC PATCH v3 05/11] s390/cert_store: Start tracking subsystem
 keys
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jarkko Sakkinen" <jarkko@kernel.org>
Cc: linux-s390@vger.kernel.org, linux-security-module@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261105005311.804098-6-jarkko@kernel.org>
References: <20261105005311.804098-1-jarkko@kernel.org>
 <20261105005311.804098-6-jarkko@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 06 Nov 2026 00:54:08 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> cert_store refreshes its keyring by unregistering and then registering
> again key_type_cert_store_key. Once keys pin to the kernel module of their
> key type, this is no longer necessary.
>=20
> Register key_type_cert_store_key once during init before creating sysfs
> attributes, and track subsystem-created keys explicitly so that the refre=
sh
> operationunlinks and invalidates previous entries directly.
>=20
> Signed-off-by: Jarkko Sakkinen <jarkko@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261105005311.8040=
98-1-jarkko@kernel.org?part=3D5

