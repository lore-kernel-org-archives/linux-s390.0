Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9B1B3C43334
	for <linux-s390@archiver.kernel.org>; Wed, 29 Jun 2022 07:15:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231217AbiF2HPV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 29 Jun 2022 03:15:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229836AbiF2HPU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Wed, 29 Jun 2022 03:15:20 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 9094A33364
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 00:15:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1656486918;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=yxaIGjt/4YMOZg4WjQlEh9o2Sctvt7eqfm3ZD+2F0lo=;
        b=LvMQUCr0zU0UbQu79lR6FLd9ER1VKAhhDE2AfeiibMxKhBd5/u2sYTmDJhUq+LAuaCm5Ga
        NaPUXV8Dn3KgZOQ8FoYRdOYjfRDHgazGEBzI8z+kdlXb4kAw5TLjZdNLYCKus+w17sgO/m
        U76ikF2wDHAg9AWUYD2wps/99RZ8fys=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-536-Dut44pyYO-eJGE6-aNL6xA-1; Wed, 29 Jun 2022 03:15:16 -0400
X-MC-Unique: Dut44pyYO-eJGE6-aNL6xA-1
Received: by mail-wm1-f72.google.com with SMTP id v125-20020a1cac83000000b0039c832fbd02so10099889wme.4
        for <linux-s390@vger.kernel.org>; Wed, 29 Jun 2022 00:15:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=yxaIGjt/4YMOZg4WjQlEh9o2Sctvt7eqfm3ZD+2F0lo=;
        b=ZrPwlNaRhsPCZf19sb/PsR2XjuKZ5NAbJl5+0Gp0drOlkoi/me4AVeZoT0ClsZt8BD
         NWtO0sH/jkjCnLiaolOyZBYAcoTFImAQvXnGQo1z6fE62XeVeuC70AcT7++o6pLaXorv
         hYXPbyqMHe6Qyw87z8tNqvDW4kVAAfw8M2IqvcJqXg25+vrE/WNNnJnFURwoze0RQ+Zn
         Uhtn9MRlpWl8spaswWrB0lQ6v/aAbsbWHQc3/TG0b262DJGGD8wiLZNtW1SK1zPHlMyX
         9EDYE6FY36JIGbdrEfHCzuzzE2AmsoTcLlZv0mPnPy+8Ps4hrJmhz8CfeSge8zVyNY1h
         Ufyw==
X-Gm-Message-State: AJIora8oCrcVbvJHu9xN1ayJNtUHQwbwOqibvXW1b1EMBhW8g1MeTNCl
        z7+/JMV26n4NbOFoz6Ir9ykAYte9QLp2lZ6Ubx5yXqem8MYZEFFczFw/OqZ0slAeXRdFpNsgPZc
        H0V8qOgEy4wfL87iWJ2M49w==
X-Received: by 2002:a05:600c:3542:b0:3a1:6855:1153 with SMTP id i2-20020a05600c354200b003a168551153mr1702713wmq.121.1656486915120;
        Wed, 29 Jun 2022 00:15:15 -0700 (PDT)
X-Google-Smtp-Source: AGRyM1tpClGQvlBrnG+3cY/I3Shi+z3wdCHGxIqznCCwszS9iYsWm4igce/0pKeAuj4JN2pzhuyLJw==
X-Received: by 2002:a05:600c:3542:b0:3a1:6855:1153 with SMTP id i2-20020a05600c354200b003a168551153mr1702662wmq.121.1656486914525;
        Wed, 29 Jun 2022 00:15:14 -0700 (PDT)
Received: from redhat.com ([2.52.23.204])
        by smtp.gmail.com with ESMTPSA id h13-20020adff4cd000000b002103aebe8absm15585352wrp.93.2022.06.29.00.15.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Jun 2022 00:15:14 -0700 (PDT)
Date:   Wed, 29 Jun 2022 03:15:09 -0400
From:   "Michael S. Tsirkin" <mst@redhat.com>
To:     Jason Wang <jasowang@redhat.com>
Cc:     Cornelia Huck <cohuck@redhat.com>,
        Halil Pasic <pasic@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        linux-s390@vger.kernel.org,
        virtualization <virtualization@lists.linux-foundation.org>,
        kvm <kvm@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ben Hutchings <ben@decadent.org.uk>,
        David Hildenbrand <david@redhat.com>
