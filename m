Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792564;
	b=sbwn8GsRQLy2qeqCNSZNquCyk+8Uy0nS/gWM2YnLQlqyP9QgxAl1KgeU2bzlT1xvNdT3
	 BFI6iLE9tOwgAaxLLdBNU4Z5MvN+w6rRHJ+pTiYwKygW6+y4yf26Cgdm8TcNq9nrHcTHD
	 Azqt3hBfiw2T/U8dpYrR851Jn/BUmIqkD5Wl1vvXIXF0BTF7+NaikH4eIJgoDfOYbdUR4
	 eK7hTT6qM9EcXB9zH+bBo+ZR5aQu6dbr1+qjGpbKEbP+L8xU2f9Q0q0i1y8YsdTjbddku
	 Yu0J5HYP+ACIAMPMbmNFA9cZFRJAtz+mqvy5SHURBf4Z+7G5sUwMJ1H4ynLxiEhmsTQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=q0VDy7IJDS4Iy+2GCyIthJ6SwdvErvWZOq0pOz18IvE=;
	b=3JWcT9AcfmBPeCoYcCL8o7l5ppMXwQRFSSXfzZHTpiAIxbi2aVVgmUY1JUGQJ6eyfqlo
	 a8U2ADoMftMA9V/78qJAvW6oHOEfocANrgvE/pxFRcVqZRPcvti167C3uDd+o0rl0OnbS
	 k+ya18yEG6x0zctSJp6a7irjeLb7nNaR2mBkdbhefgfT4+kqIxIQKNUSiDgxeFzAfWSMN
	 vnkd9s/fPlIPYjtZL2VSYFaboH1gruI3x7uKlHzMyhGuPFValUVLPPxR/AX3NoE7mkA4Z
	 IdYwUMbkzIWILnTCAZe+dG9gBKBzNg2RuTJNN7CjpP1RveSqXjUyo81Fr0bH/+i2UNA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuugUn64;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D8976606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=nuugUn64
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DA441F000C4;
	Mon, 16 Nov 2026 01:29:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792564;
	bh=q0VDy7IJDS4Iy+2GCyIthJ6SwdvErvWZOq0pOz18IvE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=nuugUn6433jiY3gHkWg1bEXvERzCu7Yrg4Nquwf9yrq0Te7nYqutxgou7+jJ77xO4
	 /UzQyoFky4GfnO80SWt1wCr38oHpeXJKSPkyvt3mpfeiO9uChKUG6wv7QuqhIEJI34
	 zLL9s4qdO+/nCD8YRCqQZq50UuWM8IVKskaPmLq3l9wnyED1bgZLRwng76etBzG+8I
	 pFsk+93kp9WfpjhmaANNUjWe+Jnub/CmT6xAsain500ExqIdQl0ARYbswLQIeDeW9E
	 MmBsfU7vSbceB3WM6OGuDKt9HWiPJ35Tx0O+khCM/ii3+X60HvfAmoBkJ6OjoMMr9E
	 xhJLnGCOl+J6w==
Message-ID: <sashiko-outbox-215993@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 2/8] net/iucv: do not clear SEND_SHUTDOWN to
 send a control frame
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-2-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-2-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:24 +0000
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Post: <mailto:linux-s390@vger.kernel.org>
List-Help: <mailto:linux-s390+help@vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
List-Owner: <mailto:linux-s390+owner@vger.kernel.org>
Precedence: list

> From: Bryam Vargas <hexlabsecurity@proton.me>
>=20
> iucv_send_ctrl() allocates with sock_alloc_send_skb(), which fails once
> SEND_SHUTDOWN is set, so it clears the bit first and writes a copy of
> sk_shutdown back afterwards. recvmsg() calls it for a window update and
> the NETDEV_GOING_DOWN notifier for a FIN, both without the socket lock.
> On a socket that has shut down sending:
>=20
> - A shutdown(SHUT_RD) done in between is undone when the copy is
>   written back: the call returned 0 and the socket still receives.
> - sendmsg() can find SEND_SHUTDOWN clear and send data after the SHT of
>   a shutdown(SHUT_WR) that already returned.
>=20
> Allocate the control frame with sock_wmalloc() behind the test of
> sk_sndbuf that sock_alloc_send_skb() makes, and leave sk_shutdown alone.
>=20
> Fixes: 4e0ad3221691 ("Subject: [PATCH] af_iucv: enable control sends in c=
ase of SEND_SHUTDOWN")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D2

