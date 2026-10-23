Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1792720668;
	b=3CyJfuyNgtclauL8q44Sq4Pf3B49qj8PMbSJwvvLYd6tl+ycQWRl/yDvOfnCD/grLzoJ
	 pe1zfEQTO0ZkaofE7Jp3tac4VFGJ4xW+KB7pG6aHdBrrZqxc4NX3Uhbg8WKwFYiKmFkIh
	 E0YUzv9NoF1tMdAA1M25oPnAlYFyaddJBFtNzqvdcM4ZEpHM01gYcZGIpff0y3axhDreu
	 tNy6qmp/VZI9LuH+NNFrkTwOlKFF5yBtL7yOA/YN7QHAPLxunbOKlO+ohLAMS+P8kfWpt
	 bA2LQkjj7qr3pxFjJQ+8efH7omB/EEWBEtKMqZQPhMOBfGtOcwO8rXJj90I70rggRQQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1792720668;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=/DTnVxRwtB8f3dA03fXrF57ein3lbbtiBqO++ouc+z0=;
	b=Q3UyYUiMZfteodj41QZU8gnaiRSjPRv35xJaIhN6c80cTfvKCPU9kCmyBkQJ8iJBV7cG
	 irLBCvbUo4zFGwSoLx7l32Z2J+KReMKZKmrcttqKqtlC0HRSrUkn11+iOdTAcIW27jprC
	 iJaq6pWfflbBJcyYfhLYfbgGY6V9Do0mfDxqVKUaZDcmn3wHEsVnPaWQJeq9+G9d/YFUE
	 yFUWaYC6Who3F/7nzbIxBr9KZrH+y6hiLsQn5NhRvthDHzFqK9KCsRxJIChnMnPnYd2rX
	 0Cx9j3ZJElZDZ1HlNyMkfud4VkTLRMY8Yj9PKeLUgYPqCI5ZCQTZhVEQhFW35je5aVA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+AN3lbJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 951A5606A31B
	for <linux-s390@vger.kernel.org>; Fri, 23 Oct 2026 01:57:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F+AN3lbJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 25EC21F01828;
	Fri, 23 Oct 2026 01:57:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1792720668;
	bh=/DTnVxRwtB8f3dA03fXrF57ein3lbbtiBqO++ouc+z0=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F+AN3lbJZGsAgaA+z77B0Kz7O2dpymxT10pkrmeDG7hBFVcKeulXVkQhtsY9wLwwE
	 XP/fwJkxGR1IZrwd/hm2hT29C6hrb/I9SR38g2SdQC0Bnz8jmbUO4N9NaqZ2TgImTO
	 VkQ8htCOIZdK+WMCtEEFS69KtsbBCmsZcVy44tTgqDj7Ul3a49ODt9eSPW8e8zv731
	 SWpduPjCk6P4LKN83VYJ8TaoJFAt7hN2uGGUHxtOQFOVOaTAyUvHPKvkz3xLHRK7B/
	 ylv1tIiT/M9XYEfPMS2FP8kBY5CB1AwMLi6JRtFcBNY9ZUpqvvTtvWLNPn/xvBFrNt
	 qFtuXWeaVcJ5w==
Message-ID: <sashiko-outbox-182194@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v2 2/2] kasan/test: cover load_unaligned_zeropad()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Qiliang Yuan" <odys.yuan@gmail.com>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261023-bug-word-at-a-time-zeropad-kasan-v2-2-be0ecfbae847@gmail.com>
References: <20261023-bug-word-at-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com>
 <20261023-bug-word-at-a-time-zeropad-kasan-v2-2-be0ecfbae847@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 23 Oct 2026 01:57:47 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> On architectures with CONFIG_DCACHE_WORD_ACCESS, load_unaligned_zeropad()
> does the word loads of the dcache name compare and of path name
> hashing.
>=20
> None of the KASAN test cases reads memory through it, so nothing
> noticed that KASAN did not check these loads at all.
>=20
> Add a case that reads a freed object through load_unaligned_zeropad()
> and expects a report. Skip it with hardware tag-based KASAN, since
> arm64 turns tag checking off for this load:
>=20
>   kasan_load_unaligned_zeropad, x86_64, generic KASAN
>   without "word-at-a-time: check the first byte in
>   load_unaligned_zeropad()"                                 FAILED
>   with it                                                   PASSED
>=20
> Signed-off-by: Qiliang Yuan <odys.yuan@gmail.com>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261023-bug-word-a=
t-a-time-zeropad-kasan-v2-0-be0ecfbae847@gmail.com?part=3D2

