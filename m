Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50FF9C433EF
	for <linux-s390@archiver.kernel.org>; Tue, 21 Jun 2022 09:36:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347196AbiFUJgm (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Jun 2022 05:36:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349107AbiFUJgl (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Jun 2022 05:36:41 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id BF29F27161
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 02:36:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1655804199;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=NcXrei2y1YJ8W4iMhBTE/8lC+VPJchskiCKRKCR2d9s=;
        b=EqW+Zr/FXK0APLEWkVhJrucStNtT3Vvo9Ib5SJUwFCho+0sLIyFLuWXe5U+oQcUKel72nl
        kHX+h5mzOiY6ldkaMWP0CfNq3fX3+Yuoav5swvkmue5ufsE9DlSqAYzJHX+ZHQ/1hq18jW
        ZJcHsAtUr2vuak/BMP1g+BBnWxbaTMU=
Received: from mail-lf1-f72.google.com (mail-lf1-f72.google.com
 [209.85.167.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-483-FUOD_IEdNiC9Q_KvWXGxvQ-1; Tue, 21 Jun 2022 05:36:36 -0400
X-MC-Unique: FUOD_IEdNiC9Q_KvWXGxvQ-1
Received: by mail-lf1-f72.google.com with SMTP id g40-20020a0565123ba800b004791450e602so6717583lfv.17
        for <linux-s390@vger.kernel.org>; Tue, 21 Jun 2022 02:36:36 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NcXrei2y1YJ8W4iMhBTE/8lC+VPJchskiCKRKCR2d9s=;
        b=Vu9UKcsrQbE3RqVlyDS6nLWFdviPyNuRIKQubdK7vkugoFBOnNCyTJpM//fP9yjf6p
         ZhW+JLnmTm3i4wNiw6qC2yzwXpQbRvf/1FaIEP2YgnW279y2Me286GhVH/MVXEgfmvtk
         Gh9c32kmFi6U97dR8EwEbiaRl8+Ct9AJ25h3hsgxgd84W1+idRgYK6k30MBkQA5htE+l
         SSuLPT6J6m1VjotX4sYBhR6nMc6knbHKo3cpZhqiwzdAAJC4FXy+1Y75eaJ670uywOQz
         3AvHsqmLHi5JcMOWI23+05//z/PgnzwckTHyMUaDEJ5H+qqXxlVIoJQn+/x3Hg/NHJ7g
         ruhw==
X-Gm-Message-State: AJIora9SHEquwKWklkCrhMsneT9Jphpm0lp4/sffvflMQYcBaIhCQpFH
        yUrdV6zcnGoA2Zo8mg0dcgpJiR+dVPBFfR/houVsOVs8V62iHc4W7JiNG1pNLTftzGQUXxX8/uk
        VhiSu90ayGMNWXWGvyjv67SVh3fzTK1pfyd5hhA==
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id p37-20020a05651213a500b0047dc1d9dea8mr16179014lfa.442.1655804194871;
        Tue, 21 Jun 2022 02:36:34 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1vYHin7RcteM0oZeoqpcOaahexAusmGmc0X7KmU5H3LSzGjszNsAIJFXEvBb7MZram6VDes8GvKxQzQWHh+L8w=
X-Received: by 2002:a05:6512:13a5:b0:47d:c1d9:dea8 with SMTP id
 p37-20020a05651213a500b0047dc1d9dea8mr16178998lfa.442.1655804194646; Tue, 21
 Jun 2022 02:36:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220620024158.2505-1-jasowang@redhat.com> <87y1xq8jgw.fsf@redhat.com>
In-Reply-To: <87y1xq8jgw.fsf@redhat.com>
From:   Jason Wang <jasowang@redhat.com>
Date:   Tue, 21 Jun 2022 17:36:23 +0800
Message-ID: <CACGkMEun6C9RgQVGq1B8BJMd9DyRQkSXj8shXVVhDymQYQLxgA@mail.gmail.com>
Subject: Re: [PATCH V2] virtio: disable notification hardening by default
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>, mst <mst@redhat.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jun 21, 2022 at 5:16 PM Cornelia Huck <cohuck@redhat.com> wrote:
>
> On Mon, Jun 20 2022, Jason Wang <jasowang@redhat.com> wrote:
>
> > We try to harden virtio device notifications in 8b4ec69d7e09 ("virtio:
> > harden vring IRQ"). It works with the assumption that the driver or
> > core can properly call virtio_device_ready() at the right
> > place. Unfortunately, this seems to be not true and uncover various
> > bugs of the existing drivers, mainly the issue of using
> > virtio_device_ready() incorrectly.
> >
> > So let's having a Kconfig option and disable it by default. It gives
> > us a breath to fix the drivers and then we can consider to enable it
> > by default.
> >
> > Signed-off-by: Jason Wang <jasowang@redhat.com>
> > ---
> > Changes since V1:
> > - tweak the Kconfig prompt
> > - don't hold spinlock for IRQ path in s390
> > ---
> >  drivers/s390/virtio/virtio_ccw.c |  4 ++++
> >  drivers/virtio/Kconfig           | 11 +++++++++++
> >  drivers/virtio/virtio.c          |  2 ++
> >  drivers/virtio/virtio_ring.c     | 12 ++++++++++++
> >  include/linux/virtio_config.h    |  2 ++
> >  5 files changed, 31 insertions(+)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index 97e51c34e6cf..89bbf7ccfdd1 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -1136,8 +1136,10 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >                       vcdev->err = -EIO;
> >       }
> >       virtio_ccw_check_activity(vcdev, activity);
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       /* Interrupts are disabled here */
> >       read_lock(&vcdev->irq_lock);
>
> Should we add a comment that this pairs with
> virtio_ccw_synchronize_cbs()? Just to avoid future headscratching as to
> why this lock is only needed when notification hardening is enabled.

Fine.

>
> > +#endif
> >       for_each_set_bit(i, indicators(vcdev),
> >                        sizeof(*indicators(vcdev)) * BITS_PER_BYTE) {
> >               /* The bit clear must happen before the vring kick. */
> > @@ -1146,7 +1148,9 @@ static void virtio_ccw_int_handler(struct ccw_device *cdev,
> >               vq = virtio_ccw_vq_by_ind(vcdev, i);
> >               vring_interrupt(0, vq);
> >       }
> > +#ifdef CONFIG_VIRTIO_HARDEN_NOTIFICATION
> >       read_unlock(&vcdev->irq_lock);
> > +#endif
> >       if (test_bit(0, indicators2(vcdev))) {
> >               virtio_config_changed(&vcdev->vdev);
> >               clear_bit(0, indicators2(vcdev));
> > diff --git a/drivers/virtio/Kconfig b/drivers/virtio/Kconfig
> > index b5adf6abd241..96ec56d44b91 100644
> > --- a/drivers/virtio/Kconfig
> > +++ b/drivers/virtio/Kconfig
> > @@ -35,6 +35,17 @@ menuconfig VIRTIO_MENU
> >
> >  if VIRTIO_MENU
> >
> > +config VIRTIO_HARDEN_NOTIFICATION
> > +        bool "Harden virtio notification"
> > +        help
> > +          Enable this to harden the device notifications and supress
> > +          the ones that are illegal.
>
> "...and suppress those that happen at a time where notifications are
> illegal." ?

Ok.

>
> > +
> > +          Experimental: not all drivers handle this correctly at this
> > +          point.
>
> "Note that several drivers still have bugs that may cause crashes or
> hangs when correct handling of notifications is enforced; depending on
> the subset of drivers and devices you use, this may or may not work."
>
> Or is that too verbose?

Looks fine.

>
> > +
> > +          If unsure, say N.
> > +
> >  config VIRTIO_PCI
> >       tristate "PCI driver for virtio devices"
> >       depends on PCI
>
> The ifdeffery looks a big ugly, but I don't have a better idea.

I guess you meant the ccw part, I leave the spinlock here in V1, but
Michael prefers to have that.

In the future, we may consider removing that, one possible way is to
have a per driver boolean for the hardening.

Tanks

>

