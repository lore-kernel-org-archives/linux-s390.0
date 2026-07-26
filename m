Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A75483DA5D9;
	Sun, 26 Jul 2026 17:40:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785087650; cv=none; b=nBxalwJIMeEk6k10ldzSdO/V4UlOEyfYDcQ8ChrySGNDM/57E4U2ms6dqIDr4MAfriJXCEb5rdQ8ThqmDsgObhf4hIfEeB+l/0VIdmZ4gg/dt6kHWJKBBIcsoINQA4pwQSwAc6vLDcJwX1zFHtzqQAMDV0ccOdB/QiA4fijFimk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785087650; c=relaxed/simple;
	bh=U22RvA53Joeqw1mg59i7cxmxc4yKQY4yA2GuDzso3AY=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=JiOnzWCWq/a3aEg2mY9DNfPuh+bVeUUc4F62JXsUeD+rjC198L+hUWtvosGyFjdGqx4/uMXke1H6UiYSCqv2kRJPFrMWrctAyN3PRGOCRPcG9PR+4kcr1lW2+mA17G0KF7I69XEyGL25+342u6NBg1ZTjMmIDPKRuIN9K05AGFc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=VKD79Xl7; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="VKD79Xl7"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3BB71F000E9;
	Sun, 26 Jul 2026 17:40:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785087649;
	bh=7FH47QMXmEDcxdhFltnt+16ETzYXgymQ4FC/YV50LeE=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=VKD79Xl74Ufxa4llSdl+8sE0zkEIFJXeuWUfg6lXYuFlSjQW5kBCk6R8nbvl9560z
	 hgLDZH9YTGv3C7I6JPa5mpDO5ZO3+Vhg1mpLX4IN3tMx1bSDAUv5ritcoGa1x7d4zZ
	 pFRPUsWVdvL4nFE8XsYaxdPmCH3AWHTqoqV6NPLUT5eWZ3KGj3QTApsul6NSljJFjC
	 TZj8xlQA16r0TcTsm6FhxQ3K2HrcGFWlF75fYaDs67B26mZLb1lH6hs5sdhcTgbfsP
	 jTnyM/WcIUdNpE40PpiKQAd2La9nMoIbl2Wi2l02Rtv1wzMCP1sKJDkHvHa23A/rmI
	 BrOgKX5+6wQKw==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v6 09/10] s390/vfio_ccw: implement a channel program
 mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Alexander Gordeev" <agordeev@linux.ibm.com>, kvm@vger.kernel.org, linux-s390@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, "Vasily Gorbik" <gor@linux.ibm.com>
In-Reply-To: <20260726172153.1818056-10-farman@linux.ibm.com>
References: <20260726172153.1818056-1-farman@linux.ibm.com>
 <20260726172153.1818056-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Sun, 26 Jul 2026 17:40:48 +0000
Message-Id: <20260726174048.E3BB71F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 1 potential issue(=
s) to consider:
- [High] A 3-thread AB-BC-CA deadlock is introduced involving `cp_mutex`, `=
iommu->lock`, and `iommu->device_list_lock`.
--

--- Patch [9]: [PATCH v6 09/10] s390/vfio_ccw: implement a channel program =
mutex ---
commit 24b60b7244a72b137b8847a953a24223d19d152e
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: implement a channel program mutex

This patch introduces a mutex to protect the channel program struct in the
vfio_ccw driver. The lock is held across operations that require private->cp
to ensure consistent behavior and replaces some incorrect subchannel lock u=
ses.

> diff --git a/drivers/s390/cio/vfio_ccw_fsm.c b/drivers/s390/cio/vfio_ccw_=
fsm.c
> --- a/drivers/s390/cio/vfio_ccw_fsm.c
> +++ b/drivers/s390/cio/vfio_ccw_fsm.c
> @@ -249,6 +246,8 @@ static void fsm_io_request(struct vfio_ccw_private *p=
rivate,
>  	private->state =3D VFIO_CCW_STATE_CP_PROCESSING;
>  	memcpy(scsw, io_region->scsw_area, sizeof(*scsw));
> =20
> +	mutex_lock(&private->cp_mutex);
> +
>  	if (scsw->cmd.fctl & SCSW_FCTL_START_FUNC) {
>  		orb =3D (union orb *)io_region->orb_area;

[ ... ]

> diff --git a/drivers/s390/cio/vfio_ccw_ops.c b/drivers/s390/cio/vfio_ccw_=
ops.c
> --- a/drivers/s390/cio/vfio_ccw_ops.c
> +++ b/drivers/s390/cio/vfio_ccw_ops.c
> @@ -38,8 +38,13 @@ static void vfio_ccw_dma_unmap(struct vfio_device *vde=
v, u64 iova, u64 length)
>  		container_of(vdev, struct vfio_ccw_private, vdev);
> =20
>  	/* Drivers MUST unpin pages in response to an invalidation. */
> -	if (!cp_iova_pinned(&private->cp, iova, length))
> +	mutex_lock(&private->cp_mutex);

[Severity: High]
Could this introduce a 3-way deadlock with the VFIO IOMMU subsystem?

When an I/O request is submitted, fsm_io_request() takes cp_mutex and
eventually calls cp_prefetch(), which attempts to acquire iommu->lock via
vfio_pin_pages().

At the same time, if a VFIO DMA unmap occurs, the VFIO core calls this
vfio_ccw_dma_unmap() callback while already holding device_list_lock.
This function then attempts to acquire cp_mutex.

Meanwhile, a concurrent VFIO DMA unmap could acquire iommu->lock in the
VFIO core (which drops it temporarily) and attempt to acquire
device_list_lock.

This seems to create a circular dependency:

Thread 1 (I/O submission):
fsm_io_request()
  mutex_lock(&private->cp_mutex);
  cp_prefetch()
    ...
      mutex_lock(&iommu->lock);

Thread 2 (VFIO DMA unmap):
vfio_notify_dma_unmap()
  mutex_lock(&iommu->device_list_lock);
  vfio_ccw_dma_unmap()
    mutex_lock(&private->cp_mutex);

Thread 3 (Concurrent VFIO DMA unmap):
vfio_notify_dma_unmap()
  mutex_lock(&iommu->lock);
  mutex_lock(&iommu->device_list_lock);

Is it possible for this sequence to freeze the CCW device operations and
the VFIO IOMMU subsystem?

> +	if (!cp_iova_pinned(&private->cp, iova, length)) {
> +		mutex_unlock(&private->cp_mutex);
>  		return;
> +	}
> +
> +	mutex_unlock(&private->cp_mutex);
> =20
>  	vfio_ccw_mdev_reset(private);
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260726172153.1818=
056-1-farman@linux.ibm.com?part=3D9
