Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D127E47DFB3
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:30:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125846; cv=none; b=c5LekSVn+U5VfUXn5IYaaK1xKCKnVr0Q0E4rX0OWiwMX2yvM5WIeGAYf/FdBUh6JyNjZWPIvzadX1pzWkNcdV2BA907CsFdxNTzR2sAZVGwGmsEfg05tOCEDAtXCtewx51SWpek/MfhChMwgUMK/qU/DOAJdYrarW9kq/vfHG8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125846; c=relaxed/simple;
	bh=BcRdd2BIZZgZu5tLBaauX8kAn4pqJpY8leF0rhoNl6k=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=p5RFRaBvoEuERU2bbRwuIplzafAE3vt9msJPrYgd0PBmJ0AlQvIXLWZTUS9cAZ9FWpdJn/EL7p3v+cFsQMaRRamQlAGVfnyho3D1ilNTgZ/ztOK4xeg+BGqU+VJjGNgBLDAf1ApRrgdMT4PT5C4eYzPnGsptWFHlm/7v7acWgCs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=UJrnuHyJ; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="UJrnuHyJ"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E91711F000E9;
	Wed, 15 Jul 2026 14:30:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784125845;
	bh=mvYFp/Lt9u+PnKHMDrTQRq5bADZYeV8MA2npkPCncNs=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=UJrnuHyJF4ez9KvJqV1OAV+zRX13FUQbLBOfmOGwT8oC3JmN2nFmJYf88BWdkkb1j
	 dyuGDrQXo57pSaQUC2sq+NfZwvARolsgkOplyHBlNv36hWz7MnR63ezRoRYvUDG7LF
	 HtwtDaGqiK1VdANsEFwEPZYb+xu1BEt81GvaC+V9P9NE51QVwoRY8chcwL8E3z8s03
	 mOPG8BXZzvDaAASE76Tf6BCK7fAcliZKmRngxjzTLe6lYeafEKFPz+RFN1IoVPQiJd
	 6LzACqnMzuiHWpII7RTPmukvKkq3539KZT737CEdC/lqzQIClUujT5pyS1gguhS8Ra
	 TYP89JoFFBvjQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v2 11/14] RDMA/core: Make device names unique
 per net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260714142927.1298897-12-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-12-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:30:44 +0000
Message-Id: <20260715143044.E91711F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Format String Vulnerability / Arbitrary Memory Write
--

--- Patch [11]: [PATCH rdma-next v2 11/14] RDMA/core: Make device names uni=
que per net namespace ---
commit db3597c8065e66f96858593e01ba04bca7a7d075
Author: Jiri Pirko <jiri@nvidia.com>

RDMA/core: Make device names unique per net namespace

This commit updates RDMA device name lookups and index allocations to be
scoped within the relevant net namespace. It uses rdma_dev_access_netns()
to ensure name uniqueness per namespace while maintaining system-wide
behavior in shared mode.

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c

[ ... ]

> @@ -452,7 +457,7 @@ static int __alloc_name_id(struct net *net, const cha=
r *name,
>  	xa_for_each (&devices, index, device) {
>  		char buf[IB_DEVICE_NAME_MAX];
> =20
> -		if (device =3D=3D skip)
> +		if (device =3D=3D skip || !rdma_dev_access_netns(device, net))
>  			continue;
>  		if (sscanf(dev_name(&device->dev), name, &i) !=3D 1)
>  			continue;

[Severity: Critical]
This isn't a bug introduced by this patch, but is it possible that the
sscanf call here is vulnerable to a format string injection?

Since name can be user-supplied via the RDMA_NLDEV_CMD_NEWDEV netlink
command in nldev_newdev() and is copied without checking for '%' characters:

drivers/infiniband/core/nldev.c:nldev_newdev() {
        ...
        nla_strscpy(name, tb[RDMA_NLDEV_ATTR_DEV_NAME], sizeof(name));
        ...
}

The string is passed down through ib_register_device() and assign_name()
into __alloc_name_id(). Could a user with CAP_NET_ADMIN supply a malicious
format string containing format specifiers like %n?

If an attacker sets up a device with a matching prefix, sscanf would
parse the attacker's format string and write to memory addresses beyond
the supplied &i pointer.

Since CAP_NET_ADMIN can be acquired within a user namespace, could this
allow unprivileged local attackers to corrupt memory and trigger an
arbitrary memory write?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714142927.1298=
897-1-jiri@resnulli.us?part=3D11
