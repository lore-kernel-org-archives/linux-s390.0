Return-Path: <linux-s390-owner@vger.kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6118C761A6
	for <linux-s390@archiver.kernel.org>; Tue,  4 Apr 2023 18:17:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236179AbjDDSR0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 4 Apr 2023 14:17:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236187AbjDDSRY (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 4 Apr 2023 14:17:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 731C82713
        for <linux-s390@vger.kernel.org>; Tue,  4 Apr 2023 11:16:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1680632196;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=IteB3h1IFF9JrrwNNhJrcSxfFKVKvFn7WIKCluRji64=;
        b=FHLPZ54nUWsIY+GemvRuVl6uB+kCMtpVg53frSCrFsKgRyxlme8v1uz9qCtJATbM/B7pO7
        bU58WZKt1ZA/RNRlC9hXmvOdXId1jGpZ2x3Uyks3DVLjMzLr3cUllLeYKtGjQrkUgsJbJh
        ZFz2PouSKcKNXEp549QnkF9n+8JjPT4=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-508-8RkIcBXTM0O_3ppD2apnXA-1; Tue, 04 Apr 2023 14:16:32 -0400
X-MC-Unique: 8RkIcBXTM0O_3ppD2apnXA-1
Received: by mail-ed1-f69.google.com with SMTP id v1-20020a50d581000000b0050291cda08aso13700438edi.15
        for <linux-s390@vger.kernel.org>; Tue, 04 Apr 2023 11:16:32 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680632191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IteB3h1IFF9JrrwNNhJrcSxfFKVKvFn7WIKCluRji64=;
        b=KWL72R8pZQP1OPV5baz4MXbwkqnqHKScq4ksWPu1s6dTySfluowlzTV80aQC8C+JFv
         YSeTex+UJlIBKC5anvlYE7Txd7pwSmSSEQrIPKryMD35FPprjeMCf9kjRTdpu0dIgTt9
         ECnzvRy6kWJ9vg74za4x8gbmQG/3DJUzxZIm/iyd8lwNCJKeSYJESADT0NlKaCbIhoQV
         9OJBc5wbhNDcnO1i0G2CZofMT/a2wtfowxgfIo1WyRgDvposXCprA4TwTMdnHWtDhLIu
         x6Pz7BcU1IQvj48CklMr8u8dhCiVnJp6/16JHPLYHgKg1IjvcautjzouxX1mCaSTf5BI
         dPpA==
X-Gm-Message-State: AAQBX9fMbevy76IezEkFn3y8v+H3vkmzrZVmJv5xyLwx9SXq2YtwZDqn
        xMliWKNT1MIExxIkltttpuXUw0XFVEul9ZFAt4WNdW6GcC996oXTj8YlrKG/rn6SLNeapX1GpyP
        EEoOuwZK1uI7NRweC+qJuZg==
X-Received: by 2002:a17:906:4714:b0:84d:4e4f:1f85 with SMTP id y20-20020a170906471400b0084d4e4f1f85mr344222ejq.59.1680632191697;
        Tue, 04 Apr 2023 11:16:31 -0700 (PDT)
X-Google-Smtp-Source: AKy350ZCgo8S1M18VZAugvOWFRDnPyPjTek7bcWsZJ7qMIVGPNRWD16Sn2oW1a2cmFO9+19n6ACQMQ==
X-Received: by 2002:a17:906:4714:b0:84d:4e4f:1f85 with SMTP id y20-20020a170906471400b0084d4e4f1f85mr344205ejq.59.1680632191371;
        Tue, 04 Apr 2023 11:16:31 -0700 (PDT)
Received: from redhat.com ([2.52.139.22])
        by smtp.gmail.com with ESMTPSA id g1-20020a170906394100b00933356c681esm6266002eje.150.2023.04.04.11.16.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 11:16:30 -0700 (PDT)
Date:   Tue, 4 Apr 2023 14:16:26 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Alvaro Karsz <alvaro.karsz@solid-run.com>
Cc:     Viktor Prutyanov <viktor@daynix.com>,
        "jasowang@redhat.com" <jasowang@redhat.com>,
        "cohuck@redhat.com" <cohuck@redhat.com>,
        "pasic@linux.ibm.com" <pasic@linux.ibm.com>,
        "farman@linux.ibm.com" <farman@linux.ibm.com>,
        "linux-s390@vger.kernel.org" <linux-s390@vger.kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "virtualization@lists.linux-foundation.org" 
        <virtualization@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "yan@daynix.com" <yan@daynix.com>
Subject: Re: [PATCH v6] virtio: add VIRTIO_F_NOTIFICATION_DATA feature support
Message-ID: <20230404141501-mutt-send-email-mst@kernel.org>
References: <20230324195029.2410503-1-viktor@daynix.com>
 <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <AM0PR04MB4723A8D079076FA56AB45845D48C9@AM0PR04MB4723.eurprd04.prod.outlook.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Sun, Apr 02, 2023 at 08:17:49AM +0000, Alvaro Karsz wrote:
> Hi Viktor,
> 
> > diff --git a/drivers/virtio/virtio_ring.c b/drivers/virtio/virtio_ring.c
> > index 4c3bb0ddeb9b..f9c6604352b4 100644
> > --- a/drivers/virtio/virtio_ring.c
> > +++ b/drivers/virtio/virtio_ring.c
> > @@ -2752,6 +2752,23 @@ void vring_del_virtqueue(struct virtqueue *_vq)
> >  }
> >  EXPORT_SYMBOL_GPL(vring_del_virtqueue);
> > 
> > +u32 vring_notification_data(struct virtqueue *_vq)
> > +{
> > +       struct vring_virtqueue *vq = to_vvq(_vq);
> > +       u16 next;
> > +
> > +       if (vq->packed_ring)
> > +               next = (vq->packed.next_avail_idx &
> > +                               ~(-(1 << VRING_PACKED_EVENT_F_WRAP_CTR))) |
> > +                       vq->packed.avail_wrap_counter <<
> > +                               VRING_PACKED_EVENT_F_WRAP_CTR;
> > +       else
> > +               next = vq->split.avail_idx_shadow;
> > +
> > +       return next << 16 | _vq->index;
> > +}
> > +EXPORT_SYMBOL_GPL(vring_notification_data);
> > +
> >  /* Manipulates transport-specific feature bits. */
> >  void vring_transport_features(struct virtio_device *vdev)
> >  {
> > @@ -2771,6 +2788,8 @@ void vring_transport_features(struct virtio_device *vdev)
> >                         break;
> >                 case VIRTIO_F_ORDER_PLATFORM:
> >                         break;
> > +               case VIRTIO_F_NOTIFICATION_DATA:
> > +                       break;
> 
> This function is used by virtio_vdpa as well (drivers/virtio/virtio_vdpa.c:virtio_vdpa_finalize_features).
> A vDPA device can offer this feature and it will be accepted, even though VIRTIO_F_NOTIFICATION_DATA is not a thing for the vDPA transport at the moment.
> 
> I don't know if this is bad, since offering VIRTIO_F_NOTIFICATION_DATA is meaningless for a vDPA device at the moment.
> 
> I submitted a patch adding support for vDPA transport.
> https://lore.kernel.org/virtualization/20230402081034.1021886-1-alvaro.karsz@solid-run.com/T/#u

Hmm.  So it seems we need to first apply yours then this patch,
is that right? Or the other way around? What is the right way to make it not break bisect?
Do you mind including this patch with yours in a patchset
in the correct order?




> >                 default:
> >                         /* We don't understand this bit. */
> >                         __virtio_clear_bit(vdev, i);
> 

