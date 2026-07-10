Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 993333FB7E9
	for <linux-s390@vger.kernel.org>; Fri, 10 Jul 2026 09:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1783677388; cv=none; b=hGfg6Mxt8eCj1OgDRrK3yoGO+dK30TH/s9/TCDASObCKYWTCbl5P1SUGdOgL1FQ5ct9/6ZvWZ/NmM0Y17fGBHMj6G8OenPVju84Udl8RASUg+NivT6LX9zytfaFpOh3qQidUYLEh+Qp6rQb3QxqUjitiRdxPkUlj/aus5vT79NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1783677388; c=relaxed/simple;
	bh=TCmTuhtSI5A+XIt2RiJAYZ90/KofV+VQYVb93Kgdbzk=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=Y1kHloakVg7N66y2oq/3upqnc/aT6GouWtZbZl/9vVyPpfWYKJh+Wd0BE7Uv95jMt9Zqc/vR0cfDzPpOcVHlvQZl8Yrc+Rg/p1cScyBoYZBhrJFO/XUvk/SoLsLtCoTuL7QMAAlawpTGbSDVef4cOTlx0fjiejKU2MRzUVyk6JM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mXzQjiaa; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mXzQjiaa"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D434B1F000E9;
	Fri, 10 Jul 2026 09:56:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1783677387;
	bh=HiYU4MpDh1ijNW7p0m7hnJsDzRAubtREbIr/ITiaCGE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=mXzQjiaalvF1cx66Tw338WIMIHHV1JR1oxcG6SO2alRAoucyE+E211JsnoBgzmq8x
	 v53xxRqCYn1QC6ltQ5UnabOLf7W/dK267U0ffWJgAFiwHepBQtWoRkwRub/UjZ1ubZ
	 OTR2X5TByDZP2BpivywCbK5H4NOKThp3l3M4GRBwOd1rtjaUYVt12bCDV2HGZYx5hH
	 bCMUx7uPlfKgyo+oC9LBSX6qgmXmZUoqhUO0Of+oIpsLnwz4Zjyz6XojKZRFXoLVml
	 lSG7MePnlbvsX5loVjj/hMsyqPHXqQIiZmzU0vJpzneQ+aCNci32m7ccuLVF+0qqGt
	 mmIdtROkEpsCg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next 03/13] RDMA/core: Support renaming a device
 when changing its net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: mkoutny@suse.com, "Vasily Gorbik" <gor@linux.ibm.com>, hannes@cmpxchg.org, tj@kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260709095532.855647-4-jiri@resnulli.us>
References: <20260709095532.855647-1-jiri@resnulli.us>
 <20260709095532.855647-4-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 10 Jul 2026 09:56:26 +0000
Message-Id: <20260710095626.D434B1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The destination device name requested by userspace is ignored du=
ring a net namespace move because NULL is hardcoded in the netlink handler.
--

--- Patch [3]: [PATCH rdma-next 03/13] RDMA/core: Support renaming a device=
 when changing its net namespace ---
commit 481a893ec5cd10a7f8be8c8de249d86cc283c470
Author: Jiri Pirko <jiri@nvidia.com>

RDMA/core: Support renaming a device when changing its net namespace

This patch updates the RDMA core to allow requesting a destination device
name when moving a device to a different network namespace. It modifies
ib_device_set_netns_put to take a requested name and implements the naming
rules during namespace teardown.

> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 3a9ec43a16f1a..3540cb0b9d4fb 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1194,7 +1194,7 @@ static int nldev_set_doit(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
>  		u32 ns_fd;
> =20
>  		ns_fd =3D nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
> -		err =3D ib_device_set_netns_put(skb, device, ns_fd);
> +		err =3D ib_device_set_netns_put(skb, device, ns_fd, NULL);

[Severity: Medium]
Does this hardcode NULL instead of extracting and passing the user-provided
device name?

The commit message mentions allowing namespace moves to request a destinati=
on
device name, but it appears ib_device_set_netns_put is always called with
NULL here.

How does this interact with the rename logic in nldev_set_doit? If a user
supplies both the RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD
attributes in the netlink command, will the code enter the rename logic fir=
st
and return, completely skipping the net namespace change instead of moving =
and
renaming the device?

>  		if (err =3D=3D -EEXIST)
>  			NL_SET_ERR_MSG(extack,
>  				       "Device name already exists in the target net namespace");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260709095532.8556=
47-1-jiri@resnulli.us?part=3D3
