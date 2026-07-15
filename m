Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DAC1647DD40
	for <linux-s390@vger.kernel.org>; Wed, 15 Jul 2026 14:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784125844; cv=none; b=BWkAVEmNTyVYxd+IzqAyQ/K8hDZhaw3SgUvhJAUdUa+EhUM78K6ZmGHQpHGfFv8WzVRibzyjkP1sTLs4RvMEIktdvLAcAyn439GKnnCaryi7XS/9Wex7R07ZkqbaUUBPW4sL1sQN8Zmvlhdwr8P8JpW8c8f2/G+NM4y4H/LjAbM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784125844; c=relaxed/simple;
	bh=teXkzPywQyl7C1tqgfUM8/NSPAyVjOlaIZs5zDAx+Dg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YjOwO9WG3EcKjLpd8Pdh2ZtwVXSrhLEkWgR+3AFl7ASqM43cpSFJAwMGVC/tDfDdBUrdqvy5dz988VxcL5dhBN0gqmGrNqaxKIJlo7X8csOl+YGWE44zEKgPg0GAynFN0Q7eKBin/tCj5Jw6uoovKytP4ZKkvslYRkBmZALi1GI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=k9gd1pu0; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="k9gd1pu0"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A46771F000E9;
	Wed, 15 Jul 2026 14:30:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784125842;
	bh=5yuTusAnq9di8D+nScnNevtnfjboAzmi9xfkgp5i6Bg=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=k9gd1pu0mt9NNr7bUKOvp0XNT3sjhbRJ0/4hLc3gqBftJmScEfuLK2aiTGMS5R1y+
	 Drqg9EDIBrmGCupuMbIXIS37iC6kaIRgdseHHHBUoEKL5BzMndeFaAMI4mJBSAKdna
	 7pCPiecdmUM3elKdU9tkEbDs2h181ipCuordlcJ4QEmWNAJ4+T51r2syykunY3Czxm
	 Aum/yJ5QAUFexLrydZ4rYJ/hFvzU3Af8Xaye/XWK4qgPLrcRW3ZZ1choPNweATQi/N
	 r38cMe1agorJqdzwMapnqMZV3K8N5WgYEoY2TNubGv428XNqacZPbi2cFyR8H151Ay
	 kmJM1l8QOaF5A==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v2 03/14] RDMA/core: Support renaming a device
 when changing its net namespace
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: hannes@cmpxchg.org, "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, tj@kernel.org, mkoutny@suse.com
In-Reply-To: <20260714142927.1298897-4-jiri@resnulli.us>
References: <20260714142927.1298897-1-jiri@resnulli.us>
 <20260714142927.1298897-4-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 15 Jul 2026 14:30:37 +0000
Message-Id: <20260715143041.A46771F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] Unreachable feature and silent failure in netlink handler for RDMA=
 namespace moves
--

--- Patch [3]: [PATCH rdma-next v2 03/14] RDMA/core: Support renaming a dev=
ice when changing its net namespace ---
commit 4056da04c986796c81666352d7fa9e90d5591d4e
Author: Jiri Pirko <jiri@nvidia.com>

RDMA/core: Support renaming a device when changing its net namespace

This commit introduces support for renaming an RDMA device when moving
it to a new network namespace. It preserves the literal-name path for
user requests and keeps the fallback naming on the teardown path.

> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 32b6c4d68ca0a..77a7580801486 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
[ ... ]
> @@ -1195,7 +1195,7 @@ static int nldev_set_doit(struct sk_buff *skb, stru=
ct nlmsghdr *nlh,
>  		u32 ns_fd;
> =20
>  		ns_fd =3D nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
> -		err =3D ib_device_set_netns_put(skb, device, ns_fd);
> +		err =3D ib_device_set_netns_put(skb, device, ns_fd, NULL);

[Severity: High]
Does hardcoding NULL here make the newly introduced naming feature
unreachable from user space?

If a user space application sends an RDMA_NLDEV_CMD_SET netlink message
containing both RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD,
nldev_set_doit() appears to hardcode NULL for the destination name instead
of extracting and passing the requested name to ib_device_set_netns_put().

Additionally, if the RDMA_NLDEV_ATTR_DEV_NAME attribute is processed
separately in nldev_set_doit():

    if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
        ...
        err =3D ib_device_rename(device, name);
        goto done;
    }

is there a risk that passing both attributes will cause the namespace
move to be silently skipped entirely because the rename block
unconditionally jumps to the end of the function?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260714142927.1298=
897-1-jiri@resnulli.us?part=3D3
