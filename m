Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_NONE
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46777C48BE5
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 14:47:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 218B1610C7
	for <linux-s390@archiver.kernel.org>; Mon, 21 Jun 2021 14:47:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230052AbhFUOtV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Mon, 21 Jun 2021 10:49:21 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:57059 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229897AbhFUOtU (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Mon, 21 Jun 2021 10:49:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1624286826;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=MYUWWvfas2vfmbE1PFvd5rlCu4u4NSRSDtDz3HiuHqw=;
        b=UiG3NmSrzaBWxHjwi6ZffmPdWrR0/mPKFR8BIMaBlq3ehzOh4jAnsb+H/H/TMkzCrZM7Pf
        t8cH+ginaiWHJRZsZVQuO0dMkndt3BaPZWDjPNZXBLUl6ZZLZhYyHKkz/h6Vk139TqhMoQ
        LqOISt3clCihyp7OL9UNcXNkt8DzKOU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-580-mGQ-nS3PMU6D7W2w11na0A-1; Mon, 21 Jun 2021 10:47:04 -0400
X-MC-Unique: mGQ-nS3PMU6D7W2w11na0A-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 71CB9800C78;
        Mon, 21 Jun 2021 14:47:03 +0000 (UTC)
Received: from localhost (ovpn-113-141.ams2.redhat.com [10.36.113.141])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 01A601899A;
        Mon, 21 Jun 2021 14:47:00 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2] s390x: selftest: Add prefixes to fix
 report output (was "s390x: selftest: Fix report output")
In-Reply-To: <20210610141913.61553-1-frankja@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210610141913.61553-1-frankja@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Mon, 21 Jun 2021 16:46:59 +0200
Message-ID: <87pmwfnul8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Thu, Jun 10 2021, Janosch Frank <frankja@linux.ibm.com> wrote:

> To make our TAP parser (and me) happy we don't want to have two reports
> with exactly the same wording so I added in two new prefix pushes.
>
> Also moving the code inside of the region of a prefix will give us
> more data when a problem arises.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> Reviewed-by: Claudio Imbrenda <imbrenda@linux.ibm.com>
> ---
>  s390x/selftest.c | 26 ++++++++++++++++++--------
>  1 file changed, 18 insertions(+), 8 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

