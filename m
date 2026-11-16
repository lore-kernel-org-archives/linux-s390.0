Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794792564;
	b=npKQJ+mmniBOYgNtnFYFW15FXxQGMCstDQ/x0KL6AoaeWmjgGfWilGdrD9BcqyNvXHpQ
	 2YExf7uHQXio1ZnvhbaKRbtDGFnQUgr+WEY4q0azZaLYsxRxsoteml5+ByBXk9qddauXS
	 8IOX8gDJBc6R1U++FTcjndXkHfV18c4SVYyOjVY/WPIxpL7WBXZ6SXd/zdqZy+hv1wNLL
	 XocWPmJGWUVnIsmaxSrg1eQYHzPckdxHFDTjFA4RcFBTKnC48JbyDzWS71a6BBlTWAShd
	 LY5+KYGU+8KZPrlLofWbjjgA8OetANYsFjjp712mSXj6MCFAWGEMhR++615P6KaE3Tg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794792564;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Wx9kfwmppqDZd0k1VdahX3LmMfXalk8Gahiz4/y38Kw=;
	b=vRbx5OLz93Iv7/8xIOa+rb14YiBPBRFY2tQH/drD12WNYpUzlG1qAk/0phRIXL+LwUfR
	 uNyYz9YbvzFGeNpF0ehymywQJRVk5dhK34RcJjxhmFzFQvFw1XBY0njOX50U+BX0rZuKY
	 LP9gG9PcglaJivibQHSU9HFo7ul4+RspWfOL8fQvVwEnNXpGIeLDcwYcPqkT+ymsZ6VbC
	 YdUo+2su9ZViCyM0FGGdDrzvi5tyJ4Pcn5N5YfWD+Kny8SdaPQEmYyPhF6m09L4c/NmeB
	 gHI4oIIuytpiWWjzZ4xFhONebOKXKofKGonOoeSTzw0oM/tOmJy+a5fjtBj2bH2VWeg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgO2faWt;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26236606A31C
	for <linux-s390@vger.kernel.org>; Mon, 16 Nov 2026 01:29:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=LgO2faWt
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A03661F000C4;
	Mon, 16 Nov 2026 01:29:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794792564;
	bh=Wx9kfwmppqDZd0k1VdahX3LmMfXalk8Gahiz4/y38Kw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=LgO2faWtyWUDFqLI3kdo4ZbqMP93XemRUtrX22KXy78NYSiP1rZaGTXEbLjSCntWU
	 PZiGNmNM1t1kDXYRZf1v3SorAaE5lJwM9ggqkydxCoMeGppDnMul5yKQ1pY4nK7g7T
	 mgYJZeKflJ0QnV3lxNPd3Z90LaoyF0kUBXAndlKGFlswkbNHGYSlTSdqPR8Sm75m90
	 8IlzoKB2KFoXHyPTHoBaUsS8bTMCKHA0qTDIFzX6oDrAqzKRqwe4evxwddjnAqM53+
	 iC26DIdAwvPnWeyz8uweJzOO2hxegNxBAFVE9lYI5itUVsdyyGM3H7tJ6bOXRPg/DY
	 qXH0Fhn5iGgRA==
Message-ID: <sashiko-outbox-215992@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v4 1/8] net/iucv: keep the window given to the
 peer in a field of its own
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261114-b4-disp-fc0634a3-v4-1-f96c506447ce@proton.me>
References: <20261114-b4-disp-fc0634a3-v4-0-f96c506447ce@proton.me>
 <20261114-b4-disp-fc0634a3-v4-1-f96c506447ce@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 16 Nov 2026 01:29:23 +0000
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
> A HiperSockets SYN carries msglimit as the receive window, and
> SO_MSGLIMIT is accepted while the socket is IUCV_BOUND, which it is
> until the SYN|ACK arrives. A msglimit changed in between leaves the peer
> with the window the SYN carried, while recvmsg() counts the frames it
> reads against the new value:
>=20
> - Lowered, a peer that keeps to its window has the socket closed on it
>   once the receive buffer is full and frames wait in backlog_skb_q,
>   where no window update resets the count: WARN_ON(), -EFAULT, the rest
>   of the stream lost.
> - Raised far enough, the threshold of the window update lies above the
>   window: the count never reaches it, the peer uses up its window and
>   its writer waits for an update that only a data frame from us would
>   carry.
>=20
> Record the window when the first SYN of a socket leaves, and in a
> listener's SYN|ACK, and let recvmsg() count frames against it and take
> the window-update threshold from it. A SYN that is not sent records
> nothing, and a later SYN of the socket carries the recorded window. A
> msglimit set after the first SYN no longer changes anything for that
> socket; getsockopt() still returns it. A socket connected by a SYN|ACK
> without having sent a SYN keeps msglimit as its window.
>=20
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Fixes: 800c5eb7b5eb ("af_iucv: change net_device handling for HS transpor=
t")
> Cc: stable@vger.kernel.org # 6.18.x
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261114-b4-disp-fc=
0634a3-v4-0-f96c506447ce@proton.me?part=3D1

