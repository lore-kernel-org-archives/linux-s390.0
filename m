Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9BECBC433FE
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:13:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 821196120C
	for <linux-s390@archiver.kernel.org>; Tue,  5 Oct 2021 11:13:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234327AbhJELPt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 5 Oct 2021 07:15:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:51377 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233514AbhJELPs (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 5 Oct 2021 07:15:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1633432438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=l9NIjeIAQCFxtj6GGh0Whhg4tP/fsFPSi3algChPtGc=;
        b=IoeEga2db4sStw4cENDtz39p5JgP3VK4EksqgFZLOjyrpESCL/ua01HI2/ec9AkWNbRV/6
        eV63SvKb8jGZ7jTzaP4sr8chbizwLvqcnEpw5TXinm2B3b6IHV0UQ+NtclrCQbPN3eeyVa
        Q2/W6mdqBIEJw7pZZeFuIoZAtHe88zo=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-164-SJRXkDwFOOWPwxdT0Az79Q-1; Tue, 05 Oct 2021 07:13:54 -0400
X-MC-Unique: SJRXkDwFOOWPwxdT0Az79Q-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C86271006AA2;
        Tue,  5 Oct 2021 11:13:52 +0000 (UTC)
Received: from localhost (unknown [10.39.192.167])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id CA34B1036B32;
        Tue,  5 Oct 2021 11:13:38 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Halil Pasic <pasic@linux.ibm.com>,
        "Michael S. Tsirkin" <mst@redhat.com>
Cc:     linux-s390@vger.kernel.org, markver@us.ibm.com,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        qemu-devel@nongnu.org, linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Xie Yongji <xieyongji@bytedance.com>, stefanha@redhat.com,
        Raphael Norwitz <raphael.norwitz@nutanix.com>,
        Halil Pasic <pasic@linux.ibm.com>
Subject: Re: [RFC PATCH 1/1] virtio: write back features before verify
In-Reply-To: <20211005124303.3abf848b.pasic@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210930012049.3780865-1-pasic@linux.ibm.com>
 <87r1d64dl4.fsf@redhat.com> <20210930130350.0cdc7c65.pasic@linux.ibm.com>
 <87ilyi47wn.fsf@redhat.com> <20211001162213.18d7375e.pasic@linux.ibm.com>
 <87v92g3h9l.fsf@redhat.com>
 <20211002082128-mutt-send-email-mst@kernel.org>
 <20211004042323.730c6a5e.pasic@linux.ibm.com>
 <20211004040937-mutt-send-email-mst@kernel.org>
 <20211005124303.3abf848b.pasic@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 05 Oct 2021 13:13:31 +0200
Message-ID: <87lf372084.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Oct 05 2021, Halil Pasic <pasic@linux.ibm.com> wrote:

> On Mon, 4 Oct 2021 05:07:13 -0400
> "Michael S. Tsirkin" <mst@redhat.com> wrote:
>> Well we established that we can know. Here's an alternative explanation:
>
>
> I thin we established how this should be in the future, where a transport
> specific mechanism is used to decide are we operating in legacy mode or
> in modern mode. But with the current QEMU reality, I don't think so.
> Namely currently the switch native-endian config -> little endian config
> happens when the VERSION_1 is negotiated, which may happen whenever
> the VERSION_1 bit is changed, or only when FEATURES_OK is set
> (vhost-user).
>
> This is consistent with device should detect a legacy driver by checking
> for VERSION_1, which is what the spec currently says.
>
> So for transitional we start out with native-endian config. For modern
> only the config is always LE.
>
> The guest can distinguish between a legacy only device and a modern
> capable device after the revision negotiation. A legacy device would
> reject the CCW.
>
> But both a transitional device and a modern only device would accept
> a revision > 0. So the guest does not know for ccw.

Well, for pci I think the driver knows that it is using either legacy or
modern, no?

And for ccw, the driver knows at that point in time which revision it
negotiated, so it should know that a revision > 0 will use LE (and the
device will obviously know that as well.)

Or am I misunderstanding what you're getting at?

