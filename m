Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6F59189F43;
	Sun, 26 Jul 2026 04:16:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785039398; cv=none; b=L4nPhvTF+SO2mvBzwXy3Zr12QwtkAJEUW+FNVvqaaWko9zt+Mokq4kyDCFCO1pq0JBMOIQEAnnIR/u74waBzqTLLnfh+5E1R3kzVSNIJKZMJqjk3umWns5t+irBcVIRD1oSBXdmsSpLmTIRAGgD80JKV0no5BhOAp9Dns4dq4NE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785039398; c=relaxed/simple;
	bh=vSBcng/VMDy5XnymQpPdYEds4VNBLtSUErKtEVQkmNg=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=DeL4zGt0hwU2E2bLvR074iFX1j2WRnVKDpaWyUVm04ofcuYLiQZoCcqlPdaRgyg3j8G5Ww8mr11nAJf1B/Wdlg72ewk9mho5CJp+HVRuxdHBuSL3dTZaJhuK1GQ1/wwtBVBVl6j3Alo/AUO54z9i7ydrqVErW968BhXK93pzHfw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=DHnlR/YI; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="DHnlR/YI"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B2CA61F000E9;
	Sun, 26 Jul 2026 04:16:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785039385;
	bh=bdFAeiVQ5KoYIjj6eWQF6ebrMdeP8b0XrfC38OxhQSY=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=DHnlR/YII4+pnzUPUm/FpK7Ce4WKMtHAXbiBS5BLzXSEGUiSTImIaGBPPO+gW4Ei+
	 AGwzhxuo7NhEh86MuJBnhTyB73i5FpnWQq9j3rk9Ptdmf7r3A6AADw1lxTuDg1GmdA
	 pq1v8rpogzOIOCloLo2lalJrzeIdPZvDXHIJQn1x8OlFuOpD2u2yG3DKRUqs1EdXOY
	 DEXC4YibhIczBpoIMDd6hPA2gAPn6D3GUj33da3IIRrJTgDuiNDoCVoOEtcikDnmy1
	 Q5J8CrkN/5naVix9OQSrtO+2iAkXcmMNZavk3ehmLFc7i8F6SPliTFBgd7rjH8DZrk
	 XVcrJJ9VPApSA==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v5 06/10] s390/vfio_ccw: ensure index for read/write
 regions are within range
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org
In-Reply-To: <20260726040129.2946151-7-farman@linux.ibm.com>
References: <20260726040129.2946151-1-farman@linux.ibm.com>
 <20260726040129.2946151-7-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 04:16:24 +0000
Message-Id: <20260726041624.B2CA61F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] Lockless operations on the `private->crw` linked list can lead to =
list corruption, Use-After-Free, and double free.
- [High] Missing cancellation of background work items (`crw_work` and `io_=
work`) during device teardown allows them to execute on freed memory.
--

--- Patch [6]: [PATCH v5 06/10] s390/vfio_ccw: ensure index for read/write =
regions are within range ---
commit 9645c29c603d4b1935d8c4e94d4ecac3dcd69174
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: ensure index for read/write regions are within range

This commit clamps region indexes for read/write operations to be within
the bounds of private->num_regions. It also uses array_index_nospec() to
prevent speculative out-of-bounds access.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index 38c176cf62957..f3015132d4b5f 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c

[ ... ]

> @@ -97,6 +105,12 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  		list_del(&crw->next);

[Severity: High]
This is a pre-existing issue, but does this locklessly dequeue elements from
private->crw and cause list corruption or use-after-free?

The userspace read syscall path calls vfio_ccw_crw_region_read(), which
dequeues elements from private->crw using list_del():

drivers/s390/cio/vfio_ccw_chp.c:vfio_ccw_crw_region_read() {
	...
	crw =3D list_first_entry_or_null(&private->crw, struct vfio_ccw_crw, next);
	if (crw)
		list_del(&crw->next);
	...
}

Concurrently, the asynchronous hardware event path locklessly appends eleme=
nts
to private->crw using list_add_tail():

drivers/s390/cio/vfio_ccw_drv.c:vfio_ccw_queue_crw() {
	...
	list_add_tail(&crw->next, &private->crw);
	queue_work(vfio_ccw_work_q, &private->crw_work);
	...
}

Could an unprivileged guest with VFIO access trigger this race by executing
a read() syscall on the CRW region concurrently with a hardware asynchronous
channel path event to crash the host kernel?

> =20
>  	mutex_lock(&private->io_mutex);
> +	if (i >=3D private->num_regions) {
> +		ret =3D -EINVAL;
> +		goto out;
> +	}
> +
> +	i =3D array_index_nospec(i, private->num_regions);
>  	region =3D private->region[i].data;

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> index 45ec722d25ea6..032a1cdf4df70 100644
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c

[ ... ]

> @@ -338,11 +340,8 @@ static int vfio_ccw_mdev_ioctl_get_region_info(struc=
t vfio_device *vdev,
>  		    VFIO_CCW_NUM_REGIONS + private->num_regions)
>  			return -EINVAL;
> =20
> -		info->index =3D array_index_nospec(info->index,
> -						 VFIO_CCW_NUM_REGIONS +
> -						 private->num_regions);
> -
>  		i =3D info->index - VFIO_CCW_NUM_REGIONS;
> +		i =3D array_index_nospec(i, private->num_regions);

[Severity: High]
This is a pre-existing issue, but does device teardown safely cancel backgr=
ound
work items before freeing memory?

Asynchronous events can queue crw_work (via vfio_ccw_chp_event) or io_work
(via fsm_irq). When the device is torn down, fsm_close() conditionally flus=
hes
the workqueue only on an error/busy path, leaving pending work active on the
success path:

drivers/s390/cio/vfio_ccw_fsm.c:fsm_close() {
	...
	ret =3D cio_disable_subchannel(sch);
	if (ret =3D=3D -EBUSY)
		ret =3D vfio_ccw_sch_quiesce(sch);
	...
}

Then, vfio_ccw_mdev_release_dev() frees the private structure and destroys =
the
mutex without invoking cancel_work_sync() for crw_work and io_work:

drivers/s390/cio/vfio_ccw_ops.c:vfio_ccw_mdev_release_dev() {
	...
	kfree(private->cp.guest_cp);
	mutex_destroy(&private->io_mutex);
	...
}

Can this lead to a use-after-free on the vfio_ccw_private structure if the
pending work executes on the freed private pointer after it is destroyed by
the VFIO core?

> =20
>  		info->offset =3D VFIO_CCW_INDEX_TO_OFFSET(info->index);
>  		info->size =3D private->region[i].size;

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726040129.2946=
151-1-farman@linux.ibm.com?part=3D6
