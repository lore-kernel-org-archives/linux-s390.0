Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AED4DC433EF
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9191261506
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 07:38:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231816AbhJEHkN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 03:40:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36032 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230526AbhJEHkM (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 03:40:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633419502;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=EtTBfJ7umQKOo9c4zQtEMAqccC4CaaUVFj0BPcVpmPk=;
        b=Xz+rDMB3u6YVvM0KG83ArDFLV5p1ME5fDm/fFxlsS13Z8+iY0QkUy2Ri6avlh4jVP34m36
        wXJtjWGxCu8aVZTzdKbO1QpPrtwCX4x9JfjtR8KC16fB8CZFc4Ab7UFWwV4mOsLkQ6PDkR
        uGvcSt2Uv0IqrNW/VGf0oFe+XtvjCqw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-520-N9l1X2KRMuymU2ciTndIsQ-1; Tue, 05 Oct 2021 03:38:21 -0400
X-MC-Unique: N9l1X2KRMuymU2ciTndIsQ-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id F331DA40C0;
        Tue,  5 Oct 2021 07:38:19 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id D750F18A50;
        Tue,  5 Oct 2021 07:38:07 +0000 (UTC)
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
In-Reply-To: <20211004160005-mutt-send-email-mst@kernel.org>
Organization: Red Hat GmbH
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
 <20211004160005-mutt-send-email-mst@kernel.org>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 05 Oct 2021 09:38:05 +0200
Message-ID: <87r1cz2a76.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:

> On Mon, Oct 04, 2021 at 05:45:06PM +0200, Cornelia Huck wrote:
>> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Mon, Oct 04, 2021 at 04:27:23PM +0200, Cornelia Huck wrote:
>> >> On Mon, Oct 04 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> >> 
>> >> > Do we want to also add explanation that features can be
>> >> > changed until FEATURES_OK?
>> >> 
>> >> I always considered that to be implict, as feature negotiation is not
>> >> over until we have FEATURES_OK. Not sure whether we need an extra note.
>> >
>> > Well Halil here says once you set a feature bit you can't clear it.
>> > So maybe not ...
>> 
>> Ok, so what about something like
>> 
>> "If FEATURES_OK is not set, the driver MAY change the set of features it
>> accepts."
>> 
>> in the device initialization section?
>
> Maybe "as long as". However Halil implied that some features are not
> turned off properly if that happens. Halil could you pls provide
> some examples?

Yes, "as long as" sounds better.

