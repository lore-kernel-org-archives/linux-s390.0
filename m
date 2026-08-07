Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63BFC472771
	for <linux-s390@vger.kernel.org>; Fri,  7 Aug 2026 12:05:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1786104330; cv=none; b=lJgTjO0mqUmYpCd2jz3M7bOnYPq8kv6vMKnJoguIF9XwZQaYFT0w9bHws47bfnfPVVWXev64S/Fdefj2d5UoVOf199GIP0UNTEsuVj/O1f9F/TTDIzwIYdwFPNs+kqx+bkI1DsPWU903MsQ0oI4z9OjZB3VadP6DCGkoW9J7VoA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1786104330; c=relaxed/simple;
	bh=KgfLhsNbbFgyzOZ5SkA54n/vgOszh9GPP3tq3pY6nGA=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=YyG0VCT9hIUIRwm/Bw3V8eMeRnfrNldf0H+VTpLxjYpqEsaHT1kYgqcsS7bq9NxcBz7Bk+PwOH7bwmCacr6EGXZQ4bGRWiIOFP72gfKWeCRxFpdwo0210Qa1DV3zgZ116ZOipAvIIaBeBcFDrNMFRTDdShKBZE3/dzn12GEyM4I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=jr0vrqEN; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="jr0vrqEN"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BC5761F00A3A;
	Fri,  7 Aug 2026 12:05:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1786104303;
	bh=7V7SPLHWzQL9WJUHosPjOzzzKx5aJ3hKKhquZ/vQKy8=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=jr0vrqENYMb37PtwRVIpnNwO1SNDfiKlYtXiAh+jKdLm6nxXxRufdtSgkLQv1agdB
	 pJZZPTQckV1Cafb3Qn6gcqr4/UxirlLpnKAIYzYVAVADQxJ8BbAILl9TpWxI9okwne
	 DVUZOlicL5mJTpCViX7SFV/QU4+Px49zrJQp/juKOxS+2OvXrSccEPu4cZ4n4RSMMV
	 CZTP2AGOJoCvvbU+kNhRhzZDOXcv0mFnsTZ26zSE27MNQS3S6IzA1FuHCjjSJCrJ1i
	 AFhYkTu+t5Mzt9RUoRNJ0nXYSBhes84qGxl8Po9t6OR5gBkjZhKTxKZgeoEDFlePnE
	 yuKrJHNafaeFQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net v2] dibs: fix double free of dmb_clientid_arr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: linux-s390@vger.kernel.org, "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260806120447.596164-1-hidayath@linux.ibm.com>
References: <20260806120447.596164-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 07 Aug 2026 12:05:02 +0000
Message-Id: <20260807120502.BC5761F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 5 potential issue(=
s) to consider:

Pre-existing issues:
- [High] dibs_unregister_client() fails with partial unregistration if an a=
ctive DMB is found on a device later in the list, leaving the client in a c=
orrupted state.
- [High] Initialization failure in dibs_init() leaks dibs_class and causes =
Use-After-Free.
- [High] Early registration of ism_handle_irq() in ism_probe() causes poten=
tial NULL Pointer Dereference and Use-After-Free.
- [High] `dibs_lo_move_data()` acquires `dibs->lock` with plain `spin_lock(=
)`, missing IRQ masking.
- [High] In the error path of `ism_alloc_dmb()`, a folio allocated page is =
illegally freed using `kfree()`.
--

--- Patch [1]: [PATCH net v2] dibs: fix double free of dmb_clientid_arr ---
commit c4dab923b3875e2fdb8522fd524541f2cd53cf25
Author: Hidayath Khan <hidayath@linux.ibm.com>
Subject: dibs: fix double free of dmb_clientid_arr

This commit removes the kfree() call in dibs_lo_dev_probe() to prevent a
double free of dibs->dmb_clientid_arr. The pointer is already freed on both
failure paths of dibs_dev_add(), which is called just before the error path.

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index fd5caf1e19a8f..649e4e375be33 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c
> @@ -335,7 +335,6 @@ static int dibs_lo_dev_probe(void)
>  	return 0;
> =20
>  err_reg:
> -	kfree(dibs->dmb_clientid_arr);
>  	/* pairs with dibs_dev_alloc() */
>  	put_device(&dibs->dev);
>  	kfree(ldev);

While reviewing this area, I noticed a few pre-existing issues that were not
introduced by this patch.

