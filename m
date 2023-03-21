Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F646C6FD1D
	for <linux-s390@archiver.kernel.org>; Tue, 21 Mar 2023 09:08:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229828AbjCUJIh (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 21 Mar 2023 05:08:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229861AbjCUJId (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 21 Mar 2023 05:08:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D2DC45FEA
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 02:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1679389666;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=TxTS5ViTydaXh/skwlc4PDyBHB5ONwiCHoXqm/uMAZ8=;
        b=FbUyBj2lYvpaqecxNfNfhxTRWvSIEzjPe81gCeqXp1nIxaqUDGMHYDgBtq2WXsyt80QeQJ
        HSkytptnR7ac52+nP+YPU1MUvnXNqPd/JuEF+FJiHuUSXe0JVUiwgQWi/b9SnGmN13yMNM
        il7cri6Ss/15IzX6TmfpLd2WathR8tM=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-319-vg6W1vyLMUipe9Qz-h-hsA-1; Tue, 21 Mar 2023 05:07:44 -0400
X-MC-Unique: vg6W1vyLMUipe9Qz-h-hsA-1
Received: by mail-wm1-f69.google.com with SMTP id n38-20020a05600c3ba600b003ed29a0b729so6737101wms.9
        for <linux-s390@vger.kernel.org>; Tue, 21 Mar 2023 02:07:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679389663;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TxTS5ViTydaXh/skwlc4PDyBHB5ONwiCHoXqm/uMAZ8=;
        b=1oApPJyocTTuHzt2pjVI7MAhUlVaR4pzX24ejAN/JpKKMCGF7YEmzi8rYvqGHnfc4R
         x9EhdaPNARdVHNu3vaVKM7fiOXxMtUd7BuelUiuC8LHisrKdtzzhvI60DgnxjLwUPd2R
         FrsD8XlB699RfaFh5UMZdIGfFSI44T1R5Edafjdry1QAHyL4pXC980UhPYfcAjlPvlm7
         N37tJI8qk6XLwgnvYPTdauK82rxx4gQXQc4TTfSWoFajAzYA8N9dafu127Q/6yr3UZVt
         D0GK70VnHxpqyNO2NEXaPQkCCWo7dJo58azUIs/pNAx9nAg+uJs287j52QrxbHOXP+jw
         8+CA==
X-Gm-Message-State: AO0yUKVMFkf1S8M2b8bjJ8HotMnzXzb2N2n1ojHj7dH5bEGRGoDxePcU
        loQ4iJUXh7kayM4ITv+mK/zp7JToq7/5j5qpfXvmV6mRCDEYReo1+G77NntWCgEDy8ZIjBIBpC1
        la3Z2crwX1KSmM0rB3mTdmA==
X-Received: by 2002:adf:e7d1:0:b0:2d2:d324:e44f with SMTP id e17-20020adfe7d1000000b002d2d324e44fmr1833309wrn.16.1679389663371;
        Tue, 21 Mar 2023 02:07:43 -0700 (PDT)
X-Google-Smtp-Source: AK7set8rdGk1Xi3XCG51r7iI8dIWqGm7FxVlS/Io6weMMs7WpN4AKGfDdGE3SAbdAZa+LqTF4JoysA==
X-Received: by 2002:adf:e7d1:0:b0:2d2:d324:e44f with SMTP id e17-20020adfe7d1000000b002d2d324e44fmr1833288wrn.16.1679389663088;
        Tue, 21 Mar 2023 02:07:43 -0700 (PDT)
Received: from redhat.com ([2.52.1.105])
        by smtp.gmail.com with ESMTPSA id a18-20020a5d4d52000000b002d1e49cff35sm10811622wru.40.2023.03.21.02.07.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 02:07:42 -0700 (PDT)
Date:   Tue, 21 Mar 2023 05:07:39 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Viktor Prutyanov <viktor@daynix.com>
Cc:     Jason Wang <jasowang@redhat.com>, cohuck@redhat.com,
        pasic@linux.ibm.com, farman@linux.ibm.com,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, yan@daynix.com
Subject: Re: [PATCH v2] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230321050719-mutt-send-email-mst@kernel.org>
References: <20230320232115.1940587-1-viktor@daynix.com>
 <CACGkMEu5qa2KUHti3w59DcXNxBdh8_ogZ9oW9bo1_PHwbNiCBg@mail.gmail.com>
 <CAPv0NP5wTMG=3kT_FX4xi9kGbX0Dah4qTQfFQPutWYsWvK1i-g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAPv0NP5wTMG=3kT_FX4xi9kGbX0Dah4qTQfFQPutWYsWvK1i-g@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Mar 21, 2023 at 12:00:42PM +0300, Viktor Prutyanov wrote:
> On Tue, Mar 21, 2023 at 5:29 AM Jason Wang <jasowang@redhat.com> wrote:
> >
> > On Tue, Mar 21, 2023 at 7:21 AM Viktor Prutyanov <viktor@daynix.com> wrote:
> > >
> > > According to VirtIO spec v1.2, VIRTIO_F_NOTIFICATION_DATA feature
> > > indicates that the driver passes extra data along with the queue
> > > notifications.
> > >
> > > In a split queue case, the extra data is 16-bit available index. In a
> > > packed queue case, the extra data is 1-bit wrap counter and 15-bit
> > > available index.
> > >
> > > Add support for this feature for MMIO and PCI transports. Channel I/O
> > > transport will not accept this feature.
> > >
> > > Signed-off-by: Viktor Prutyanov <viktor@daynix.com>
> > > ---
> > >
> > >  v2: reject the feature in virtio_ccw, replace __le32 with u32
> > >
> > >  drivers/s390/virtio/virtio_ccw.c   |  4 +---
> > >  drivers/virtio/virtio_mmio.c       | 15 ++++++++++++++-
> > >  drivers/virtio/virtio_pci_common.c | 10 ++++++++++
> > >  drivers/virtio/virtio_pci_common.h |  4 ++++
> > >  drivers/virtio/virtio_pci_legacy.c |  2 +-
> > >  drivers/virtio/virtio_pci_modern.c |  2 +-
> > >  drivers/virtio/virtio_ring.c       | 17 +++++++++++++++++
> > >  include/linux/virtio_ring.h        |  2 ++
> > >  include/uapi/linux/virtio_config.h |  6 ++++++
> > >  9 files changed, 56 insertions(+), 6 deletions(-)
> > >
> > > diff --git a/drivers/s390/virtio/virtio_ccw.c b/drivers/s390/virtio/virtio_ccw.c
> > > index a10dbe632ef9..d72a59415527 100644
> > > --- a/drivers/s390/virtio/virtio_ccw.c
> > > +++ b/drivers/s390/virtio/virtio_ccw.c
> > > @@ -789,9 +789,7 @@ static u64 virtio_ccw_get_features(struct virtio_device *vdev)
> > >
> > >  static void ccw_transport_features(struct virtio_device *vdev)
> > >  {
> > > -       /*
> > > -        * Currently nothing to do here.
> > > -        */
> > > +       __virtio_clear_bit(vdev, VIRTIO_F_NOTIFICATION_DATA);
> >
> > Is there any restriction that prevents us from implementing
> > VIRTIO_F_NOTIFICATION_DATA? (Spec seems doesn't limit us from this)
> 
> Most likely, nothing.

So pls code it up. It's the same format.

> >
> > >  }
> > >
> > >  static int virtio_ccw_finalize_features(struct virtio_device *vdev)
> > > diff --git a/drivers/virtio/virtio_mmio.c b/drivers/virtio/virtio_mmio.c
> > > index 3ff746e3f24a..0e13da17fe0a 100644
> > > --- a/drivers/virtio/virtio_mmio.c
> > > +++ b/drivers/virtio/virtio_mmio.c
> > > @@ -285,6 +285,19 @@ static bool vm_notify(struct virtqueue *vq)
> > >         return true;
> > >  }
> > >
> > > +static bool vm_notify_with_data(struct virtqueue *vq)
> > > +{
> > > +       struct virtio_mmio_device *vm_dev = to_virtio_mmio_device(vq->vdev);
> > > +       u32 data = vring_fill_notification_data(vq);
> >
> > Can we move this to the initialization?
> 
> This data is new for each notification, because it helps to identify
> the next available index.
> 
> >
> > Thanks
> >
> 
> Thanks,
> Viktor Prutyanov

