Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE43CC433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:46:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C474A6113A
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 15:46:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235927AbhJDPr7 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 11:47:59 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:51554 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235911AbhJDPr4 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 11:47:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633362367;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=/kgxHPxpLf6tZjNevWzK9k9Z43+ZiXIpJpi5hdMq0z0=;
        b=S6rMgc3iH0dfy9fdKrVY4axO+6A5NEDDZLE7UOhvSMXeodTGIF25EEirlj8BBFCw5WaM7g
        VsWfVBItGn9w8gA3UFa9QdwOOcqByHaNBqrhEhh4NSc2CtzR7K8EZPWwUQZIw+2f5X3xDO
        1ZlmbNVIJYWAP+5brEauJKOXuSTX8p8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-263-x44U3w48N9KR2IkCHQKonA-1; Mon, 04 Oct 2021 11:46:02 -0400
X-MC-Unique: x44U3w48N9KR2IkCHQKonA-1
Received: from smtp.corp.redhat.com (int-mx05.intmail.prod.int.phx2.redhat.com [10.5.11.15])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 341D58F51C;
        Mon,  4 Oct 2021 15:46:01 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21AE36B544;
        Mon,  4 Oct 2021 15:45:08 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     "Michael S. Tsirkin" <mst@redhat.com>
Cc:     Halil Pasic <pasic@linux.ibm.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, virtio-dev@lists.oasis-open.org
Subject: Re: [virtio-dev] Re: [RFC PATCH 1/1] virtio: write back features
 before verify
In-Reply-To: <20211004110152-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <20210930070444-mutt-send-email-mst@kernel.org>
 <87fstm47no.fsf@redhat.com>
 <20211002141351-mutt-send-email-mst@kernel.org>
 <20211003070030.658fc94e.pasic@linux.ibm.com>
 <20211003021027-mutt-send-email-mst@kernel.org>
 <20211003032253-mutt-send-email-mst@kernel.org>
 <87ee912e45.fsf@redhat.com>
 <20211004083455-mutt-send-email-mst@kernel.org>
 <878rz83lx0.fsf@redhat.com>
 <20211004110152-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 04 Oct 2021 17:45:06 +0200
Message-ID: <87zgro23r1.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.15
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 02:01:14PM +0200, Cornelia Huck wrote:
>> >> On Sun, Oct 03 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> > @@ -160,6 +163,33 @@ \subsection{Legacy Interface: A Note on Feature
>> >> >  Specification text within these sections generally does not apply
>> >> >  to non-transitional devices.
>> >> >  
>> >> > +\begin{note}
>> >> > +The device offers different features when used through
>> >> > +the legacy interface and when operated in accordance with this
>> >> > +specification.
>> >> > +\end{note}
>> >> > +
>> >> > +Transitional drivers MUST use Devices only through the legacy interface
>> >> 
>> >> s/Devices only through the legacy interface/devices through the legacy
>> >> interface only/
>> >> 
>> >> ?
>> >
>> > Both versions are actually confused, since how do you
>> > find out that device does not offer VIRTIO_F_VERSION_1?
>> >
>> > I think what this should really say is
>> >
>> > Transitional drivers MUST NOT accept VIRTIO_F_VERSION_1 through
>> > the legacy interface.
>> 
>> Ok, that makes sense.
>> 
>> Would it make sense that transitional drivers MUST accept VERSION_1
>> through the non-legacy interface? Or is that redundant?
>
> We already have:
>
> A driver MUST accept VIRTIO_F_VERSION_1 if it is offered.

Yep, so it is redundant.

>
>
>> >
>> >
>> > Does linux actually satisfy this? Will it accept VIRTIO_F_VERSION_1
>> > through the legacy interface if offered?
>> 
>> I think that the Linux drivers will not operate on feature bit 32+ if
>> they are in legacy mode?
>
>
> Well ... with PCI there's no *way* for host to set bit 32 through
> legacy. But it might be possible with MMIO/CCW. Can you tell me
> what happens then?

ccw does not support accessing bit 32+, either. Not sure about mmio.

>
>
>> >> 
>> >> Generally, looks good to me.
>> >
>> > Do we want to also add explanation that features can be
>> > changed until FEATURES_OK?
>> 
>> I always considered that to be implict, as feature negotiation is not
>> over until we have FEATURES_OK. Not sure whether we need an extra note.
>
> Well Halil here says once you set a feature bit you can't clear it.
> So maybe not ...

Ok, so what about something like

"If FEATURES_OK is not set, the driver MAY change the set of features it
accepts."

in the device initialization section?

