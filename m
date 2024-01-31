Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 03AC5762DC
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 09:12:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692366; cv=none; b=QcxEfRB+QVfinCHNgDHnnJn1s/LVMihu9xws4VgAKfHRlAjHws6qTxqj+iPzjBpiPqeUqnFyQh8ETa+9p3IEk5SZveYezBV5r3mx3dL662SgsARSLPt49IDt8oDG9g8QIu5VRMsx1y10g6P6P260wK2tBQEBgb3wh97sNQT2gwg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692366; c=relaxed/simple;
	bh=iy8IxvqKOpmyszmUICuSRJZdyFyS8a08syYg9oqhiwo=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=hiJ0VJxbvU1azPtn8JMQ+YPwfOqUt9vp1Olhf2g9eRTM/AkD3SNE34utY2VxHSgZccVf5x1zcSyaZPxWFRKHF89JLGi0mXL87hvdJmA8KV4YC02IIFVSdgIGfji9/a6lx4OpalaQyYjhG8BzB1Gxe+CN7ciJx4A/NV0XcHzQS2g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=cweqj1lw; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="cweqj1lw"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692363;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wsqjWW/MnDSmuwoZiRaLj0nDWAmbUu5RXdiCDY/znJM=;
	b=cweqj1lw7nWV5WtGPmu9XMSl7136DKp5+cuMsdize4WK8kVRdY0BKElwSe8irPPHm5WFp4
	EOTEuYDnAqhbeLw+C9pUMNT2qH4jDVrCqSHuyxm5z8EWBSjYz9RJZK/SP3HK5eCxW0oNG/
	EbpG0hC3/J0IcYt3PT8YmUpx7t/u7e8=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-TTct0O3uP4i-xYZSaDmDNQ-1; Wed, 31 Jan 2024 04:12:41 -0500
X-MC-Unique: TTct0O3uP4i-xYZSaDmDNQ-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3bec05c9047so252090b6e.3
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 01:12:41 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692361; x=1707297161;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wsqjWW/MnDSmuwoZiRaLj0nDWAmbUu5RXdiCDY/znJM=;
        b=d6THuAb6PLXnyqq1eHaYSqDk1mazmrhnEtOpmmcLgjjBw8+GN9KxraiV0/Xsbqj3nx
         ltPcg9CR3i3R1eJjwY4lZMEWe9ueOUpUtKNzH/CVdhBkblw/C00c0/B+PbmpW8ob8hLx
         34ujkRqES3CMqBMUijzTmttZyvKYVd8lKC6eYfKRvsQuPncdowXkIcR5rPGyIYIaaSLV
         hujx6oGN2QD6D3bEgDCDgg4FKyOjK4k0iAdjc7pE+ipLWJDNaLmdDTuoppspqJYK/n6i
         mbwCgOrXsL6h02VphZLy0bibVvQqtBmXj6M495gB3fJ7R2MhEqKyAz0YStKqid4/qyzV
         rfEQ==
X-Gm-Message-State: AOJu0Yxh7VBbHR7o/sa3csgiRya9bbjHOT8ga2hgf1UQCpbsh49Pqgpj
	Ztys+C7uFrOWjxmXUema1jr2d0WX5ry5/pX3Uv/lJ9eXQ0c1qK+pB1bl8BABzlp2FtT2WdN1Dc9
	y1Ba63593PHwnPlM+W8TVBkXqXeu2BRjan1BEYG+DEzQDY0j6t9+uKSgH2UgOa5h6o5tyXkyg2K
	p4J3ll3roexS5IlUrc6AtmjChibBplv0Br0g==
X-Received: by 2002:a05:6808:1411:b0:3bd:692d:b234 with SMTP id w17-20020a056808141100b003bd692db234mr1439594oiv.46.1706692360825;
        Wed, 31 Jan 2024 01:12:40 -0800 (PST)
X-Google-Smtp-Source: AGHT+IGkhNl8CYmtHiEfIUfnPYL5oLs/Tc6D6VHe9+SWIvn+sLqMZVRWwpFiE+EIR4sYMDOZHFDn03BUTmGXgWIZEJ8=
X-Received: by 2002:a05:6808:1411:b0:3bd:692d:b234 with SMTP id
 w17-20020a056808141100b003bd692db234mr1439555oiv.46.1706692360520; Wed, 31
 Jan 2024 01:12:40 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-7-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-7-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:29 +0800
