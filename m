Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9653EC07E96
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:05:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AE7F61945
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 16:05:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229823AbhGFQIN (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 12:08:13 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:36632 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229807AbhGFQIN (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 12:08:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625587534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nfIRC7rfDe6kFL8Lgm0JvIXgRdabfH05pXW2TNlYm0M=;
        b=afsMMvT65OAraRmU6iCkGnP8EqFXDH6hlqDBS/j0XT4aR2cIrOYZ+s4Dom3fZnvQsh8qFq
        bhtpN/HSGuGgW6rCm7DQl2iJkilNYxLTBUrpl4ROXDYKeXU3jmORPlaKLslrvbmpjcmlFu
        napTrk1huaeVkzzf1n17gYZhQyqlo0Y=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-594-Tktz9wa-PDOil2dmFkSzyA-1; Tue, 06 Jul 2021 12:05:30 -0400
X-MC-Unique: Tktz9wa-PDOil2dmFkSzyA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 0DFF5804141;
        Tue,  6 Jul 2021 16:05:29 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id A956C5D9D5;
        Tue,  6 Jul 2021 16:05:28 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     kernel@pengutronix.de, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Vineeth Vijayan <vneethv@linux.ibm.com>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        linux-s390@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 3/4] s390/scm: Make struct scm_driver::remove return
 void
In-Reply-To: <20210706154803.1631813-4-u.kleine-koenig@pengutronix.de>
Organization: Red Hat GmbH
References: <20210706154803.1631813-1-u.kleine-koenig@pengutronix.de>
 <20210706154803.1631813-4-u.kleine-koenig@pengutronix.de>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 18:05:27 +0200
Message-ID: <87tul7fmwo.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>=
 wrote:

> The driver core ignores the return value of scmdev_remove()
> (because there is only little it can do when a device disappears).
>
> So make it impossible for future drivers to return an unused error code
> by changing the remove prototype to return void.
>
> The real motivation for this change is the quest to make struct
> bus_type::remove return void, too.
>
> Signed-off-by: Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>
> ---
>  arch/s390/include/asm/eadm.h | 2 +-
>  drivers/s390/block/scm_drv.c | 4 +---
>  drivers/s390/cio/scm.c       | 5 ++++-
>  3 files changed, 6 insertions(+), 5 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

