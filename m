Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A49BE311C2A
	for <linux-s390@vger.kernel.org>; Fri, 12 Jun 2026 10:21:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1781259713; cv=none; b=X/ijwqaJ+GTQS5IWB3AuMLSz9rJJVe1ReyCyHfSHWPfeHlOnMy9Csj3KQCgEc7Yp4NIBxZyefMDJ8k04hgNIlY2MLb2VazY3F3yZjLeNg3wd2DZz3GY1K5OJw9Nw5xsbICqjQ1N6EB0J15Nvm/oGLvrCwEX1KtrHkGaSbqHMvNA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1781259713; c=relaxed/simple;
	bh=dIUwTkPI6jWBJ++QosR80MbQU6dxh+KtgWH7sitw/uo=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=djFApqFf3kK4+ygNrUPdvgcAr5A3uGvSzNUyJt9hHNRdG1Koa2h0+lGZUZTk4b6PRXMStFqa/SQ590pXg5d3avP9TU8840cVlZ7HQMhaYK+j0DHxra7E2/5PO3DC19Uqf7TRtk75cN29wA7njwtEhGaIvIjjDXvCy6yGHnSMXJw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=EEBAUl4v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="EEBAUl4v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D782D1F000E9;
	Fri, 12 Jun 2026 10:21:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1781259712;
	bh=lwbBABVChMGBYIuEdctLXKNV02BwIAg20FGe/BKJ2ug=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=EEBAUl4vsPZRsw/ML30VCZkxay/VTR8Ae4VhJyO3Mt7A0gO0hCoGWob8Xp/ahtPWW
	 81hkjIURCSSdaGpVGjsc+YBhQM6ntSaaMED7/yQWN4aidyS5rd1UYciI4GBet5Fben
	 Iy6f2OKEdD/EGsb0vNhxz7ILYKvDw88P8AapzvjgWPr8vvQL11jHXK/ookq51gwUWO
	 zsr3sWWskmu2kiaqMRVB5zSXPY/6s00HI6q7qwBudxZW25BF9ZMO6jXJKX5LD3VmTk
	 2yBwsdNahxtLpcGPs6rizK7gKGteHbavDv3gP13ZVAT/7fNYkLiOQABHLO3OcKGqtO
	 RiwWVgdyFzH6g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net-next v2 1/2] tls: remove tls_toe and the related
 driver
Reply-To: sashiko-reviews@lists.linux.dev
To: "Sabrina Dubroca" <sd@queasysnail.net>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
References: <1f30e73275c07bf879f547589872d0916025a52e.1781165969.git.sd@queasysnail.net>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 12 Jun 2026 10:21:51 +0000
Message-Id: <20260612102151.D782D1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The cxgb4 driver continues to reserve MSI-X vectors and hardware=
 queues for inline TLS offload even though the chtls driver has been remove=
d.
--

commit fe56f0d87d512a0eea1f91c98873fd22553c6faf
Author: Sabrina Dubroca <sd@queasysnail.net>

tls: remove tls_toe and the related driver

This commit removes the tls_toe feature and its single user, the chelsio
chtls driver. These components have been unmaintained and bypass most of
the networking stack.

> diff --git a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c b/drivers/ne=
t/ethernet/chelsio/cxgb4/cxgb4_main.c
> index 6df98fca932f7..9e2c2fa16d7a5 100644
> --- a/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> +++ b/drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c
> @@ -6795,8 +6795,7 @@ static int init_one(struct pci_dev *pdev, const str=
uct pci_device_id *ent)
>  						   NETIF_F_TSO | NETIF_F_TSO6;
> =20
>  			netdev->hw_features |=3D NETIF_F_GSO_UDP_TUNNEL |
> -					       NETIF_F_GSO_UDP_TUNNEL_CSUM |
> -					       NETIF_F_HW_TLS_RECORD;
> +					       NETIF_F_GSO_UDP_TUNNEL_CSUM;

[Severity: Medium]
Since the chtls driver is being removed, should we also remove the=20
FW_CAPS_CONFIG_TLS_INLINE capability check in get_caps() within the same fi=
le?

drivers/net/ethernet/chelsio/cxgb4/cxgb4_main.c:get_caps() {
    ...
		if (ntohs(caps_cmd.cryptocaps) &
		    FW_CAPS_CONFIG_TLS_INLINE) {
			params[0] =3D FW_PARAM_PFVF(TLS_START);
			params[1] =3D FW_PARAM_PFVF(TLS_END);
			ret =3D t4_query_params(adap, adap->mbox, adap->pf, 0,
					      2, params, val);
			if (ret < 0)
				goto bye;
			adap->vres.key.start =3D val[0];
			adap->vres.key.size =3D val[1] - val[0] + 1;
			adap->num_uld +=3D 1;
		}
    ...
}

Leaving this check in place causes the driver to increment adap->num_uld wh=
en
the firmware advertises TLS inline offload. This unconditionally reserves M=
SI-X
vectors and offload queues in cfg_queues() for a ULD that no longer exists =
in
the kernel.

Does this waste hardware queues and MSI-X vectors, potentially reducing the
number of queues available for the main Ethernet interface?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/cover.1781165969.gi=
t.sd@queasysnail.net?part=3D1