Message-ID: <CACGkMEtNCjvtDWySzeAqETGZtBSL0MR6=JySBBtm3=s19wB=1w@mail.gmail.com>
Subject: Re: [PATCH vhost 06/17] virtio_ring: no store dma info when unmap is
 not needed
To: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc: virtualization@lists.linux.dev, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	"Michael S. Tsirkin" <mst@redhat.com>, "David S. Miller" <davem@davemloft.net>, Eric Dumazet <edumazet@google.com>, 
	Jakub Kicinski <kuba@kernel.org>, Paolo Abeni <pabeni@redhat.com>, Hans de Goede <hdegoede@redhat.com>, 
	=?UTF-8?Q?Ilpo_J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>, 
	Vadim Pasternak <vadimp@nvidia.com>, Bjorn Andersson <andersson@kernel.org>, 
	Mathieu Poirier <mathieu.poirier@linaro.org>, Cornelia Huck <cohuck@redhat.com>, 
	Halil Pasic <pasic@linux.ibm.com>, Eric Farman <farman@linux.ibm.com>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Alexei Starovoitov <ast@kernel.org>, 
	Daniel Borkmann <daniel@iogearbox.net>, Jesper Dangaard Brouer <hawk@kernel.org>, 
	John Fastabend <john.fastabend@gmail.com>, Benjamin Berg <benjamin.berg@intel.com>, 
	Yang Li <yang.lee@linux.alibaba.com>, linux-um@lists.infradead.org, 
	netdev@vger.kernel.org, platform-driver-x86@vger.kernel.org, 
	linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org, 
	kvm@vger.kernel.org, bpf@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

