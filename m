Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22FE0C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  8 Jul 2022 06:21:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237266AbiGHGVT (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Jul 2022 02:21:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237271AbiGHGVO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Jul 2022 02:21:14 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6167A2C109
        for <linux-s390@vger.kernel.org>; Thu,  7 Jul 2022 23:21:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1657261272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=vucI6v2UNiSkfdv0+LNa4VjRInUBJ0CkIXv+ERyy8hk=;
        b=eVJmhLQWYawQG84H/6Ej8fTXvMKeYR8yXZK9LgLzt1HtO4YtMH2McfxFijisV3ieo73Opk
        xmo5vNHG3xZJUEsxUPX2C86S40rlXsolTqw4hrKqJmEoVE5ebwu10yky0UsqAK33nIfoP2
        uyzVr/7xSpsue+EVDXa3wapLSvTYf6g=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-648-VhSSI3HMNmWQVsTyAztzaw-1; Fri, 08 Jul 2022 02:21:05 -0400
X-MC-Unique: VhSSI3HMNmWQVsTyAztzaw-1
Received: by mail-lj1-f197.google.com with SMTP id g3-20020a2e9cc3000000b00253cc2b5ab5so5790324ljj.19
        for <linux-s390@vger.kernel.org>; Thu, 07 Jul 2022 23:21:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=vucI6v2UNiSkfdv0+LNa4VjRInUBJ0CkIXv+ERyy8hk=;
        b=ulAK8e89GbjagFFlL7K99h/PfOkbu6fdMnjRcjn9nRivOFmHVtw6ODUmUQtSKvSmpC
         uCtrESBjtYyV/a1a38fYeRPa1z6gpGhhh78bNM/6s5keEf+1VpW6a7/zlSuCyy6P449q
         rXdIbz6YLMMK5ztYJvR0PgQ/IQtB3M1eO/hrwks1xOcZENV+CpGvD0Yj1Dr31/NQNBLa
         sVZ1sRDozpv4pSc+qfW55mA/L9eyfRFk2AFkihWATTB2vJkViHZKswDcFyPCoyig10pa
         xdaisej9P9woScCYwEd1jIxC8EvjuuPXyMz+KeCplDo4z4Yqy6LRJXRQl/7ySL6/6aoI
         hU3w==
X-Gm-Message-State: AJIora+KNjoUC3hK+v5CBeFTMXtzlW7sRdYwSibZIcRCsYXrF56wA4q6
        k6zpLJbaaI86z2DWuOokGIuDMRyVyPk5isNhuMPNU1wFfRhn2X175IMRGpfUAU/YHaJQnAX68UA
        IISwtG4R+424Xi3j49cBgLeJLs5yscfRVV+/bMQ==
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id p16-20020a2e9ad0000000b0025a715626bbmr999479ljj.141.1657261263910;
        Thu, 07 Jul 2022 23:21:03 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1siGvuif2Z3b/qz6BV5rwXiRX4Y2KnHOm/sW0UQhHOR8L3Ua/tIp6J6o+V7iV6847cM54TvfHUP9+sN1Wog1zw=
X-Received: by 2002:a2e:9ad0:0:b0:25a:7156:26bb with SMTP id
 p16-20020a2e9ad0000000b0025a715626bbmr999458ljj.141.1657261263714; Thu, 07
 Jul 2022 23:21:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220629065656.54420-1-xuanzhuo@linux.alibaba.com>
 <20220629065656.54420-39-xuanzhuo@linux.alibaba.com> <c0747cbc-685b-85a9-1931-0124124755f2@redhat.com>
 <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
In-Reply-To: <1656986375.3420787-1-xuanzhuo@linux.alibaba.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Fri, 8 Jul 2022 14:20:52 +0800
Message-ID: <CACGkMEu80KP-ULz_CBvauRk_3XsCubMkkWv0uLnbt-wib5KOnA@mail.gmail.com>
Subject: Re: [PATCH v11 38/40] virtio_net: support rx queue resize
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>
Cc:     Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Johannes Berg <johannes@sipsolutions.net>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>,
        kangjie.xu@linux.alibaba.com,
        virtualization <virtualization@lists.linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 5, 2022 at 10:00 AM Xuan Zhuo <xuanzhuo@linux.alibaba.com> wrot=
e:
>
> On Mon, 4 Jul 2022 11:44:12 +0800, Jason Wang <jasowang@redhat.com> wrote=
:
> >
> > =E5=9C=A8 2022/6/29 14:56, Xuan Zhuo =E5=86=99=E9=81=93:
> > > This patch implements the resize function of the rx queues.
> > > Based on this function, it is possible to modify the ring num of the
> > > queue.
> > >
> > > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > > ---
> > >   drivers/net/virtio_net.c | 22 ++++++++++++++++++++++
> > >   1 file changed, 22 insertions(+)
> > >
> > > diff --git a/drivers/net/virtio_net.c b/drivers/net/virtio_net.c
> > > index 9fe222a3663a..6ab16fd193e5 100644
> > > --- a/drivers/net/virtio_net.c
> > > +++ b/drivers/net/virtio_net.c
> > > @@ -278,6 +278,8 @@ struct padded_vnet_hdr {
> > >     char padding[12];
> > >   };
> > >
> > > +static void virtnet_rq_free_unused_buf(struct virtqueue *vq, void *b=
uf);
> > > +
> > >   static bool is_xdp_frame(void *ptr)
> > >   {
> > >     return (unsigned long)ptr & VIRTIO_XDP_FLAG;
> > > @@ -1846,6 +1848,26 @@ static netdev_tx_t start_xmit(struct sk_buff *=
skb, struct net_device *dev)
> > >     return NETDEV_TX_OK;
> > >   }
> > >
> > > +static int virtnet_rx_resize(struct virtnet_info *vi,
> > > +                        struct receive_queue *rq, u32 ring_num)
> > > +{
> > > +   int err, qindex;
> > > +
> > > +   qindex =3D rq - vi->rq;
> > > +
> > > +   napi_disable(&rq->napi);
> >
> >
> > Do we need to cancel the refill work here?
>
>
> I think no, napi_disable is mutually exclusive, which ensures that there =
will be
> no conflicts between them.

So this sounds similar to what I've fixed recently.

1) NAPI schedule delayed work.
2) we disable NAPI here
3) delayed work get schedule and call NAPI again

?

Thanks

>
> Thanks.
>
> >
> > Thanks
> >
> >
> > > +
> > > +   err =3D virtqueue_resize(rq->vq, ring_num, virtnet_rq_free_unused=
_buf);
> > > +   if (err)
> > > +           netdev_err(vi->dev, "resize rx fail: rx queue index: %d e=
rr: %d\n", qindex, err);
> > > +
> > > +   if (!try_fill_recv(vi, rq, GFP_KERNEL))
> > > +           schedule_delayed_work(&vi->refill, 0);
> > > +
> > > +   virtnet_napi_enable(rq->vq, &rq->napi);
> > > +   return err;
> > > +}
> > > +
> > >   /*
> > >    * Send command via the control virtqueue and check status.  Comman=
ds
> > >    * supported by the hypervisor, as indicated by feature bits, shoul=
d
> >
>

