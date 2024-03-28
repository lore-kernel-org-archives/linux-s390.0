Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B1DFD3770B
	for <linux-s390@vger.kernel.org>; Thu, 28 Mar 2024 04:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711599563; cv=none; b=APSir5oDdrDmK7VlyR9DWMTldCFHaw8Wf/4ga9vdQv/Tc/WgtjmF8aiBOVo63dAOvZZqVbL6tB9NcYRu+FnljDBZvnfklM2JXN/xzmKE3VZVMrH0asckeN7PwsEoifVtRDkHP8iJ0+0SDeLM7Gt8LD6x2d3Q0eutuH183SVAgk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711599563; c=relaxed/simple;
	bh=1ZDDNQUQvY0+ThIzTgJ67rkj+dipkjfyEL+qgEFYHmE=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=EFFbL0bZj74n7ISqaijm6B/+0ju4wS3oU0+3h/1XwqRMMvkz5o0YeAa25pNWnMdqJvXRt5WuXwC3FlCphm8tHOpbg/gpkRMjHnzcFE3hfY7cZDsTcaTD3INVzOtvo1FoX5mBT8bvDqxGuFOWuvQ6fQFUUVsYXM1A8LaV0jGAqyw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=UWgWtShs; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UWgWtShs"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1711599560;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=amjfd4M7Bjlz8eF+VEdK92gHvs+RzroD+0WjsBulYN8=;
	b=UWgWtShsdMnzWebYKHEE8kc4toMGuugZVRjBdp0Zdp8Tps6kxGsLAAdy9q5KWO3hReARk0
	vL1L89Vy64JUbtd1tDcQIUgWnAPpeFHQ/PNBF2xVIuEWzgUF4q1RPWbWPDgceQftLn6hW1
	41/HcNWKJVrr6QRrGm5aRWL2UMhx+8k=
