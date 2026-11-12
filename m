Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794483043;
	b=lmJdy/ZlEay0dJOfndwzExqtDGvMcXg/YdMdcAN8kDnXPuW3Tvj6HCHcnD/ix0lNJx/0
	 TcKVT2a0dE6S1aF4gA5kBaMQqVXnfRRYxyYqtynoJ8aq7Mn3A7VMdSxO7/nzqPH+MTj2q
	 R/XnFzytibnFaSxYCapWrFNC0dJQBHY4erQix37PDFltEMMNpBR/pqdNLQ+9ikxYg5+qM
	 r/3kxS9zfL5/tb4JXXfowQRORWPFXg5xvjEs+a5sXp38xgP9/M8M2UdbxeSQaz+5gzmCH
	 2ATPQZ5YJMKCntf264Iyw9uT/6H5pltNf7OzlGhhNegdFRZl+8ZfZSRzwCkmKtaYZ3w==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794483043;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=HqMXct5PEV6biJSL+up+Q5a/LP0cl+Qu44P49RwE4SI=;
	b=LG6S1TkRuf8cck5JOWXbAjJeni6nzfF+IsBA3OXEMHiR8muro0ABBMu6Jv7UyxaEhH+z
	 tUtdliSUY+dpPHv9gpNxjM945QHfE/ajj5cfUBZJ/sFfFe5LllJi8cYbLuKyILbYuP0pY
	 h/Tg80wxymW12PXpMQaGD4ugwU6nbJ+LvPxyo/oivGG8N6PO/ZQz9TYy6NfIudgeawfzY
	 ACJ7h6m+Iiydl0r/UgXqHvGFvPoIecUex1zdES2heBLjvfpK35HzOPZ7XztRcQCevPSdw
	 ggi9332msd2WnEGjr3Cqq88quVcJSDnO88OpfV6YggvaNkYipW80idxOijWWre3A5WQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1rEevOg;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D518C606A323
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 11:30:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=A1rEevOg
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 23BD51F00A06;
	Thu, 12 Nov 2026 11:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794483043;
	bh=HqMXct5PEV6biJSL+up+Q5a/LP0cl+Qu44P49RwE4SI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=A1rEevOg5JKxJ7L23C//RbmcPanr5CdRQSIJIMowEqwo9dkPnJ6IO/FDAFrocC5IM
	 ycmZW7y+hHdkSYx728Qt6I4XWAJnaoRYoMmb7SfplelzOozah3KLQahlvGMt3zma8f
	 AFgzFluQCDb3lo9VoMg4H0mVFp7baMbUJW3C0qBdkDmUxmK7veoK1fT5TQCdgFgukX
	 38FWT7o4kIRf+F9a6Yb8sJnkmEhHR6LSCgPW/ys47YQn05Hqo0i+7TvkqxiacpQH4p
	 wBjL7q/iECIsU3Zr9R7BcSXmb4dLr63tDblsKVicpbqM3hfPtqqbXQ+L9UhgXyBEam
	 laP9Sco+Kh5Ig==
Message-ID: <sashiko-outbox-211018@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v1 7/8] s390/kdump: Skip the crashkernel CMA DMA wait
Reply-To: sashiko-reviews@lists.linux.dev
To: "Mikhail Zaslonko" <zaslonko@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
Cc: "Ilya Leoshkevich" <iii@linux.ibm.com>, "Andrew Morton" <akpm@linux-foundation.org>, "Baoquan
 He" <baoquan.he@linux.dev>, "Mike Rapoport" <rppt@kernel.org>, "Pasha
 Tatashin" <pasha.tatashin@soleen.com>, "Pratyush Yadav" <pratyush@kernel.org>, "Dave
 Young" <ruirui.yang@linux.dev>, "Jiri Bohac" <jbohac@suse.cz>, "Jonathan
 Corbet" <corbet@lwn.net>, "Usama Arif" <usama.arif@linux.dev>, linux-s390@vger.kernel.org, kexec@lists.infradead.org, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261112112105.1169118-8-zaslonko@linux.ibm.com>
References: <20261112112105.1169118-1-zaslonko@linux.ibm.com>
 <20261112112105.1169118-8-zaslonko@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 11:30:42 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> With a crashkernel CMA reservation, __crash_kexec() waits 10 seconds
> before starting the kdump kernel, so that pending DMA into the CMA
> memory can finish.
>=20
> s390 does not need this: before it jumps to the kdump kernel,
> s390_reset_system() issues diag 308 subcode 1, which terminates all
> in-flight I/O.
>=20
> Let architectures override the timeout and set it to 0 on s390.
>=20
> Signed-off-by: Mikhail Zaslonko <zaslonko@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261112112105.1169=
118-1-zaslonko@linux.ibm.com?part=3D7

