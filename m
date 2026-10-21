Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792584478;
	b=4pKc7IJKySDQ/CaNd4JQ+/pQbGJjrakpPcuXcx/BfEJUjUItek3vmP/jLJfNfG/TbSTE
	 ZWdc97sCdXALWjpaz4fDFSKu09DWayB/QkG3oy47wVxqoE1dbeMQSNxi2uqflHKNVdA+s
	 qQTgialruL1rjjC0TU+ung77dd30e+7PinqRpNWKfTzuKL0Dr1FVDt0/Y+jwaUDw5NiKZ
	 YrYfLwu8Xf6GKxLpMaNC4nqqyNIK779vhaQ/oGEKft30CxjOJeJ2ynt0vpn6AMCn9Rfvu
	 4xl/rDJLb9tFQrhBv3fxeMYah2zrqauK5NCIlABWqoA+0+e0lvfXr5q1hAlDdGiPWGg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792584478;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=VkHlu6uBnl8LdB2TyDVMcAwdFhoeJveQCF3nEqpiHuA=;
	b=qBQXgppJK3LGNvSr31J9/T4MH3LNR45pOkt/flfl1LhFDyF21G/sXSFejzV0eKab0M1v
	 4NqKQlrIhmKeHqvHMORIhIXSMMslWM+aprEHRVFsRjcXtmP6DnAZO2c6jb8M+V1v8QN2S
	 DPY05IfYfrL+FXiaRQR4XO+gkFvDksK5ACpaMUUHgaY4keZ3k9bBfuUW/Nq2WbQdlX0TN
	 cc3O9EQ288i3oG6dpPOic5AD2gAlbewDl6BZiqzgpcAOwXvdf4ls/sbmjfhGpPEaq6VF4
	 14MNA7B8K7g6G5qXzjth9iBPV8kJ46F0ar0h26OxVAjZl/aaaD6bkRh2TfjprLZvNgA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAbxyDWY;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2CBDC606A319
	for <linux-s390@vger.kernel.org>; Wed, 21 Oct 2026 12:07:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IAbxyDWY
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7CC051F000C4;
	Wed, 21 Oct 2026 12:07:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792584477;
	bh=VkHlu6uBnl8LdB2TyDVMcAwdFhoeJveQCF3nEqpiHuA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IAbxyDWYMjTTRpQr231EZluSH1N58s/WV//zcqVAYTxjbdGWyTmvc8lbmZ44e2KQl
	 kh5E+1grWqDQd9hRqPaL33sGgvGhxDPZ9Fff4p6AuqfiSfMqm29EAPRW7pqiGBY4ri
	 ZuFomJibHj+pU6HWCfzeF+beKZb3o13XpUeW16Byztgo2sUXMSIKv6VJvesZHbTbTI
	 pllDaSFcMmR9ZjrO8DjkyFCRIAGplmqa4diA1+4ud+rgRGq0Be1ORTUYnubVaJJkhj
	 bhOfM7f2DbWNhVa8ZqoIUduOAqf6CYQI3SpknW725syFe7BKDWdJVktVB1I8jsz6wv
	 YUSHMQURkqc6w==
Message-ID: <sashiko-outbox-180205@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH] s390/appldata: Fix error handling in
 appldata_generic_handler()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Gerald Schaefer" <gerald.schaefer@linux.ibm.com>, linux-s390 <linux-s390@vger.kernel.org>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261021120426.1148360-1-gerald.schaefer@linux.ibm.com>
References: <20261021120426.1148360-1-gerald.schaefer@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 21 Oct 2026 12:07:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> appldata_generic_handler() always returns 0 after starting or stopping
> monitor recording.
>=20
> So "echo {0,1} > /proc/sys/appldata/{os,mem,net_sum}" returns success even
> when DIAG 0xDC failed. A failed start would keep ops->active as 0, so
> reading the sysctl later would correctly reflect this.
>=20
> A failed stop would falsely set ops->active to 0 and decrement module
> refcount. This would allow the data gathering module to be removed, and
> the data buffer to be freed, while z/VM monitor service is still collecti=
ng
> data from that buffer.
>=20
> Fix this by returning -EIO when appldata_diag() failed, and only set
> ops->active to 0 and decrement module refcount when it succeeded on stop
> path.
>=20
> Cc: stable@vger.kernel.org
> Signed-off-by: Gerald Schaefer <gerald.schaefer@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261021120426.1148=
360-1-gerald.schaefer@linux.ibm.com?part=3D1

