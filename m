Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792565;
	b=MaRSksP41G5yuR4+Co+3hTK72mU826wNwYqOKS748IbB0AX8TwpCJxrpabD2fnxwH4ZX
	 p1hbEIMrPjUS1o4nVPCgDOPmdoZmrfDRJVwVHDGHxj6WrmFpOoMNTA5BMGsAv+AsCHTSR
	 09Y/gYzbxRhw5KDqvTtYfehMVmn7EcKK33+dfUzgVZYGUEYRjPoDmOymfOI6UWtDTYYKt
	 23wKiWfG0ClmsNDZdmd2JuLinCzXE9vgpX3ipD02ahZnkVVuaHf7V3zad9u6Jh+9aoaLN
	 DzYcHCCmNxKuRMb/e94gCpD/fct3CnKdEtCAighgXf/agS8OFQc6VlFfeN4QGH54wfQ==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792565;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Ep41EjhYT8rOSyZQj8+Q+U9duSKQr7BiqbUnua48EvA=;
	b=x3usOIik7UrOpy43i8ptsW3CPYbAOXfVxvJufWZRBGx1QySTWHwYbSukGBJNjSR5fYK+
	 4z4rafqkUeAJWBowKNOPVYrwBSkZcaBByKPZyqiJy+k5ZLQeFfJg6BBhebCI6tCh6X9WX
	 eM3XWefDRXiV83pvx+MEQoK1k0tKOBPfepQ7bMH4GXZpedJ9kyFBncy3xPbMCwv3IO70w
	 ntRaUDLTY4tpExE0SsuHrBEtjxiSB4fYWY3Njef/hebiMMe9li4vQg7bNt30XdOQFvJLG
	 PzGdDp+zev0b8aGMXZOGYBW5a1WNSaVOHEGqpCOmWlw35MEfpjvMyu7P+AOAd1ySMTQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF8MUCFi;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE182606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=IF8MUCFi
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 380731F000C4;
	Mon, 16 Nov 2026 01:29:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792565;
	bh=Ep41EjhYT8rOSyZQj8+Q+U9duSKQr7BiqbUnua48EvA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=IF8MUCFixoXMWinJ6d+/oKc+k0BdyAGFbKuAoyYW6TP3GqQmCNiYfGf97HpCQac6C
	 vnqGnwJgBjD15wFqhSWDvImPdKJaeiH88tVrUUxvJIuEgmi9r9326+uyNurzK8nUtu
	 Xt8FIy2E4bKdhnRkQciT5K6OE1rVDRMDHd1bTzT/liefSC+3UpZNxVjav0QmkzxRlx
	 c4okf44V8xm1QgCxg3Dss/eGymvirW/+q2JeZVGOs3ZbzEMnAixf6xMFfzXnQ8ROdA
	 QKXEaFSsIw75AZ2D4Xfjtq5WRAD9wxJejPlt9pFoeWnsmLGbO1oybsrRkU3LGxQDp/
	 OQ9qLYgEwtiNQ==
Message-ID: <sashiko-outbox-215994@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 3/8] net/iucv: fail sendmsg() with EPIPE once
 sending is shut down
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-3-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-3-f96c506447ce@proton.me>
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
> sendmsg() tests SEND_SHUTDOWN on entry only, then waits for the peer's
> window without the socket lock. When sending is shut down during that
> wait, by shutdown(SHUT_WR) in another thread or by the peer's quiesce
> over z/VM, the wait does not end and the call does not fail: the writer
> waits out SO_SNDTIMEO, or, when the window opens first, sends its
> record after the socket's SHT and the peer reads data after EOF. With
> the peer's FIN in as well it returns -ECONNRESET for a stream its own
> socket shut down.
>=20
> End the wait when sending is shut down and test SEND_SHUTDOWN again
> after it, ahead of the sk_state test, so the call fails with -EPIPE as
> it does on entry.
>=20
> Fixes: 0ea920d211e0 ("af_iucv: Return -EAGAIN if iucv msg limit is exceed=
ed")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D3

