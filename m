Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B00B47B434
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125845; cv=none; b=iRnyebFX6pDiHAc8QW/hkG7dJFRUo8t4ppYwm1/H1QSPXbxjFFZH+nkW6klk7WlIyuW4Nn9hC4+X+yeVzNOY7hnXn4LdbodeT+D8dGdX5oz0INv7ok+j7cpcdtY9EmuW92EcXYyEq1ULMHZSEFbWiT+fEM3CfVJal+LnFUqDSfA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125845; c=relaxed/simple;
	bh=QlQv4G2fXaxZtPtimAu0QarqZU8B0wfrrHspyeWpF48=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Clb7hTBLR3sY4wi1hOaWU4k5NppRsuyIFnwUGUafTgCEnY/C6sJmoMZ/0jdz3AgFfHOps7HCeyaXPvI7HftyaxXkDugt4jj7HsEk79qXi8r55mciwblimFzb67GZNUX9VNnAPY1NguoMs4zGiQbbzIcVaFg1CaKt1nv+2Le/3Cs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=d3sbkvMf; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="d3sbkvMf"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F3CC1F00A3A;
	Wed, 15 Jul 2026 14:30:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784125844;
	bh=/8b1xTutgzGkyelNDGZgZE1FdczQ0uoEh+PGfOSjt80=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=d3sbkvMfZ3gbsFmdlitNEuR3Gv44eDHHiOJKXrlgMUTs7hai7OKlKLc3Umd+spwFU
	 90d9Ahuy5F8NRxWM6kGEGT9iX9qa40FPYHTrbduL4Oq1jsQbWU2GinN9H0KFq6rykR
	 vPhuLy4TpQv1hqMLXgESmQ0vV+jUJFZt8BITpSVr7JmelHYqoS41HRVdKHhQWWda4i
	 RSTU5A0Zir5Mw1vSnemOnPfiT4/Q/xrvapxqWbuN4y71cyTe/5ipDnCPrMIK1C/vOc
	 MOvzGb2GtSia61DaqoiYr50H0wLb38zveUmXH/KF0YlgUikzF6aR9tRDAwVyo+ePUL
	 DHIo+NOiCsiWA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v2 06/14] net/smc: Look up the pnetid ib
 device within the net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, hannes@cmpxchg.org, mkoutny@suse.com, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714142927.1298897-7-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-7-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:30:42 +0000
Message-Id: <20260715143043.4F3CC1F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Returning unreferenced device pointers from `smc_pnet_find_ib()` a=
nd `smc_pnet_find_smcd()` causes Use-After-Free vulnerabilities when device=
s are concurrently removed.
--

--- Patch [6]: [PATCH rdma-next v2 06/14] net/smc: Look up the pnetid ib de=
vice within the net namespace ---
commit 4529cf06709604767797679d2d489bb89001f950
Author: Jiri Pirko <jiri@nvidia.com>
Date:   Tue Jul 14 14:29:19 2026 +0000

    net/smc: Look up the pnetid ib device within the net namespace
   =20
    Scope smc_pnet_find_ib() to the caller's net namespace so pnetid setup
    cannot bind to a same-named RDMA device from another namespace once nam=
es
    become per-netns.

> diff --git a/net/smc/smc_pnet.c b/net/smc/smc_pnet.c
> index 63e286e2dfaa8..ff9c9c35cc2f5 100644
> --- a/net/smc/smc_pnet.c
> +++ b/net/smc/smc_pnet.c
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

[Severity: High]
This is a pre-existing issue, but can this lead to a use-after-free?

Looking at smc_pnet_find_ib(), it searches for an IB device while holding
smc_ib_devices.mutex, finds one, drops the lock, and returns a raw,
unreferenced ibdev pointer:

net/smc/smc_pnet.c:smc_pnet_find_ib() {
    ...
    mutex_unlock(&smc_ib_devices.mutex);
    return ibdev;
}

If an asynchronous device unregistration occurs immediately after the lock =
is
dropped, smc_ib_remove_dev() could acquire the mutex, remove the device from
the list, and free the smc_ib_device structure.

The caller (smc_pnet_add_ib) then dereferences the freed pointer locklessly
(e.g., when accessing ib_dev->ibdev->name for logging) or passes it to
smc_pnet_apply_ib(), which re-acquires the mutex and accesses fields of the
potentially freed device pointer.

Should smc_pnet_find_ib() take a reference on the device before dropping the
mutex?

>  	if (ib_dev) {
>  		ibdev_applied =3D smc_pnet_apply_ib(ib_dev, ib_port, pnet_name);
>  		if (ibdev_applied)

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714142927.1298=
897-1-jiri@resnulli.us?part=3D6