Subject: Re: [PATCH V3] virtio: disable notification hardening by default
Message-ID: <20220629030600-mutt-send-email-mst@kernel.org>
References: <CACGkMEuurobpUWmDL8zmZ6T6Ygc0OEMx6vx2EDCSoGNnZQ0r-w@mail.gmail.com>
 <20220627024049-mutt-send-email-mst@kernel.org>
 <CACGkMEvrDXDN7FH1vKoYCob2rkxUsctE_=g61kzHSZ8tNNr6vA@mail.gmail.com>
 <20220627053820-mutt-send-email-mst@kernel.org>
 <CACGkMEvcs+9_SHmO1s3nyzgU7oq7jhU2gircVVR3KDsGDikh5Q@mail.gmail.com>
 <20220628004614-mutt-send-email-mst@kernel.org>
 <CACGkMEsC4A+3WejLSOZoH3enXtai=+JyRNbxcpzK4vODYzhaFw@mail.gmail.com>
 <CACGkMEvu0D0XD7udz0ebVjNM0h5+K9Rjd-5ed=PY_+-aduzG2g@mail.gmail.com>
 <20220629022223-mutt-send-email-mst@kernel.org>
 <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACGkMEuwvzkbPUSFueCOjit7pRJ81v3-W3SZD+7jQJN8btEFdg@mail.gmail.com>
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Wed, Jun 29, 2022 at 03:02:21PM +0800, Jason Wang wrote:
> On Wed, Jun 29, 2022 at 2:31 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> >
> > On Wed, Jun 29, 2022 at 12:07:11PM +0800, Jason Wang wrote:
> > > On Tue, Jun 28, 2022 at 2:17 PM Jason Wang <jasowang@redhat.com> wrote:
> > > >
> > > > On Tue, Jun 28, 2022 at 1:00 PM Michael S. Tsirkin <mst@redhat.com> wrote:
> > > > >
> > > > > On Tue, Jun 28, 2022 at 11:49:12AM +0800, Jason Wang wrote:
> > > > > > > Heh. Yea sure. But things work fine for people. What is the chance
> > > > > > > your review found and fixed all driver bugs?
> > > > > >
> > > > > > I don't/can't audit all bugs but the race between open/close against
> > > > > > ready/reset. It looks to me a good chance to fix them all but if you
> > > > > > think differently, let me know
> > > > > >
> > > > > > > After two attempts
> > > > > > > I don't feel like hoping audit will fix all bugs.
> > > > > >
> > > > > > I've started the auditing and have 15+ patches in the queue. (only
> > > > > > covers bluetooth, console, pmem, virtio-net and caif). Spotting the
> > > > > > issue is not hard but the testing, It would take at least the time of
> > > > > > one release to finalize I guess.
> > > > >
> > > > > Absolutely. So I am looking for a way to implement hardening that does
> > > > > not break existing drivers.
> > > >
> > > > I totally agree with you to seek a way without bothering the drivers.
> > > > Just wonder if this is possbile.
> > > >
> > > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > The reason config was kind of easy is that config interrupt is rarely
> > > > > > > > > vital for device function so arbitrarily deferring that does not lead to
> > > > > > > > > deadlocks - what you are trying to do with VQ interrupts is
> > > > > > > > > fundamentally different. Things are especially bad if we just drop
> > > > > > > > > an interrupt but deferring can lead to problems too.
> > > > > > > >
> > > > > > > > I'm not sure I see the difference, disable_irq() stuffs also delay the
> > > > > > > > interrupt processing until enable_irq().
> > > > > > >
> > > > > > >
> > > > > > > Absolutely. I am not at all sure disable_irq fixes all problems.
> > > > > > >
> > > > > > > > >
> > > > > > > > > Consider as an example
> > > > > > > > >     virtio-net: fix race between ndo_open() and virtio_device_ready()
> > > > > > > > > if you just defer vq interrupts you get deadlocks.
> > > > > > > > >
> > > > > > > > >
> > > > > > > >
> > > > > > > > I don't see a deadlock here, maybe you can show more detail on this?
> > > > > > >
> > > > > > > What I mean is this: if we revert the above commit, things still
> > > > > > > work (out of spec, but still). If we revert and defer interrupts until
> > > > > > > device ready then ndo_open that triggers before device ready deadlocks.
> > > > > >
> > > > > > Ok, I guess you meant on a hypervisor that is strictly written with spec.
> > > > >
> > > > > I mean on hypervisor that starts processing queues after getting a kick
> > > > > even without DRIVER_OK.
> > > >
> > > > Oh right.
> > > >
> > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > So, thinking about all this, how about a simple per vq flag meaning
> > > > > > > > > "this vq was kicked since reset"?
> > > > > > > >
> > > > > > > > And ignore the notification if vq is not kicked? It sounds like the
> > > > > > > > callback needs to be synchronized with the kick.
> > > > > > >
> > > > > > > Note we only need to synchronize it when it changes, which is
> > > > > > > only during initialization and reset.
> > > > > >
> > > > > > Yes.
> > > > > >
> > > > > > >
> > > > > > >
> > > > > > > > >
> > > > > > > > > If driver does not kick then it's not ready to get callbacks, right?
> > > > > > > > >
> > > > > > > > > Sounds quite clean, but we need to think through memory ordering
> > > > > > > > > concerns - I guess it's only when we change the value so
> > > > > > > > >         if (!vq->kicked) {
> > > > > > > > >                 vq->kicked = true;
> > > > > > > > >                 mb();
> > > > > > > > >         }
> > > > > > > > >
> > > > > > > > > will do the trick, right?
> > > > > > > >
> > > > > > > > There's no much difference with the existing approach:
> > > > > > > >
> > > > > > > > 1) your proposal implicitly makes callbacks ready in virtqueue_kick()
> > > > > > > > 2) my proposal explicitly makes callbacks ready via virtio_device_ready()
> > > > > > > >
> > > > > > > > Both require careful auditing of all the existing drivers to make sure
> > > > > > > > no kick before DRIVER_OK.
> > > > > > >
> > > > > > > Jason, kick before DRIVER_OK is out of spec, sure. But it is unrelated
> > > > > > > to hardening
> > > > > >
> > > > > > Yes but with your proposal, it seems to couple kick with DRIVER_OK somehow.
> > > > >
> > > > > I don't see how - my proposal ignores DRIVER_OK issues.
> > > >
> > > > Yes, what I meant is, in your proposal, the first kick after rest is a
> > > > hint that the driver is ok (but actually it could not).
> > > >
> > > > >
> > > > > > > and in absence of config interrupts is generally easily
> > > > > > > fixed just by sticking virtio_device_ready early in initialization.
> > > > > >
> > > > > > So if the kick is done before the subsystem registration, there's
> > > > > > still a window in the middle (assuming we stick virtio_device_ready()
> > > > > > early):
> > > > > >
> > > > > > virtio_device_ready()
> > > > > > virtqueue_kick()
> > > > > > /* the window */
> > > > > > subsystem_registration()
> > > > >
> > > > > Absolutely, however, I do not think we really have many such drivers
> > > > > since this has been known as a wrong thing to do since the beginning.
> > > > > Want to try to find any?
> > > >
> > > > Yes, let me try and update.
> > >
> > > This is basically the device that have an RX queue, so I've found the
> > > following drivers:
> > >
> > > scmi, mac80211_hwsim, vsock, bt, balloon.
> >
> > Looked and I don't see it yet. Let's consider
> > ./net/vmw_vsock/virtio_transport.c for example. Assuming we block
> > callbacks until the first kick, what is the issue with probe exactly?
> 
> We need to make sure the callback can survive when it runs before sub
> system registration.

