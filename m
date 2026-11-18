Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1795013467;
	b=yYLXjZXwhrfCI9ymTBwhIy/qUnO7q/lnuiMHwfvYHMqdK1bgl1QE5UJzNNjftbY/KTFX
	 8fBdIm7Sb7JoDFffDx91CC5/+sw9FtG+G/IC6IpDvTnxtefGIyfI6HSqdCkxgr6HZDxXZ
	 JX4MvNHgzj6u8Kx8ThIgmrbXzbV7/pAwYXZIivp0jxy5HbTyFjp2sF3Tp3OqO72KTKWM5
	 5y+pDM4NgSBdCLr2KPpparEc2dwdPp0+ir+ngA8kAVKjLB/jEfLY/3LtHYFtEQ2CHz0wC
	 4NE6PslXBWaWsMmt5NbXUNzCH2AkFfMcJbzQ8WF3VlKzatrllaVNhsqYqMQI/CX+qCg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1795013467;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=1fmp24rW86PS9u3S+62t1mFrKhjZy/gVye9J+SqAHJ0=;
	b=cPMPfp+m/LkJgGiHIG+e51tJAmsnosfAPhhBsJE87OAKb3MYHzF897FBZQ2EqD9+pD0h
	 KKfqIof924MvJDeZuVhzPDc1zcGkdrfkQ/I9bZcee8Ks6BxdLlvovJkrb8n9+MNcBQjNV
	 +v76+jHOFdoilzORCEW3LgJ2u9sm38t9xmZv5POa1jYCjkBXIGRCHzDs4nPO9h5Otxbci
	 zj3MZ1RF/S5NHIwQPBCdzIE2DOwgK8U/9Vg6pHOugCRN4QcAeXshJSwuwCxyZkTjDpxpM
	 BYZLZBhjN2cb81q/QqezHGDCDlVgkhgRVLqskJi2wW7OwgvZpwgdTkNvr10N34X1xiw==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLv7E3Ws;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F13C5606A31C
	for <linux-s390@vger.kernel.org>; Wed, 18 Nov 2026 14:51:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=XLv7E3Ws
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 343041F000C4;
	Wed, 18 Nov 2026 14:51:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1795013466;
	bh=1fmp24rW86PS9u3S+62t1mFrKhjZy/gVye9J+SqAHJ0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=XLv7E3WsvNSCO63At9jyXbbFgs4LJ9qAuhV5vLFC72qsbHWgCj4f0fMJ42JraPeXy
	 kPVBsgL8bBB1KzsL41Nq5wzd3yeid+UoZoYKW1pkQpeoBCqOrNbR56zePGvvCd5Z/n
	 07U5xqJdWNE6flM6DWNso6CUSDAE2YOSpVrRQRZqlPlAA37rIEq5eiX1tA25y1htQl
	 V6XGUDzOira93+OXo4yOC0jaRY3N0Zt//vel66Qw9BLSLTqz0Hckf6iL9XuMwi21xH
	 ndz55W14rW2kxUkDV3BGPd5H9egb4fXAvDIrUDcSj5Hpbo/++rUWu1nHKw4DvFOwM2
	 fAKHa8EnVsXwA==
Message-ID: <sashiko-outbox-221257@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 6/8] s390/mm: Add error handling to mark_rodata_ro()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261118144709.202520-7-hca@linux.ibm.com>
References: <20261118144709.202520-1-hca@linux.ibm.com>
 <20261118144709.202520-7-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 18 Nov 2026 14:51:05 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> If __set_memory_ro() fails early in mark_rodata_ro() just panic.
> This should never happen.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261118144709.2025=
20-1-hca@linux.ibm.com?part=3D6

