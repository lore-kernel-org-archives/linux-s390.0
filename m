Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5290F3F8ECA
	for <linux-s390@vger.kernel.org>; Fri, 17 Jul 2026 13:24:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1784294668; cv=none; b=A7BG9kuUf6ABKu7YpyHMpSCRNl5RO8XB2uxifwfj2pimkOoA/MMbjOXk0fcwt1nIaRtJr+EUwRCiGgSop3dLbq/yf4DPMyGTrSerZHmtnl7qsmcRp6UFj/X4AhxWfise+kR0hl7Jt9yLvX4bXlGqf7FTSRyalboV4WVEQmCdEaQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1784294668; c=relaxed/simple;
	bh=x9q6ETf1e+DoaubnAudx9diMja35E7LKZKQAQbElTUE=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CevL6OORQnOkQ2Yl4re/PbacUj6rvR66P0mNhUD+yyu6ppppUMixM58A3TTeBOwdY/PdX3QVtOUm9HA5IT1qXFE+aKJvkN2T59sG4a0dn2e+G3qNn6n12BUm13qp5dgdiGEvEJlMHa82wXLI5db0z/N1XTPfwk598Q4MCteU6cI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=isAzWO5l; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="isAzWO5l"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C9FBE1F00AC4;
	Fri, 17 Jul 2026 13:24:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1784294666;
	bh=WHAW4Sg+xp1r0mrXXl3FH5nC9I4+yUQBpM4KRh6WicE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=isAzWO5l4AqW2sw4uYzHs5SsLtN4ypfjEp+jt2XFKwWVHX7CLGLmTpIWdVooFiRMh
	 gfrfwmPpcongqsgR4HWK5b5E8RC9PkWNPxZ92JXLRC5PHQqNhCgo6CxZ9DMqDeDFQi
	 uK+oeuPkWy7oFthw4bpeMydJeuUXFHtQWd6g202Ljs0qzbwTNMNYbxk4597MWmBNuV
	 aTTEYAYupV95JMT/IqZby187IRpGXoZko7POUues9Vr+9I/4z0Zb5IrQX4aAUWh6hl
	 4wKfG8JoaMtyf+pmh8VZlPo8oLenG0PNv9aKkD6EFqfrQ+CFHxmPHshvrGhonfk0M/
	 TPzp6IFdWDw9g==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH rdma-next v3 04/14] RDMA/nldev: Report net namespace
 move errors through extack
Reply-To: sashiko-reviews@lists.linux.dev
To: "Jiri Pirko" <jiri@resnulli.us>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, tj@kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, hannes@cmpxchg.org, "Heiko
 Carstens" <hca@linux.ibm.com>, mkoutny@suse.com
In-Reply-To: <20260716132316.1495242-5-jiri@resnulli.us>
References: <20260716132316.1495242-1-jiri@resnulli.us>
 <20260716132316.1495242-5-jiri@resnulli.us>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 17 Jul 2026 13:24:25 +0000
Message-Id: <20260717132425.C9FBE1F00AC4@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] The newly added feature to support renaming an RDMA device while m=
oving its network namespace is inaccessible from userspace due to a logic f=
law in the netlink handler. Additionally, providing both attributes silentl=
y aborts the namespace move.
--

--- Patch [4]: [PATCH rdma-next v3 04/14] RDMA/nldev: Report net namespace =
move errors through extack ---
commit dd68e4a951ab0b58504bc034673213514633a1a1
Author: Jiri Pirko <jiri@resnulli.us>

RDMA/nldev: Report net namespace move errors through extack

Thread extack through the existing net namespace move helper and report the
main failure reasons from the core path. Keep the existing move UAPI shape
unchanged.

> diff --git a/drivers/infiniband/core/nldev.c b/drivers/infiniband/core/nl=
dev.c
> index 77a7580801486..8648e95700bfa 100644
> --- a/drivers/infiniband/core/nldev.c
> +++ b/drivers/infiniband/core/nldev.c
> @@ -1195,10 +1195,8 @@ static int nldev_set_doit(struct sk_buff *skb, str=
uct nlmsghdr *nlh,
>  		u32 ns_fd;
> =20
>  		ns_fd =3D nla_get_u32(tb[RDMA_NLDEV_NET_NS_FD]);
> -		err =3D ib_device_set_netns_put(skb, device, ns_fd, NULL);
> -		if (err =3D=3D -EEXIST)
> -			NL_SET_ERR_MSG(extack,
> -				       "Device name already exists in the target net namespace");
> +		err =3D ib_device_set_netns_put(skb, device, ns_fd, NULL,
> +					      extack);

[Severity: High]
Does this logic prioritize the device rename and exit early, preventing the
namespace move from occurring if both attributes are present?

Looking at nldev_set_doit(), if a user with CAP_NET_ADMIN provides both
RDMA_NLDEV_ATTR_DEV_NAME and RDMA_NLDEV_NET_NS_FD in a single message:

    if (tb[RDMA_NLDEV_ATTR_DEV_NAME]) {
        /* ... */
        err =3D ib_device_rename(device, name);
        goto done;
    }

won't the handler process the rename and hit a goto done; silently skipping
the namespace move? This could result in a success response while leaving t=
he
device in the old namespace.

Additionally, it unconditionally passes NULL as the name to
ib_device_set_netns_put() in the patched hunk above. Doesn't this render
the rename-on-move functionality completely inaccessible from userspace?

>  		goto put_done;
>  	}

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260716132316.1495=
242-1-jiri@resnulli.us?part=3D4
