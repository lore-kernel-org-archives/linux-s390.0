Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.remote-ip=100.103.45.18
ARC-Seal: i=1; d=subspace.kernel.org; s=arc20261015; a=rsa-sha256; cv=none;
	t=1794458693;
	b=rRxFq+yapxGqbEQTJKk/S7prYxaI2I0MHuQtf8Z0iJnPVpbESDsSZ318G3WcLZi5G8gk
	 4yvNAZzKJPgH787JP4Q/pZUoOe7mAPlKabdehO6PN4CFzhY58ZkrTiWL+4b0YW1dtx4NY
	 rGBt3mWveHc5KX7zESuAU7aiVAfOQJ+nyTL7fjNKz/OhMfZFtUUwIU5lJXf67um/aS+2B
	 1bwUZBTvzI95vCyBwH7ub41v8wWsubaZig3IoAFMN5ffOqcNc8emzW1DmZvFOJTcgl2zv
	 BapizBjORlUjtYu6Gg+dvuWhdd9Eo6L7t33pzhBF1L4qiFmhQM23P9UAzRAXEDu4Thg==
ARC-Message-Signature: i=1; d=subspace.kernel.org; s=arc20261015;
	a=rsa-sha256; c=relaxed/relaxed; t=1794458693;
	h=Received:DKIM-Signature:Message-ID:From:Subject:Reply-To:To:Cc:
	 In-Reply-To:References:Content-Type:Content-Transfer-Encoding:Date;
	bh=qda8UjmOzXvU9jQqMPgjGDyPtN4WI5O+pSBtOUbHh0M=;
	b=C5LiXW5eAq+aWb/cwGvPWXD+L4UmFLzEftcybS+xaek0MN5Wd3BAzfqMYFgKQZb3bu6H
	 Ll59wK5XaONGZZQ1KfvkUn7olnZu9dtH8sw+y5Jsi619V1NOzJw5IafNjvqxY+zlrZl/C
	 00GnYU2HiIwHGAiNV7kD28JGRy+k6xAmo69wji+SDiCyAc7JOe9w45mH88aG0Z4E3tJpR
	 gNeVp0O/WaCnm5qGiw2OoLZkjCuARG7LgdhHoQXE5Mza8pNLAQd9Uk90hlrwcvrRPjHLL
	 Y1bTUyal+BKqqpDKsDdoWWT5JjNNPffbcwEnUsjCA9bLeJKqETNQghNlR4FviFr3Myg==
ARC-Authentication-Results: i=1; smtp.subspace.kernel.org; 
	dkim=pass header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3bpFutJ;
	arc=none smtp.remote-ip=100.103.45.18
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature ECDSA (prime256v1))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9C96B606A321
	for <linux-s390@vger.kernel.org>; Thu, 12 Nov 2026 04:44:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=F3bpFutJ
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F42F1F00A06;
	Thu, 12 Nov 2026 04:44:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1794458693;
	bh=qda8UjmOzXvU9jQqMPgjGDyPtN4WI5O+pSBtOUbHh0M=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=F3bpFutJEvOw7enhgM1oWLRdfIU8+hgCJbIolelYZWNDobhEVjPEBwqGX2JggwxIh
	 L8/GpCmvhXJyWNYfZXTxSYekl1GkoAXiB9rxjBynK5h1aY9GWMLZZjX5VgT0qZm/rc
	 tLKxBcLVZhJmrfglH+/aks69GFyKxgLkCFd1YsPemdf28++S20CUuB6nmGSrR18KF+
	 LDpIx5PmdB1ge1XLaqejPVVO52+UFqTS2AZmuZafB+gjhI60g7JxEpUHVjrS7Sz5da
	 CD4Zle57T5UhH87JtEBQymyKpkwf/eHLY01O0EUxQv1Nrk5mlnpDA6QAB/OW711+aR
	 jUmNu30yAWLvg==
Message-ID: <sashiko-outbox-210389@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH RFC net v3 7/7] net/iucv: return EOF to a reader parked
 when the peer closes
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: linux-s390@vger.kernel.org, "Heiko Carstens" <hca@linux.ibm.com>, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20261110-b4-disp-2a6b4364-v3-7-35677b68e697@proton.me>
References: <20261110-b4-disp-2a6b4364-v3-0-35677b68e697@proton.me>
 <20261110-b4-disp-2a6b4364-v3-7-35677b68e697@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 12 Nov 2026 04:44:51 +0000
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
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261110-b4-disp-2a=
6b4364-v3-0-35677b68e697@proton.me?part=3D7

