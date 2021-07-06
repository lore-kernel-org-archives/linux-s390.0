Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7BCA0C07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 15:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62CD76101C
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 15:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230109AbhGFQBL (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:01:11 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:55501 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230108AbhGFQBK (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 12:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625587111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CtgBxXlhJt8Wtll8aba26kDe6OF3hHBqz0hVb5nuD0E=;
        b=OLIdZl0TeJcary8IgENEvtB5UrQsDveNLpkuP7ZzSeXCuOPbQEOvQJcr2jFvayXogCOUzR
        ylnv2xmgx//jf0vUXIPYNPy0ZuMHx8Xrij3M/qUxyKnKPEQMs1m+0llXenLVGqr0xVFP51
        SyCY5sk+jnzJySXH4nfQeWs9L+BDTxM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-3tmVkwYNON-NoZjdKr8Puw-1; Tue, 06 Jul 2021 11:58:30 -0400
X-MC-Unique: 3tmVkwYNON-NoZjdKr8Puw-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 1302E362F8;
        Tue,  6 Jul 2021 15:58:28 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 9A55719D9D;
        Tue,  6 Jul 2021 15:58:27 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Eric Farman <farman@linux.ibm.com>,
        Matthew Rosato <mjrosato@linux.ibm.com>,
        Halil Pasic <pasic@linux.ibm.com>, linux-s390@vger.kernel.org,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH v2 1/4] s390/cio: Make struct css_driver::remove return
 void
In-Reply-To: <20210706154803.1631813-2-u.kleine-koenig@pengutronix.de>
Organization: Red Hat GmbH
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-2-u.kleine-koenig@pengutronix.de>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 17:58:25 +0200
Message-ID: <87zguzfn8e.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 wrote:

> The driver core ignores the return value of css_remove()
> (because there is only little it can do when a device disappears) and
> there are no pci_epf_drivers with a remove callback.

s/pci_epf/css/

>
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
>
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  drivers/s390/cio/chsc_sch.c     | 3 +--
>  drivers/s390/cio/css.c          | 7 ++++---
>  drivers/s390/cio/css.h          | 2 +-
>  drivers/s390/cio/device.c       | 5 ++---
>  drivers/s390/cio/eadm_sch.c     | 4 +---
>  drivers/s390/cio/vfio_ccw_drv.c | 3 +--
>  6 files changed, 10 insertions(+), 14 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

