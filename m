Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458689;
	b=xWn9g35uTIKZ1vNGZ/tSaRKE/FEu3/X2jHBl7F7nVPudaL4SBegCq6SDOiHOpAk1s2MN
	 ypex68dREj8ArubJURy1OOUlKCf277sh1vZR4BVkniwbgKawiozVsBJxMOWJN1JkhINwE
	 e5d0HNiC5k08wZOhQfp6Qj7Xy4ct6M045Pf691X7wv/wgAdu9ELA59ffR8jl9jvyT/Bhi
	 NkXrFfGqoQvdq8azUANL9qWAp+aGcczF0CyKrLAoFXagPn54fZQgnMstOGWmz75qry3K2
	 x4ggp2ABh9qvzk15JdGGt95mhGGvS1Fm+1rFF/3AJyAeF+jezYDamASSXA1mCOGELbw==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458689;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=Lh5PngIljiPLDGucK8PaEYJjGQRLzuYaGFMHK+KHQ9Y=;
	b=C6BOViALw2yoQnrlBPH116Nw+xIoCLVrcxBmT98tYwmle/vtZBaz918QgxvwYFV64ei4
	 hJWHijh56/DFxkbGCg+NDrgRTP+/21SZhy2BehQKSnxg8G81232ZYC5NnskelcYLD7THc
	 0q9KwFB78RGlPOcAxLR7OGVNoNbCT0XxIr8YJJN5Fof3sypMDcbZGlIlBUJQthL7LHIkd
	 7HAsSGpykkClh8CZFU2H28+mmtr15Kp6NJ9qwqefu44/WphSU3MKULPIZVubAXs+9HDSU
	 mj4xvc4EdqCwTwiUWZY6MnP3oEehC7vx25h6pOGZWYa1dP8sL3G+xrX7Kh4TiXytb9Q==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b="lZinhM/x";
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 99ED2606A327
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=lZinhM/x
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E00251F00A06;
	Thu, 12 Nov 2026 04:44:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458689;
	bh=Lh5PngIljiPLDGucK8PaEYJjGQRLzuYaGFMHK+KHQ9Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=lZinhM/xUfCP0a53RXh/u3oF5YnoUZOh3WrCC+cBlv2W3kiKU+m3vkDvLe956YXjj
	 f1YQfpiS5ki/Y65lqYRdbRJJbhHJeTZMUEVVTyzMRvam3wzGdL3rQXoGCD3FlJAjNg
	 BXjgOMRyYIwRisZBkzjrd3CvUNlGgzJhP7wmIFjWjuWVFhNsV662MluMed/9y6L0jj
	 myktNABLydY9TPwlVzVC+sau4jkgzm902acMm9GmQlOQQkOQAz0sBAdT7bl3TMHStd
	 wxZr9QZtphRTRFmrb6mnL0NAnJWdFxgM4XhVbwOb5jI+jZXt8otQ5Wg9yIOq48yz2o
	 auDzoTHGkvu3A==
Message-ID: <sashiko-outbox-210386@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 4/7] net/iucv: factor out the HiperSockets
 frame dispatch and state changes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-4-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-4-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:41 +0000
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
> Move the switch on the frame type out of afiucv_hs_rcv() into
> afiucv_hs_dispatch(), and the state changes a SYN|ACK, a SYN|FIN and a
> FIN make into afiucv_hs_synack(), afiucv_hs_synfin() and
> afiucv_hs_fin(). The three are still called under the bh_lock_sock() of
> their callbacks, which now test sk where they tested iucv_sk(sk), a
> cast of it. They are defined ahead of iucv_proto: the next patch
> reaches them from proto->release_cb. afiucv_hs_synfin() and
> afiucv_hs_fin() are the same for now and stay two: a later patch sets
> RCV_SHUTDOWN in the second only.
>=20
> No functional change. The next patch runs the dispatch from a second
> place and the three state changes from the task that owns the socket.
>=20
> Cc: stable@vger.kernel.org # 6.18.x, needed by the next patch
> Signed-off-by: Bryam Vargas <hexlabsecurity@proton.me>

Sashiko has reviewed this patch and found no issues.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D4

