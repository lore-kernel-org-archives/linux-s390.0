Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A7E6469D18
	for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 09:13:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706692390; cv=none; b=j2wgy8b2T0w48f0OhF/K+B/GrGMDUIip1sdvsK5LolOp+AfNI7O8PPe3Jdlk5cTAjVcMg4sUFQ2BLyHXTKg8hG2QXHBZePtgu0pNWOLE9MmZR/dMQPAqgk+twjD45WPlEucJGElXpTxpRpISOu7JEmBozR/ViASKR7Q//78NMSA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706692390; c=relaxed/simple;
	bh=kgV9w/3r2N+l2XD1xKQ4N3OKQGrm1FtckgzvTrOPwHY=;
	h=MIME-Version:References:In-Reply-To:From:Date:Message-ID:Subject:
	 To:Cc:Content-Type; b=Bol98tJIUCQXitUL5Bow5w0CpW61TPlZ7kIe/oBIjix2EIk1Xd8ifC+g+eJT1Nff/6+xhzlb4+xIl6DtfNf7tt+QbC7obg6Cp/XxWdM2LqDXdt3MN4fTaI1V9frfPwn7MytkDoDWVO15rJnGqal0lo2edZ+bESpKQyZJQhUemLk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=baBlRvHB; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="baBlRvHB"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1706692387;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=60OE93oZxMpAy5PTfrRWb+NgmfRgxzqKxIV3hKWBwnk=;
	b=baBlRvHB9m6n6049YYfFMTCFp2F95gj+THb4UyU/FHKQcn992c+55F9Hkf/ncWtgBqw2pE
	zK6W4e92BozoT6VYNZW4Nr219vBNSdmG/X71nyZdClov+9a/uHQTsiA2lxbo4RhP3h4Pjk
	BizRITv8lcHqhvWLz9EKzByFG18m8n8=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-558-6Uy9JvgtNs2E9FmJE9_hnA-1; Wed, 31 Jan 2024 04:13:05 -0500
X-MC-Unique: 6Uy9JvgtNs2E9FmJE9_hnA-1
Received: by mail-ua1-f71.google.com with SMTP id a1e0cc1a2514c-7d2dfe84153so3292323241.3
        for <linux-s390@vger.kernel.org>; Wed, 31 Jan 2024 01:13:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706692385; x=1707297185;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=60OE93oZxMpAy5PTfrRWb+NgmfRgxzqKxIV3hKWBwnk=;
        b=VLg8aRnVVW5uI1rWPfcZnxLthHjyOMy5jltUW5+L6vnm7OJs3K8WXsQWEOk70EGHEn
         KANGW1yzEfWryPK3Bv7e7GhyNZQAWa7hmUQwcmwycaoe7KPpmookMam0ox2Ed3ChzU63
         RhEaZ49lpEA2m+T+kU2NC/EctlXxC6+NU7kkPGytLYIxly7miraA1d2vMzk+iw+ktM6C
         cbpseB4sEcj3cukmH1bCRd4nK0RgyHl+rQ6XwEDu6dQYJC0kfvbisVtfc8cEKwgpnLRg
         0aCC+uWtto75GS5gOdcJrFWBgyGiHy5cmhsZEt8E9bCewc+u4XqaGcX6ijrK4S+aaC46
         UTXw==
X-Gm-Message-State: AOJu0YyG+cXcp/q7y2N1GoDBry8GG2w9yNpSRovr/m3MeC3rv01Zxr0C
	/GZ+wWEmDQy7mDa8i/2rHPfRykxxKXddB+2RG+rbD5pDanRTra106gc4DCcGf5OaRdvj10K+ylm
	pi1HCdAsAiH0R9xRB8f5tyr1mLFrtSMEUdxiRQF4lc4lO0MwdR48prJF/GKi3yU2y+n/12y/8hS
	Kd1JKsJpbbodxFsMH1mYKbKrMuuWTuLmnEIA==
X-Received: by 2002:a05:6102:3a72:b0:46b:3515:e946 with SMTP id bf18-20020a0561023a7200b0046b3515e946mr689890vsb.26.1706692384888;
        Wed, 31 Jan 2024 01:13:04 -0800 (PST)
X-Google-Smtp-Source: AGHT+IEgfhT0+kNvJvRq3b0MROwRjSrfE5RBznl53uEMT/GjL79yJlQ2dVHq4B1TZ1jfZQ3KLNrl4yziYblN9FfKH0U=
X-Received: by 2002:a05:6102:3a72:b0:46b:3515:e946 with SMTP id
 bf18-20020a0561023a7200b0046b3515e946mr689871vsb.26.1706692384618; Wed, 31
 Jan 2024 01:13:04 -0800 (PST)
Precedence: bulk
X-Mailing-List: linux-s390@vger.kernel.org
List-Id: <linux-s390.vger.kernel.org>
List-Subscribe: <mailto:linux-s390+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-s390+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
References: <20240130114224.86536-1-xuanzhuo@linux.alibaba.com> <20240130114224.86536-18-xuanzhuo@linux.alibaba.com>
In-Reply-To: <20240130114224.86536-18-xuanzhuo@linux.alibaba.com>
From: Jason Wang <jasowang@redhat.com>
Date: Wed, 31 Jan 2024 17:12:47 +0800
Message-ID: <CACGkMEv2cyuesaTx899hwZt7uDdqwmAwXJ8fZDv00W9FbVbTpw@mail.gmail.com>
Subject: Re: [PATCH vhost 17/17] virtio_net: sq support premapped mode
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

