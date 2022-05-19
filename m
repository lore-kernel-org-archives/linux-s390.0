Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C36A7C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 08:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230046AbiESIIi (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 04:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229484AbiESIIi (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 04:08:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4B6B85C36C
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:08:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652947716;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
        b=YglDRBKj6NtFtEJYgfjfIpd1ByEZctatedn6v9j81LNqt+xhBZV61SoFn79PG0s02KGQUu
        a/UgZ74/I1bUEYl+5IjHPdee1b7/n8vcOIg0ctb8k6uydrnF8a3j4nl7JLUs+qp16r4rQV
        lh8SI1THDehlZ7EwnriNP+yGI6IbaaE=
Received: from mail-lj1-f200.google.com (mail-lj1-f200.google.com
 [209.85.208.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-92-lEGz_3izPp6j-fCwQIZ0pQ-1; Thu, 19 May 2022 04:08:35 -0400
X-MC-Unique: lEGz_3izPp6j-fCwQIZ0pQ-1
Received: by mail-lj1-f200.google.com with SMTP id a8-20020a2e7f08000000b00253c7e7f572so902738ljd.1
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:08:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PaRT19em+T4GPwPQ/T0xXwQTdvktI3d/a43tTl0NNkw=;
        b=napWHYbsBmaAWu+ljEHAoKSgsZsRWDFpPX6kAu8bj/saEXXI7RMV10+53c6h6kFoKm
         68Pquz7d6tOSbREn/ljoPE9aJLo7FEhW42dsINUc9rwoGE8GRotVL3BiRgIehxnFxnd3
         VFi9IPV9a9O7pRzsDeSrarY0lf8+qlNyjppIhCx/aU8lZPeroGPEtcLKCCam9K+TrIbB
         eGbNq5YB1FN550R7U7KZOVjS+TgXrNDkWX0j2gPw3Dp33VDiuLqAPFrLCGgwxPuRUn4Q
         PaJsRgo/gCXKE+5rQ2Dp8vMPtdVuuUcil7E4ITGT8IThM8yr9e2mEeIPjFphzIlTFfEa
         QK5g==
X-Gm-Message-State: AOAM530lz/ovFaw5qnApmX+nV1MDXCUJNRcxp1W0oFRbuVKiwqswy62R
        dM85va2r1YDC3Zqcg+KPNsA5R+6a0MAScFuTmHBwdiKGRAN+Mtk2o7JAdCCXkE+Px25tOqjJfsZ
        XwY2H0MJSSgo0L9mINm651EDVY24zKWtwk4qOvw==
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id o5-20020a2ebd85000000b002509bf28e27mr1936022ljq.177.1652947713555;
        Thu, 19 May 2022 01:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzTVSo9SydbYuTdAcj6vvShrXEBo1eZDTyMXTBaYDqgH2C2D8RyXds5Ke02dPdHxXw8Kdl7wrNxJTIMixKQCm4=
X-Received: by 2002:a2e:bd85:0:b0:250:9bf2:8e27 with SMTP id
 o5-20020a2ebd85000000b002509bf28e27mr1936002ljq.177.1652947713385; Thu, 19
 May 2022 01:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com> <20220518035951.94220-8-jasowang@redhat.com>
 <87r14rf983.fsf@redhat.com>
In-Reply-To: <87r14rf983.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 May 2022 16:08:22 +0800
Message-ID: <CACGkMEs7f63SDxed0qg4XVspJ9cSCTRrV8R-MUUVQCvjAXp+DA@mail.gmail.com>
Subject: Re: [PATCH V5 7/9] virtio: allow to unbreak virtqueue
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     mst <mst@redhat.com>,
        virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        eperezma <eperezma@redhat.com>, Cindy Lu <lulu@redhat.com>,
        Stefano Garzarella <sgarzare@redhat.com>,
        Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, May 18, 2022 at 6:04 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch allows the new introduced __virtio_break_device() to
> > unbreak the virtqueue.
> >
> > Cc: Thomas Gleixner <tglx@linutronix.de>
> > Cc: Peter Zijlstra <peterz@infradead.org>
> > Cc: "Paul E. McKenney" <paulmck@kernel.org>
> > Cc: Marc Zyngier <maz@kernel.org>
> > Cc: Halil Pasic <pasic@linux.ibm.com>
> > Cc: Cornelia Huck <cohuck@redhat.com>
> > Cc: Vineeth Vijayan <vneethv@linux.ibm.com>
> > Cc: Peter Oberparleiter <oberpar@linux.ibm.com>
> > Cc: linux-s390@vger.kernel.org
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> >  drivers/virtio/virtio_ring.c | 21 +++++++++++++++++++++
> >  include/linux/virtio.h       |  1 +
> >  2 files changed, 22 insertions(+)
> >
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index cfb028ca238e..5b7df7c455f0 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2397,6 +2397,27 @@ void virtio_break_device(struct virtio_device *dev)
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_break_device);
> >
> > +/*
> > + * This should allow the device to be used by the driver. You may
> > + * need to grab appropriate locks to flush. This should only be used
>
> Hm, to flush what?

How about "to flush the write to vq->broken"?

>
> > + * in some specific case e.g (probing and restoring). Driver should
> > + * not call this directly.
>
> Maybe "This function should only be called by the core, not directly by
> the driver."?

Ok.

Thanks

>
> > + */
> > +void __virtio_unbreak_device(struct virtio_device *dev)
> > +{
> > +     struct virtqueue *_vq;
> > +
> > +     spin_lock(&dev->vqs_list_lock);
> > +     list_for_each_entry(_vq, &dev->vqs, list) {
> > +             struct vring_virtqueue *vq = to_vvq(_vq);
> > +
> > +             /* Pairs with READ_ONCE() in virtqueue_is_broken(). */
> > +             WRITE_ONCE(vq->broken, false);
> > +     }
> > +     spin_unlock(&dev->vqs_list_lock);
> > +}
> > +EXPORT_SYMBOL_GPL(__virtio_unbreak_device);
> > +
> >  dma_addr_t virtqueue_get_desc_addr(struct virtqueue *_vq)
> >  {
> >       struct vring_virtqueue *vq = to_vvq(_vq);
>

