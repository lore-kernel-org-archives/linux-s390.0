Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B15BDC48BC2
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90CB061042
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 15:27:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbhFUP3Y (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 11:29:24 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:48347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230006AbhFUP3W (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 11:29:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624289228;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=oKH3WrghurtcSjJURHMQlR3Xfv09Uet3o3zg0EOXmTY=;
        b=gWlbOD/sfGeQRrQc5YDFBLe7I/fghcaEOXbdg6t9PB3UgJCAZSAGPLL54q9+ERh10IkWT5
        cWnarfCMj2mX+W4z5+o0cTpqOXoyaZiyyI2TReocFqwr9CLeuhvLqmQJZwP3nNoFFeRe3e
        3NUUXZDgQFslj/respMBsRaS7f1Fbzw=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-51-cgFO5IpsNC2f9V91EieTFA-1; Mon, 21 Jun 2021 11:27:04 -0400
X-MC-Unique: cgFO5IpsNC2f9V91EieTFA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DE6285074E;
        Mon, 21 Jun 2021 15:27:02 +0000 (UTC)
Received: from localhost (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 8783E369A;
        Mon, 21 Jun 2021 15:27:02 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Heiko Carstens <hca@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>
Cc:     Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        linux-s390@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] virtio/s390: get rid of open-coded kvm hypercall
In-Reply-To: <20210621144522.1304273-1-hca@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210621144522.1304273-1-hca@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 21 Jun 2021 17:27:00 +0200
Message-ID: <87lf73nsqj.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Mon, Jun 21 2021, Heiko Carstens <hca@linux.ibm.com> wrote:

> do_kvm_notify() and __do_kvm_notify() are an (exact) open-coded variant
> of kvm_hypercall3(). Therefore simply make use of kvm_hypercall3(),
> and get rid of duplicated code.
>
> Signed-off-by: Heiko Carstens <hca@linux.ibm.com>
> ---
>  drivers/s390/virtio/virtio_ccw.c | 30 ++++--------------------------
>  1 file changed, 4 insertions(+), 26 deletions(-)
>

Hm, I wonder why I didn't use kvm_hypercall3 in the first place. It's in
a header, and therefore should be independent of kvm being configured.

I don't think there's anything else virtio-ccw in flight at the moment,
so maybe you can apply this one directly?

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