With my proposal no - only if we also kick before registration.
So I do not see the issue yet.

Consider ./net/vmw_vsock/virtio_transport.c

kicks: virtio_transport_send_pkt_work,
virtio_vsock_rx_fill, virtio_vsock_event_fill

which of these triggers before we are ready to
handle callbacks?


> >
> >
> > > >
> > > > >I couldn't ... except maybe bluetooth
> > > > > but that's just maintainer nacking fixes saying he'll fix it
> > > > > his way ...
> > > > >
> > > > > > And during remove(), we get another window:
> > > > > >
> > > > > > subsysrem_unregistration()
> > > > > > /* the window */
> > > > > > virtio_device_reset()
> > > > >
> > > > > Same here.
> > >
> > > Basically for the drivers that set driver_ok before registration,
> >
> > I don't see what does driver_ok have to do with it.
> 
> I meant for those driver, in probe they do()
> 
> virtio_device_ready()
> subsystem_register()
> 
> In remove() they do
> 
> subsystem_unregister()
> virtio_device_reset()
> 
> for symmetry

Let's leave remove alone for now. I am close to 100% sure we have *lots*
of issues around it, but while probe is unavoidable remove can be
avoided by blocking hotplug.


> >
> > > so
> > > we have a lot:
> > >
> > > blk, net, mac80211_hwsim, scsi, vsock, bt, crypto, gpio, gpu, i2c,
> > > iommu, caif, pmem, input, mem
> > >
> > > So I think there's no easy way to harden the notification without
> > > auditing the driver one by one (especially considering the driver may
> > > use bh or workqueue). The problem is the notification hardening
> > > depends on a correct or race-free probe/remove. So we need to fix the
> > > issues in probe/remove then do the hardening on the notification.
> > >
> > > Thanks
> >
> > So if drivers kick but are not ready to get callbacks then let's fix
> > that first of all, these are racy with existing qemu even ignoring
> > spec compliance.
> 
> Yes, (the patches I've posted so far exist even with a well-behaved device).
> 
> Thanks

patches you posted deal with DRIVER_OK spec compliance.
I do not see patches for kicks before callbacks are ready to run.

> >
> >
> > --
> > MST
> >

