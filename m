Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1793249514;
	b=cfEVtrtGiAzUgNfEkcYGP85U6VuWtFXoimsNZZKdV+1yLVE2gn9oGcrzz2aVOzWXx5ny
	 yAMLU7rm8RAohW5oW8gLT9CCSSvfjayJacaEnqOOj8V8MHU4qf+po0OTIxIXHftuEeVQy
	 R0qd3Tf1lKnBElG236khDgNdv82MG8LonzP+sxxv8aVXqU9alZm+pq1kxr7Cb4Z9iTUaO
	 W7aU9C/rLBfDNLyz0CAk1VePtpDu4p3pjiH7S1lLxlP1cT/TGavSrP6mJbUU8tdc96JZ8
	 dcrqe6PiBaADAkcUHnMIquZZzal3ztv6KNbnTayl3iNdSQzQo16/v6mSyYUmzrxherw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1793249514;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=eXZk+B++V420SS3Nc66Cz7ZlQc8LwM9IjEE4HSCkCTE=;
	b=imu6wx8h8VjubKA+VOL/nn4ajUu9JmUceBUXRK7TlvN8TEDExP+n18Rr7VbsBI3cyKDf
	 bqWcaqb61WZ46CUgwr8k6ue04/kOKpVNLRDiqTTL2B+bq8mWmFLrq+u/aQBWKnnIClgP/
	 B434WbEgVztN6muxTjuVRdEzdzayNNr0sVSijNenRiIlMEnjYTYBcYHYrffZAXAnl0udc
	 6r//p2KOxNdb8CI9kawOkJ6kxVuN8HmazbFyvoehtAntrUdpaqU2MVV+4zcSfvLifUqaC
	 xrrDHvYKO7A1bioWZhovZ8i1ZSBUpCZjUXzmCamv36jLPfEiGFyLMqVGef7uBFh3OLA==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqFpwwX8;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6942606A31F
	for <linux-s390@vger.kernel.org>; Thu, 29 Oct 2026 04:51:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key, unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=mqFpwwX8
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B0C41F01829;
	Thu, 29 Oct 2026 04:51:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1793249513;
	bh=eXZk+B++V420SS3Nc66Cz7ZlQc8LwM9IjEE4HSCkCTE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mqFpwwX8fDO9ef5ntdSx5UAxa1VWd5gAcNtm5bYGwayqkUTTWNndy1OSEsXtmDFT7
	 PEo3mKRLoLxBGzWU1aKp1IbBYbKLiHgyDcBtTi19DKfFC3iy26VXDmlwb4tFcyoMyo
	 SGJvia+m/miC6WfkUZ7UVA4jTWfBsa2DUlWbRahgQNpx5nMX/SIptUqvVUOcWNjZIa
	 mZjue0L3zuQChsgXHzb3FsK0RQt+1AmUhJyC5VU2i73cTOBb7bx9PW6CEILf27EOQf
	 UDdsttBhwHfRwwtYF+suur1DhS6qzuw2MOz0VSgG3ulM1iqgxjRssEk1SUgOaG19ct
	 4I26HQ29vQcWA==
Message-ID: <sashiko-outbox-188712@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v3] net/iucv: take a private, writable frame before
 rewriting it in place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
References: <20261028-b4-disp-1edbbc34-v3-1-13495411f5b9@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 29 Oct 2026 04:51:52 +0000
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
> afiucv_hs_rcv() rewrites the frame in place -- EBCASC() on four name
> fields, then afiucv_swap_src_dest() swaps them and pushes an Ethernet
> header -- and can hand the same skb to dev_queue_xmit(), without making
> it private first, so a packet socket that also gets the frame reads the
> rewritten names. An ETH_P_ALL tap runs first and leaves af_iucv a
> cloned skb; a socket opened for ETH_P_AF_IUCV sits on a ptype_specific
> list, walked after ptype_base[], so deliver_skb() takes a reference and
> af_iucv runs on an skb that is shared but not cloned.
>=20
> Unshare, then cow, in that order: skb_cow() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). skb_cow() tests
> skb_cloned(), which is what a rewrite of the data needs; skb_cow_head()
> tests only the header. Asking for ETH_HLEN also covers the unchecked
> push in afiucv_swap_src_dest(); on the ordinary path eth_type_trans()
> has already pulled that much, so it only compares.
>=20
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509=
e1200533e@proton.me?part=3D1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261028-b4-disp-1e=
dbbc34-v3-1-13495411f5b9@proton.me?part=3D1

