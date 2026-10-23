Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720668;
	b=qjymRpHAaxDv4FHKoL0lUMa0C5Ens6WGQGLXcYW4yLwGjeQW+ccx9bJTwXnkK7YuRlbb
	 Nn19lkxPD32jpLAIRlDYRzLPfzBGB3ypRZbrypWW/KJK6MmtrPfmsktvdAxyX0TxFUsaR
	 T+U+N7sxW7nq7kuzgLzO+LCm8S0IEMpM9RgN2HjgZYLKNnEUP15vtB+QSg9NcG6hcg0i/
	 6wX9d5rLudHswl8DxRCwBYA4a5qK3gGGwd+MrYOnxCsRpo/4KlFUDmJeIX1xlDlyzdxcO
	 p+CQeLaD5OAb6Gz7XE5g6XtR8caiO2ym6T2RKFokyoKpIIzXgQRqkNltlwX1d+apwsg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=nwHUnFcuypt0vUjXp/vnd0SN9TY1By/PeR5kUhWy0IY=;
	b=YP/Y/jQtQi5KMmub+6lwFoDQtTRMgKsh+9c/zn3vBJq4iu/VVfD6ilqdsRhI/GoFtLxj
	 tN7cbo5mSUTD8yFgRypAACaiHC7yocj6/P30SgfzlmT6p+TcNfxqUL/UVUWm5+MoaB2QD
	 jF5n+eHb9KRYvx5ivED4NbVkb9wccBDLrCW4mbEKQX2VAZowe9/K69EGxuI/jC7lcl4T4
	 52vL+zK1cKDAbqc47Thz75E7cXIDMAVB/k8FJaZXb5D4AIrvkQjm+ISHs1iiVAqHYZmVr
	 mueNIOlpVW62X87MeSF0kFNX8IpX0jhB9Gqnm59/guk+EZJYnRLb3D2AQG1keh3kALg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNCr8oyJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0D555606A31B
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 01:57:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=hNCr8oyJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4DAC91F01825;
	Fri, 23 Oct 2026 01:57:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720667;
	bh=nwHUnFcuypt0vUjXp/vnd0SN9TY1By/PeR5kUhWy0IY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=hNCr8oyJVVBj+NZS6MiIJQG2CfPxJKp9pCUlsURX3CYzSedkKnazgCXIfWJwa3ClO
	 7OFb6Fn3DkGBYu8BJ1U2mUN7zDl7JgCqJQ8uN9w7PiYMRIqVZsnO8qr6M8djGwfTIX
	 uUlUVBxWnYgPg5b96v/DbbhIoq3wC3RiKHq8kk10c9MqQfMvfF4l34zdw+NAlOEL4X
	 XTuUXNJeyPeqW+zYDTMMyHhsZNfahMib06xQ1kjQRjNVGFi8u79J3dHihiv/hZp+3t
	 b5Wapv6o+80dFdjRpmsb8Mjzazlk6ZYJ+VaaO68nXgdwmkMeZ3Vwy4rMLfw+ovRfvT
	 lWDjQi4Hw1PEg==
Message-ID: <sashiko-outbox-182193@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 1/2] word-at-a-time: check the first byte in
 load_unaligned_zeropad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
 <20261023-bug-word-at-a-time-zeropad-kasan-v2-1-be0ecfbae847@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 01:57:46 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> load_unaligned_zeropad() reads a word that may run into an unmapped
> page and recovers through an exception fixup. It does the word loads of
> sized_strscpy() and of the name compare in dentry_string_cmp(), path
> components in hash_name() and hashlen_string(), and the trailing bytes
> in x86's csum_partial().
>=20
> It is inline assembly on every architecture that implements it, so
> KASAN and KCSAN never see these loads, while read_word_at_a_time() at
> least checks the first byte of each word. A use-after-free or
> out-of-bounds read of a name handed to path lookup goes unreported, and
> so does strscpy() reading from a bad source, which the kasan_strings
> KUnit case expects to be reported. On x86_64 with generic KASAN:
>=20
>   KASAN and string KUnit suites      failures
>                                   before    after
>   CONFIG_FORTIFY_SOURCE=3Dn              1        0
>   CONFIG_FORTIFY_SOURCE=3Dy              1        0
>=20
> Check the first byte with instrument_read() at the start of
> load_unaligned_zeropad() on every architecture, as read_word_at_a_time()
> does. All callers only load a word whose first byte belongs to the
> string or buffer they read, so the check does not flag their intended
> reads past the end. Add a no-op instrument_read() for the powerpc
> selftest that builds the header in user space.
>=20
> Suggested-by: Peter Collingbourne <peter@pcc.me.uk>
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-bug-word-a=
t-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com?part=3D1