drivers/dibs/dibs_main.c:dibs_unregister_client()
> 		for (int i =3D 0; i < max_dmbs; ++i) {
> 			if (dibs->dmb_clientid_arr[i] =3D=3D client->id) {
> 				WARN(1, "%s: attempt to unregister '%s' with registered dmb(s)\n",
> 				     __func__, client->name);
> 				rc =3D -EBUSY;
> 				goto err_reg_dmb;
> 			}
> 		}
> 		/* Stop forwarding IRQs and events */
> 		dibs->subs[client->id] =3D NULL;
> 		spin_unlock_irqrestore(&dibs->lock, flags);
> 		clients[client->id]->ops->del_dev(dibs);

[Severity: High]
This isn't a bug introduced by this patch, but if dibs_unregister_client()
finds an active DMB on a device later in the list, it aborts and returns
-EBUSY. Does this leave the client in a corrupted state since the earlier
devices in the list already had their forwarding stopped and del_dev() call=
ed?
A subsequent retry could result in a double-free or use-after-free when
del_dev() is called again for the already processed devices.

drivers/dibs/dibs_main.c:dibs_init()
> static int __init dibs_init(void)
> {
> 	int rc;
>=20
> 	rc =3D class_register(&dibs_class);
> 	if (rc)
> 		return rc;
>=20
> 	rc =3D dibs_loopback_init();
> 	if (rc)
> 		pr_err("%s fails with %d\n", __func__, rc);
>=20
> 	return rc;
> }

[Severity: High]
This is a pre-existing issue, but does an initialization failure here leak =
the
dibs_class? If dibs_loopback_init() fails, the module load is aborted and
memory is freed, but class_register() isn't undone. Could this result in a
use-after-free if sysfs accesses the freed module memory?

drivers/s390/net/ism_drv.c:ism_probe()
> 	/* enable ism device, but any interrupts and events will be ignored
> 	 * before dibs_dev_add() adds it to any clients.
> 	 */
> 	ret =3D ism_dev_init(ism);
> 	if (ret)
> 		goto err_dibs;
> ...
> 	ret =3D dibs_dev_add(dibs);

drivers/s390/net/ism_drv.c:ism_handle_irq()
> 	spin_lock(&dibs->lock);
> 	ism->sba->s =3D 0;
> 	barrier();
> ...
> 		client_id =3D dibs->dmb_clientid_arr[bit];

[Severity: High]
This isn't a bug introduced by this patch, but is it possible for an early
interrupt to trigger a NULL pointer dereference or use-after-free?
ism_dev_init() enables the hardware interrupts before dibs_dev_add()
initializes dibs->lock and allocates dibs->dmb_clientid_arr. If an interrupt
fires early, could ism_handle_irq() attempt to acquire an uninitialized lock
and dereference a NULL pointer?

drivers/dibs/dibs_loopback.c:dibs_lo_move_data()
> 	spin_lock(&dibs->lock);
> 	client_id =3D dibs->dmb_clientid_arr[sba_idx];
> 	s_mask =3D ror16(0x1000, idx);
> 	if (likely(client_id !=3D NO_DIBS_CLIENT && dibs->subs[client_id]))
> 		dibs->subs[client_id]->ops->handle_irq(dibs, sba_idx, s_mask);
> 	spin_unlock(&dibs->lock);

[Severity: High]
This is a pre-existing issue, but is it safe to acquire dibs->lock using
spin_lock() here? Since the lock is also acquired in the hardirq context by
ism_handle_irq(), could acquiring it here without disabling interrupts caus=
e a
deadlock if an interrupt arrives on the same CPU?

drivers/s390/net/ism_drv.c:ism_alloc_dmb()
> 	folio =3D folio_alloc(GFP_KERNEL | __GFP_NOWARN | __GFP_NOMEMALLOC |
> 			    __GFP_NORETRY, get_order(dmb->dmb_len));
>=20
> 	if (!folio) {
> 		rc =3D -ENOMEM;
> 		goto out_bit;
> 	}
>=20
> 	dmb->cpu_addr =3D folio_address(folio);
> 	dmb->dma_addr =3D dma_map_page(&ism->pdev->dev,
> 				     virt_to_page(dmb->cpu_addr), 0,
> 				     dmb->dmb_len, DMA_FROM_DEVICE);
> 	if (dma_mapping_error(&ism->pdev->dev, dmb->dma_addr)) {
> 		rc =3D -ENOMEM;
> 		goto out_free;
> 	}
>=20
> 	return 0;
>=20
> out_free:
> 	kfree(dmb->cpu_addr);

[Severity: High]
This isn't a bug introduced by this patch, but does the error path incorrec=
tly
free the page memory? Since dmb->cpu_addr was allocated via folio_alloc(),
shouldn't it be freed using folio_put() instead of kfree() to avoid slab
allocator corruption?

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260806120447.5961=
64-1-hidayath@linux.ibm.com?part=3D1
