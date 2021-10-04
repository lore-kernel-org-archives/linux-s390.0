Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4194C433EF
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 09:51:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B943F61090
	for <linux-s390@archiver.kernel.org>; Mon,  4 Oct 2021 09:51:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232161AbhJDJx0 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 4 Oct 2021 05:53:26 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:21755 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232117AbhJDJx0 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Mon, 4 Oct 2021 05:53:26 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633341097;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=11lDRR5Yz28JFxRtHvrquBSIh5tMxQHAlBJP5+qYWSo=;
        b=DHWBpIMySfcR2f34HYwHLXAqDbZ7a++6s9liwrPFBsGZ0LsMLTV/6c0ShUgiPCjxdAWE0k
        mxIAbSLizVyzKCIUX1+PCsCok6iL1egx4qfVoRgsOp3g2HEXjDLeV7R/74VrjrAl+h+Olp
        tRCjKztEA3Eu76TzajUFMSvA0xb3d9Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-343-TsrUeYovNKGhF15TjTdcUg-1; Mon, 04 Oct 2021 05:51:35 -0400
X-MC-Unique: TsrUeYovNKGhF15TjTdcUg-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3B63E8015C7;
        Mon,  4 Oct 2021 09:51:34 +0000 (UTC)
Received: from localhost (unknown [10.39.193.66])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 154DC60657;
        Mon,  4 Oct 2021 09:51:29 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>
Cc:     "Michael S. Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Xie Yongji <xieyongji@bytedance.com>,
        virtualization@lists.linux-foundation.org,
        linux-kernel@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211004112528.74442e52.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <87pmsl2rzd.fsf@redhat.com> <20211004112528.74442e52.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 04 Oct 2021 11:51:28 +0200
Message-ID: <87mtnp2k4f.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Oct 04 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 04 Oct 2021 09:01:42 +0200
> Cornelia Huck <cohuck@redhat.com> wrote:
>
>> On Sat, Oct 02 2021, "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> 
>> > On Fri, Oct 01, 2021 at 05:18:46PM +0200, Cornelia Huck wrote:  
>> >> I'd say we need a hack here so that we assume little-endian config space
>> >> if VERSION_1 has been offered; if your patch here works, I assume QEMU
>> >> does what we expect (assmuming little-endian as well.) I'm mostly
>> >> wondering what happens if you use a different VMM; can we expect it to
>> >> work similar to QEMU?  
>> >
>> > Hard to say of course ... hopefully other VMMs are actually
>> > implementing the spec. E.g. IIUC rust vmm is modern only.  
>> 
>> Yes, I kind of hope they are simply doing LE config space accesses.
>> 
>> Are there any other VMMs that are actually supported on s390x (or other
>> BE architectures)?
>> 
>
> I think zCX (z/OS Container Extensions) is relevant as it uses virtio.
> That is all I know about.

Ok, I'll assume that you (IBM) will be able to verify that any fixup
will continue to work there.

