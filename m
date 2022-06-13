Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BC29C43334
	for <linux-s390@archiver.kernel.org>; Mon, 13 Jun 2022 05:27:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231645AbiFMF1R (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 13 Jun 2022 01:27:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiFMF1Q (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 13 Jun 2022 01:27:16 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A48CFCE25
        for <linux-s390@vger.kernel.org>; Sun, 12 Jun 2022 22:27:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655098034;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IL4VED6YmG0etJ0q08o0zkJsamndtz5NfelOHtzFlL0=;
        b=Xo4vBQpMbnjlXt9g24H9vqLldl4R7sK3e2K4Gln+7xAHxu2klLO3CegO4g0n/1Qkwy4+0+
        +RtgVaIxmN2lOvdQNViL92ggnp1QOwgeSyUJ4MTNl1l4uQZ+2tNz2NwlHGxJmtwKIidBKs
        zVL70cN3+Xy2fEp2ROmhCvggAKJPYaQ=
Received: from mail-lf1-f70.google.com (mail-lf1-f70.google.com
 [209.85.167.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-480-wI5nx6FPNeGpOQdpq1SN_w-1; Mon, 13 Jun 2022 01:27:12 -0400
X-MC-Unique: wI5nx6FPNeGpOQdpq1SN_w-1
Received: by mail-lf1-f70.google.com with SMTP id bq13-20020a056512150d00b0047908a2e33cso2547987lfb.16
        for <linux-s390@vger.kernel.org>; Sun, 12 Jun 2022 22:27:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IL4VED6YmG0etJ0q08o0zkJsamndtz5NfelOHtzFlL0=;
        b=h9kfb7ZY8hg4HO6wJNzWkYaZJ9vrZWVm4mLORzSW75dTX9ax6jsCN7Xe3sOQxdcAh2
         +bvl2W2dj8PEnD6tI8M+XO0TQX+Vj8b5MtFJM3hBiPS96TW/hXGQz1te5YGjXTFuoDFf
         ELmsjSWNqmzRl2CSXfsmUYORnqXCTJ86PCXUCNG31LgbRQSVwIZfStoANPQnMjo1dHL5
         VXFbhoMnuYPn42JFyA0UlKGp/tpGI5JtAXgWsHkfbMhVxc4osv+iUEUNrqhxlOo5+ztg
         evO6NcInfnKt76VHyAC50FQ9LoBWjHiafYllj55u96BkmpZ25zJ+FDWyqFLL2VuBLpPN
         lA9w==
X-Gm-Message-State: AOAM5321tiCcE0A++mVil6XpaM6tMU5K3wvsvcdKP/UYzZRPQoIj+1Ip
        bfLn1QaFEqfCoi9OrjLf09LOLJ6ew4sA3rTFHnPjE47zL8meCBL09EKVxkifUE9i193tsguiiko
        V2wBIUNc9r1LuUfZp/z3ZVdNe/2RsEFX5Th7o8A==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id p37-20020a05651213a500b0047dc1d9dea8mr6054144lfa.442.1655098031004;
        Sun, 12 Jun 2022 22:27:11 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyrjsUIFndhLZ+ji5u0Oc//Oq8SKHIyK4PKaIhDleqMoDxCdG5Si3MDbzSXElfeanurs80dUc4XDYmMZ/DV+r8=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr6054138lfa.442.1655098030791; Sun, 12
 Jun 2022 22:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220527060120.20964-1-jasowang@redhat.com> <20220527060120.20964-9-jasowang@redhat.com>
 <20220611010747-mutt-send-email-mst@kernel.org>
In-Reply-To: <20220611010747-mutt-send-email-mst@kernel.org>
From:   Jason Wang <jasowang@redhat.com>
Date:   Mon, 13 Jun 2022 13:26:59 +0800
Message-ID: <CACGkMEtRP+0Xy63g0SF_y1avv=3rFv6P9+Z7kp9XBS5d+_py8w@mail.gmail.com>
Subject: Re: [PATCH V6 8/9] virtio: harden vring IRQ
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     virtualization <virtualization@lists.linux-foundation.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Marc Zyngier <maz@kernel.org>,
        Halil Pasic <pasic@linux.ibm.com>,
        Cornelia Huck <cohuck@redhat.com>,
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

On Sat, Jun 11, 2022 at 1:12 PM Michael S. Tsirkin <mst@redhat.com> wrote:
>
> On Fri, May 27, 2022 at 02:01:19PM +0800, Jason Wang wrote:
> > This is a rework on the previous IRQ hardening that is done for
> > virtio-pci where several drawbacks were found and were reverted:
> >
> > 1) try to use IRQF_NO_AUTOEN which is not friendly to affinity managed IRQ
> >    that is used by some device such as virtio-blk
> > 2) done only for PCI transport
> >
> > The vq->broken is re-used in this patch for implementing the IRQ
> > hardening. The vq->broken is set to true during both initialization
> > and reset. And the vq->broken is set to false in
> > virtio_device_ready(). Then vring_interrupt() can check and return
> > when vq->broken is true. And in this case, switch to return IRQ_NONE
> > to let the interrupt core aware of such invalid interrupt to prevent
> > IRQ storm.
> >
> > The reason of using a per queue variable instead of a per device one
> > is that we may need it for per queue reset hardening in the future.
> >
> > Note that the hardening is only done for vring interrupt since the
> > config interrupt hardening is already done in commit 22b7050a024d7
> > ("virtio: defer config changed notifications"). But the method that is
> > used by config interrupt can't be reused by the vring interrupt
> > handler because it uses spinlock to do the synchronization which is
> > expensive.
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
>
>
> Jason, I am really concerned by all the fallout.
> I propose adding a flag to suppress the hardening -
> this will be a debugging aid and a work around for
> users if we find more buggy drivers.
>
> suppress_interrupt_hardening ?

I can post a patch but I'm afraid if we disable it by default, it
won't be used by the users so there's no way for us to receive the bug
report. Or we need a plan to enable it by default.

It's rc2, how about waiting for 1 and 2 rc? Or it looks better if we
simply warn instead of disable it by default.

Thanks

>
>
> > ---
> >  drivers/s390/virtio/virtio_ccw.c       |  4 ++++
> >  drivers/virtio/virtio.c                | 15 ++++++++++++---
> >  drivers/virtio/virtio_mmio.c           |  5 +++++
> >  drivers/virtio/virtio_pci_modern_dev.c |  5 +++++
> >  drivers/virtio/virtio_ring.c           | 11 +++++++----
> >  include/linux/virtio_config.h          | 20 ++++++++++++++++++++
> >  6 files changed, 53 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index c188e4f20ca3..97e51c34e6cf 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -971,6 +971,10 @@ static void virtio_ccw_set_status(struct virtio_device *vdev, u8 status)
> >       ccw->flags = 0;
> >       ccw->count = sizeof(status);
> >       ccw->cda = (__u32)(unsigned long)&vcdev->dma_area->status;
> > +     /* We use ssch for setting the status which is a serializing
> > +      * instruction that guarantees the memory writes have
> > +      * completed before ssch.
> > +      */
> >       ret = ccw_io_helper(vcdev, ccw, VIRTIO_CCW_DOING_WRITE_STATUS);
> >       /* Write failed? We assume status is unchanged. */
> >       if (ret)
> > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > index aa1eb5132767..95fac4c97c8b 100644
> > --- a/drivers/virtio/virtio.c
> > +++ b/drivers/virtio/virtio.c
> > @@ -220,6 +220,15 @@ static int virtio_features_ok(struct virtio_device *dev)
> >   * */
> >  void virtio_reset_device(struct virtio_device *dev)
> >  {
> > +     /*
> > +      * The below virtio_synchronize_cbs() guarantees that any
> > +      * interrupt for this line arriving after
> > +      * virtio_synchronize_vqs() has completed is guaranteed to see
> > +      * vq->broken as true.
> > +      */
> > +     virtio_break_device(dev);
>
> So make this conditional
>
> > +     virtio_synchronize_cbs(dev);
> > +
> >       dev->config->reset(dev);
> >  }
> >  EXPORT_SYMBOL_GPL(virtio_reset_device);
> > @@ -428,6 +437,9 @@ int register_virtio_device(struct virtio_device *dev)
> >       dev->config_enabled = false;
> >       dev->config_change_pending = false;
> >
> > +     INIT_LIST_HEAD(&dev->vqs);
> > +     spin_lock_init(&dev->vqs_list_lock);
> > +
> >       /* We always start by resetting the device, in case a previous
> >        * driver messed it up.  This also tests that code path a little. */
> >       virtio_reset_device(dev);
> > @@ -435,9 +447,6 @@ int register_virtio_device(struct virtio_device *dev)
> >       /* Acknowledge that we've seen the device. */
> >       virtio_add_status(dev, VIRTIO_CONFIG_S_ACKNOWLEDGE);
> >
> > -     INIT_LIST_HEAD(&dev->vqs);
> > -     spin_lock_init(&dev->vqs_list_lock);
> > -
> >       /*
> >        * device_add() causes the bus infrastructure to look for a matching
> >        * driver.
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index c9699a59f93c..f9a36bc7ac27 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -253,6 +253,11 @@ static void vm_set_status(struct virtio_device *vdev, u8 status)
> >       /* We should never be setting status to 0. */
> >       BUG_ON(status == 0);
> >
> > +     /*
> > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > +      * that the the cache coherent memory writes have completed
> > +      * before writing to the MMIO region.
> > +      */
> >       writel(status, vm_dev->base + VIRTIO_MMIO_STATUS);
> >  }
> >
> > diff --git a/drivers/virtio/virtio_pci_modern_dev.c b/drivers/virtio/virtio_pci_modern_dev.c
> > index 4093f9cca7a6..a0fa14f28a7f 100644
> > --- a/drivers/virtio/virtio_pci_modern_dev.c
> > +++ b/drivers/virtio/virtio_pci_modern_dev.c
> > @@ -467,6 +467,11 @@ void vp_modern_set_status(struct virtio_pci_modern_device *mdev,
> >  {
> >       struct virtio_pci_common_cfg __iomem *cfg = mdev->common;
> >
> > +     /*
> > +      * Per memory-barriers.txt, wmb() is not needed to guarantee
> > +      * that the the cache coherent memory writes have completed
> > +      * before writing to the MMIO region.
> > +      */
> >       vp_iowrite8(status, &cfg->device_status);
> >  }
> >  EXPORT_SYMBOL_GPL(vp_modern_set_status);
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 9c231e1fded7..13a7348cedff 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -1688,7 +1688,7 @@ static struct virtqueue *vring_create_virtqueue_packed(
> >       vq->we_own_ring = true;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
>
> and make this conditional
>
> > @@ -2134,8 +2134,11 @@ irqreturn_t vring_interrupt(int irq, void *_vq)
> >               return IRQ_NONE;
> >       }
> >
> > -     if (unlikely(vq->broken))
> > -             return IRQ_HANDLED;
> > +     if (unlikely(vq->broken)) {
> > +             dev_warn_once(&vq->vq.vdev->dev,
> > +                           "virtio vring IRQ raised before DRIVER_OK");
> > +             return IRQ_NONE;
> > +     }
> >
> >       /* Just a hint for performance: so it's ok that this can be racy! */
> >       if (vq->event)
> > @@ -2177,7 +2180,7 @@ struct virtqueue *__vring_new_virtqueue(unsigned int index,
> >       vq->we_own_ring = false;
> >       vq->notify = notify;
> >       vq->weak_barriers = weak_barriers;
> > -     vq->broken = false;
> > +     vq->broken = true;
> >       vq->last_used_idx = 0;
> >       vq->event_triggered = false;
> >       vq->num_added = 0;
>
> and make this conditional
>
> > diff --git a/include/linux/virtio_config.h b/include/linux/virtio_config.h
> > index 25be018810a7..d4edfd7d91bb 100644
> > --- a/include/linux/virtio_config.h
> > +++ b/include/linux/virtio_config.h
> > @@ -256,6 +256,26 @@ void virtio_device_ready(struct virtio_device *dev)
> >       unsigned status = dev->config->get_status(dev);
> >
> >       BUG_ON(status & VIRTIO_CONFIG_S_DRIVER_OK);
> > +
> > +     /*
> > +      * The virtio_synchronize_cbs() makes sure vring_interrupt()
> > +      * will see the driver specific setup if it sees vq->broken
> > +      * as false (even if the notifications come before DRIVER_OK).
> > +      */
> > +     virtio_synchronize_cbs(dev);
> > +     __virtio_unbreak_device(dev);
> > +     /*
> > +      * The transport should ensure the visibility of vq->broken
> > +      * before setting DRIVER_OK. See the comments for the transport
> > +      * specific set_status() method.
> > +      *
> > +      * A well behaved device will only notify a virtqueue after
> > +      * DRIVER_OK, this means the device should "see" the coherenct
> > +      * memory write that set vq->broken as false which is done by
> > +      * the driver when it sees DRIVER_OK, then the following
> > +      * driver's vring_interrupt() will see vq->broken as false so
> > +      * we won't lose any notification.
> > +      */
> >       dev->config->set_status(dev, status | VIRTIO_CONFIG_S_DRIVER_OK);
> >  }
> >
> > --
> > 2.25.1
>

