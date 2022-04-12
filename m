Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61275C433F5
	for <linux-s390@archiver.kernel.org>; Tue, 12 Apr 2022 02:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245558AbiDLCvy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 11 Apr 2022 22:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243245AbiDLCvw (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 11 Apr 2022 22:51:52 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C83742229E
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 19:49:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649731774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=fJBNte/3e7GfibiQrK4sBywM+oAime7uDuFoDGQDJlo=;
        b=RMEiL5h948Si5TwZueZB+WuaEr65E5Lsep0SVPubgwd1G94r6BEK/uXkkj7TuHeW9nOzyl
        EMhi+7678KH2cxyK8gm/hyYQeYMrK+itZPiSAzioRP+jrzg9Q54nZTAa6i5pQ0hRl0zdjR
        UUstmf4DnRFcsb2cwleupZAEPOq/Cfw=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-127-7ynwakBNPC291biTF2AHbA-1; Mon, 11 Apr 2022 22:49:33 -0400
X-MC-Unique: 7ynwakBNPC291biTF2AHbA-1
Received: by mail-lf1-f70.google.com with SMTP id n2-20020a0565120ac200b0044a2c76f7e1so5287445lfu.5
        for <linux-s390@vger.kernel.org>; Mon, 11 Apr 2022 19:49:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=fJBNte/3e7GfibiQrK4sBywM+oAime7uDuFoDGQDJlo=;
        b=2/f6yc/dlchZhxhCJXH0Yqfb+HhkYXDrHwSvlpxRiMuXBgzOapj9I8S8NdlcWFFvTx
         /29+TpHRM6K8xMMkO6aBPLTLfbrGqmI6TSU1NAu7ZVsqobcfOMBgR96i6IwK+RIPSUHQ
         JyLXA248lJxtSTPK8lNJneILefbGpT0MSkoZ14nQRH1pYBAKV6UXfEXnpjQnI004LYzy
         3RVVg6ojK4SpCzyzW2Lz8raxYAsYLVhf864JqLlkwpAdMkWbDDyL3Io4B+fq+Q6Gwf7O
         CoT5fDo4F5OYrcsnWZnldhsmYjZ7pQrMVdIcMTfv5u9m7DTvbwmPm/JIBbuoSEBjk/8u
         kHnQ==
X-Gm-Message-State: AOAM531DMsR1IZcmMkiVzDEuRMj9lIOzl5wJ7XGxzQs/HhVJitf19TmK
        1qUyY3biWgRbPemTnBKjyVBZTbBmP9WkZGpvLKRtcy4oLZ3vUyChcGntUyRlf/hGOwLHOlk7Awc
        wrYzLuHxuuidCsTMnEaW1zIfEjDpqhwZcbYUZLw==
X-Received: by 2002:a2e:b53a:0:b0:24b:12f7:237b with SMTP id z26-20020a2eb53a000000b0024b12f7237bmr22142546ljm.177.1649731772197;
        Mon, 11 Apr 2022 19:49:32 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJz5gifaFaCekGQJ1T+aENC3f64ZQLZ890sWCpVm+zpEZs7NBKRTWSl38qWP6QLR7AWdmzIlDvMoCmEZyQhCI0I=
X-Received: by 2002:a2e:b53a:0:b0:24b:12f7:237b with SMTP id
 z26-20020a2eb53a000000b0024b12f7237bmr22142498ljm.177.1649731771824; Mon, 11
 Apr 2022 19:49:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220406034346.74409-1-xuanzhuo@linux.alibaba.com>
 <20220406034346.74409-3-xuanzhuo@linux.alibaba.com> <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
In-Reply-To: <9868de23-c171-2492-a43f-78f51df84640@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 12 Apr 2022 10:49:20 +0800
Message-ID: <CACGkMEvgO=QsBjHZLhW72gsnWUp6JWOZkSrVZYHBmPoP+KhTZg@mail.gmail.com>
Subject: Re: [PATCH v9 02/32] virtio: struct virtio_config_ops add callbacks
 for queue_reset
To:     Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        virtualization <virtualization@lists.linux-foundation.org>
Cc:     Jeff Dike <jdike@addtoit.com>, Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Hans de Goede <hdegoede@redhat.com>,
        Mark Gross <markgross@kernel.org>,
        Vadim Pasternak <vadimp@nvidia.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Jesper Dangaard Brouer <hawk@kernel.org>,
        John Fastabend <john.fastabend@gmail.com>,
        Johannes Berg <johannes.berg@intel.com>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>,
        linux-um@lists.infradead.org, netdev <netdev@vger.kernel.org>,
        platform-driver-x86@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-s390@vger.kernel.org,
        kvm <kvm@vger.kernel.org>,
        "open list:XDP (eXpress Data Path)" <bpf@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Apr 12, 2022 at 10:47 AM Jason Wang <jasowang@redhat.com> wrote:
>
>
> =E5=9C=A8 2022/4/6 =E4=B8=8A=E5=8D=8811:43, Xuan Zhuo =E5=86=99=E9=81=93:
> > Performing reset on a queue is divided into four steps:
> >
> >   1. transport: notify the device to reset the queue
> >   2. vring:     recycle the buffer submitted
> >   3. vring:     reset/resize the vring (may re-alloc)
> >   4. transport: mmap vring to device, and enable the queue
>
>
> Nit: it looks to me we'd better say it's an example (since step 3 or
> even 2 is not a must).
>
>
> >
> > In order to support queue reset, add two callbacks(reset_vq,
> > enable_reset_vq) in struct virtio_config_ops to implement steps 1 and 4=
.
> >
> > Signed-off-by: Xuan Zhuo <xuanzhuo@linux.alibaba.com>
> > ---
> >   include/linux/virtio_config.h | 12 ++++++++++++
> >   1 file changed, 12 insertions(+)
> >
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_confi=
g.h
> > index 4d107ad31149..d4adcd0e1c57 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -74,6 +74,16 @@ struct virtio_shm_region {
> >    * @set_vq_affinity: set the affinity for a virtqueue (optional).
> >    * @get_vq_affinity: get the affinity for a virtqueue (optional).
> >    * @get_shm_region: get a shared memory region based on the index.
> > + * @reset_vq: reset a queue individually (optional).
> > + *   vq: the virtqueue
> > + *   Returns 0 on success or error status
> > + *   reset_vq will guarantee that the callbacks are disabled and synch=
ronized.
> > + *   Except for the callback, the caller should guarantee that the vri=
ng is
>
>
> I wonder what's the implications for virtio hardening[1]. In that

For [1] I meant
https://lore.kernel.org/lkml/20220406083538.16274-1-jasowang@redhat.com/

Thanks


> series, we agree to have a synchronize_vqs() config ops to make sure
> callbacks are synchronized.
>
> It uses a global flag and a device wise synchronization mechanism. It
> looks to me we need to switch to
>
> 1) per virtqueue flag
> 2) per virtqueue synchronization
>
> Thanks
>
>
> > + *   not accessed by any functions of virtqueue.
> > + * @enable_reset_vq: enable a reset queue
> > + *   vq: the virtqueue
> > + *   Returns 0 on success or error status
> > + *   If reset_vq is set, then enable_reset_vq must also be set.
> >    */
> >   typedef void vq_callback_t(struct virtqueue *);
> >   struct virtio_config_ops {
> > @@ -100,6 +110,8 @@ struct virtio_config_ops {
> >                       int index);
> >       bool (*get_shm_region)(struct virtio_device *vdev,
> >                              struct virtio_shm_region *region, u8 id);
> > +     int (*reset_vq)(struct virtqueue *vq);
> > +     int (*enable_reset_vq)(struct virtqueue *vq);
> >   };
> >
> >   /* If driver didn't advertise the feature, it will never appear. */

