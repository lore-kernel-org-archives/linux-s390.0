Received: from smtp.kernel.org (aws-us-west-2-korg-mail-alma10-1.taild15c8.ts.net [100.103.45.18])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ACA1A428481;
	Mon, 27 Jul 2026 20:12:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=100.103.45.18
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1785183175; cv=none; b=uFA48MFXY7NJGW7J5BCldiNrhE96Ro0yZhXnHFoXl3wHZ0Kvo1lXZaRLYl20alMIkQE4VHLgdYPJ4x5vBdoagjrQFw//wALKdECq8GRcifmcWa+MUPQakJv06xE48IjotzWSkO4TOIYQ8OI04EPjgxipwLG9HaJJmuGx894i4gs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1785183175; c=relaxed/simple;
	bh=Tznq1nKq+iKC9YnFKHnxZ+hg+vkW7DUqtp3+SJyMnXQ=;
	h=From:Subject:To:Cc:In-Reply-To:References:Content-Type:Date:
	 Message-Id; b=qUGuqjn3Vujec1C0pZhbuyeSMwSLNxw55EEG2H8v1BSKbAhGIieZhD3lmu/CRaxRD8Yf9DjIgU84rGjT6lyn2Fvsth53El8h0jW1sojqzITsY8dTKiBQWrTD5PWzjG8qfMz6ykhN4uQW5N3acVqU07yfO8R7hTy32rkz5L0jCY0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=P0o6eKYv; arc=none smtp.client-ip=100.103.45.18
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="P0o6eKYv"
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 448811F000E9;
	Mon, 27 Jul 2026 20:12:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1785183174;
	bh=WGZ100YNsjMDbHKvrMv9JGt8rDkyfxvyj2sX79HNn8g=;
	h=From:Subject:Reply-To:To:Cc:In-Reply-To:References:Date;
	b=P0o6eKYvVfGh2aJSdKSc5BaBT0tQtDuC5oD5GZxgsylQdttxGHEdemT2iejEExP1L
	 8v/V3LJeZQBAAJ+9WQmqc7sXn3glff5ssxu7B4PYnKPlYDPWHcuLhEk+ClHxZugL8j
	 4/Gp136avuwjlcTAB3InTmzCFvjzrrDmTlZuxdDZ3mD7q0kN2OZk1J1GHi71QIyHDz
	 JuzxdeiJQdWJJ+QcAWS8Tvj7CFDbJ5WYpQIEWPG/Q6pW8fAGtwSKzkE674Rg1Yem1i
	 Mc76qagj0S2+f0LbyOe1bofomcgVfhWKVi+QhUWx+c76rDtKLOvf2doNW29c8RoHFW
	 j7VmhZ9IZkShQ==
From: sashiko-bot@kernel.org
Subject: Re: [PATCH v7 09/10] s390/vfio_ccw: selectively expand io_mutex
Reply-To: sashiko-reviews@lists.linux.dev
To: "Eric Farman" <farman@linux.ibm.com>
Cc: "Vasily Gorbik" <gor@linux.ibm.com>, kvm@vger.kernel.org, "Heiko
 Carstens" <hca@linux.ibm.com>, linux-s390@vger.kernel.org, "Alexander
 Gordeev" <agordeev@linux.ibm.com>
In-Reply-To: <20260727192230.2715207-10-farman@linux.ibm.com>
References: <20260727192230.2715207-1-farman@linux.ibm.com>
 <20260727192230.2715207-10-farman@linux.ibm.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
Date: Mon, 27 Jul 2026 20:12:53 +0000
Message-Id: <20260727201254.448811F000E9@smtp.kernel.org>
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>

Thank you for your contribution! Sashiko AI review found 2 potential issue(=
s) to consider:

Pre-existing issues:
- [High] TOCTOU race in cp_iova_pinned ignores IOMMU unmap requests, leadin=
g to hardware DMA into unmapped memory.
- [High] Data race and list corruption on private->crw between process and =
IRQ contexts.
--

