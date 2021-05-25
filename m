Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3591C2B9F8
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:21:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C49B26142B
	for <linux-s390@archiver.kernel.org>; Tue, 25 May 2021 14:21:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233795AbhEYOW5 (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 25 May 2021 10:22:57 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57138 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233555AbhEYOW5 (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Tue, 25 May 2021 10:22:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1621952487;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7yXc2J9QU9ELNw+eWMpTrg/FjDyia1T2yZ46TejbBKA=;
        b=HNCOvTZmR7O2HgunF9SuXZUWefS4G8OjS4E5nKvTHwKDSk3QnfbLK1xbRKJ7oY+qDatTNG
        zvxnWLdXITLbwBX1wGng3BfyXbl5U0Um35o6Z3DhLde/pXSINuqSwcVQEWzefHad+BTyDv
        ABC8tPa7ZwwaGMjYpXCPvEA/g/s2z3s=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-475-dI-VuYkSNRGjFxAXGI9OsA-1; Tue, 25 May 2021 10:21:25 -0400
X-MC-Unique: dI-VuYkSNRGjFxAXGI9OsA-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3F0FF8042B4;
        Tue, 25 May 2021 14:21:23 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-112-197.ams2.redhat.com [10.36.112.197])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 8CBBA5DEC1;
        Tue, 25 May 2021 14:21:21 +0000 (UTC)
Date:   Tue, 25 May 2021 16:21:18 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Stefan Haberland <sth@linux.ibm.com>
Cc:     Jens Axboe <axboe@kernel.dk>, linux-block@vger.kernel.org,
        Jan Hoeppner <hoeppner@linux.ibm.com>,
        linux-s390@vger.kernel.org, Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Subject: Re: [PATCH 1/1] s390/dasd: add missing discipline function
Message-ID: <20210525162118.0f4e5b84.cohuck@redhat.com>
In-Reply-To: <20210525125006.157531-2-sth@linux.ibm.com>
References: <20210525125006.157531-1-sth@linux.ibm.com>
        <20210525125006.157531-2-sth@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 25 May 2021 14:50:06 +0200
Stefan Haberland <sth@linux.ibm.com> wrote:

> Fix crash with illegal operation exception in dasd_device_tasklet.
> Commit b72949328869 ("s390/dasd: Prepare for additional path event handling")
> renamed the verify_path function for ECKD but not for FBA and DIAG.
> This leads to a panic when the path verification function is called for a
> FBA or DIAG device.
> 
> Fix by defining a wrapper function for dasd_generic_verify_path().
> 
> Fixes: b72949328869 ("s390/dasd: Prepare for additional path event handling")
> 
> Cc: <stable@vger.kernel.org> #5.11
> Reviewed-by: Jan Hoeppner <hoeppner@linux.ibm.com>
> Signed-off-by: Stefan Haberland <sth@linux.ibm.com>
> ---
>  drivers/s390/block/dasd_diag.c | 8 +++++++-
>  drivers/s390/block/dasd_fba.c  | 8 +++++++-
>  drivers/s390/block/dasd_int.h  | 1 -
>  3 files changed, 14 insertions(+), 3 deletions(-)

Oops.

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

[Just to satisfy my curiosity: are there still any FBA devices around,
other than z/VM emulating a DASD frontend for FCP devices?]

