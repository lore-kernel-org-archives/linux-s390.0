Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65402C433EF
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 15:42:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4E3CF6101A
	for <linux-s390@archiver.kernel.org>; Fri,  8 Oct 2021 15:42:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243302AbhJHPoM (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Fri, 8 Oct 2021 11:44:12 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55484 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S243113AbhJHPoH (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Fri, 8 Oct 2021 11:44:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633707730;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qMC5Klotg1aJNEk7elIqSRCi23Sna03uJX/agMDIgxg=;
        b=hfG3zom7+tWBYTRUDnC3e7/50qouLfw3ciRb2G5ZG0Kn38JGdJz5/rc9MTxIgLHoBcb8mo
        oRDpLvVzxVl4W+8LJ9OexglyqZc9n7xXkcb7b4HtmCOa0rcb6oDUKdGLCaBitA8KaTFizC
        e4rTYcqPJv4F8jp7yNFVg7+x8gk1w40=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-93-xxK_XmJcPbKoe_U20jPGqw-1; Fri, 08 Oct 2021 11:42:09 -0400
X-MC-Unique: xxK_XmJcPbKoe_U20jPGqw-1
Received: by mail-ed1-f71.google.com with SMTP id 14-20020a508e4e000000b003d84544f33eso9597205edx.2
        for <linux-s390@vger.kernel.org>; Fri, 08 Oct 2021 08:42:09 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qMC5Klotg1aJNEk7elIqSRCi23Sna03uJX/agMDIgxg=;
        b=A+gi3D2NwzELiMQa4+rdFLJwzSBI3KNnwgry7bTXaKLpArEqcFlqBVC7TTsOVO1yx7
         9lAoX/cvNdjjRGNK5dmSlQFvTAcpXIeNOEWkXnc+JswfeJdqPJZhhm7frn2dhMDLfQxe
         z8VKhmWrp9SSpRs/4FOAXR7nOAsK1M3N0v0C4sDuP1M7nwqJ9B1H9oLh4fZt8Bov/R8E
         F3T0PNhnfzPSfB3d36OjqAjzJJ6oZlTAQL7phn+DItyROdDjtVoqAfg8ZeshLew7A+D3
         s7gWtHRUM/akjNWn5Lw7XRdZdHfYcyruPDibCX8eWbVFgwredL1nm13jQe2Fhh/71Ylh
         Nk/g==
X-Gm-Message-State: AOAM530Nn2aplADQT8UkCWj/GMhOo87QRGc4xQCnqBaTschm3oMKDmjh
        073cQYRhBmBOIJMe0eDKXUWHFFPCOK+FmqwvHKslONBsZjAOz15aUcTWldoH9fLC6OIjWa3cLNl
        Qnm6/097XgLTjKZBkqt0scQ==
X-Received: by 2002:a50:da04:: with SMTP id z4mr15752288edj.52.1633707728440;
        Fri, 08 Oct 2021 08:42:08 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwHLSNoBYozNsq5483RYGKOQ6xoIu8y6Sysra7Dpoor+71RjKofWVLel+TDlQXhZNhKirsgbQ==
X-Received: by 2002:a50:da04:: with SMTP id z4mr15752226edj.52.1633707728015;
        Fri, 08 Oct 2021 08:42:08 -0700 (PDT)
Received: from redhat.com ([2.55.132.170])
        by smtp.gmail.com with ESMTPSA id m9sm1193458edl.66.2021.10.08.08.42.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 08 Oct 2021 08:42:07 -0700 (PDT)
Date:   Fri, 8 Oct 2021 11:42:02 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, stable@vger.kernel.org,
        markver@us.ibm.com, Cornelia Huck <cohuck@redhat.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        qemu-devel@nongnu.org
Subject: Re: [PATCH v2 1/1] virtio: write back F_VERSION_1 before validate
Message-ID: <20211008113904-mutt-send-email-mst@kernel.org>
References: <20211008123422.1415577-1-pasic@linux.ibm.com>
 <20211008085839-mutt-send-email-mst@kernel.org>
 <20211008155156.626e78b5.pasic@linux.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211008155156.626e78b5.pasic@linux.ibm.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Fri, Oct 08, 2021 at 03:51:56PM +0200, Halil Pasic wrote:
> On Fri, 8 Oct 2021 09:05:03 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Fri, Oct 08, 2021 at 02:34:22PM +0200, Halil Pasic wrote:
> > > The virtio specification virtio-v1.1-cs01 states: "Transitional devices
> > > MUST detect Legacy drivers by detecting that VIRTIO_F_VERSION_1 has not
> > > been acknowledged by the driver."  This is exactly what QEMU as of 6.1
> > > has done relying solely on VIRTIO_F_VERSION_1 for detecting that.
> > > 
> > > However, the specification also says: "... the driver MAY read (but MUST
> > > NOT write) the device-specific configuration fields to check that it can
> > > support the device ..." before setting FEATURES_OK.
> > > 
> > > In that case, any transitional device relying solely on
> > > VIRTIO_F_VERSION_1 for detecting legacy drivers will return data in
> > > legacy format.  In particular, this implies that it is in big endian
> > > format for big endian guests. This naturally confuses the driver which
> > > expects little endian in the modern mode.
> > > 
> > > It is probably a good idea to amend the spec to clarify that
> > > VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> > > is complete. However, we already have a regression so let's try to address  
> > 
> > actually, regressions. and we can add 
> > "since originally before validate callback existed
> > config space was only read after
> > FEATURES_OK. See Fixes tags for relevant commits"
> > 
> > > it.
> 
> How about replacing the paragraph above with the following?
> 
> "It is probably a good idea to amend the spec to clarify that
> VIRTIO_F_VERSION_1 can only be relied on after the feature negotiation
> is complete. Before validate callback existed, config space was only
> read after FEATURES_OK. However, we already have two regression,

two regressions

> so
> let's address this here as well."
> > > 
> > > The regressions affect the VIRTIO_NET_F_MTU feature of virtio-net and
> > > the VIRTIO_BLK_F_BLK_SIZE feature of virtio-blk for BE guests when
> > > virtio 1.0 is used on both sides. The latter renders virtio-blk
> > > unusable with DASD backing, because things simply don't work with
> > > the default.  
> 
> and add 
> "See Fixes tags for relevant commits."
> here.
> > 
> > Let's add a work around description now:
> > 
> > 
> > For QEMU, we can work around the issue by writing out the features
> > register with VIRTIO_F_VERSION_1 bit set.  We (ab) use the
> s/features register/feature bits/
> rationale: ccw does not have a features register, and qemu does not
> really act as if its behavior was controlled by the values in a features
> register. I.e. when we read the register we see VIRTIO_F_VERSION_!
> because the feature is offered. In QEMU we basically read host_featues
> but write the guest_features. And what drives device behavior is mostly
> guest_features. 
> 
> s/(ab) use/(ab)use/
> 
> > finalize_features config op for this. It's not enough to address vhost
> 
> s/It's/This is/
> 
> > user and vhost block devices since these do not get the features until
> 
> s/vhost user and vhost block/some vhost-user and vhost-vdpa/ ?

Let's just say "not enough to address vhost devices since some
of these etc" 

> Ratioale: I think vhost block is just a vhost-user device. On the other
> hand vhost-user-fs works like charm because the config space is
> implemented in qemu and not in the vhost-user device. I
> didn't check vhost_net. I'm not even sure qemu offers a vhost_net
> implementation.

it does

> Anyway I wouldn't like to make any false statements here.

ok

> > FEATURES_OK, however it looks like these two actually never handled the
> > endian-ness for legacy mode correctly, so at least that's not a
> > regression.
> > 
> > No devices except virtio net and virtio blk seem to be affected.
> > 
> > Long term the right thing to do is to fix the hypervisors.
> > 
> 
> Sounds good. Thanks! Are you OK with my changes proposed to your changes?
> 
> Regards,
> Halil

yes.

> > 
> > > 
> > > Cc: <stable@vger.kernel.org> #v4.11
> > > Signed-off-by: Halil Pasic <pasic@linux.ibm.com>
> > > Fixes: 82e89ea077b9 ("virtio-blk: Add validation for block size in
> > > config space") Fixes: fe36cbe0671e ("virtio_net: clear MTU when out
> > > of range") Reported-by: markver@us.ibm.com
> > > ---
> > >  drivers/virtio/virtio.c | 11 +++++++++++
> > >  1 file changed, 11 insertions(+)
> > > 
> > > diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
> > > index 0a5b54034d4b..236081afe9a2 100644
> > > --- a/drivers/virtio/virtio.c
> > > +++ b/drivers/virtio/virtio.c
> > > @@ -239,6 +239,17 @@ static int virtio_dev_probe(struct device *_d)
> > >  		driver_features_legacy = driver_features;
> > >  	}
> > >  
> > > +	/*
> > > +	 * Some devices detect legacy solely via F_VERSION_1. Write
> > > +	 * F_VERSION_1 to force LE config space accesses before
> > > FEATURES_OK for
> > > +	 * these when needed.
> > > +	 */
> > > +	if (drv->validate && !virtio_legacy_is_little_endian()
> > > +			  && device_features &
> > > BIT_ULL(VIRTIO_F_VERSION_1)) {
> > > +		dev->features = BIT_ULL(VIRTIO_F_VERSION_1);
> > > +		dev->config->finalize_features(dev);
> > > +	}
> > > +
> > >  	if (device_features & (1ULL << VIRTIO_F_VERSION_1))
> > >  		dev->features = driver_features & device_features;
> > >  	else
> > > 
> > > base-commit: 60a9483534ed0d99090a2ee1d4bb0b8179195f51
> > > -- 
> > > 2.25.1  
> > 

