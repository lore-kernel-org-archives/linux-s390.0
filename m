Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 339DDC433F5
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 12:15:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 15F8E610A8
	for <linux-s390@archiver.kernel.org>; Wed,  6 Oct 2021 12:15:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238452AbhJFMRJ (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 6 Oct 2021 08:17:09 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:50967 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238440AbhJFMRI (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 6 Oct 2021 08:17:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633522516;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
        b=cKiG+WOybh2sZ2ZsquOVXREOamLakQY0NRF5kFPQpIHmLAar0SumRuYLGIjv4rjBwgZ1Et
        gHXDMaFILOaRQLrS39E0aScUeTgvnUgqIoJYuKrhdH8LsqWTo7i++0Q/wte9m262C6g2Fz
        cGVnXJuOXLIvsaCRD2dWgl8Ph3UPXmM=
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com
 [209.85.208.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-199-JG7vr57mPZ-xdOa8PYN8tQ-1; Wed, 06 Oct 2021 08:15:15 -0400
X-MC-Unique: JG7vr57mPZ-xdOa8PYN8tQ-1
Received: by mail-ed1-f69.google.com with SMTP id c8-20020a50d648000000b003daa53c7518so2398284edj.21
        for <linux-s390@vger.kernel.org>; Wed, 06 Oct 2021 05:15:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qnmDIGptsktOkioDWWXCssVddVdWstmqHBWueCna4kc=;
        b=cPnmWcAeSIbFRZPOtmRurWYdA8B9ZT7TZ8vw6E2aRYgqlho9CTCIrGHNYrKs6p+89/
         B1tQXWeFY52EOjidqvRZDF2TiEpC8mudcRLIpO/rJ5L+ZpubLuLbMiDampvZf2xLnMxR
         hd7UvPW3ue23miucKhzNHIKDA1viFeeqqNAFN5MsMEEmIg3MGa4yxmC+UkUlerUrizpd
         WRZFV79kEndvX4BE1zAdXZ2tzQ8auTpXMOY51KLxl3dNH9772mNSm9XVTJUXxZu8RR0b
         UEnBSn/o+4CrdytXs6DH75chXhMHTVH/Pw4QNgd7FfF73jYU+D8PtwCwZBzcv8QPHvEc
         ChyA==
X-Gm-Message-State: AOAM533DroPOP2cqWiGzaka7Ce4Dn7Bi9rNu/l96BaTQKnLa9XtnwWBL
        kRcJp+47O9xL0SkvyBcZ1h86EVCXqyrY9lIxMOAP6dYipPby/cw9fjHe4Krpj1Nc3WS0QZOExo3
        bEyVsg5xg3olCGsWHio9HRw==
X-Received: by 2002:a17:906:f208:: with SMTP id gt8mr21806747ejb.522.1633522513831;
        Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwG9wllx9y16DQrS76uUlfwpX+3oqTEzh8ajeSft32BLV8/8AcXlKmgVAU0xygywoNNmIYASA==
X-Received: by 2002:a17:906:f208:: with SMTP id gt8mr21806715ejb.522.1633522513589;
        Wed, 06 Oct 2021 05:15:13 -0700 (PDT)
Received: from redhat.com ([2.55.147.134])
        by smtp.gmail.com with ESMTPSA id k20sm8795905ejd.33.2021.10.06.05.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Oct 2021 05:15:12 -0700 (PDT)
Date:   Wed, 6 Oct 2021 08:15:08 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Cornelia Huck <cohuck@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, qemu-devel@nongnu.org
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
Message-ID: <20211006081430-mutt-send-email-mst@kernel.org>
References: <20210930070444-mutt-send-email-mst@kernel.org>
 <20211001092125.64fef348.pasic@linux.ibm.com>
 <20211002055605-mutt-send-email-mst@kernel.org>
 <87bl452d90.fsf@redhat.com>
 <20211004090018-mutt-send-email-mst@kernel.org>
 <875yuc3ln2.fsf@redhat.com>
 <20211004110537-mutt-send-email-mst@kernel.org>
 <87wnms23hn.fsf@redhat.com>
 <20211004151408-mutt-send-email-mst@kernel.org>
 <87sfxezcjp.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87sfxezcjp.fsf@redhat.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Oct 06, 2021 at 12:13:14PM +0200, Cornelia Huck wrote:
> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> 
> > On Mon, Oct 04, 2021 at 05:50:44PM +0200, Cornelia Huck wrote:
> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> 
> >> > On Mon, Oct 04, 2021 at 04:33:21PM +0200, Cornelia Huck wrote:
> >> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> 
> >> >> > On Mon, Oct 04, 2021 at 02:19:55PM +0200, Cornelia Huck wrote:
> >> >> >> 
> >> >> >> [cc:qemu-devel]
> >> >> >> 
> >> >> >> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
> >> >> >> 
> >> >> >> > ok so that's a QEMU bug. Any virtio 1.0 and up
> >> >> >> > compatible device must use LE.
> >> >> >> > It can also present a legacy config space where the
> >> >> >> > endian depends on the guest.
> >> >> >> 
> >> >> >> So, how is the virtio core supposed to determine this? A
> >> >> >> transport-specific callback?
> >> >> >
> >> >> > I'd say a field in VirtIODevice is easiest.
> >> >> 
> >> >> The transport needs to set this as soon as it has figured out whether
> >> >> we're using legacy or not.
> >> >
> >> > Basically on each device config access?
> >> 
> >> Prior to the first one, I think. It should not change again, should it?
> >
> > Well yes but we never prohibited someone from poking at both ..
> > Doing it on each access means we don't have state to migrate.
> 
> Yes; if it isn't too high overhead, that's probably the safest way to
> handle it.
> 
> >
> >> >
> >> >> I guess we also need to fence off any
> >> >> accesses respectively error out the device if the driver tries any
> >> >> read/write operations that would depend on that knowledge?
> >> >> 
> >> >> And using a field in VirtIODevice would probably need some care when
> >> >> migrating. Hm...
> >> >
> >> > It's just a shorthand to minimize changes. No need to migrate I think.
> >> 
> >> If we migrate in from an older QEMU, we don't know whether we are
> >> dealing with legacy or not, until feature negotiation is already
> >> done... don't we have to ask the transport?
> >
> > Right but the only thing that can happen is config access.
> 
> Checking on each config space access would be enough then.
> 
> > Well and for legacy a kick I guess.
> 
> I think any driver that does something that is not config space access,
> status access, or feature bit handling without VERSION_1 being set is
> neccessarily legacy? Does that really need special handling?

Likely not, I just wanted to be exact.

-- 
MST

