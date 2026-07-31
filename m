Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55E963AA1B2
	for <linux-s390@vger.kernel.org>; Fri, 31 Jul 2026 07:56:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785484612; cv=none; b=tx2CqztfftXdNuImpPMc49IzkG1evyj8+cdSSzqIO9DdH84c7OjZqndvsnEHWcMnGPBS31+EC8egRvCkhPOnCsWqJzg3bQTGizv08LzwZBGRaKMdMZLaUy7n66xGKdUj8dS6Ar/Rn26AH+GwHYcCUCHQBl6uu8q2ao0gWqBvc0U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785484612; c=relaxed/simple;
	bh=NFbRIA4+ofx3pQStKRT0RSpTIrEX6hq8aU/bvhUyqGw=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=RHUHbRvKLfuqVH1t/3iaWkWFWi2CA0JFD2jscmYsstEyNiCwjpvfp70iNCSgIhFgo7KHEBN1sVuoC4RnAf02Ap9SDUhVMdr/SmyWzMkQKsgQzJ0CQpdFt4tiZ62IkgC56KkzhCKAEvFr8w1uHKe8OY+KfqCHmrghH7HEtnn5eJ4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=cie5SD7v; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="cie5SD7v"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C2BA91F00A3A;
	Fri, 31 Jul 2026 07:56:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785484611;
	bh=fGehXtro3PyB/itCz2qpy3XXK5zwhlyHakzEDQ5FEvw=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=cie5SD7vB9KEywfCigMk+5OWPVjl0BveFetzKiPrHPWf7Pqsr6/dcaq9ggLNGgC67
	 lx5OPJ3aNKMJdp757ILCrVdBwp/vcUwbJWHGibr6acIlF6Bmn/IpPla23nFtDyDzu+
	 IDEWLG8fD8VwvWvm3xtHp46/Ve1m4x/+BK0+9Yfmey3WwPNhvyxUg6a2dHa1L7mhmm
	 mnmFXctj9CRHYmZS+ipnT0ix1WaQx58VflQwl/SO2Ekdt5LL1O6Qyy4al+xFTG0lvP
	 V09enj9J7v2lxF6mMAXulA4zuKWv2ctzrPbGRMQa8G6y3TmoiIv6ldxQi+ggCuuJX6
	 CmYc4pmZaJpmg==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH net] dibs: fix double free of dmb_clientid_arr
Reply-To: sashiko-reviews@lists.linux.dev
To: "Hidayath Khan" <hidayath@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, "Heiko Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Vasily
 Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260730075624.114778-1-hidayath@linux.ibm.com>
References: <20260730075624.114778-1-hidayath@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Fri, 31 Jul 2026 07:56:50 +0000
Message-Id: <20260731075650.C2BA91F00A3A@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 3 potential issue(=
s) to consider:

Pre-existing issues:
- [High] The hardware interrupt handler `ism_handle_irq()` can execute out-=
of-order with respect to initialization and teardown of critical resources,=
 leading to crashes (UAF, NULL deref, and uninitialized spinlock accesses).
- [High] `dibs_unregister_client()` leaves the subsystem in an inconsistent=
 partial state if it aborts midway through its device iteration.
- [High] `dibs_lo_attach_dmb` drops the hash table read lock before increme=
nting the object's reference count, leading to a Use-After-Free.
--

--- Patch [1]: [PATCH net] dibs: fix double free of dmb_clientid_arr ---
commit 45565b8a1cec1239be540b3b54fad60822ae8b57
Author: Hidayath Khan <hidayath@linux.ibm.com>

dibs: fix double free of dmb_clientid_arr

dibs_dev_add() frees dibs->dmb_clientid_arr on both of its failure
paths, but does not clear the pointer. dibs_lo_dev_probe() then frees
the same pointer again in its err_reg path, so a failing device_add()
or sysfs_create_group() results in a double free.

Drop the kfree() from dibs_lo_dev_probe().

Cc: stable@vger.kernel.org

> diff --git a/drivers/dibs/dibs_loopback.c b/drivers/dibs/dibs_loopback.c
> index 0f2e093111526..aeb8787ea9816 100644
> --- a/drivers/dibs/dibs_loopback.c
> +++ b/drivers/dibs/dibs_loopback.c
> @@ -334,7 +334,6 @@ static int dibs_lo_dev_probe(void)
>  	return 0;
> =20
>  err_reg:
> -	kfree(dibs->dmb_clientid_arr);

[Severity: High]
This isn't a bug introduced by this patch, but does dibs_lo_attach_dmb() ha=
ve
a use-after-free if the reference count is incremented after dropping the h=
ash
table lock?

drivers/dibs/dibs_loopback.c:dibs_lo_attach_dmb() {
...
	read_unlock_bh(&ldev->dmb_ht_lock);

	if (!refcount_inc_not_zero(&dmb_node->refcnt))
...
}

If a concurrent thread executing dibs_lo_unregister_dmb() acquires the lock
and drops the refcount to zero, could it free the node before the first thr=
ead
resumes, causing refcount_inc_not_zero() to operate on freed memory?

[Severity: High]
This is a pre-existing issue, but is there an initialization race with the
hardware interrupt handler in ism_drv.c?

drivers/s390/net/ism_drv.c:ism_probe() {
...
	ret =3D dibs_dev_add(dibs);
...
}

If the hardware interrupt is registered before dibs_dev_add() initializes
resources, and a spurious interrupt fires, could ism_handle_irq() access an
uninitialized spinlock or dereference a NULL pointer?

drivers/s390/net/ism_drv.c:ism_handle_irq() {
...
		client_id =3D dibs->dmb_clientid_arr[bit];
...
}

Similarly, during teardown:

drivers/s390/net/ism_drv.c:ism_remove() {
...
	dibs_dev_del(dibs);
	ism_dev_exit(ism);
...
}

Could freeing resources like dibs->dmb_clientid_arr via dibs_dev_del() befo=
re
the active IRQ is unregistered create a use-after-free window?

[Severity: High]
This is also a pre-existing issue, but does dibs_unregister_client() leave =
the
subsystem in an inconsistent state if it aborts early?

drivers/dibs/dibs_main.c:dibs_unregister_client() {
...
				rc =3D -EBUSY;
				goto err_reg_dmb;
...
}

If the loop successfully processes some devices but then encounters a device
with active DMBs, it returns -EBUSY without rolling back the teardown on the
previously processed devices. If the caller ignores this return value and
proceeds to unload the module, could the detached devices later trigger an
event and dereference freed ops function pointers?

>  	/* pairs with dibs_dev_alloc() */
>  	put_device(&dibs->dev);
>  	kfree(ldev);

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260730075624.1147=
78-1-hidayath@linux.ibm.com?part=3D1