Received: from mail-pj1-f69.google.com (mail-pj1-f69.google.com
 [209.85.216.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-634-9-xPyrlcPxmbjcMOg652Aw-1; Thu, 28 Mar 2024 00:19:18 -0400
X-MC-Unique: 9-xPyrlcPxmbjcMOg652Aw-1
Received: by mail-pj1-f69.google.com with SMTP id 98e67ed59e1d1-2a1f5c7db31so485388a91.2
        for <linux-s390@vger.kernel.org>; Wed, 27 Mar 2024 21:19:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711599557; x=1712204357;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=amjfd4M7Bjlz8eF+VEdK92gHvs+RzroD+0WjsBulYN8=;
        b=Ars5zlAQORH1PzDPc03dSzY5XZy+oXoalPAczR5KPp/KdS/Zh8rO2lsVfq9MKqAhGQ
         1Jfe4Y5IVdg4wFVsqzWjt54jMxmA9eBr6w+HEeaURqBbRo2V9j+3lLUFShkM1XQIE0Dn
         g6UYIsW3aC7JjYkvXOEKryvRByv7QLBwWd1TQptfGqRykiYSQwmTijsmXKBPpZCalHwl
         j+G4mQgaJmJz0aEvErzQqCVqOYemDXql1SU8lQaB9Pj6KYG3oqYm/5krVLCRALYsbv7o
         pFLG/5KSIuBId3q32tCL2WeWoezRVkIjsCN3/LyZQilHP8MMeTTHyt7rwmdGlc29KPDq
         8ctg==
X-Forwarded-Encrypted: i=1; AJvYcCXVkCMb8GkodjRtUj4yT+DroODrymoXgBQ6eaVSW4CTpTRZyTBud1YiVbPkOzEjPHZY1i6LO0YYMfqelgyTDU+VNBefx56W1dHw5Q==
X-Gm-Message-State: AOJu0YxXyZBByhgUop7cnLNhMjlLSe6FMxjSx5USsNvJ7b6KiWUob56F
	X29UM5eYvGYsYOSm+rhEMkN2rWa/7ad2WeD6H/pOSJMdve3AW6cr9clgzpVKbKEdLxyPMfjXXtR
	6skpx5Ecb7QwhTV10hnO+qgZyOMxhqOWHGzu1NThZpAS1l5OBCjPQhj4OTimKE9e1dGH5DtyQVy
	gYboXCVcMtwSjQv5i/U3ab7w0y/nWpEAWb3Q==
X-Received: by 2002:a17:90a:bc92:b0:2a1:f55e:d28 with SMTP id x18-20020a17090abc9200b002a1f55e0d28mr1403492pjr.25.1711599556923;
        Wed, 27 Mar 2024 21:19:16 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGnQ5et3Bf+a41fzKtEhnTvTQHOyLeIImoSeqymV4IHaPJ9Oj7tRYyF0hiiTI7/lajnV52BxGPxUXwl4Fz5BEA=
X-Received: by 2002:a17:90a:bc92:b0:2a1:f55e:d28 with SMTP id
 x18-20020a17090abc9200b002a1f55e0d28mr1403471pjr.25.1711599556521; Wed, 27
 Mar 2024 21:19:16 -0700 (PDT)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240327095741.88135-1-xuanzhuo@linux.alibaba.com> <20240327095741.88135-3-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240327095741.88135-3-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Thu, 28 Mar 2024 12:19:04 +0800
Message-ID: <CACGkMEtvf98gRQCB1qDY+fR-2xD-Xya_dnFcb1j_o0bnVqA5ow@mail.gmail.com>
Subject: Re: [PATCH vhost v6 2/6] virtio: remove support for names array
 entries being null.
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Hans de Goede <hdegoede@redhat.com>, =?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, "Michael S. Tsirkin" <mst@redhat.com>, 
	David Hildenbrand <david@redhat.com>, linux-um@lists.infradead.org, 
	platform-driver-x86@vger.kernel.org, linux-remoteproc@vger.kernel.org, 
	linux-s390@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Mar 27, 2024 at 5:58=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> commit 6457f126c888 ("virtio: support reserved vqs") introduced this
> support. Multiqueue virtio-net use 2N as ctrl vq finally, so the logic
> doesn't apply. And not one uses this.
>
> On the other side, that makes some trouble for us to refactor the
> find_vqs() params.
>
> So I remove this support.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  arch/um/drivers/virtio_uml.c           |  8 ++++----
>  drivers/remoteproc/remoteproc_virtio.c | 11 ++++-------
>  drivers/s390/virtio/virtio_ccw.c       |  8 ++++----
>  drivers/virtio/virtio_mmio.c           |  8 ++++----
>  drivers/virtio/virtio_pci_common.c     | 18 +++++++++---------
>  drivers/virtio/virtio_vdpa.c           | 11 ++++-------
>  include/linux/virtio_config.h          |  2 +-
>  7 files changed, 30 insertions(+), 36 deletions(-)
>
> diff --git a/arch/um/drivers/virtio_uml.c b/arch/um/drivers/virtio_uml.c
> index 8adca2000e51..773f9fc4d582 100644
> --- a/arch/um/drivers/virtio_uml.c
> +++ b/arch/um/drivers/virtio_uml.c
> @@ -1019,8 +1019,8 @@ static int vu_find_vqs(struct virtio_device *vdev, =
unsigned nvqs,
>                        struct irq_affinity *desc)
>  {
>         struct virtio_uml_device *vu_dev =3D to_virtio_uml_device(vdev);
> -       int i, queue_idx =3D 0, rc;
>         struct virtqueue *vq;
> +       int i, rc;
>
>         /* not supported for now */
>         if (WARN_ON(nvqs > 64))
> @@ -1032,11 +1032,11 @@ static int vu_find_vqs(struct virtio_device *vdev=
, unsigned nvqs,
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       rc =3D -EINVAL;
> +                       goto error_setup;
>                 }
>
> -               vqs[i] =3D vu_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
> +               vqs[i] =3D vu_setup_vq(vdev, i, callbacks[i], names[i],
>                                      ctx ? ctx[i] : false);
>                 if (IS_ERR(vqs[i])) {
>                         rc =3D PTR_ERR(vqs[i]);
> diff --git a/drivers/remoteproc/remoteproc_virtio.c b/drivers/remoteproc/=
remoteproc_virtio.c
> index 83d76915a6ad..8fb5118b6953 100644
> --- a/drivers/remoteproc/remoteproc_virtio.c
> +++ b/drivers/remoteproc/remoteproc_virtio.c
> @@ -119,9 +119,6 @@ static struct virtqueue *rp_find_vq(struct virtio_dev=
ice *vdev,
>         if (id >=3D ARRAY_SIZE(rvdev->vring))
>                 return ERR_PTR(-EINVAL);
>
> -       if (!name)
> -               return NULL;
> -
>         /* Search allocated memory region by name */
>         mem =3D rproc_find_carveout_by_name(rproc, "vdev%dvring%d", rvdev=
->index,
>                                           id);
> @@ -187,15 +184,15 @@ static int rproc_virtio_find_vqs(struct virtio_devi=
ce *vdev, unsigned int nvqs,
>                                  const bool * ctx,
>                                  struct irq_affinity *desc)
>  {
> -       int i, ret, queue_idx =3D 0;
> +       int i, ret;
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       ret =3D -EINVAL;
> +                       goto error;
>                 }
>
> -               vqs[i] =3D rp_find_vq(vdev, queue_idx++, callbacks[i], na=
mes[i],
> +               vqs[i] =3D rp_find_vq(vdev, i, callbacks[i], names[i],
>                                     ctx ? ctx[i] : false);
>                 if (IS_ERR(vqs[i])) {
>                         ret =3D PTR_ERR(vqs[i]);
> diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virti=
o_ccw.c
> index ac67576301bf..508154705554 100644
> --- a/drivers/s390/virtio/virtio_ccw.c
> +++ b/drivers/s390/virtio/virtio_ccw.c
> @@ -659,7 +659,7 @@ static int virtio_ccw_find_vqs(struct virtio_device *=
vdev, unsigned nvqs,
>  {
>         struct virtio_ccw_device *vcdev =3D to_vc_device(vdev);
>         unsigned long *indicatorp =3D NULL;
> -       int ret, i, queue_idx =3D 0;
> +       int ret, i;
>         struct ccw1 *ccw;
>
>         ccw =3D ccw_device_dma_zalloc(vcdev->cdev, sizeof(*ccw));
> @@ -668,11 +668,11 @@ static int virtio_ccw_find_vqs(struct virtio_device=
 *vdev, unsigned nvqs,
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       ret =3D -EINVAL;
> +                       goto out;
>                 }
>
> -               vqs[i] =3D virtio_ccw_setup_vq(vdev, queue_idx++, callbac=
ks[i],
> +               vqs[i] =3D virtio_ccw_setup_vq(vdev, i, callbacks[i],

Nit:

This seems an unnecessary change or we need to remove the queue_idx variabl=
e.

>                                              names[i], ctx ? ctx[i] : fal=
se,
>                                              ccw);
>                 if (IS_ERR(vqs[i])) {
> diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> index 59892a31cf76..82ee4a288728 100644
> --- a/drivers/virtio/virtio_mmio.c
> +++ b/drivers/virtio/virtio_mmio.c
> @@ -496,7 +496,7 @@ static int vm_find_vqs(struct virtio_device *vdev, un=
signed int nvqs,
>  {
>         struct virtio_mmio_device *vm_dev =3D to_virtio_mmio_device(vdev)=
;
>         int irq =3D platform_get_irq(vm_dev->pdev, 0);
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         if (irq < 0)
>                 return irq;
> @@ -511,11 +511,11 @@ static int vm_find_vqs(struct virtio_device *vdev, =
unsigned int nvqs,
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       vm_del_vqs(vdev);
> +                       return -EINVAL;
>                 }
>
> -               vqs[i] =3D vm_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
> +               vqs[i] =3D vm_setup_vq(vdev, i, callbacks[i], names[i],

Similar issue as above.

>                                      ctx ? ctx[i] : false);
>                 if (IS_ERR(vqs[i])) {
>                         vm_del_vqs(vdev);
> diff --git a/drivers/virtio/virtio_pci_common.c b/drivers/virtio/virtio_p=
ci_common.c
> index b655fccaf773..eda71c6e87ee 100644
> --- a/drivers/virtio/virtio_pci_common.c
> +++ b/drivers/virtio/virtio_pci_common.c
> @@ -292,7 +292,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
>         u16 msix_vec;
> -       int i, err, nvectors, allocated_vectors, queue_idx =3D 0;
> +       int i, err, nvectors, allocated_vectors;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -302,7 +302,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>                 /* Best option: one for change interrupt, one per vq. */
>                 nvectors =3D 1;
>                 for (i =3D 0; i < nvqs; ++i)
> -                       if (names[i] && callbacks[i])
> +                       if (callbacks[i])
>                                 ++nvectors;
>         } else {
>                 /* Second best: one for change, shared for all vqs. */
> @@ -318,8 +318,8 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>         allocated_vectors =3D vp_dev->msix_used_vectors;
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       err =3D -EINVAL;
> +                       goto error_find;
>                 }
>
>                 if (!callbacks[i])
> @@ -328,7 +328,7 @@ static int vp_find_vqs_msix(struct virtio_device *vde=
v, unsigned int nvqs,
>                         msix_vec =3D allocated_vectors++;
>                 else
>                         msix_vec =3D VP_MSIX_VQ_VECTOR;
> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
> +               vqs[i] =3D vp_setup_vq(vdev, i, callbacks[i], names[i],
>                                      ctx ? ctx[i] : false,
>                                      msix_vec);
>                 if (IS_ERR(vqs[i])) {
> @@ -363,7 +363,7 @@ static int vp_find_vqs_intx(struct virtio_device *vde=
v, unsigned int nvqs,
>                 const char * const names[], const bool *ctx)
>  {
>         struct virtio_pci_device *vp_dev =3D to_vp_device(vdev);
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         vp_dev->vqs =3D kcalloc(nvqs, sizeof(*vp_dev->vqs), GFP_KERNEL);
>         if (!vp_dev->vqs)
> @@ -378,10 +378,10 @@ static int vp_find_vqs_intx(struct virtio_device *v=
dev, unsigned int nvqs,
>         vp_dev->per_vq_vectors =3D false;
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       err =3D -EINVAL;
> +                       goto out_del_vqs;
>                 }
> -               vqs[i] =3D vp_setup_vq(vdev, queue_idx++, callbacks[i], n=
ames[i],
> +               vqs[i] =3D vp_setup_vq(vdev, i, callbacks[i], names[i],
>                                      ctx ? ctx[i] : false,
>                                      VIRTIO_MSI_NO_VECTOR);
>                 if (IS_ERR(vqs[i])) {
> diff --git a/drivers/virtio/virtio_vdpa.c b/drivers/virtio/virtio_vdpa.c
> index e803db0da307..e82cca24d6e6 100644
> --- a/drivers/virtio/virtio_vdpa.c
> +++ b/drivers/virtio/virtio_vdpa.c
> @@ -161,9 +161,6 @@ virtio_vdpa_setup_vq(struct virtio_device *vdev, unsi=
gned int index,
>         bool may_reduce_num =3D true;
>         int err;
>
> -       if (!name)
> -               return NULL;
> -
>         if (index >=3D vdpa->nvqs)
>                 return ERR_PTR(-ENOENT);
>
> @@ -370,7 +367,7 @@ static int virtio_vdpa_find_vqs(struct virtio_device =
*vdev, unsigned int nvqs,
>         struct cpumask *masks;
>         struct vdpa_callback cb;
>         bool has_affinity =3D desc && ops->set_vq_affinity;
> -       int i, err, queue_idx =3D 0;
> +       int i, err;
>
>         if (has_affinity) {
>                 masks =3D create_affinity_masks(nvqs, desc ? desc : &defa=
ult_affd);
> @@ -380,11 +377,11 @@ static int virtio_vdpa_find_vqs(struct virtio_devic=
e *vdev, unsigned int nvqs,
>
>         for (i =3D 0; i < nvqs; ++i) {
>                 if (!names[i]) {
> -                       vqs[i] =3D NULL;
> -                       continue;
> +                       err =3D -EINVAL;
> +                       goto err_setup_vq;
>                 }
>
> -               vqs[i] =3D virtio_vdpa_setup_vq(vdev, queue_idx++,
> +               vqs[i] =3D virtio_vdpa_setup_vq(vdev, i,

And here.

With those fixed.

Acked-by: Jason Wang <jasowang@redhat.com>

Thanks

>                                               callbacks[i], names[i], ctx=
 ?
>                                               ctx[i] : false);
>                 if (IS_ERR(vqs[i])) {
> diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.=
h
> index da9b271b54db..1c79cec258f4 100644
> --- a/include/linux/virtio_config.h
> +++ b/include/linux/virtio_config.h
> @@ -56,7 +56,7 @@ typedef void vq_callback_t(struct virtqueue *);
>   *     callbacks: array of callbacks, for each virtqueue
>   *             include a NULL entry for vqs that do not need a callback
>   *     names: array of virtqueue names (mainly for debugging)
> - *             include a NULL entry for vqs unused by driver
> + *             MUST NOT be NULL
>   *     Returns 0 on success or error status
>   * @del_vqs: free virtqueues found by find_vqs().
>   * @synchronize_cbs: synchronize with the virtqueue callbacks (optional)
> --
> 2.32.0.3.g01195cf9f
>
>

