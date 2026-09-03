Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D7B124BA9E2
	for <linux-s390@vger.kernel.org>; Thu,  3 Sep 2026 14:35:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1788446112; cv=none; b=VT8AYuDzzMLmC8uF8Dwb3wKNz9rWZy4mS+DZGOLwwOFMMY+7bUf3H9P9cpeZ9wvOrg9wWtJNuERa4hRDuW8dHsaSeQ0F4qCVTvX5XkshDrWx4OzfCw37iVcbXzLEXSNkQKPBTVn9qcJUUmialMni3Rvu/mBoMzZ5ny0UG9pafJs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1788446112; c=relaxed/simple;
	bh=o7n8X7ZGQsV1nbRt5G1h+iX5J/9qNBRhFSfUP8V9+xc=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=TAL3CZ/sg0ATyKjKwlcRgrYbrbvI8GELlTPE6keV0O99d3QCBTUYP8rJF+IxW9O7blSYSOHejb8gpf+C3tdWTRWVFoaX0LvDvISlArZfGLR5J8zbB8Iw5mCqn/YJ5exDHFvQr/Q5QFp+h1UfAeN9KWDtNs+FNoP2LkMmD860XbI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=RWsFJ6Vk; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="RWsFJ6Vk"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0A7361F00A3D;
	Thu,  3 Sep 2026 14:35:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1788446105;
	bh=Ql3Dqh5RKVCzF+M7HusT1eDeiOfdKDembtJ3sZmxqX4=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=RWsFJ6VkA9LFDOEKZWJuYqSZMnhNz7sgNaM2kFrITDEiF7SwHWbdcmNONRNtejzxn
	 x/QxgeUuwgrshIGMQhOwi42fcCCAuNjZCwKQjbW4l3P13BATbf3B3WNpEspAtf/OnJ
	 zh/z0Y0iKA/QZltmRLfd8xl3/A2aVv/ci4HgoIRSpJmv7kwsxcYUUko/37ubsjPZuh
	 6r0v5gv3ouOcFD84kASntBQ97ngJEIdGG0K7pDfT6F9fDLqCMJ/66I7Whlgm5WM4Q+
	 PM3dEZzwqv/sxTYp9Y52DdYymjF0NQpgVJsvu5AK6ZAhPi+mgi0K94yhb6OBMmofzj
	 a14CQnzZ7rTzA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] dibs: Unregister dibs_class after error
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Christian
 Borntraeger" <borntraeger@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260902143438.426664-1-wintera@linux.ibm.com>
References: <20260902143438.426664-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Thu, 03 Sep 2026 14:35:04 +0000
Message-Id: <20260903143505.0A7361F00A3D@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dibs_unregister_client() can return -EBUSY after partially unregis=
tering a client from some devices, leaving the client in an inconsistent st=
ate.
--

commit fa56c806dec36c4e7b30debb7ef4f13581270392
Author: Alexandra Winter <wintera@linux.ibm.com>

dibs: Unregister dibs_class after error

This commit ensures dibs_class is properly unregistered during dibs_init() =
if
dibs_loopback_init() fails. Previously, a failure would leave the class
registered, causing subsequent module load attempts to fail with -EEXIST.

> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 2b53a9d277dca..20c50997a7cf2 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -251,13 +251,19 @@ static int __init dibs_init(void)
> =20
>  	rc =3D class_register(&dibs_class);
>  	if (rc)
> -		return rc;
> +		goto err;
> =20
>  	rc =3D dibs_loopback_init();
>  	if (rc)
> -		pr_err("%s fails with %d\n", __func__, rc);
> +		goto err_unregister;
> =20
>  	return rc;
> +
> +err_unregister:
> +	class_unregister(&dibs_class);
> +err:
> +	pr_err("%s fails with %d\n", __func__, rc);
> +	return rc;
>  }

[Severity: High]
This is a pre-existing issue, but I noticed a potential problem in
dibs_unregister_client() in this same file:

drivers/dibs/dibs_main.c:dibs_unregister_client() {
...
	list_for_each_entry(dibs, &dibs_dev_list.list, list) {
		spin_lock_irqsave(&dibs->lock, flags);
		max_dmbs =3D dibs->ops->max_dmbs();
		for (int i =3D 0; i < max_dmbs; ++i) {
			if (dibs->dmb_clientid_arr[i] =3D=3D client->id) {
				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
				     __func__, client->name);
				rc =3D -EBUSY;
				goto err_reg_dmb;
			}
		}
		/* Stop forwarding IRQs and events */
		dibs->subs[client->id] =3D NULL;
		spin_unlock_irqrestore(&dibs->lock, flags);
		clients[client->id]->ops->del_dev(dibs);
		dibs->priv[client->id] =3D NULL;
	}
...
}

If dibs_unregister_client() successfully unregisters the client from the fi=
rst
device in dibs_dev_list, but then encounters a device where the client stil=
l has
registered DMBs, it returns -EBUSY and aborts.

Since the function clears dibs->subs, calls del_dev(), and clears dibs->priv
for previous devices, does returning -EBUSY without rolling back those chan=
ges
leave the client in an inconsistent state?

If the caller retries dibs_unregister_client() later, could this cause
del_dev() to be called a second time on the already processed devices,
potentially leading to a use-after-free or double-free?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260902143438.4266=
64-1-wintera@linux.ibm.com?part=3D1
