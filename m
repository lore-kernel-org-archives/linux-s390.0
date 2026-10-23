Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792778223;
	b=uY/a6Nm0HKEvP7EtOctHhqkbac0mgCRaWXty5M4s0zLnchL1lE4/OIXl1FT83FaiSq2h
	 fKFz58qojccquVT9ndLxuEqS29niJyE/62moMpAvEitfPSnVfs2NmZXGP+RjgPVPYA2JM
	 NNAcOwzmfasEn+Gwulhov03wFSqDlp5OBmw0Kl1gNGdULwG61zJqW0Roquq6YqSW3S2xb
	 cDyZNFNZqGrFfVz5epZ6a/0HZmNpdE+SvQi2DtYi0n3kLZnszh70xk/O4ZbI7I81WaqHg
	 cB+USunBJQMqvZr8OzGXfjTEbJyfB6yeM7x2x2PW2p0ekPcqtJr4bXCizmoTRoJvTlA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792778223;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=5IRst4UqWKmr+jAo7JWQkdSaq/HA8YQQMT3sMq4Cs0k=;
	b=UcgopL8/FBLIfYrWbSNDzrFT4zPi+RP6BR/VA/pOa0TCsfnx3/4+Wz6Zt3eVc8FihyDp
	 FUAt4AyrjkhN/4DO3iOHoo/o+b4THCyPdC6VF2m+nTQoTq8vLPkXcwaEvY2iyxqwBsBwF
	 73gPTi1821C6/tolbs6g4U1Ym58fXSoyMz6EEaJelSiQS//dD/4kr5onJhDxPLEVfS/5T
	 j9tqKi2b0qIV35aymv0NCaek2kp8cE4D2Q/2a7q9Bt58Xu5q6WzxQ0HJ1RdHpapYgcFT3
	 z3f18hfXumtqbuB1aitHBAX8iVufV3EoFk9rQcJ/NRzhurMQwMtAF5yjVbWpaLre3Hw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yv2I+pWj;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B181560A5BCA
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 17:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Yv2I+pWj
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F09ED1F01828;
	Fri, 23 Oct 2026 17:57:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792778222;
	bh=5IRst4UqWKmr+jAo7JWQkdSaq/HA8YQQMT3sMq4Cs0k=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Yv2I+pWjCu24THAO3ktuqzVsdKWXP6JyZEJZt6u8O5NLGifSK5/eoKTiK9lyjZdq2
	 2G/506eSFqLTBVOKwNq+xZkm+KgtBOfdIwbs1jdzKTU5RwWRyqFTYIzZjKtjvcgrjm
	 6TBpilDouEqYHQCk5IZzUxRSy7eO+jtM9dWlh9LdCkNbMSbuVimazWfIGLenAjDCgu
	 tI2iEJFNqOmK03i9jtEaEnmb18jTcfhyWtOe4Wf5XGuqw9vs6rKlUOuHOirERnx+XM
	 6YaVUs7pS6YFYvKJuZk1eEYH7pz+lxMkE7h7kAVQPAZNGh/h6wkOExLYyOuLzQwZPn
	 zuGHIVWXbEbuw==
Message-ID: <sashiko-outbox-183024@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v10 02/15] s390/vfio-ap: Data structures for
 facilitating vfio device migration
Reply-To: sashiko-reviews@lists.linux.dev
To: "Anthony Krowiak" <akrowiak@linux.ibm.com>, linux-s390@vger.kernel.org
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023174349.3545941-3-akrowiak@linux.ibm.com>
References: <20261023174349.3545941-1-akrowiak@linux.ibm.com>
 <20261023174349.3545941-3-akrowiak@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 17:57:01 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Creates the data structures used to facilitate state transitions during
> vfio device migration.
>=20
> Signed-off-by: Anthony Krowiak <akrowiak@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023174349.3545=
941-1-akrowiak@linux.ibm.com?part=3D2

