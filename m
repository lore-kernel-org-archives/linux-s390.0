Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793111759;
	b=ALsKPRKRW6NdLKwRwpKQ1DxWtZdtAZIUidWQ62Jcj5LsXhn1ZCIIfdXPYmDpFnZIqsGa
	 6v7dJE0NWrYp5zgqSus9SCLMhV0hdHYO9vJnUCKPN/seS2BSBgqfSPSwy2XJQCWII+vQD
	 OS+yXPIEMS1avCSGLjkwsiCjY9SbifFNrrEohGDtegDURW9rb2CS+SmBWGbP49hsv+sHU
	 Cfh/ImF8JxZ1XrBq9ff7o3cOVztHVoD/1KULN0s8g3NcfpsPLzqVpxyJ1qOAt74NzHvvC
	 R4l2+Dqx9/8Oj0IZZHKuQXv9X0viBZe/5QLmJDeXwqyCxwgpNHrWKf+IAEfB8FqKTmw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793111759;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=h+G5CeLd5LQFvlYaKeJNk/hZ2i3mfdUahbHxlwM6mv0=;
	b=G4txgyM6cEHOV14rwkKH5bV+7tgDdz46Ikpt2AF+fHlZXXdzxnLPcmwbynaox4bTLF34
	 HpqNA/nY9omzmard4fWjBjDgZIvt+GZ7hn+Hb/oOvkHaxf4dwAe83v45hEGoK/NGhIA8N
	 sUggGnFT5214RmsmL0iLUcjpd972m1+VExMgbt0ZgZ1gY4ROIx+pnoI6kjfAklUMQ03l7
	 ckAceVNsbtMrHseSHeERo/LCos2AO0f2CerCjBI424HVZ06Q7Xoa+KWlv3ONjIBX9p858
	 +FjomRIIKmeP1Bgi2qVx0H11fcySxyGPqtUCpWP007aeflyRHVSX/gUWTiwe5ETVxAA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUpDL2Sn;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C6D7D606A31D
	for <linux-s390@vger.kernel.org>; Tue, 27 Oct 2026 14:35:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=AUpDL2Sn
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1A3771F01828;
	Tue, 27 Oct 2026 14:35:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793111758;
	bh=h+G5CeLd5LQFvlYaKeJNk/hZ2i3mfdUahbHxlwM6mv0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AUpDL2SnBj0t85o985jST5Ofx6gfb+EXmq8VvkjFHszUDhWXsGNVyP/DhbU874LPr
	 m+UiER8ltjN+23y78zzFEwr8cMUoHF3FtHOgtLCa+O8J9UDg/SPtu7Xdhv6VfV18BQ
	 tzxiPvPSzCVPu+yrHMg+TKlyI4iXRn20S0YIno8j8kPAvIjmNJFb4rwPt7KqljFoPx
	 7daSyf9x9P32N8zHac4de9ABIZ4NHn3xIkfjunW+4/A/Cxy74Z7iXYlCgwTs7bsJMx
	 k7rO7XvFEnKc6z+DcDWo+Rnz5N/ANQJWGJBuiX/8VmFOtjx8q1RK8aFC9TV5K5gFzC
	 bHMq9TFmJb6zQ==
Message-ID: <sashiko-outbox-186733@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 01/10] s390/jump_label: Serialize text patching with
 text_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261027143030.3154657-2-hca@linux.ibm.com>
References: <20261027143030.3154657-1-hca@linux.ibm.com>
 <20261027143030.3154657-2-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Tue, 27 Oct 2026 14:35:57 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Acquire text_mutex around the verify-then-patch sequence in
> jump_label_transform(). This way s390 uses text_mutex like other
> architectures and does not need to rely on other implicit semantics
> (e.g. no kprobe can be set on a jump label).
>=20
> This is part of larger series where at the end s390_kernel_write()
> requires that callers hold text_mutex for serialization.
>=20
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261027143030.3154=
657-1-hca@linux.ibm.com?part=3D1

