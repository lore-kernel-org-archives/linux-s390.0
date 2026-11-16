Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792569;
	b=iYGnpDTi3xq6Hsh0YFLi0BaCaVb7AFPcT41czU0Drsm2D3xzS8811Ch1melgU47A8D4V
	 hBVTt0vLXpgFfk5I+vu2iSKch4BnX517/gGlo4eeMzfSC55pvsDnOphUkxFZJm9aVXI2D
	 XdTzne4K9YdP0KWznd0d2uwNV3/SgnLMav9ixZkS8bDOCeddmw4BK/+UcINCbWDoYP6RB
	 QzO0KhIzL1C3AtAoQLD1ZSbnLzS0AQu74QNxl/KRr9kdx1lQRvsHLYCc0afDaIjrjtny1
	 q2hNxCCRV8ME3AExHs6o/55W9q3zYRDlOYWokDtGJFKVYz16wEGVyYymMDQFUSTn0yg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792569;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Cb5hjmZM6Q1bH2M9+A6yYwAfT2DW8HA8GUIUOK99eys=;
	b=eu9q8JyWJDKn60kkhRbadGSM2WmLoGZnWWBTtmYPUYXLr0rQS8FhrrAIy2spKo2MAGS7
	 GzVlFt3nBlcu6CjWx84YLcDqCvUApK0LU1BmA9Rbxy2vq+2/sQTEzzCGkHi/anoTEGCNH
	 9PWF7KcO/mLqk+jXamMy+RjiAh6JrQtZbhofSBG5gdWU4QkPxGJF540ztNnlBpKh6Ykgj
	 IkpdUAe1hwxqFIDbJx2NYj7S5n8X8D+xtrD2W7f5OpOd1qgFYYz93vswugIDFq72Q/3/A
	 ExxcvinNiqNSyP8qr5SgwqNJIEHlD8XC3wdt3Pc/aVhxNn1hJ8CXy3znlRum2SvbxKQ==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwOaU70u;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DBDF3606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=gwOaU70u
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5FE221F000C4;
	Mon, 16 Nov 2026 01:29:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792569;
	bh=Cb5hjmZM6Q1bH2M9+A6yYwAfT2DW8HA8GUIUOK99eys=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=gwOaU70uX/UCdkFPEWjha2XqM/zpn/w9PhoONa7pN2OkRDbexlpSF82DDVGmKgRZp
	 wgZ5bZOgJdoLD1FBVbmDXAiiwVPCJbRfTz5P/mEfsq1QgHW1jNDvNkyBxKPiIsyc38
	 0btyR6fuwqkNNMYCChaJXoMthIsuQ1UkAPUhpL3faUNFihDae3tfljukrv60IObCA1
	 oYMNaST4/s2p8r10LyH5sSZ1FLEHGVZBo3kYE5cLx2xIo6oNRkpPSrhcAo3QO7NLFf
	 EgZAmroLVKickYt2uMxcl2qBqZgRJB1x6jr2MwXUrEJgFvNthwnipzln6MJs2CJRY1
	 NZRyeqwOw2UVw==
Message-ID: <sashiko-outbox-215999@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 8/8] net/iucv: return EOF to a reader parked
 when the peer closes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-8-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-8-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:29 +0000
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
> A recvmsg() that starts after the peer closed returns 0. One that was
> already waiting returns -ENOTCONN: its wait ends on sk_state and does
> not ask whether anything is left to read. In a z/VM guest over
> HiperSockets that was every parked reader, 13627 of 13627 on net-next
> [1]. poll() does not report EPOLLRDHUP for the close either.
>=20
> Return EOF from the wait too when the socket is IUCV_DISCONN with
> nothing left to read. As for a call that starts afterwards, it does not
> matter how the socket got there: the peer's FIN, a severed z/VM path, a
> transmit error, a window update that could not be sent or the device
> going down. EOF does not say that all the peer sent was read: a severed
> z/VM path drops the messages not yet received, for either call. Set
> RCV_SHUTDOWN where the HiperSockets FIN is applied, as TCP does: poll()
> then reports EPOLLRDHUP and EPOLLRDNORM for the close, and EPOLLHUP if
> the socket had shut down its own sending. The other ways still report
> none of the three.
>=20
> Fixes: 561e036006dc ("[AF_IUCV]: Implementation of a skb backlog queue")
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Reported-by: Hidayath Khan <hidayath@linux.ibm.com>
> Closes: https://lore.kernel.org/netdev/82691101-92d7-4838-b16e-2e41a83f65=
d0@linux.ibm.com/
> Link: https://lore.kernel.org/netdev/51a4a40a-f34b-4d41-b049-69aa53f4dcf5=
@linux.ibm.com/ [1]
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D8

