Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77A71C433EF
	for <linux-s390@archiver.kernel.org>; Thu, 19 May 2022 08:02:56 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232541AbiESICy (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 19 May 2022 04:02:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235110AbiESICr (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 19 May 2022 04:02:47 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4730D57179
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:02:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1652947365;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
        b=LHQMQSUHiRGj6vv9A4x+UN4aJUlN8/oDsWNhfyWtQkmYn625XTwbAD9M2iUO9/kbNohxXF
        YaxBus9WICDEOR3APB3zXxTJgD48lh5CG1GP43EuKHm1xpWNCjywRuaKMsl6WqIWH/6hxA
        sOr1mbEJMIr+d7zqDb78A1pANjybjIQ=
Received: from mail-lj1-f199.google.com (mail-lj1-f199.google.com
 [209.85.208.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-401-cGVyrzp6MSqI98v_3n9xcQ-1; Thu, 19 May 2022 04:02:43 -0400
X-MC-Unique: cGVyrzp6MSqI98v_3n9xcQ-1
Received: by mail-lj1-f199.google.com with SMTP id a8-20020a2e7f08000000b00253c7e7f572so898381ljd.1
        for <linux-s390@vger.kernel.org>; Thu, 19 May 2022 01:02:43 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBpdwym2ArG4EquWnWSi2ftom73RXQQa+Rs2uQPWbKQ=;
        b=bS/xES8pwXEGsqkFYNT9/qLR3QssbZTA32UzfUkp2dNNqoEp6X2KODSV/LyNHATXhy
         76wnrIGMI2wQR/4w+djA1pk19468bQo7lYc3CZ/2ZJitE5KpT3on8F544l5oteV75vL5
         2RZ8eR5BGfdjQvF6RP5/08LcfT1EPJADk1NPxtpgFcQcsrK80JEa+pjP2qzW7zZxv9/E
         C0DzKoZVTGpS72NOFKiNYDHylYXnaik1LSfnsyh7zRm+bYhddTugZ4k7Ynh4qYW7/D8J
         Dh0/biwgk2lAyVhqP4Mw7x1eWu0YXiCXyCzcfDRszROxE8RfcIF0JyrgjGXiD9ev84EP
         n7ow==
X-Gm-Message-State: AOAM533HA3rqnbQef/oYLQygFqcY0C6xpMsEf4dH9Saq/P/4vuAES/Vy
        QW9MXKLBIJFvz7P6WwrqdVwDSjZd9GkwTSKGw6fgPyTapxbci3tF/BL7bal+jnJ9s9yIabmoOH0
        KEOz3hhpo+OYGT51muD+BFzxzqk6dJCjpGs7ccQ==
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id p21-20020a056512139500b00446d38279a5mr2463632lfa.210.1652947362409;
        Thu, 19 May 2022 01:02:42 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwnED6RSEVAGwD+6jZQlEqqnkm9njtiJZnFEYibosooBXmmsa4+cJ2PSgTUPo3sWmsUgAZgWgEnJrDT+wPlxRw=
X-Received: by 2002:a05:6512:1395:b0:446:d382:79a5 with SMTP id
 p21-20020a056512139500b00446d38279a5mr2463601lfa.210.1652947362047; Thu, 19
 May 2022 01:02:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220518035951.94220-1-jasowang@redhat.com> <20220518035951.94220-7-jasowang@redhat.com>
 <87tu9nfaoe.fsf@redhat.com>
In-Reply-To: <87tu9nfaoe.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Thu, 19 May 2022 16:02:30 +0800
Message-ID: <CACGkMEsiMQ7zDZ6r-q2W=yFqW8WbMEwUc8OFd+o1JzUL-E19Ew@mail.gmail.com>
Subject: Re: [PATCH V5 6/9] virtio-ccw: implement synchronize_cbs()
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

On Wed, May 18, 2022 at 5:32 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Wed, May 18 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > This patch tries to implement the synchronize_cbs() for ccw. For the
> > vring_interrupt() that is called via virtio_airq_handler(), the
> > synchronization is simply done via the airq_info's lock. For the
> > vring_interrupt() that is called via virtio_ccw_int_handler(), a per
> > device rwlock is introduced ans used in the synchronization method.
>
> s/ans/and/
>

Will fix.

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
> >  drivers/s390/virtio/virtio_ccw.c | 27 +++++++++++++++++++++++++++
> >  1 file changed, 27 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index d35e7a3f7067..22d36594bcdd 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -62,6 +62,7 @@ struct virtio_ccw_device {
> >       unsigned int revision; /* Transport revision */
> >       wait_queue_head_t wait_q;
> >       spinlock_t lock;
> > +     rwlock_t irq_lock;
> >       struct mutex io_lock; /* Serializes I/O requests */
> >       struct list_head virtqueues;
> >       bool is_thinint;
> > @@ -984,6 +985,27 @@ static const char *virtio_ccw_bus_name(struct virtio_device *vdev)
> >       return dev_name(&vcdev->cdev->dev);
> >  }
> >
> > +static void virtio_ccw_synchronize_cbs(struct virtio_device *vdev)
> > +{
> > +     struct virtio_ccw_device *vcdev = to_vc_device(vdev);
> > +     struct airq_info *info = vcdev->airq_info;
> > +
> > +     if (info) {
> > +             /*
> > +              * Synchronize with the vring_interrupt() with airq indicator
>
> Maybe
>
> /*
>  * This device uses adapter interrupts: synchronize with
>  * vring_interrupt() called by virtio_airq_handler() via the indicator
>  * area lock.
>  */
>

Fine.

> > +              */
> > +             write_lock_irq(&info->lock);
> > +             write_unlock_irq(&info->lock);
> > +     } else {
> > +             /*
> > +              * Synchronize with the vring_interrupt() called by
> > +              * virtio_ccw_int_handler().
>
> /*
>  * This device uses classic interrupts: synchronize with
>  * vring_interrupt() called by virtio_ccw_int_handler() via the
>  * per-device irq_lock.
>  */
>

Looks fine.

> > +              */
> > +             write_lock_irq(&vcdev->irq_lock);
> > +             write_unlock_irq(&vcdev->irq_lock);
> > +     }
> > +}
> > +
> >  static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .get_features = virtio_ccw_get_features,
> >       .finalize_features = virtio_ccw_finalize_features,
> > @@ -995,6 +1017,7 @@ static const struct virtio_config_ops virtio_ccw_config_ops = {
> >       .find_vqs = virtio_ccw_find_vqs,
> >       .del_vqs = virtio_ccw_del_vqs,
> >       .bus_name = virtio_ccw_bus_name,
> > +     .synchronize_cbs = virtio_ccw_synchronize_cbs,
> >  };
> >
> >
> > @@ -1106,6 +1129,8 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +     /* Local interrupt should be disabled at this time */
>
> /* Interrupts are disabled here. */
>
> ?
>
> Interrupts enabled here would surely be a bug.

Right.

Thanks

>
> > +     read_lock(&vcdev->irq_lock);
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
>

