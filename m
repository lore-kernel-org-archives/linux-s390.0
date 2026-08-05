Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B9C63DA7CA
	for <linux-s390@vger.kernel.org>; Wed,  5 Aug 2026 08:59:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785920353; cv=none; b=Cc8b/3P6OZZ4tBUqBdMBEs4rWMpeEmX21kFCFc5ge+tuOgeFnRlb2r3ERQ8nBvsX04oFW6Cw88lcFHR+rEj4fCoQyEjzjyj86dQYxAhxuOsAduGOJDSOs7Q+JXvCSXT7WLzIX5u2I77tA0oZlyncJYZ4kmq+UKWlYyvipKm5yh4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785920353; c=relaxed/simple;
	bh=dnZVDYceUE16CfikaMjLb6z4eL6bSB2dQJjQ9zhCb3Y=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=CweMgX8W5VRtp5nVYPYUcNqY3WUeM1uwbHM2VIdUZSu6b5AYgzFtn7RNw7bt9LdEJWRRXbsSF3xXflsi23MGYLn+U6MUw/7YZbxX8G7vRt6tTkTHoz0yxzhGJ818qtHPkeIIYyghf09ZItgQfHxu9n6TtujChLGocn8ZVDzpJyQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=U/6ZmT0K; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="U/6ZmT0K"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4F10A1F000E9;
	Wed,  5 Aug 2026 08:59:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785920352;
	bh=5CmanxleiF0qzha+2YLKvpwGS5pOoSZNF1GnxMaoyIA=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=U/6ZmT0KSYYVw+by3AHPv2SOeR9Bk92nnkuVFGHCslPu4atqZScVoejm+boi1JzNd
	 qskfhzNW2BbP9yhZ3D5QystUbWifbe/FylHLUctuW8pkop8TLrAjAsgyhNBY3IB9By
	 5H+/d5S4VEWuj2gVL8JaXnpKilrsh7SLSsW4Vlc4W21z2XvwsteXHGVM2ty2z305SA
	 YYvNmf2T1D4yXETXSMVBO4xHnyp8o3dErDagtAdHZ3RQH8LnwAjIgR7UuGLA8Yy9mX
	 pFI0jaTO1Uhu37AzPlVyeB8M569vi8zEO8K48t4Ukx6sr8ywmTKugGS1M91PU0LH2z
	 sENzd2vIcOXJg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after
 dibs_dev_del()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Alexandra Winter" <wintera@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>
In-Reply-To: <20260804085848.3579518-1-wintera@linux.ibm.com>
References: <20260804085848.3579518-1-wintera@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Wed, 05 Aug 2026 08:59:10 +0000
Message-Id: <20260805085911.4F10A1F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 4 potential issue(=
s) to consider:

Pre-existing issues:
- [Critical] Double free of `dmb_clientid_arr` in the error path of `dibs_l=
o_dev_probe()`.
- [Critical] The interrupt handler `ism_handle_irq()` can dereference NULL =
pointers and acquire an uninitialized lock due to early interrupt enablemen=
t.
- [Critical] Use-after-free of `ism->sba` and `ism->ieq` during teardown du=
e to improper ordering with `free_irq()`.
- [High] Partial rollback failure leaves client in a broken state in `dibs_=
unregister_client()`.
--

--- Patch [1]: [PATCH net] net/dibs: Fix UAF of dmb_clientid_arr after dibs=
_dev_del() ---
commit 40d2232069f48423978af98bbecb5075fb611ca0
Author: Alexandra Winter <wintera@linux.ibm.com>

net/dibs: Fix UAF of dmb_clientid_arr after dibs_dev_del()
   =20
A dibs device interrupt handler can be active after dibs_dev_del() and
may still access dmb_clientid_arr. Free dmb_clientid_arr in
dibs_dev_release() after last reference is gone.

Fixes: cc21191b584c ("dibs: Move data path to dibs layer")
Cc: stable@vger.kernel.org
Co-developed-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Hidayath Khan <hidayath@linux.ibm.com>
Signed-off-by: Alexandra Winter <wintera@linux.ibm.com>

> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c
> @@ -128,6 +128,7 @@ static void dibs_dev_release(struct device *dev)
> =20
>  	dibs =3D container_of(dev, struct dibs_dev, dev);
> =20
> +	kfree(dibs->dmb_clientid_arr);

[Severity: Critical]
This is a pre-existing issue, but does this lead to a double free in the
error path of dibs_lo_dev_probe()?

If device registration fails during loopback probe, the error path explicit=
ly
frees the array and then puts the device:

drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
    ...
err_reg:
	kfree(dibs->dmb_clientid_arr);
	/* pairs with dibs_dev_alloc() */
	put_device(&dibs->dev);
    ...
}

Since put_device() now unconditionally calls dibs_dev_release() and frees
the array again, will this corrupt memory?

[ ... ]

> @@ -194,12 +195,13 @@ int dibs_dev_add(struct dibs_dev *dibs)

[Severity: Critical]
This isn't a bug introduced by this patch, but can the interrupt handler
access uninitialized structures if an early interrupt occurs?

In ism_dev_init(), interrupts are requested and enabled before the device
is fully registered:

drivers/s390/net/ism_drv.c:ism_dev_init() {
    ...
	ret =3D request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
			  pci_name(pdev), ism);
	if (ret)
		goto free_vectors;

	ret =3D register_sba(ism);
    ...
}

If a hardware interrupt arrives immediately after request_irq(),
ism_handle_irq() will execute and unconditionally access the uninitialized
ism->sba and acquire dibs->lock, before register_sba() or dibs_dev_add()
have initialized them. Can this lead to a NULL pointer dereference or
uninitialized lock access?

[ ... ]

[Severity: High]
This is a pre-existing issue, but does dibs_unregister_client() fail to
roll back its state if a client is busy?

If a client attempts to unregister while still having active DMBs on
multiple devices, the loop aborts and returns -EBUSY:

drivers/dibs/dibs_main.c:dibs_unregister_client() {
    ...
				rc =3D -EBUSY;
				goto err_reg_dmb;
			}
		}
		/* Stop forwarding IRQs and events */
		dibs->subs[client->id] =3D NULL;
		spin_unlock_irqrestore(&dibs->lock, flags);
		clients[client->id]->ops->del_dev(dibs);
    ...
}

Since it does not undo the modifications made to the preceding devices in
the list (such as clearing dibs->subs[client->id]), will this leave the
client in a broken state?


[Severity: Critical]
This isn't a bug introduced by this patch, but can a device interrupt cause
a use-after-free during driver removal?

In ism_dev_exit(), the data structures are destroyed before the interrupt
handler is quiesced:

drivers/s390/net/ism_drv.c:ism_dev_exit() {
	struct pci_dev *pdev =3D ism->pdev;

	unregister_ieq(ism);
	unregister_sba(ism);
	free_irq(pci_irq_vector(pdev, 0), ism);
    ...
}

If an interrupt arrives after unregister_sba() but before free_irq(),
ism_handle_irq() will access the freed ism->sba. Should free_irq() be
called before tearing down the data structures?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260804085848.3579=
518-1-wintera@linux.ibm.com?part=3D1
