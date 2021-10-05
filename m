Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96057C433FE
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E4DA61350
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:53:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232511AbhJEHzO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:55:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:24721 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232108AbhJEHzO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 03:55:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633420403;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8MQQUBfg6gmlUyb1M/tqnYV/yKo2UEgU362rTr4iyf0=;
        b=BFBKEOpsNDaRGKjh7P5EZ57QM1trx5aQbj5F0mvCSlBBPZKLdoXKih9GIdRra1Jj/g87K6
        6vP+ZlWah7pLHaa2ZBWKzO1bhspO9h3YR5gfTQpdLATlQPphI0Rj0rvxH0lRw0dsn4l9zH
        7ewcxTACYB2Pk7MFSb1Wxl6J2DfR6KU=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-318-QKtCClpZNwSeRl2sIVyMSg-1; Tue, 05 Oct 2021 03:53:22 -0400
X-MC-Unique: QKtCClpZNwSeRl2sIVyMSg-1
Received: by mail-ed1-f72.google.com with SMTP id z6-20020a50cd06000000b003d2c2e38f1fso19807795edi.1
        for <linux-s390@vger.kernel.org>; Tue, 05 Oct 2021 00:53:22 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=8MQQUBfg6gmlUyb1M/tqnYV/yKo2UEgU362rTr4iyf0=;
        b=u5uiqclcNnzH2ByLxJ3nQuULxRkvzdM7mi1dJbN60IY3xUo+5I/DrbzGD+pA+hn3mu
         Y4qJDwToDaMxCJfVaVbOv7KvRsN0/mUx/TlgIsrds2BOH/qsImfSRuerGdjzr6O3wmva
         G5ABT4fBIRWhCtjH6TJJY6ma0GxZjGi8mDizxytxP1zTevfJDvE6Imilf9X8C4vzAkb2
         Tiy7uIl5SyxD47t1aGPbz5jx2NyxFnN/RzFxqphc6yJRbxPX9pxHG3F14zl3fTqUYWp5
         47M1HtT9wPHDh3cS6Or20CqRwH4QJB5+uuEKnUlmvSHufNn/Zw2s77qF87xetJP9xxHO
         HUTA==
X-Gm-Message-State: AOAM533rVnN1coknBrKqzBd7JHie9sZkiWL8mKwUkMuF0nI20oeciqcM
        wlItKWnEdt1A6JpiM0SLG81oUq4kNTXo2gzNbLDoGjmuuRCnaUPbPrdng/Z5Sutz5MDR+q0kzE1
        jJZ1SRP9iGRb2CGhB5RLpcQ==
X-Received: by 2002:a05:6402:35cb:: with SMTP id z11mr14610265edc.252.1633420401452;
        Tue, 05 Oct 2021 00:53:21 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxOHxXYAke10DbjPKeGoglSdZPOuPMBgTSaN3r5HKwcc031+p/zWsEEMu11Yvb7QTyz4BzKrw==
X-Received: by 2002:a05:6402:35cb:: with SMTP id z11mr14610244edc.252.1633420401312;
        Tue, 05 Oct 2021 00:53:21 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id u6sm8260227edt.30.2021.10.05.00.53.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Oct 2021 00:53:20 -0700 (PDT)
Date:   Tue, 5 Oct 2021 03:53:17 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211005035014-mutt-send-email-mst@kernel.org>
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <20211005092539.145c9cc4.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211005092539.145c9cc4.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05, 2021 at 09:25:39AM +0200, Halil Pasic wrote:
> On Mon, 4 Oct 2021 09:11:04 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > > >> static inline bool virtio_access_is_big_endian(VirtIODevice *vdev)
> > > >> {
> > > >> #if defined(LEGACY_VIRTIO_IS_BIENDIAN)
> > > >>     return virtio_is_big_endian(vdev);
> > > >> #elif defined(TARGET_WORDS_BIGENDIAN)
> > > >>     if (virtio_vdev_has_feature(vdev, VIRTIO_F_VERSION_1)) {
> > > >>         /* Devices conforming to VIRTIO 1.0 or later are always LE. */
> > > >>         return false;
> > > >>     }
> > > >>     return true;
> > > >> #else
> > > >>     return false;
> > > >> #endif
> > > >> }
> > > >>   
> > > >
> > > > ok so that's a QEMU bug. Any virtio 1.0 and up
> > > > compatible device must use LE.
> > > > It can also present a legacy config space where the
> > > > endian depends on the guest.  
> > > 
> > > So, how is the virtio core supposed to determine this? A
> > > transport-specific callback?  
> > 
> > I'd say a field in VirtIODevice is easiest.
> 
> Wouldn't a call from transport code into virtio core
> be more handy? What I have in mind is stuff like vhost-user and vdpa. My
> understanding is, that for vhost setups where the config is outside qemu,
> we probably need a new  command that tells the vhost backend what
> endiannes to use for config. I don't think we can use
> VHOST_USER_SET_VRING_ENDIAN because  that one is on a virtqueue basis
> according to the doc. So for vhost-user and similar we would fire that
> command and probably also set the filed, while for devices for which
> control plane is handled by QEMU we would just set the field.
> 
> Does that sound about right?

I'm fine either way, but when would you invoke this?
With my idea backends can check the field when get_config
is invoked.

As for using this in VHOST, can we maybe re-use SET_FEATURES?

Kind of hacky but nice in that it will actually make existing backends
work...

-- 
MST

