Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF4721F09AD
	for <linux-s390@vger.kernel.org>; Thu,  8 Oct 2026 09:30:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791451861; cv=none; b=TV2gf2clE4dY00UEH5ra61PRM/kBvOV0RqwNB5uN03goxb3JWS+tp1Df4tnVyCqLRslzca6vO92xQ6eESeqAZ6oaXGiItm3FinoIfBmsJF8ir06AqgUeTYHO3a9QLSa60kawO0nqv6IJu4nX/NYS+lGDANPX6kzAEOwCtOgnz+o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791451861; c=relaxed/simple;
	bh=j/k2vyFmbeCiokD6xAGsN6D8yV6lZq1Oguvh78L+O5A=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=lpT7RuTDGK6GL2Ru8QZ055r7GRrBypfv2VkSI2h2LV3X6qXz2rChvAekp7XdbWv1XY/EaWCtGdRJbLr57b7Ow6vy1+6x+/Bn5540gjn0SlSAZmtJs0eKexrEWOnOeAVK93o5TTC4Ck9QJlk6cQdWvzhdOpGNsCN4f9VAoIKEALc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Ml2W3UKl; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Ml2W3UKl"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CCB131F000FF;
	Thu,  8 Oct 2026 09:30:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791451854;
	bh=j/k2vyFmbeCiokD6xAGsN6D8yV6lZq1Oguvh78L+O5A=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=Ml2W3UKlYWvK8fN0yuZJejWiyMJeEbAkCpJyyZQyVwXaRFg31EgIOVS50Toc4HeK6
	 XbPGB8odvjmbif3Rf9lRDaUqZ9p1X3ETIR4u9jRFkUJgZQl7CcyAEhxi+AzMMTY95m
	 r2Awb4Clzeif6SsEJaMQEwuwuAxVpqqBAZmxNYUYlf6d9v9zevciRZcBbZxKQLKL22
	 NMeUTkszizzUL2cUvm9FFb9l7S213dXREiChu4oZf8SWTg19fGVmESppFJ2L89XGub
	 IDcFgSfX5USHIqqgxqepNAOY9L7Y6FfRkzergoTy1R2nsR1g9SApjT+fPuFB9oRjQM
	 jyUFwwzgaYp8Q==
Message-ID: <sashiko-outbox-163939@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] net/iucv: take a private, writable frame before
 rewriting it in place
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
References: <20261008-b4-disp-bf46f1ba-v2-1-46ff1ea9c40b@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 08 Oct 2026 09:30:53 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

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
> Unshare, then cow the head, in that order: skb_cow_head() can reach
> pskb_expand_head(), which has BUG_ON(skb_shared()). Asking for ETH_HLEN
> also covers the unchecked push in afiucv_swap_src_dest(); on the ordinary
> path eth_type_trans() has already pulled that much, so it only compares.
>=20
> Fixes: 3881ac441f64 ("af_iucv: add HiperSockets transport")
> Closes: https://sashiko.dev/#/patchset/20260813-b4-disp-60433a46-v1-1-509=
e1200533e@proton.me?part=3D1
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues. It looks great!

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261008-b4-disp-bf=
46f1ba-v2-1-46ff1ea9c40b@proton.me?part=3D1

