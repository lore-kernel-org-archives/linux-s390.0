Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 42D3C3998B1
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294669; cv=none; b=gI6lPYxQLWs4yC3plCDdqqZApXWAeYjScqtmh1sl37VqjqbjR+2bEf87kSKo5NdYSH0OPrbyAHUlOYRtSLeyFSa4DYG9HYLSmy5uOnJd+q4r7EoBlznaXppekSdYUJnhm2sMbEf5U46MooQu8ynIAwQokFiu3zB2iLgQQLLdqqA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294669; c=relaxed/simple;
	bh=WNxEfunE5Vce9oXBwbuFMsLWzn8URobOOi5mNzlMVDg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=n40KMKuBnCtaHb4DpP/7BKwY4c3zl3FNG2M+4LrQXopePmkgssxpUXdHeTZaK4yzQaDLbgA0sWYQt2hHpEl3EMKeciP6fxJgro5c6Xa/y/tZcY6QnccOPCiupCRPkodQL0sfFB5ObrgAP+yyKEou+x5dCwzD5jvqH5P2g2E8HMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=oyfAALFU; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="oyfAALFU"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 82BA81F000E9;
	Fri, 17 Jul 2026 13:24:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294668;
	bh=zrhMimYvLsZpswdFVTQdA8lBK+iV4PtFtUBjg19/Pxo=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=oyfAALFUu3c/xUQiVZQFCMwTOkmreRk8rzX9IrsbVwGQkxpR+8KymkgYCVuiTPIZd
	 TxomPRFXlN61UVKUBcb4Z40NcSjVf+lFfsh4U4bSjOe4/Fbua4kgR4HOKqZhSEZl68
	 EsveEa2Eh5by659/qI+njVlc2kmoQg/+z+yQM0S7Ag57F/B9zk02o0k7PTYoMUeHVE
	 rekmp9nDxV590xj3tM7kt+Nu1LL6IiK0eXuv1GN+Ks41IgUcEqeljyrS39fhLDkXRs
	 4wnSoiXzX5SHL2y3sWdozumsVMJxcmgNNOkG+bqUybsq+CTBKFlIkl1A5GBYljdSOt
	 HDQnvcCu1162A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v3 06/14] net/smc: Look up the pnetid ib
 device within the net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, hannes@cmpxchg.org, mkoutny@suse.com, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260716132316.1495242-7-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-7-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:27 +0000
Message-Id: <20260717132427.82BA81F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] `smc_pnet_find_ib()` and `smc_pnet_find_smcd()` return unrefer=
enced pointers leading to a Use-After-Free during concurrent device removal.
--

--- Patch [6]: [PATCH rdma-next v3 06/14] net/smc: Look up the pnetid ib de=
vice within the net namespace ---
commit 22bac16fe9606993a05fb72609386eb7b37fed92
Author: Jiri Pirko <jiri@resnulli.us>

net/smc: Look up the pnetid ib device within the net namespace

Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
cannot bind to a same-named RDMA device from another namespace once names
become per-netns.

> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 63e286e2dfaa8..ff9c9c35cc2f5 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c

[ ... ]

> @@ -408,8 +413,8 @@ static int smc_pnet_add_eth(struct smc_pnettable *pne=
ttable, struct net *net,
>  	return rc;
>  }
> =20
> -static int smc_pnet_add_ib(struct smc_pnettable *pnettable, char *ib_nam=
e,
> -			   u8 ib_port, char *pnet_name)
> +static int smc_pnet_add_ib(struct smc_pnettable *pnettable, struct net *=
net,
> +			   char *ib_name, u8 ib_port, char *pnet_name)
>  {
>  	struct smc_pnetentry *tmp_pe, *new_pe;
>  	struct smc_ib_device *ib_dev;
> @@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnet=
table, char *ib_name,
>  	bool new_ibdev;
> =20
>  	/* try to apply the pnetid to active devices */
> -	ib_dev =3D smc_pnet_find_ib(ib_name);
> +	ib_dev =3D smc_pnet_find_ib(net, ib_name);

[Severity: Critical]
This isn't a bug introduced by this patch, but does returning an unreferenc=
ed
pointer from smc_pnet_find_ib() create a use-after-free window?

Looking at smc_pnet_find_ib(), the function holds smc_ib_devices.mutex while
finding the device, but then drops the lock and returns the raw ibdev point=
er:

net/smc/smc_pnet.c:smc_pnet_find_ib() {
    ...
    out:
        mutex_unlock(&smc_ib_devices.mutex);
        return ibdev;
}

If a concurrent device removal path acquires the mutex, removes the device
from the list, and frees the struct smc_ib_device via kfree(), could the
netlink thread subsequently dereference the freed pointer?

>  	if (ib_dev) {
>  		ibdev_applied =3D smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
>  		if (ibdev_applied)

For example, smc_pnet_apply_ib() re-acquires the mutex and writes to
ib_dev->pnetid, and the caller then reads ib_dev->ibdev->name for logging.

Does this same unreferenced pointer pattern also affect smc_pnet_find_smcd()
when it is called immediately after?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132316.1495=
242-1-jiri@resnulli.us?part=3D6
