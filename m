Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794851512;
	b=YkGX+ipgsatlOMC7/GcSOSU1PmjK0LXcfzAWQYEyEHKt+KR+tt9RvPkPyk/5UMj5LKxM
	 mdaAyOYlomKjVrAStS9hsHzEULti+LLLTDoc5st0YwxnqMm0RoRQM0OiRV1kQGinWv1Bb
	 6bDsr6pjMabrwlhuk6m6TLcxiDmOJ2Q01RZOXG+vhQmUgLf1ykQaj1E31IVcqHrtw281v
	 djTuZM/bSZcHKH6f4x7AUcNitTrNHF8BBGXA2foGEypVYElQKuiSmuWzFm0aSOt2fBM6o
	 uaeANKxrwJ5Q9VkFMOqbfbgELEubV9Wl3KRqOukNf59L2GIToLeQredYil74DsktlmA==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794851512;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=936oI3k/G89L5r4DZ4IofkuudajdVruRugpksT7J7oE=;
	b=EyUmt5LBIVTe1lFUqWGUuHKZGTNEjNUaKD6ilT2202giCQNtbpseLq59Ihg4IlZvVxnI
	 jMkmyIuOLpTRiYRm4aGqVRA1SZUaUESHDpazDZmGYb8iwW0cARbWORsgFm08ayNZoOSEg
	 4oioP9Ph+K2m4YU70lDJ2hmd7WXl8KXGu0WxJqIrQ+zrHOe8QANsxC/Rum/Ycc0bPRDLS
	 aP2Z4OM7WCI8eKZD85LGNuRV8Xx254TZjtnB7UluCkkT4l0D8zP74ZEeEQWCCfy6z3XLG
	 BMD3/RD44NnHOPYcgdoSd97VFzzVTkycXSOXNbgOrBnlrijCI2AVWmVl3qkvl/afFJA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCdKsM9r;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CC50606A88F
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 17:51:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=iCdKsM9r
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 320561F000C4;
	Mon, 16 Nov 2026 17:51:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794851512;
	bh=936oI3k/G89L5r4DZ4IofkuudajdVruRugpksT7J7oE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=iCdKsM9rTd1r4a1HfmNvkkz/CVUKoVMgQxPxc/sndQOm7INhombBSmQRRSzf/nOsS
	 WmUY12X6uXH8Sp96QNTU2qn2WAm+4iO1deoonRX1hu/csMi1qaHPx0WKbGtR7e9Eqd
	 hxKu4nUzaKhUVqA5Fb8Wem+pRT7y5SDraerutuH4wyR1y2goU7P6+vnLA0jXgErRlZ
	 84iYPzO3KWg8/SdQKUVuCNEhdDX7mlDknGwVbzMByfpLNWeZ2UstiFpSb2XJxhnkel
	 iFJWwzvu9Yj5OenCSSLVh5Axrd/jJbzjuThA15tONMEWN/LPslG8307iK6IJAwwKR8
	 DI/NpiVuyZtoA==
Message-ID: <sashiko-outbox-217445@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH 12/15] s390/cert_store: Validate hash length in
 check_certificate_valid()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Heiko Carstens" <hca@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Christian Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261116143534.158375-13-hca@linux.ibm.com>
References: <20261116143534.158375-1-hca@linux.ibm.com>
 <20261116143534.158375-13-hca@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 17:51:51 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> Validate that vc_hash_length is SHA256_DIGEST_SIZE before checking the
> hash and use sizeof(hash) in memcmp(). This avoids an out-of-bounds
> read if vc_hash_length is incorrect.
>=20
> Fixes: 8cf57d7217c3 ("s390: add support for user-defined certificates")
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261116143534.1583=
75-2-hca@linux.ibm.com?part=3D12

