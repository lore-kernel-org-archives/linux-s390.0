Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 02C8F368299
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 12:42:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785501765; cv=none; b=JpFDPzVRl/S+JgDHRW8Ho8D0T23VG1+nTW7+Av5aRAN7Nnp8DqTfA3xBWBHLTyrCTp4d3CiMTnIQSrkpIc+zBT1UcyijRL9VTNQrL2yP0E3gMAiS0hf6DIRlAiCuX93DQ7/b9ErazzFPe23uoLWCEpfCi3cR0mYljj9YNrNqkKY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785501765; c=relaxed/simple;
	bh=tIYMHMVavwK/sbm3D7PcAi1lnAry+ybjrZ0yucFpGr4=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=WPHwe/SgUaGLhoFHy104fl6MnaTxfAKBWicSKBBsumwyTTgZAQkdaftIvE4U1FsNdINAHcsdq1QTA/IIFRJVmAeAfsjaWhQz7bunIh6LsMD35kUf73AegXpovif6IvbOc3pHhTkNN9ODAlf1410rI3ejzzOyBMGpRY8HtF8/95Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=h1xorOUL; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="h1xorOUL"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9A2651F000E9;
	Fri, 31 Jul 2026 12:42:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785501763;
	bh=0yYYBypMO7thpW78/hvhfbp6XR5e0QEXgiMiQT5JS9I=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=h1xorOULtyRS/l63dxim1+dJ0GP/y5GIVARePqKT1xWMN8PA7zce5i6uleQnI5Pgw
	 gJl2STt3taZJM4+16lf4zYpYrtiBYuIle+9rfdOmzhGX0C36GWbgOAuxhaxW5EtUXV
	 1oCXl35yiAmg8suHaQMhjoQCXFNiESwdTeBRwARWfLhQGvlgZt9phUnT+9CgYgv9Ap
	 JAX99fS91MTdY+JvB1w+RbHIR2rWEXI3FNZlJ7/Z99OgVF7cgoFcVPzNnQShT1qDMz
	 SVGCwFfY9P25sIXY7hca7YHQeZiXdkaG+dlc1FvPsqJf0CfA2XWSv9IxKXHJxTE7g9
	 y+j4QyeJjG0Og==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] dibs: initialise dibs->lock in dibs_dev_alloc()
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260730124227.167829-1-hidayath@linux.ibm.com>
References: <20260730124227.167829-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 12:42:43 +0000
Message-Id: <20260731124243.9A2651F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Early interrupt handling causes NULL pointer dereferences on `ism-=
>sba` and `dibs->dmb_clientid_arr`.
- [High] The interrupt handler is unregistered (`free_irq`) after the criti=
cal data structures it accesses are freed, leading to Use-After-Free or NUL=
L pointer dereferences during teardown.
- [High] Double free of `dibs->dmb_clientid_arr` when `dibs_dev_add` fails.
--

--- Patch [1]: [PATCH net] dibs: initialise dibs->lock in dibs_dev_alloc() =
---
commit dbb6bc52f9b974f5e291d1236762d41302672810
Author: Hidayath Khan <hidayath@linux.ibm.com>

dibs: initialise dibs->lock in dibs_dev_alloc()

dibs->lock is initialised by dibs_dev_add(), but a dibs device can already
take interrupts before that call. This moves the lock initialization to
dibs_dev_alloc() so it is valid as soon as the device can be published to
its interrupt handler.

> dibs->lock is initialised by dibs_dev_add(), but a dibs device can
> already take interrupts before that call: ism_probe() runs
> ism_dev_init(), and hence request_irq(), before it calls
> dibs_dev_add(). No client can have registered a dmb at that point, so
> no dmb interrupt can occur, but a GID event interrupt can, and
> ism_handle_irq() takes dibs->lock unconditionally on entry, before it
> inspects anything else.

[Severity: High]
This is a pre-existing issue, but while moving the lock initialization avoi=
ds a
panic on the uninitialized spinlock, won't the handler still crash immediat=
ely
after taking the lock?

Looking at drivers/s390/net/ism_drv.c, if a spurious interrupt fires right =
after
request_irq() in ism_dev_init():

	ret =3D request_irq(pci_irq_vector(pdev, 0), ism_handle_irq, 0,
			  pci_name(pdev), ism);
	if (ret)
		goto free_vectors;

	ret =3D register_sba(ism);

The interrupt handler ism_handle_irq() will execute and unconditionally
dereference ism->sba, which hasn't been populated by register_sba() yet:

	bv =3D (void *) &ism->sba->dmb_bits[ISM_DMB_WORD_OFFSET];
	end =3D sizeof(ism->sba->dmb_bits) * BITS_PER_BYTE - ISM_DMB_BIT_OFFSET;

	spin_lock(&dibs->lock);
	ism->sba->s =3D 0;

Could this cause a NULL pointer dereference when accessing ism->sba?

[ ... ]

> diff --git a/drivers/dibs/dibs_main.c b/drivers/dibs/dibs_main.c
> index 14c3e2d84902e..4c26fd06973f7 100644
> --- a/drivers/dibs/dibs_main.c
> +++ b/drivers/dibs/dibs_main.c

[ ... ]

> @@ -186,7 +187,6 @@ int dibs_dev_add(struct dibs_dev *dibs)
>  	int i, ret;
> =20
>  	max_dmbs =3D dibs->ops->max_dmbs();
> -	spin_lock_init(&dibs->lock);
>  	dibs->dmb_clientid_arr =3D kzalloc(max_dmbs, GFP_KERNEL);

[Severity: High]
This isn't a bug introduced by this patch, but does this allocation lead to=
 a
double free on error paths?

If dibs_dev_add() fails later in the function, it legitimately frees this
array:

drivers/dibs/dibs_main.c:dibs_dev_add() {
    ...
free_client_arr:
	kfree(dibs->dmb_clientid_arr);
	return ret;
}

However, the loopback driver's probe function dibs_lo_dev_probe() also free=
s it
on failure:

drivers/dibs/dibs_loopback.c:dibs_lo_dev_probe() {
    ...
err_reg:
	kfree(dibs->dmb_clientid_arr);
	/* pairs with dibs_dev_alloc() */
	put_device(&dibs->dev);
}

Can this cause a double free of dibs->dmb_clientid_arr if device registrati=
on or
sysfs group creation fails?

[Severity: High]
This is a pre-existing issue, but is there also a use-after-free risk during
device teardown involving this array?

During device removal, ism_remove() executes teardown in an order that frees
data structures while the interrupt handler is still active:

drivers/s390/net/ism_drv.c:ism_remove() {
	...
	dibs_dev_del(dibs);
	ism_dev_exit(ism);
	...
}

dibs_dev_del() calls kfree(dibs->dmb_clientid_arr):

drivers/dibs/dibs_main.c:dibs_dev_del() {
	...
	device_del(&dibs->dev);
	kfree(dibs->dmb_clientid_arr);
}

And then ism_dev_exit() unregisters and nullifies ism->sba before finally
calling free_irq():

drivers/s390/net/ism_drv.c:ism_dev_exit() {
	...
	unregister_sba(ism);
	free_irq(pci_irq_vector(pdev, 0), ism);
}

If an interrupt fires during this window, can the active IRQ handler access=
 the
freed dibs->dmb_clientid_arr or dereference the NULL ism->sba pointer?

>  	if (!dibs->dmb_clientid_arr)
>  		return -ENOMEM;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730124227.1678=
29-1-hidayath@linux.ibm.com?part=3D1
