Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662326;
	b=jfpM7D00mSaKdTH6cGmzawNUrs8VnrCiihzhhgFV/kSWmU4LdlFxC51Swb0vx9MyZGR1
	 nsFzVxF3A8EVtRziO6Jna5NtlkSgCWYQwC1u41LJ/+FlLxwOlSXXco+0ts+EQPWV/solE
	 jjSizNN+0vuwTSlfpt73m5jJC8M7nT848jWqwrBG5X8TLDvV8o2yTmEko+GAw4tIJYlCX
	 /RBOQbearsfeIx6IVOSuQRfwCPUTNtE1AF8YvMbinLF0DVnW3VTWFedmskhXctfKsxnir
	 FaqibAc5m0ZkQUFD5yrK1oz15/8JWwgIZSP5YG1Grl6mEb83sbLCi4Iy/W+sdTSj4kw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662326;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=ojGF5/Uin+5S9FhR30k4CI5O6nSvi2ouW9QjWyBs3r4=;
	b=px+8YvjqRXhdLNifPYd027mrVrFyJhLiMqHNKeIh+YJzjWVQQiHzHBKVcpjyUbT7wlpg
	 4dbLXy8MIgePlpMElPX3VJl+X1jqPJWT2EnbI1+708/+oEL/67EfXK6GBVNCWYnAHvE3V
	 v46aoZ5PlPVkKyKm8Wek2tmTAZWv/IOWG67Y7oYDSv40OZsbI0UV1kuWuEZe1eizhf2km
	 YSk53xDsOIlozSw/62PQFbmT3cN6IMgkmZf6aHrW3+chTMoxsN086/1tUOqs+yiycCc9e
	 1qBkFyZb5iSNivjMj+MUuikywXg09ys/4LmMhhq7/32ZMEikyvB/rDJg7Z42Mfz2u0w==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhxfF08F;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E91C2606A332;
	Sat, 14 Nov 2026 13:18:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=DhxfF08F
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E11D31F000C4;
	Sat, 14 Nov 2026 13:18:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662325;
	bh=ojGF5/Uin+5S9FhR30k4CI5O6nSvi2ouW9QjWyBs3r4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DhxfF08FxTX7aS9c+Y8FSsHkYPq8PNBEc1o5G4M/4mp8iNePLkHQfje0EDDxidga6
	 ttAEl51JexbdDbPrQmC33pH8htphKJUSlU6639vVleL1XeEVCVTRf3EjtZqmeP90wa
	 ZCaUFNLzv+TwvJ5YItFJ8CV7bwyVYgD2ddzTYHqZpeQ6hMuZnfIGn9SQI8vqkhCMNE
	 D2qZGgOo2eQ/gdPw+qsC48/5kMk1d9nd1Y9xC2K8SmOCPNhkqCd8ObepiySYoFOXN/
	 05/W16bnb2AS3ySPBbEWNOfWswcJSyD4ExC01UGwHmxNUqEQzrGBQniRZ9/bQQMSfp
	 elSWvfh/RpyLg==
Message-ID: <sashiko-outbox-214533@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 21/42] nfsd: use fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-21-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-21-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:18:44 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize the nfsd filesystem as a pseudo filesystem. This raises
> SB_I_PSEUDO and also SB_I_NOEXEC and SB_I_NODEV. It never holds
> executables or device nodes.
>=20
> Acked-by: Chuck Lever <cel@kernel.org>
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D21

