Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D11283FDBE5
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:24:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294669; cv=none; b=lj0d8aqoFNByWsQ6UrgWWEwMPJBhIfc6FM65OSFzhbdDUd3NdkGetiGBnvXiEqTbSq8IkPsj+ynrsqCPvyefIUXV26UvuQOehbba/ppdeLJ/00VnyZPsBRP8MItVzulfxPy65WPQ8FZ7dB5wYJ3EG1W3eymYPcYAaRvXVx/MXMc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294669; c=relaxed/simple;
	bh=nZPVxLB188AS9HSR0MfptTZk2T6PVDKhptoVeckJp/E=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=UdfLTiofL65z4e1hov/z/McW1zX6CHBtyvJC7mGqAOe0E7Hn1Ce6i+A4jGUV27B1RQStkJyniAH1o2ahZcRTujmeYxXAjcwOS0CFCAZrAukEx0kuJjogzWk+K6uzVvOLl8sSLQiNxTXBLn+s0jpbfK8InmzOLlybMaV4ifQdmuw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=myQk+TZK; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="myQk+TZK"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 686441F00A3A;
	Fri, 17 Jul 2026 13:24:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294668;
	bh=gDYKjXOBxWRpOrGKbbQGT/Vsg1mu6+oHvtcYGr47wLQ=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=myQk+TZKLn03pL3hyHzF3Mg1qoNk+eSGbPwsbH1KE/x7nODj0k2EgHnT0OzykhfeO
	 pA/vwiAe+m0c/GKKDyTEPTzSctzKfbTzqism1GcbDsPNDAysDN82mGMSdvlFvakEAu
	 P7bLATyBw3tETVRWc7h+HXf+b/IfDd/NyZA8gfB5YUBP08eFnXZXKFjESuxs6jHili
	 rjMkjxVqHDxBnhQS/qbwcjLhw3DoT0nj63nYTOcrUcZXNPpwIp5cAMZ0xnh4ENbDD5
	 eUbKN15nTkh5ZFKcZy+/z9muGadWNxzSyV8sSNhr18LoqqBUYq+yukbf/I+pl6Drbq
	 mPB3MWW/sHc2Q==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v3 03/14] RDMA/core: Support renaming a device
 when changing its net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: tj@kernel.org, linux-s390@vger.kernel.org, "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander
 Gordeev" <agordeev@linux.ibm.com>, hannes@cmpxchg.org, mkoutny@suse.com, "Heiko
 Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260716132316.1495242-4-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-4-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:28 +0000
Message-Id: <20260717132428.686441F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [Medium] The netlink handler fails to pass the requested device name to `=
ib_device_set_netns_put` during a network namespace change, and ignores nam=
espace moves entirely if a rename is also requested.
--

--- Patch [3]: [PATCH rdma-next v3 03/14] RDMA/core: Support renaming a dev=
ice when changing its net namespace ---
commit 65e19be4bcb60d41b06e567081d99cee8fd2722c
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/core: Support renaming a device when changing its net namespace

This commit adds support for renaming a device at the same time it is moved
to a new network namespace. It allows namespace moves to request a specific
destination device name, falling back to a trusted kernel-controlled pattern
if none is provided.

> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 32b6c4d68ca0a..77a7580801486 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1195,7 +1195,7 @@ static int nldev_set_doit(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
>  		u32 ns_fd;
> =20
>  		ns_fd =3D nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
> -		err =3D ib_device_set_netns_put(skb, device, ns_fd);
> +		err =3D ib_device_set_netns_put(skb, device, ns_fd, NULL);

[Severity: Medium]
Does this hardcoded NULL prevent the core feature from being reached?

It appears the newly added name parameter in ib_device_set_netns_put() is=20
never populated with the requested device name from the netlink attributes=
=20
in nldev_set_doit().=20

If a user provides both RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD,
the rename-during-move functionality cannot be used. Additionally, if the
name attribute is parsed in a separate block, the function appears to take
an early exit path, bypassing the namespace move entirely.

Could this be updated to properly process both attributes and pass the
requested device name during the move?

>  		if (err =3D=3D -EEXIST)
>  			NL_SET_ERR_MSG(extack,
>  				       "Device name already exists in the target net namespace");

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132316.1495=
242-1-jiri@resnulli.us?part=3D3
