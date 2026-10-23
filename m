Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792772835;
	b=tazDnIddDzd+ePvU4aNjn3GBeMKdIpvMVWP0ShTYQELbKA+JRl/x701cCQmw5CDN+fIL
	 yzTV/f+ntNgs31aBfIq2n3BK+2cSegXsQzp5cl+FLHHbT7SspTUzKLcLB7LAiJy65E8rC
	 VOitI2e4+LlSWWSxhpO+L1nTraspBeFSMYLLat2shCGTLr4HmJv/PZMOQpZipp4rVv5/G
	 8P2MNZDdaKOmOM5b3BdPpMl6yOvrN2035gEOpa820ut7AJUIv4kgbyLsiAd9/O9XDdntr
	 Gua7SUGz5jhA6YXGAT0NGZIt8ZKgoydDy1NLpvUf0NXvzB4olQOJLYn1g+eWeehnAKg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792772835;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=B/js+yNXB39nNQhSrv+s+nnk17+Y+KtuQcEREXPqycY=;
	b=VSPezYKCOqZEzHbIdgxfp9w+PBPWXu0PyCkf3qNnQt6eFO6Z+Y7v54GdXcWTJxtt8JEK
	 +KdV53MLAtA9QyDmkWJ5KbA6zH06OeKq4P/43hfPRR/tvN5TpcrD2QgrJxL3Ft2Gthosz
	 KsLPVyraSk8OYosmzMM0o7nfI2CVUH4lCbREEuUpkQGDARLBFUVSX+OnqFtHisk2aY0+u
	 sSj4Qz2qeB5OVof+Rw1hNDiLnCNSlSZ6Vy2ehyq6voY7YaHrp4gAvC8pJo1eSMQEbsJwH
	 wLZuhUINg8MdrAhvIw+Kk/RvY+8aSgr43NewWpK7XFRD0XxiU4NE43UyxUZ+Kp+f4OQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5OU0JS4;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99DFD606A31B
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 16:27:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=l5OU0JS4
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20D041F01825;
	Fri, 23 Oct 2026 16:27:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792772834;
	bh=B/js+yNXB39nNQhSrv+s+nnk17+Y+KtuQcEREXPqycY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=l5OU0JS4tsHqbXeznX8ZTAEIES4+nkPVO1vFrie6MkiExfHpoJQtll9mnVzy4R2sE
	 83+xfS6FAKxxCiusv0M7Einnm7yk7iO2sAOFX9nUyp8mk3QLBJzKEHzis6DKsFD27W
	 xmQ5eJP8+mpyZAC0AB7YzHbZTxlOA/pfp0wV0MFOPdCKwH6fwLL9AXOQ8W15FFOGEV
	 np2rYVW04dauKmQzuB8f/3jR6dxPExA/ROCp72h4L+6/Rfun6EOwblBZV2klY6uvOv
	 LvyuKYsvf+4Evg7WPcn8UPXmewnHPMAVqxSEuRymKg/7oceT1rUIUbHyEICJI78/jx
	 OEWgUHSx5YqIQ==
Message-ID: <sashiko-outbox-182947@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 05/10] KVM: s390: Replace ASCE usage with a struct
 with more flags
Reply-To: sashiko-reviews@lists.linux.dev
To: "Claudio Imbrenda" <imbrenda@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023155531.206113-6-imbrenda@linux.ibm.com>
References: <20261023155531.206113-1-imbrenda@linux.ibm.com>
 <20261023155531.206113-6-imbrenda@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 16:27:13 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Replace usage of simple ASCEs with a struct that contains the ASCE, a
> pointer to the table, and some flags.
>=20
> This way, there will be no need to manually pass the various flags in
> addition to the ASCE where needed. Walking the DAT tables will also not
> need to first convert the physical address to virtual.
>=20
> Signed-off-by: Claudio Imbrenda <imbrenda@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023155531.2061=
13-1-imbrenda@linux.ibm.com?part=3D5

