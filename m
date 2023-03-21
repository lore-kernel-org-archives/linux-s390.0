Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA795C74A5B
	for <linux-s390@archiver.kernel.org>; Tue, 21 Mar 2023 07:14:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229917AbjCUHOp (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Mar 2023 03:14:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229904AbjCUHOo (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Mar 2023 03:14:44 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB967F778
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 00:13:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679382835;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nuTFG9ab3u7R1jpb31bRtm51snrAor/YhsIuMOJ3A2I=;
        b=LZ6B2ADLK8ZTGLVnohGRp8i2/LgVlupCvL7tmJ4j5dYYB9C8kj44cfLqrzu88LYwwABZ32
        +m4YYlan27J63LryuQn5KgW6wMXZBJxvrRvcZBPlfSH5ABq/AHqJY53x0pakBuOroe4h9P
        7qTuVD8RiYTKBwycqQopzSQumT4dDS8=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-574-HskJm51cNL-_wRaPCX2GWw-1; Tue, 21 Mar 2023 03:13:54 -0400
X-MC-Unique: HskJm51cNL-_wRaPCX2GWw-1
Received: by mail-wm1-f71.google.com with SMTP id l18-20020a05600c4f1200b003ed35ab903aso9151451wmq.6
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 00:13:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679382833;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=nuTFG9ab3u7R1jpb31bRtm51snrAor/YhsIuMOJ3A2I=;
        b=g/x++aYFSs/07HQx/VClFPkeHZKjm8TIXCsW9mjWyuhmhyU8XIJ1Vrndl6aZVYYX+r
         kp0/Aw5IQny1Ku4LP3+919JzCsXO57twsIKd2ULdnuasplhbTra2zQyp8htyHobQ83qQ
         6q6P/qpXjAFR2w3Fn44wuOk8Gy1kAMAVWHeKUI+TH4DUAchlslWsW1HmxMbyXPnKEDNL
         xWm8DITKhGnzh664oYvXK/wm7Pk4rzGBBi5MYfcdJ7PyqLGfKeViJLLPjZtn97P8aUrE
         CMjFZEIjzYO5geXvC8sDZHWQT/QH4t+T/kwokJr6+nSqmnfxy65PyKE6h6O07N3mAJ4B
         er1g==
X-Gm-Message-State: AO0yUKXUQ+/2rFhhRa4nroUmHR9qbNf4RkQjNtWbwnCqbhlqi0NKjBqy
        0fvAwGwyuNpt95OjqJfjzEv1ZwjDB3FjRb5UvQmdzl6dG0ZWIOg/Y49TMDfmEg5OYXsToN5sL+9
        1B6mx7e7ENXnc6B90YDMP1AVjwAnlzw==
X-Received: by 2002:a5d:65c4:0:b0:2ce:a899:2293 with SMTP id e4-20020a5d65c4000000b002cea8992293mr1412889wrw.5.1679382833022;
        Tue, 21 Mar 2023 00:13:53 -0700 (PDT)
X-Google-Smtp-Source: AK7set8KbQmL98dbtoe1oAsaweQtFdB3Ts7JtWE2aDdoQilOLg6IOnVYsFOh/EJ1qessZOqW8oHHZA==
X-Received: by 2002:a5d:65c4:0:b0:2ce:a899:2293 with SMTP id e4-20020a5d65c4000000b002cea8992293mr1412874wrw.5.1679382832726;
        Tue, 21 Mar 2023 00:13:52 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id a10-20020a056000050a00b002d78a96cf5fsm3384706wrf.70.2023.03.21.00.13.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 00:13:52 -0700 (PDT)
Date:   Tue, 21 Mar 2023 03:13:48 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Viktor Prutyanov <viktor@daynix.com>, cohuck@redhat.com,
        pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321031310-mutt-send-email-mst@kernel.org>
References: <20230320232115.1940587-1-viktor@daynix.com>
 <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 21, 2023 at 10:29:11AM +0800, Jason Wang wrote:
> On Tue, Mar 21, 2023 at 7:21 AM Viktor Prutyanov <viktor@daynix.com> wrote:
> >
> > According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> > indicates that the driver passes extra data along with the queue
> > notifications.
> >
> > In a split queue case, the extra data is 16-bit available index. In a
> > packed queue case, the extra data is 1-bit wrap counter and 15-bit
> > available index.
> >
> > Add support for this feature for MMIO and PCI transports. Channel I/O
> > transport will not accept this feature.
> >
> > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > ---
> >
> >  v2: reject the feature in virtio_ccw, replace __le32 with u32
> >
> >  drivers/s390/virtio/virtio_ccw.c   |  4 +---
> >  drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
> >  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
> >  drivers/virtio/virtio_pci_common.h |  4 ++++
> >  drivers/virtio/virtio_pci_legacy.c |  2 +-
> >  drivers/virtio/virtio_pci_modern.c |  2 +-
> >  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
> >  include/linux/virtio_ring.h        |  2 ++
> >  include/uapi/linux/virtio_config.h |  6 ++++++
> >  9 files changed, 56 insertions(+), 6 deletions(-)
> >
> > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > index a10dbe632ef9..d72a59415527 100644
> > --- a/drivers/s390/virtio/virtio_ccw.c
> > +++ b/drivers/s390/virtio/virtio_ccw.c
> > @@ -789,9 +789,7 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> >
> >  static void ccw_transport_features(struct virtio_device *vdev)
> >  {
> > -       /*
> > -        * Currently nothing to do here.
> > -        */
> > +       __virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);
> 
> Is there any restriction that prevents us from implementing
> VIRTIO_F_NOTIFICATION_DATA? (Spec seems doesn't limit us from this)

Right, spec actually tells you what to do.

> >  }
> >
> >  static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > index 3ff746e3f24a..0e13da17fe0a 100644
> > --- a/drivers/virtio/virtio_mmio.c
> > +++ b/drivers/virtio/virtio_mmio.c
> > @@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
> >         return true;
> >  }
> >
> > +static bool vm_notify_with_data(struct virtqueue *vq)
> > +{
> > +       struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> > +       u32 data = vring_fill_notification_data(vq);
> 
> Can we move this to the initialization?
> 
> Thanks

