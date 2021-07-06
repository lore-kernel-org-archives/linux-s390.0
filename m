Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E201BC07E9B
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:02:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C58E361A46
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 13:02:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbhGFNEt (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:04:49 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:22987 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232168AbhGFNEt (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 09:04:49 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625576530;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f6XFX0Bphb1u8qtHsQEBRFNlThVneEST27WVaLlnJRI=;
        b=S7pAxwczBGxzLHdguCzyReRjNW66B3Tez27d1k8v9bjmWl5K0VpGo4q2uYt2RDB4N6boh9
        lwUYedwW4v0JYUXITAkaX53LpIxiSXsuVNUhBZLKBtgcgAz3G+vMFNIS6I5w/bvUzKRB6O
        M56NELNPkqmJ5+CHRcUyzoAzARY+mq8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-490-rjjCJXTwPZe9d7zz3V7uzw-1; Tue, 06 Jul 2021 09:02:06 -0400
X-MC-Unique: rjjCJXTwPZe9d7zz3V7uzw-1
Received: from smtp.corp.redhat.com (int-mx04.intmail.prod.int.phx2.redhat.com [10.5.11.14])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 23EBA1923779;
        Tue,  6 Jul 2021 13:01:57 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 21DE15DAA5;
        Tue,  6 Jul 2021 13:01:48 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 5/5] lib: s390x: Remove left behing
 PGM report
In-Reply-To: <20210706121757.24070-6-frankja@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210706121757.24070-1-frankja@linux.ibm.com>
 <20210706121757.24070-6-frankja@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 15:01:47 +0200
Message-ID: <875yxnh9z8.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.14
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Janosch Frank <frankja@linux.ibm.com> wrote:

> When I added the backtrace support I forgot to remove the PGM report.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/interrupt.c | 3 ---
>  1 file changed, 3 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