On Tue, Jan 30, 2024 at 7:43=E2=80=AFPM Xuan Zhuo <xuanzhuo@linux.alibaba.c=
om> wrote:
>
> If the xsk is enabling, the xsk tx will share the send queue.
> But the xsk requires that the send queue use the premapped mode.
> So the send queue must support premapped mode.
>
> Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> ---
>  drivers/net/virtio_net.c | 167 ++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 163 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> index 226ab830870e..cf0c67380b07 100644
> --- a/drivers/net/virtio_net.c
> +++ b/drivers/net/virtio_net.c
> @@ -46,6 +46,7 @@ module_param(napi_tx, bool, 0644);
>  #define VIRTIO_XDP_REDIR       BIT(1)
>
>  #define VIRTIO_XDP_FLAG        BIT(0)
> +#define VIRTIO_DMA_FLAG        BIT(1)
>
>  /* RX packet size EWMA. The average packet size is used to determine the=
 packet
>   * buffer size when refilling RX rings. As the entire RX ring may be ref=
illed
> @@ -140,6 +141,21 @@ struct virtnet_rq_dma {
>         u16 need_sync;
>  };
>
> +struct virtnet_sq_dma {
> +       union {
> +               struct virtnet_sq_dma *next;
> +               void *data;
> +       };
> +       dma_addr_t addr;
> +       u32 len;
> +       bool is_tail;
> +};
> +
> +struct virtnet_sq_dma_head {
> +       struct virtnet_sq_dma *free;
> +       struct virtnet_sq_dma *head;

Any reason the head must be a pointer instead of a simple index?

> +};
> +
>  /* Internal representation of a send virtqueue */
>  struct send_queue {
>         /* Virtqueue associated with this send _queue */
> @@ -159,6 +175,8 @@ struct send_queue {
>
>         /* Record whether sq is in reset state. */
>         bool reset;
> +
> +       struct virtnet_sq_dma_head dmainfo;
>  };
>
>  /* Internal representation of a receive virtqueue */
> @@ -348,6 +366,131 @@ static struct xdp_frame *ptr_to_xdp(void *ptr)
>         return (struct xdp_frame *)((unsigned long)ptr & ~VIRTIO_XDP_FLAG=
);
>  }
>
> +static inline void *virtnet_sq_unmap(struct send_queue *sq, void *data)
> +{
> +       struct virtnet_sq_dma *head, *tail;
> +
> +       if (!((unsigned long)data & VIRTIO_DMA_FLAG))
> +               return data;
> +
> +       head =3D (void *)((unsigned long)data & ~VIRTIO_DMA_FLAG);
> +
> +       tail =3D head;
> +
> +       while (true) {
> +               virtqueue_dma_unmap_page_attrs(sq->vq, tail->addr, tail->=
len,
> +                                              DMA_TO_DEVICE, 0);
> +
> +               if (tail->is_tail)
> +                       break;
> +
> +               tail =3D tail->next;
> +       }
> +
> +       data =3D tail->data;
> +       tail->is_tail =3D false;
> +
> +       tail->next =3D sq->dmainfo.free;
> +       sq->dmainfo.free =3D head;
> +
> +       return data;
> +}
> +
> +static void *virtnet_sq_dma_splice(struct send_queue *sq,
> +                                  struct virtnet_sq_dma *head,
> +                                  struct virtnet_sq_dma *tail,
> +                                  void *data)
> +{
> +       sq->dmainfo.free =3D tail->next;
> +
> +       tail->is_tail =3D true;
> +       tail->data =3D data;
> +
> +       head =3D (void *)((unsigned long)head | VIRTIO_DMA_FLAG);
> +
> +       return head;
> +}
> +
> +static struct virtnet_sq_dma *virtnet_sq_map_sg(struct send_queue *sq, i=
nt nents, void *data)
> +{
> +       struct virtnet_sq_dma *head, *tail, *p;
> +       struct scatterlist *sg;
> +       dma_addr_t addr;
> +       int i;
> +
> +       head =3D sq->dmainfo.free;
> +       p =3D head;
> +
> +       tail =3D NULL;
> +
> +       for_each_sg(sq->sg, sg, nents, i) {
> +               addr =3D virtqueue_dma_map_page_attrs(sq->vq, sg_page(sg)=
,
> +                                                   sg->offset, sg->lengt=
h,
> +                                                   DMA_TO_DEVICE, 0);
> +               if (virtqueue_dma_mapping_error(sq->vq, addr))
> +                       goto err;
> +
> +               sg->dma_address =3D addr;
> +
> +               tail =3D p;
> +               tail->addr =3D sg->dma_address;
> +               tail->len =3D sg->length;
> +
> +               p =3D p->next;
> +       }
> +
> +       return virtnet_sq_dma_splice(sq, head, tail, data);
> +
> +err:
> +       if (tail)
> +               virtnet_sq_unmap(sq, virtnet_sq_dma_splice(sq, head, tail=
, data));
> +
> +       return NULL;
> +}
> +
> +static int virtnet_add_outbuf(struct send_queue *sq, u32 num, void *data=
)
> +{
> +       int ret;
> +
> +       if (sq->vq->premapped) {
> +               data =3D virtnet_sq_map_sg(sq, num, data);
> +               if (!data)
> +                       return -ENOMEM;
> +       }
> +
> +       ret =3D virtqueue_add_outbuf(sq->vq, sq->sg, num, data, GFP_ATOMI=
C);
> +       if (ret && sq->vq->premapped)
> +               virtnet_sq_unmap(sq, data);
> +
> +       return ret;
> +}
> +
> +static int virtnet_sq_init_dma_mate(struct send_queue *sq)
> +{
> +       struct virtnet_sq_dma *d;
> +       int size, i;
> +
> +       size =3D virtqueue_get_vring_size(sq->vq);
> +
> +       size +=3D MAX_SKB_FRAGS + 2;

Is this enough for the case where an indirect descriptor is used?

Thanks

