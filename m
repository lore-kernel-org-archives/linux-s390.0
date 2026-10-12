Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 913D838E8A2
	for <linux-s390@vger.kernel.org>; Mon, 12 Oct 2026 19:08:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1791832110; cv=none; b=d8Zv6eyYIo+AhTxI2zQBijD3zgY4HXiazqAeRnBbsHADJTXpRTZpFDWgPuOUrbTAbOE4V7YMt83zLht+jOBxrbT5PwbYLIvzmHr4X42YQEhPezgCq+FyqpQ8Z9fHBT+dlKlHZGrq7RZRvlgvQACzLdJXLoixYd3VXlfEjg5aOiI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1791832110; c=relaxed/simple;
	bh=qKeOlmYmK3VryOyLhRfKdoYCkxUwb+ojXbr6v0kfBrc=;
	h=Message-ID:From:Subject:To:Cc:In-Reply-To:References:Content-Type:
	 Date; b=bMdy+gVvWJBFdH19+2bUs9slVahjUVvohxlD9MCpSMoU81XoysCk/6aSnw9RWRbFRKRdrSQ/PZ1pXlmtZtB5P4aMydTUD52M64eNxSsQJKjC9TpHwQ8dAkJTGhTL4vdLmPCPce3kXmuB7QZRcRERhtkE/r7hXyMDb8DjV5F49YE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=no7MgtZy; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="no7MgtZy"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E65FB1F0089B;
	Mon, 12 Oct 2026 19:08:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1791832109;
	bh=dbJ9MhQVlEF+aChWx+p1SXd0tniDqLz3oPllgNLSbsU=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=no7MgtZy7BXd1HSsWyuKWl1LHVr+tndDNjX8WYO0ZxsjBRczZZ7WQaBRaRdlVR2am
	 zjpEIsuk8K9GlHLd/aNH/3pksF+dCWIjprTseRWxNvjYWO+x7+Z1pOawcn9OnEKvZw
	 o/Nz7TIsIAmFv1zmo72pYqJN3wCTQiCwpqns2pr7iGxmyC8xM1/rjlsGEP/+Y68p/l
	 Kk2OdSeEIorkp1y+JpxLxAqbAsNuMbExGPBoD3p7sNoQW/SFT7OP+oPi1Db/sMTjwD
	 pYrNZgzjWkV5VFNNIU/mN6PqJtZHD5TJ5LKP6hnjOctoGYopFb1N94Zq1RyGYx107H
	 s8VUwZXwWIJDA==
Message-ID: <sashiko-outbox-168567@kernel.org>
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next] net/iucv: serialize HiperSockets receive with
 the socket lock
Reply-To: sashiko-reviews@lists.linux.dev
To: "Bryam Vargas" <hexlabsecurity@proton.me>
Cc: "Christian Borntraeger" <borntraeger@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
References: <20261011-b4-disp-410518f4-v1-1-753bf3258292@proton.me>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 12 Oct 2026 19:08:28 +0000
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] net/iucv: NULL pointer dereference in iucv_send_ctrl() due to race=
 with close()
--

commit 5321e38163a4ca2968c5ea02ef28664bf3a65a46
Author: Bryam Vargas <hexlabsecurity@proton.me>

net/iucv: serialize HiperSockets receive with the socket lock

This commit serializes the HiperSockets receive path and recvmsg() using the
socket lock. It introduces a per-socket backlog to defer frames while the
socket is owned by a user.

Link: https://lore.kernel.org/all/20260724222917.134769-1-hexlabsecurity@pr=
oton.me/

> diff --git a/net/iucv/af_iucv.c b/net/iucv/af_iucv.c
> index 5ba875798aa41..1fcb47a087551 100644
> --- a/net/iucv/af_iucv.c
> +++ b/net/iucv/af_iucv.c

[ ... ]

> @@ -374,26 +377,28 @@ static void iucv_sever_path(struct sock *sk, int wi=
th_user_data)
>  static int iucv_send_ctrl(struct sock *sk, u8 flags)
>  {
>  	struct iucv_sock *iucv =3D iucv_sk(sk);
> -	int err =3D 0;
>  	int blen;
>  	struct sk_buff *skb;
> -	u8 shutdown =3D 0;
> +	bool force;
> =20
>  	blen =3D sizeof(struct af_iucv_trans_hdr) +
>  	       LL_RESERVED_SPACE(iucv->hs_dev);

[Severity: High]
Can this code cause a regression by dereferencing a NULL iucv->hs_dev durin=
g a
concurrent close()?

If another thread concurrently calls close() on the socket,
__iucv_sock_close() runs under the socket lock and sets iucv->hs_dev to NUL=
L:

net/iucv/af_iucv.c:__iucv_sock_close() {
    ...
	if (iucv->hs_dev) {
		dev_put(iucv->hs_dev);
		iucv->hs_dev =3D NULL;
    ...
}

Meanwhile, afiucv_netdev_event() can asynchronously execute during netdev s=
tate
changes (such as NETDEV_GOING_DOWN) and call iucv_send_ctrl() without holdi=
ng
lock_sock(sk):

net/iucv/af_iucv.c:afiucv_netdev_event() {
    ...
				if (event =3D=3D NETDEV_GOING_DOWN)
					iucv_send_ctrl(sk, AF_IUCV_FLAG_FIN);
    ...
}

If this happens concurrently, evaluating LL_RESERVED_SPACE(iucv->hs_dev)
could dereference a NULL device pointer and cause a panic.

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20261011-b4-disp-41=
0518f4-v1-1-753bf3258292@proton.me?part=3D1
