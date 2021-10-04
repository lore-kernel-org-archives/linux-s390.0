Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E09FDC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 20:01:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C83CE613D2
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 20:01:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbhJDUDO (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 16:03:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:32526 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235660AbhJDUDL (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 16:03:11 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633377682;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=KsdJcxDdgTF/zmQf/6TyWls50jhunD8gsTgc9KR7gmk=;
        b=R9XBVNS01izHScLEDK6Z+5JyDNutRcHhDI9fiKIrmlWiFmWBx0Vast+ZiO6M/0y64GWYji
        K1G3/SJ7e/M5U4+2GUzUbMGnWj5vEWCq9A0QmvTVC3X9xfKBaqStWoX2hOvSfvk0xA5c2e
        0xBlHC1zDCgPHv3MWtNip2cL1OrZcYI=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-192-teb3kP8_MFi9eeDha2UKsQ-1; Mon, 04 Oct 2021 16:01:19 -0400
X-MC-Unique: teb3kP8_MFi9eeDha2UKsQ-1
Received: by mail-ed1-f72.google.com with SMTP id r11-20020aa7cfcb000000b003d4fbd652b9so18296612edy.14
        for <linux-s390@vger.kernel.org>; Mon, 04 Oct 2021 13:01:19 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=KsdJcxDdgTF/zmQf/6TyWls50jhunD8gsTgc9KR7gmk=;
        b=iudlFXfRuMcWhStx+eJHKb73dq7SPwvs7SMKFlxbek7y49x+m+KEbEqcsYRE9maiPO
         tkppCQ/V4u6A9IdIkU9mSIVXvogQfzIAcM8HUD2k0LSTwrkPj7nsduwcIdM7AK3Q4pUY
         CoNg1tDB5EyRYIWzY7AkGCSr9P822kGBeFeNblEvK9ONVKOskWzFhhGsB2ZoP2JEhB8E
         ZV5AxHtZ36CPvZ32onVEPv74hQfE+S7hUg/2ZZ7hl4freiD2cBFEiLpUXY0nsjo6S/LR
         asxs5kpTnlYZgn8SU04x3Jq59JurdHEH1Iw29NyKKywUsHekVVKhGfFgxdebeStXSPV7
         8/DA==
X-Gm-Message-State: AOAM5327EtU0g53I6Tls86U27VeND9ABpAdBjdK90c/ZTi6pMu40U/Mw
        HGMu5F6TyLvW1PlBKOUWQ4nqFl5m8tORCpYL5z+uAc+Po8X3C5SHxiM5oHunVEQA0HdGo8PJ3CG
        jEjvuhna33EwzwQ9ZK5AGKg==
X-Received: by 2002:a05:6402:2906:: with SMTP id ee6mr17966510edb.170.1633377678168;
        Mon, 04 Oct 2021 13:01:18 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyuHj3hrys0X5jcvBEKc8g2+iuDhizhWCRoVmy0jn4kkURJJbD11p6ILeMeXQvLwtLsevqp+A==
X-Received: by 2002:a05:6402:2906:: with SMTP id ee6mr17966483edb.170.1633377677943;
        Mon, 04 Oct 2021 13:01:17 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id z8sm6874865ejd.94.2021.10.04.13.01.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Oct 2021 13:01:17 -0700 (PDT)
Date:   Mon, 4 Oct 2021 16:01:12 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
Message-ID: <20211004160005-mutt-send-email-mst@kernel.org>
References: <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
 <87zgro23r1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87zgro23r1.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04, 2021 at 05:45:06PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
> >> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
> >> >> >  Specification text within these sections generally does not apply
> >> >> >  to non-transitional devices.
> >> >> >  
> >> >> > +\begin{note}
> >> >> > +The device offers different features when used through
> >> >> > +the legacy interface and when operated in accordance with this
> >> >> > +specification.
> >> >> > +\end{note}
> >> >> > +
> >> >> > +Transitional drivers MUST use Devices only through the legacy interface
> >> >> 
> >> >> s/Devices only through the legacy interface/devices through the legacy
> >> >> interface only/
> >> >> 
> >> >> ?
> >> >
> >> > Both versions are actually confused, since how do you
> >> > find out that device does not offer VIRTIO_F_VERSION_1?
> >> >
> >> > I think what this should really say is
> >> >
> >> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
> >> > the legacy interface.
> >> 
> >> Ok, that makes sense.
> >> 
> >> Would it make sense that transitional drivers MUST accept VERSION_1
> >> through the non-legacy interface? Or is that redundant?
> >
> > We already have:
> >
> > A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.
> 
> Yep, so it is redundant.
> 
> >
> >
> >> >
> >> >
> >> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
> >> > through the legacy interface if offered?
> >> 
> >> I think that the Linux drivers will not operate on feature bit 32+ if
> >> they are in legacy mode?
> >
> >
> > Well ... with PCI there's no *way* for host to set bit 32 through
> > legacy. But it might be possible with MMIO/CCW. Can you tell me
> > what happens then?
> 
> ccw does not support accessing bit 32+, either. Not sure about mmio.
> 
> >
> >
> >> >> 
> >> >> Generally, looks good to me.
> >> >
> >> > Do we want to also add explanation that features can be
> >> > changed until FEATURES_OK?
> >> 
> >> I always considered that to be implict, as feature negotiation is not
> >> over until we have FEATURES_OK. Not sure whether we need an extra note.
> >
> > Well Halil here says once you set a feature bit you can't clear it.
> > So maybe not ...
> 
> Ok, so what about something like
> 
> "If FEATURES_OK is not set, the driver MAY change the set of features it
> accepts."
> 
> in the device initialization section?

Maybe "as long as". However Halil implied that some features are not
turned off properly if that happens. Halil could you pls provide
some examples?

-- 
MST

