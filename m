Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793279023;
	b=Eju5xLvNEFTVJZ4V+ZhjEDyAtVvlJ1mCQIGxxTTnyLFFmrvyfbUQ/39gGP9hpnctzdGx
	 xm7Vr1ig4nk8nk3WV7zzquP0IBtfHOYKmLfsB5ZpTmPHqSGPA6CtBUT1LZ5JQMRpR/eL4
	 ZFqWWZMk8kDKXXrVWC/oHF4fXfRsqb0eu0PsILvRIZPex3ccMoyz6E+hsWS4A2gXitqDU
	 AHEtqYemKKmCjDMMvCm8MwxPz0qsa3ZRuoVtunAfSCV+CG/HRmzhzX5CKuZeKxlyzycPr
	 8pMRuVuJfNIR00bIoZyibrGjw8+l9mTyIl+mIe+6srUfHKkm4FwofAwdNeJ8s4u2FXQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793279023;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=dhhbAbMct7RQ25EZ86nEXg8g/D/7yTGdkUFel3srOk8=;
	b=zNrZaPlU9zhCXRB132hJ1+iA0AbXf+wiUXMUV1UlaWzpeYAQ95heSBjo0JEqLIFO1nq0
	 zgGCH9NdI6l2JKjSUFLH5+82qMHqaYAlgamtde5AtyJWOnCxhNAYeetP1ewu9y0z5DmiI
	 uKIkBfOztwJ0rWUwOy42XrVLfOQ7b2zzZIgjG+pP53HKjBHhDFVJhjkhO1eP/gAESmOR1
	 Sh6ceq5AniuJo8axbpXY052/8asdPW7AzDGoey7h8qlcQW8E9zriHz9kWWtijtFmeKhrM
	 H6+r5qLP8h4hV3EuDJDPTsEZDUqgB4/o2jruQw1aCityG0LXRczdI2s4gPH3fimk6rA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHm5RtRP;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C48606A31A
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 13:03:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=MHm5RtRP
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84DF21F01825;
	Thu, 29 Oct 2026 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793279022;
	bh=dhhbAbMct7RQ25EZ86nEXg8g/D/7yTGdkUFel3srOk8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MHm5RtRPNRrU5mbxWh9uFVGCg+ufu/9iyOCuCesyPnaP502xipzuT1YGdz77G4u++
	 JzeeAli+4UOsZxhsJGl0hEceEiIa0Onl8YL86GIgYwikkwjwglvo3E6fG70isnJZVS
	 Z19SZGD25gdYKmq8IFPWaLWDWny4RooGDU/i5P/W410NiUroOavIhLFNe+n7hVBksT
	 IXm683w8emXKRlXm8fa3/Y6mM52051S2+K6jZsO1AARKkB/6whLHYg/mQl6N+D4dUE
	 lQlvV4GD8WZQ2RveILZMzrD3Lde/dugcZkk0yV9eK+vRnmqyxQtq0q01XxUU0YraO0
	 BkAGADobXF7KA==
Message-ID: <sashiko-outbox-189345@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 2/7] KVM: s390: Move some skey functions to headers
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261029130044.125032-3-imbrenda@linux.ibm.com>
References: <20261029130044.125032-1-imbrenda@linux.ibm.com>
 <20261029130044.125032-3-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 13:03:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Move some storage key handling functions to headers, since they will be
> needed from outside, and they are small, so inlining is acceptable.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261029130044.1250=
32-1-imbrenda@linux.ibm.com?part=3D2

