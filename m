Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5BC83E2AA1
	for <linux-s390@vger.kernel.org>; Sun, 13 Sep 2026 13:50:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1789307449; cv=none; b=C+18eHwqVh7/4FHEikHp0SvRCURy/L1u44wmAoqJH17pSC8H5FHbfGPZX46xEV2pTqwXEtGBJpqJb1X5IRcUSkBCfvOJqeF6nN+B+y70TSS1l7Vwm+M+ioGp0aVmbJ0y9WYs27Xff9ssM5b3ooI+7UkuqLwrw0jg+vWp4AxGwo8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1789307449; c=relaxed/simple;
	bh=5BP1ImwpVMaAVzFUmRvqYWylGwoIYm74cTVzMRgJyxo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=QRHcUqyGmVCpuDvJGTazAME060fl5p3VN67oNf+iUf8yC3zXK/KCJBrTKdmxw5kl6KgrxwMHgDYo276mnU/kt3Nq00/IOwn+GUAJBQVGE5Y+y2Q9Uf7vsDWH564dyLIBhrBwp65e75yERGqZWXhrPX/zkVWzLv3+L1Osid7Nu+E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=MjdIiel1; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="MjdIiel1"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4529C1F00893;
	Sun, 13 Sep 2026 13:50:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1789307448;
	bh=WBQPKmSKEDyO0PwWqoVYc9ChuKjIiu8rQPhFSLyfHfY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=MjdIiel1CP7/vgJt4x5/INb4FzF4HyzwneMsNfXybmoeJ4AY7hIp0tmJPz19QD0wA
	 O3mAeAmN595Vzw7BGKmYXv3hhnj1OC1SN9G3gz0qMrNTvHfZZYsy9K5gbBUOzb2DGW
	 hPDwiL2gIfwIQwNSY5DBlMm+qWkPB9RzoiQOpE1ZghrH/J55K5PpXGNRYbG5Xw5vcx
	 XxrLLfDiuJt89O24swHZyEf0jFbZfA4qa1eK9oAOYEMKhS5xz+CcSFql8UZmGQIj97
	 ANwe8T2iXtdoKDbxyyCv8LteHc9ugdFzZdjceGXH/hy1a64hNFDBnHpXCAhxdmeyKK
	 /SBI/gwkbSSEQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 2/2] net: bridge: fail link info that does
 not fit the IFLA_AF_SPEC nest
Reply-To: sashiko-reviews@lists.linux.dev
To: "Artem Lytkin" <iprintercanon@gmail.com>
Cc: linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>
In-Reply-To: <20260912135022.1701-3-iprintercanon@gmail.com>
References: <20260912135022.1701-1-iprintercanon@gmail.com>
 <20260912135022.1701-3-iprintercanon@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 13 Sep 2026 13:50:47 +0000
Message-Id: <20260913135048.4529C1F00893@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] br_info_notify() propagates -E2BIG to rtnl_set_sk_err(), bypassing=
 NETLINK_NO_ENOBUFS and breaking listeners.
--

commit 9b1aaa64ff49b7a437b098d6d662cc77e1219f4b
Author: Artem Lytkin <iprintercanon@gmail.com>

net: bridge: fail link info that does not fit the IFLA_AF_SPEC nest

br_fill_ifinfo() puts all of a port's VLAN, tunnel and MST entries into
one nest, and nla_len is a u16, so a large enough port produces a nest
whose length wraps and userspace reads garbage.

Cancel the message and return -E2BIG with an extack pointing at
RTM_GETVLAN instead. The dump retries the port with an empty skb and
the error goes to userspace; notifications reach rtnl_set_sk_err() and
listeners resync. Not -EMSGSIZE, since no bigger buffer would help.

> diff --git a/net/bridge/br_netlink.c b/net/bridge/br_netlink.c
> index 855a46aec3a89..53676df9e4d11 100644
> --- a/net/bridge/br_netlink.c
> +++ b/net/bridge/br_netlink.c
[ ... ]
> @@ -654,7 +660,8 @@ void br_info_notify(int event, const struct net_bridg=
e *br,
>  	if (skb =3D=3D NULL)
>  		goto errout;
> =20
> -	err =3D br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false);
> +	err =3D br_fill_ifinfo(skb, port, 0, 0, event, 0, filter, dev, false,
> +			     NULL);
>  	if (err < 0) {
>  		/* -EMSGSIZE implies BUG in br_nlmsg_size() */
>  		WARN_ON(err =3D=3D -EMSGSIZE);

[Severity: High]
The commit message states "notifications reach rtnl_set_sk_err() and
listeners resync." Could this approach introduce a regression where -E2BIG
is broadcasted to netlink listeners instead of being filtered?

When br_fill_ifinfo() returns -E2BIG due to adding many VLANs to a bridge
port, br_info_notify() will jump to the errout label and pass the error to
rtnl_set_sk_err():

errout:
	rtnl_set_sk_err(net, RTNLGRP_LINK, err);

Passing -E2BIG here bypasses the NETLINK_NO_ENOBUFS socket option which
only filters ENOBUFS. Will this unhandled E2BIG error cause network
management daemons to crash or drop connections?

Might this lead to a system-wide denial of service if unprivileged users
trigger this path?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260912135022.1701=
-1-iprintercanon@gmail.com?part=3D2
