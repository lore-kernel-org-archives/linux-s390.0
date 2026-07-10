Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6EE663FADFA
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677390; cv=none; b=aDk1jbYDmqFm+WbHylOUjLSwldEHtCt7eUSTT2uY7OSYtxaNj8K4YHOkdPrtrJ6DV1A16kRXCjLli4p9oU2R/bF4k6+pTo0XO9NuZR9hMJ+3hdWTBHW2NbAc+iSY8x1qkg+ORQEJzYS912iLgl6c5Yzy2i8qWqieXmfUqTvj2xk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677390; c=relaxed/simple;
	bh=M9UOYVjaLELdO6vZLE1rwBaV6cHLQm2foWyPSLmIQz4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=ZklPVbqk1kDYdSfSwKpo2lqMFlyLCsRkFSvryO4iudBRZkfnOUM0WEFhH1/jVDtZXC/HmJEY9xDghtdCcsNwsJ/asuoumtqGnG+EvY7GrNmr2tw6J5Y+RwMLWVUHNOk/HZIgJKMyBAzYk6CpFDXaUTLRzwDy3zoqp9U3PLPZc7w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ahKQ9Qeh; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ahKQ9Qeh"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5FB51F000E9;
	Fri, 10 Jul 2026 09:56:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677389;
	bh=Lu3Dw7S4N5dN9qduy1G4LT0MptxmX99WltWUegvnOKI=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=ahKQ9QehRcG/H+IDNCGHrR6aIh/WAMKTox8VaZnxTuNkkJVuS5/aM4T5Mf4iAQGHD
	 EVHkHW/yVRYypkv8OXeSBNSBHqFjcndgURVEhK/6HM8QBPitPjsfL0hM50XlIuFVYS
	 T2+mOeeGpdb3wFNHONI6p45HxB1IsAcUvNW8uuUhejfpH7CvFztXJvqM8Xx0gyXTtT
	 MwcVRyorPGOiOlJnMkTbign9UTEmpKmhndhiybahQrfB3LsW5RL/PBmtQOaLwTGL3B
	 b9+2rtvvrULp3TjCjdU9QPT1LBeSw9b2p4yAY11bPdBGX06WzyjWh3Q+EnRw7oIx5K
	 e9ei5sGKNizyg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 06/13] net/smc: Look up the pnetid ib device
 within the net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260709095532.855647-7-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-7-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:28 +0000
Message-Id: <20260710095628.C5FB51F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Pre-existing TOCTOU and Use-After-Free race where `smc_pnet_find_i=
b()` and `smc_pnet_find_smcd()` return un-refcounted device pointers.
- [High] Pre-existing Use-After-Free during SMC connection setup due to un-=
refcounted `ib_dev` pointer in `smc_init_info`.
--

--- Patch [6]: [PATCH rdma-next 06/13] net/smc: Look up the pnetid ib devic=
e within the net namespace ---
commit d209b8afd09f2213c9477f5a717fdf012a7c2077
Author: Jiri Pirko <jiri@resnulli.us>

net/smc: Look up the pnetid ib device within the net namespace

This commit scopes smc_pnet_find_ib() to the caller's net namespace. It
ensures that pnetid setup cannot bind to a same-named RDMA device from
another namespace.

> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 63e286e2dfaa8..ff9c9c35cc2f5 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
> @@ -304,13 +304,18 @@ static bool smc_pnetid_valid(const char *pnet_name,=
 char *pnetid)
>  	return true;
>  }
> =20
> -/* Find an infiniband device by a given name. The device might not exist=
. */
> -static struct smc_ib_device *smc_pnet_find_ib(char *ib_name)
> +/*
> + * Find an infiniband device by a given name, restricted to the devices
> + * accessible from @net. The device might not exist.
> + */
> +static struct smc_ib_device *smc_pnet_find_ib(struct net *net, char *ib_=
name)
>  {
>  	struct smc_ib_device *ibdev;
> =20
>  	mutex_lock(&smc_ib_devices.mutex);
>  	list_for_each_entry(ibdev, &smc_ib_devices.list, list) {
> +		if (!rdma_dev_access_netns(ibdev->ibdev, net))
> +			continue;

[ ... ]

> @@ -419,7 +424,7 @@ static int smc_pnet_add_ib(struct smc_pnettable *pnet=
table, char *ib_name,
>  	bool new_ibdev;
> =20
>  	/* try to apply the pnetid to active devices */
> -	ib_dev =3D smc_pnet_find_ib(ib_name);
> +	ib_dev =3D smc_pnet_find_ib(net, ib_name);
>  	if (ib_dev) {
>  		ibdev_applied =3D smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
>  		if (ibdev_applied)

[Severity: High]
This isn't a bug introduced by this patch, but smc_pnet_find_ib() in
net/smc/smc_pnet.c appears to return an un-refcounted device pointer.

If a user configures a PNETID for an IB or SMCD device via netlink and calls
smc_pnet_add_ib(), it locates the device in the global list while holding
smc_ib_devices.mutex. However, smc_pnet_find_ib() returns the raw pointer
after dropping the mutex.

If the device is concurrently hot-unplugged, smc_ib_remove_dev() or
smcd_unregister_dev() will acquire the mutex, remove the device from the
list, and kfree() the device structure.

Could the original netlink thread then continue execution and dereference t=
he
now-freed pointer inside smc_pnet_apply_ib() or when printing
ib_dev->ibdev->name?

[Severity: High]
This is another pre-existing issue in net/smc/smc_pnet.c related to
un-refcounted pointers, but it happens during connection setup.

When a user calls connect() on an AF_SMC socket,
_smc_pnet_find_roce_by_pnetid() locates an active IB device while holding
smc_ib_devices.mutex, and stores its pointer in the smc_init_info structure
(ini->ib_dev) before dropping the mutex.

Connection establishment then continues across multiple function calls:
smc_find_proposal_devices() -> smc_connect_rdma() -> smc_conn_create()
using this un-refcounted pointer.

If the IB device is concurrently hot-unplugged, smc_ib_remove_dev() will
kfree() the device. Might the connection setup path then dereference the
freed memory?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D6