--- Patch [9]: [PATCH v7 09/10] s390/vfio_ccw: selectively expand io_mutex =
---
commit e5ee662e08e75a748fbe4dadeba55875910744f0
Author: Eric Farman <farman@linux.ibm.com>

s390/vfio_ccw: selectively expand io_mutex

This patch expands the scope of the io_mutex to serialize I/O regions
alongside I/O operations themselves. It also defers cp_free() to a
workqueue to avoid acquiring mutexes in interrupt context.

> diff --git a/drivers/s390/cio/vfio_ccw_chp.c b/drivers/s390/cio/vfio_ccw_=
chp.c
> index f3015132d4b5f..9269b54f5cfd4 100644
> --- a/drivers/s390/cio/vfio_ccw_chp.c
> +++ b/drivers/s390/cio/vfio_ccw_chp.c
> @@ -98,13 +98,13 @@ static ssize_t vfio_ccw_crw_region_read(struct vfio_c=
cw_private *private,
>  	if (pos + count > sizeof(*region))
>  		return -EINVAL;
> =20
> +	mutex_lock(&private->io_mutex);
>  	crw =3D list_first_entry_or_null(&private->crw,
>  				       struct vfio_ccw_crw, next);
> =20
>  	if (crw)
>  		list_del(&crw->next);

[Severity: High]
This is a pre-existing issue, but does holding only io_mutex provide enough
protection here?

In vfio_ccw_queue_crw(), which is called from hardware interrupt context,
items appear to be appended to private->crw locklessly:

vfio_ccw_queue_crw() {
        ...
        list_add_tail(&crw->next, &private->crw);
        queue_work(vfio_ccw_work_q, &private->crw_work);
}

Since io_mutex is a sleeping lock and cannot be acquired in IRQ context,
will concurrent list manipulations between the IRQ context and this read
corrupt the doubly-linked list pointers?

> -	mutex_lock(&private->io_mutex);
>  	if (i >=3D private->num_regions) {
>  		ret =3D -EINVAL;
>  		goto out;
> diff --git a/drivers/s390/cio/vfio_ccw_cp.c b/drivers/s390/cio/vfio_ccw_c=
p.c
> index 5ef082b8289af..58722c4baa251 100644
> --- a/drivers/s390/cio/vfio_ccw_cp.c
> +++ b/drivers/s390/cio/vfio_ccw_cp.c
> @@ -977,17 +977,23 @@ void cp_update_scsw(struct channel_program *cp, uni=
on scsw *scsw)
>   */
>  bool cp_iova_pinned(struct channel_program *cp, u64 iova, u64 length)
>  {
> +	struct vfio_ccw_private *private =3D
> +		container_of(cp, struct vfio_ccw_private, cp);
>  	struct ccwchain *chain;
>  	int i;
> =20
>  	if (!cp->initialized)
>  		return false;

[Severity: High]
This isn't a bug introduced by this patch, but is it safe to check
cp->initialized without holding io_mutex?

If a VFIO unmap ioctl occurs concurrently while cp_init() is pinning pages
(but before cp_init() sets cp->initialized =3D true at the very end), could
this lockless check return false, causing the unmap request to be
incorrectly ignored?

If the unmap request is ignored while the I/O is submitted to the hardware,
could this result in the hardware performing DMA into memory the guest
considers unmapped?

> +	mutex_lock(&private->io_mutex);
>  	list_for_each_entry(chain, &cp->ccwchain_list, next) {
>  		for (i =3D 0; i < chain->ch_len; i++)
> -			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length))
> +			if (page_array_iova_pinned(&chain->ch_pa[i], iova, length)) {
> +				mutex_unlock(&private->io_mutex);
>  				return true;
> +			}
>  	}
> +	mutex_unlock(&private->io_mutex);
> =20
>  	return false;
>  }

--=20
Sashiko AI review =C2=B7 https://sashiko.dev/#/patchset/20260727192230.2715=
207-1-farman@linux.ibm.com?part=3D9