On Tue, Jan 30, 2024 at 7:42=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> As discussed:
> http://lore.kernel.org/all/CACGkMEug-=3DC+VQhkMYSgUKMC=3D=3D04m7-uem_yC21=
bgGkKZh845w@mail.gmail.com
>
> When the vq is premapped mode, the driver manages the dma
> info is a good way.
>
> So this commit make the virtio core not to store the dma
> info and release the memory which is used to store the dma
> info.
>
> If the use_dma_api is false, the memory is also not allocated.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/virtio/virtio_ring.c | 89 ++++++++++++++++++++++++++++--------
>  1 file changed, 70 insertions(+), 19 deletions(-)
>
> diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> index 831667a57429..5bea25167259 100644
> --- a/drivers/virtio/virtio_ring.c
> +++ b/drivers/virtio/virtio_ring.c
> @@ -94,12 +94,15 @@ struct vring_desc_state_packed {
>  };
>
>  struct vring_desc_extra {
> -       dma_addr_t addr;                /* Descriptor DMA addr. */
> -       u32 len;                        /* Descriptor length. */
>         u16 flags;                      /* Descriptor flags. */
>         u16 next;                       /* The next desc state in a list.=
 */
>  };
>
> +struct vring_desc_dma {
> +       dma_addr_t addr;                /* Descriptor DMA addr. */
> +       u32 len;                        /* Descriptor length. */
> +};
> +
>  struct vring_virtqueue_split {
>         /* Actual memory layout for this queue. */
>         struct vring vring;
> @@ -116,6 +119,7 @@ struct vring_virtqueue_split {
>         /* Per-descriptor state. */
>         struct vring_desc_state_split *desc_state;
>         struct vring_desc_extra *desc_extra;
> +       struct vring_desc_dma *desc_dma;
>
>         /* DMA address and size information */
>         dma_addr_t queue_dma_addr;
> @@ -156,6 +160,7 @@ struct vring_virtqueue_packed {
>         /* Per-descriptor state. */
>         struct vring_desc_state_packed *desc_state;
>         struct vring_desc_extra *desc_extra;
> +       struct vring_desc_dma *desc_dma;
>
>         /* DMA address and size information */
>         dma_addr_t ring_dma_addr;
> @@ -472,13 +477,14 @@ static unsigned int vring_unmap_one_split(const str=
uct vring_virtqueue *vq,
>                                           unsigned int i)
>  {
>         struct vring_desc_extra *extra =3D vq->split.desc_extra;
> +       struct vring_desc_dma *dma =3D vq->split.desc_dma;
>         u16 flags;
>
>         flags =3D extra[i].flags;
>
>         dma_unmap_page(vring_dma_dev(vq),
> -                      extra[i].addr,
> -                      extra[i].len,
> +                      dma[i].addr,
> +                      dma[i].len,
>                        (flags & VRING_DESC_F_WRITE) ?
>                        DMA_FROM_DEVICE : DMA_TO_DEVICE);
>
> @@ -535,8 +541,11 @@ static inline unsigned int virtqueue_add_desc_split(=
struct virtqueue *vq,
>                 next =3D extra[i].next;
>                 desc[i].next =3D cpu_to_virtio16(vq->vdev, next);
>
> -               extra[i].addr =3D addr;
> -               extra[i].len =3D len;
> +               if (vring->split.desc_dma) {
> +                       vring->split.desc_dma[i].addr =3D addr;
> +                       vring->split.desc_dma[i].len =3D len;
> +               }
> +
>                 extra[i].flags =3D flags;
>         } else
>                 next =3D virtio16_to_cpu(vq->vdev, desc[i].next);
> @@ -1072,16 +1081,26 @@ static void virtqueue_vring_attach_split(struct v=
ring_virtqueue *vq,
>         vq->free_head =3D 0;
>  }
>
> -static int vring_alloc_state_extra_split(struct vring_virtqueue_split *v=
ring_split)
> +static int vring_alloc_state_extra_split(struct vring_virtqueue_split *v=
ring_split,
> +                                        bool need_unmap)
>  {
>         struct vring_desc_state_split *state;
>         struct vring_desc_extra *extra;
> +       struct vring_desc_dma *dma;
>         u32 num =3D vring_split->vring.num;
>
>         state =3D kmalloc_array(num, sizeof(struct vring_desc_state_split=
), GFP_KERNEL);
>         if (!state)
>                 goto err_state;
>
> +       if (need_unmap) {
> +               dma =3D kmalloc_array(num, sizeof(struct vring_desc_dma),=
 GFP_KERNEL);
> +               if (!dma)
> +                       goto err_dma;
> +       } else {
> +               dma =3D NULL;
> +       }
> +
>         extra =3D vring_alloc_desc_extra(num);
>         if (!extra)
>                 goto err_extra;
> @@ -1090,9 +1109,12 @@ static int vring_alloc_state_extra_split(struct vr=
ing_virtqueue_split *vring_spl
>
>         vring_split->desc_state =3D state;
>         vring_split->desc_extra =3D extra;
> +       vring_split->desc_dma =3D dma;
>         return 0;
>
>  err_extra:
> +       kfree(dma);
> +err_dma:
>         kfree(state);
>  err_state:
>         return -ENOMEM;
> @@ -1108,6 +1130,7 @@ static void vring_free_split(struct vring_virtqueue=
_split *vring_split,
>
>         kfree(vring_split->desc_state);
>         kfree(vring_split->desc_extra);
> +       kfree(vring_split->desc_dma);
>  }
>
>  static int vring_alloc_queue_split(struct vring_virtqueue_split *vring_s=
plit,
> @@ -1209,7 +1232,8 @@ static int virtqueue_resize_split(struct virtqueue =
*_vq, u32 num)
>         if (err)
>                 goto err;
>
> -       err =3D vring_alloc_state_extra_split(&vring_split);
> +       err =3D vring_alloc_state_extra_split(&vring_split,
> +                                           vring_need_unmap_buffer(vq));
>         if (err)
>                 goto err_state_extra;
>
> @@ -1245,14 +1269,16 @@ static u16 packed_last_used(u16 last_used_idx)
>
>  /* caller must check vring_need_unmap_buffer() */
>  static void vring_unmap_extra_packed(const struct vring_virtqueue *vq,
> -                                    const struct vring_desc_extra *extra=
)
> +                                    unsigned int i)
>  {
> +       const struct vring_desc_extra *extra =3D &vq->packed.desc_extra[i=
];
> +       const struct vring_desc_dma *dma =3D &vq->packed.desc_dma[i];
>         u16 flags;
>
>         flags =3D extra->flags;

I don't think this can be compiled.

Thanks

