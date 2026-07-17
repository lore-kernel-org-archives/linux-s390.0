Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 493403F8ECA
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:24:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294666; cv=none; b=jaCTwJMyonu8E37Kt4OuRI9yiHU1vrplEZGuYLUzxSGfKFre/75L1Js9k4hhfQyoJ3rjxAJ0c09OnqVZsYT3lzqxOJ2vq1SZPi+GG72lvyMtHacQnFsrBcN+3mTUxsfFenI9uF83qTQIdU9m2bxewxU5FeCmj+dBt1GLaGAwfRw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294666; c=relaxed/simple;
	bh=0jmAhDrvqM31abTs7GscUaBMtDUlDtrcxoIPMkI8Org=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=lbA6l6wlNKQH5CRM3bSRZljNAgVnl7SrGwrYrbNoKQSbUK9z1sMh+7HZe72QB3PoLnyoDsKsMOz4nUo9vGguk7Epc6sZcknYNXAfFyzHWhMK/QTfx17O3cESDYmQrhhalvit4MnLKzzgBsXZLZX6d2g+Gob7DrDkvu2QskBBSXU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=AuTMM0F4; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="AuTMM0F4"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DD4661F000E9;
	Fri, 17 Jul 2026 13:24:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294665;
	bh=j+6F8g4eR18DVm75xh0u7zbwImdkx00r6YdToILSF7Y=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=AuTMM0F45PxHyjRJvQgHUOgpt7vNt5utHTofMQIhQ5zJMk0nLfjIdv26RmzAGPzrf
	 1GMsjrofFPYUjJojuBxgzsha/mPBFNByBx6d8WMnPDrS6DJZruGafVGd9GEUYGXU45
	 F2SbcQsSUue8XuXABEX5KUBp3r2edGhV4MXcQGh7MK2ywA4JfTpgVA/aziTJUPWg1M
	 gAk/YoWnYCTDeB8RYLSwIKrfes1RmknEH34EonzCgYexveWcTyyqMYN/gZFDvQennD
	 Or1pNN2xivauzry20ZJMpU+9JTg5+laJr0i3KncfQOy1QnErpA7u6oXn65DXHbkKAq
	 ZXhC4DM80ioTw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v3 02/14] RDMA/core: Handle device name
 conflicts when changing net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Heiko Carstens" <hca@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com, hannes@cmpxchg.org, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260716132316.1495242-3-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-3-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:24 +0000
Message-Id: <20260717132424.DD4661F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Skipping device_rename() during namespace teardown fallback leaves=
 the sysfs kobject tagged with a dying namespace, leading to Use-After-Free.
--

--- Patch [2]: [PATCH rdma-next v3 02/14] RDMA/core: Handle device name con=
flicts when changing net namespace ---
commit 8e5328bda494a60bcfbc9c96c81fb95f503e0fdd
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/core: Handle device name conflicts when changing net namespace
   =20
Prepare namespace moves for per-netns names. Check user-initiated moves for
destination-name conflicts before disabling the device, keep same-netns
moves as no-ops, and make teardown moves detach from the exiting namespace
even if fallback naming fails.

> diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/d=
evice.c
> index de610f52c9b23..b55fb075d0aef 100644
> --- a/drivers/infiniband/core/device.c
> +++ b/drivers/infiniband/core/device.c
[ ... ]
> @@ -1704,30 +1778,63 @@ static int rdma_dev_change_netns(struct ib_device=
 *device, struct net *cur_net,
>  		goto out;
>  	}
> =20
[ ... ]
>  	/*
> -	 * At this point no one can be using the device, so it is safe to
> -	 * change the namespace.
> +	 * Recompute the destination name under the write side of devices_rwsem
> +	 * now that the device is disabled, closing races with a concurrent
> +	 * registration or rename, then publish the new namespace at the sysfs
> +	 * level.
>  	 */
> -	write_pnet(&device->coredev.rdma_net, net);
> +	down_write(&devices_rwsem);
> +	ret =3D rdma_dev_pick_netns_name(device, net, fallback_pattern, buf,
> +				       sizeof(buf), &new_name);
> +	if (ret) {
> +		if (fallback_pattern) {
> +			WARN(1,
> +			     "%s: failed to pick device name during namespace teardown: %d\n",
> +			     __func__, ret);
> +			write_pnet(&device->coredev.rdma_net, net);
> +			ret =3D 0;
> +		}
> +		goto rename_done;
> +	}
> =20
> -	down_read(&devices_rwsem);
> -	/*
> -	 * Currently rdma devices are system wide unique. So the device name
> -	 * is guaranteed free in the new namespace. Publish the new namespace
> -	 * at the sysfs level.
> -	 */
> -	ret =3D device_rename(&device->dev, dev_name(&device->dev));
> -	up_read(&devices_rwsem);
> +	write_pnet(&device->coredev.rdma_net, net);
> +	ret =3D device_rename(&device->dev, new_name);
>  	if (ret) {
> -		dev_warn(&device->dev,
> -			 "%s: Couldn't rename device after namespace change\n",
> -			 __func__);
> -		/* Try and put things back and re-enable the device */
> -		write_pnet(&device->coredev.rdma_net, cur_net);
> +		if (fallback_pattern) {
> +			WARN(1,
> +			     "%s: failed to rename device during namespace teardown: %d\n",
> +			     __func__, ret);
> +			ret =3D 0;
> +		} else {

[Severity: High]
This isn't a bug introduced by this patch, but does skipping device_rename()
during namespace teardown fallback leave the sysfs kobject tagged with a dy=
ing
namespace?

If rdma_dev_pick_netns_name() fails and the code jumps to rename_done, or if
device_rename() fails and the error is suppressed by setting ret =3D 0, the
kernfs_node->ns tag for the device's sysfs directory would appear to remain
pointing to the dying network namespace.

Once the network namespace is freed, couldn't a subsequent sysfs traversal =
or
lookup calling kernfs_ns_id(kn->ns) dereference the freed pointer and result
in a use-after-free?

> +			dev_warn(&device->dev,
> +				 "%s: Couldn't rename device after namespace change\n",
> +				 __func__);
> +			/* Try and put things back and re-enable the device */
> +			write_pnet(&device->coredev.rdma_net, cur_net);
> +		}
> +	} else {
> +		strscpy(device->name, dev_name(&device->dev),
> +			IB_DEVICE_NAME_MAX);
>  	}
> +rename_done:
> +	up_write(&devices_rwsem);
> =20
>  	ret2 =3D enable_device_and_get(device);
>  	if (ret2) {

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132316.1495=
242-1-jiri@resnulli.us?part=3D2
