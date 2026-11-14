Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794662506;
	b=DuLveA+yTm2UTkYQilLK7bEYR8xtzmoapLGbzxh2EOxefSqqf6mZ2eFBom5Ec1IsrXIH
	 p5WR5x5g+ylax+l928m/iPLgnvy2SZAx1+amWNJRnedC6uc0hNJrQyOd50BTeTjuCMlQ3
	 gYkXC0AohQX/Tj0tLt4pii+dxKLKKelJ5uEpwktsZefv212LgWCL9AhMjbnvdCgF2ICqW
	 zSysXrqImaCY72FxJkOwKTGnnJ5Zvsb+MgcHSmQgcwTrAdar4CItg+prW1Vs/OKD+rk59
	 Menog+tc7ZebHElZ4Fs9pxgAJprWwQBrp3CERl4FZbuQPE8hPifAMbJxy8vqow6HKnA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794662506;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=D/4fYM+KM604RTygECHqhdqnMZxxa5GhB1pB0GHi8c4=;
	b=f85iPaavAjMo5nIofMHWbaoAMYjBm4KwKJaUZUPDgJUUlv/NchyUButN9rKRxuITHgBw
	 am1nQdlG695etUCu47B2E3L5NDVE2SoShYIsyNWjQyHSCLZVZO/vKgpnMHrWkr/Flv+1w
	 Ohu+UnCw5EMGA2b/LS+4q2a674sjstyKlMo5XJkUOT84XtazlvyRXBrIF8dR54MrV5A/5
	 blKI4qvtfJ4W2XOuZ1mStUo5w9JRuJ6EYSPXrA5aCX2LsMJsSzPj3Ku4TAKy8teli8il5
	 DywRaDgTchj9Hm/ISLlkSBXFeOtMn+4vjBy86g/8PdYpBzcYf7SEKys4kT4KgjbWRsA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo5ZQIXa;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68DF606A335;
	Sat, 14 Nov 2026 13:21:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=Uo5ZQIXa
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A3DA01F000C4;
	Sat, 14 Nov 2026 13:21:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794662506;
	bh=D/4fYM+KM604RTygECHqhdqnMZxxa5GhB1pB0GHi8c4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Uo5ZQIXaz9Okx6SeGDcGdjw2dI9j58pSQjudwe46m+l2Ps3RAwk7vxGLZWmueQjFI
	 LyPyc74TFQqe6ants4ymj8sneMBFV2Dz3W0QbbkCxK2eMTK2bP9OGIzKm+12uvCvbY
	 f5L5efh1zGLY7tpWzaK/PTHI+JHDn1o+LWbRcwZPEPXmgtXjUTucc2mZSiHPRHAdqp
	 9jG6iClpF5KS4/bZkbyM9KtE8vfWHEDPXm2XrnBKVfJfKVeMRqxMYdfXjxoxLh8YCd
	 a3gHWO5VMaYJjqXbmWtBuZxYTC3i9Z+uw+9rxQTJWh/zE4AkhkUe3OwwuGqEHaYdea
	 ul1zehNpxdTbA==
Message-ID: <sashiko-outbox-214556@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC v2 32/42] usb: gadget: gadgetfs: use
 fc_init_pseudo()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Christian Brauner" <brauner@kernel.org>
Cc: linux-security-module@vger.kernel.org, selinux@vger.kernel.org, linux-s390@vger.kernel.org, linux-usb@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>, "Mark
 Fasheh" <mark@fasheh.com>, "Joel Becker" <jlbec@evilplan.org>, "Joseph Qi" <joseph.qi@linux.alibaba.com>
In-Reply-To: <20261114-work-loop-pseudo-v2-32-98639a2286fb@kernel.org>
References: <20261114-work-loop-pseudo-v2-0-98639a2286fb@kernel.org>
 <20261114-work-loop-pseudo-v2-32-98639a2286fb@kernel.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sat, 14 Nov 2026 13:21:45 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Initialize gadgetfs as a pseudo filesystem. This raises SB_I_PSEUDO and
> also SB_I_NOEXEC and SB_I_NODEV. gadgetfs never holds executables or
> device nodes.
>=20
> Signed-off-by: Christian Brauner (Amutable) <brauner@kernel.org>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-work-loop-=
pseudo-v2-0-98639a2286fb@kernel.org?part=3D32

