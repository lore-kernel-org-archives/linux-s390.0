Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.2 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8A40C07E9C
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 12:59:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F6B1619AC
	for <linux-s390@archiver.kernel.org>; Tue,  6 Jul 2021 12:59:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231549AbhGFNBw (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Tue, 6 Jul 2021 09:01:52 -0400
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:57767 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S232723AbhGFNBv (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Tue, 6 Jul 2021 09:01:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1625576352;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=a/LsHk5TN6wOMml8gyhLBmK665ICNQkvaI7/pWPpbgA=;
        b=HcU+2Vt7MlLEoSlbVA++8uwQAc4Fofyfe4p4aGZlXMjfg7QfoGYEA9HQwWe1qiwphISjDo
        wo6pVPhr9QjjyI64q1zUqiqh8ZE426U/oeTONnKE/FMay7nzs7tEutbOti9C+pGqmuamhP
        W1Uiu10F7OjkYTLI13PWsrKoj+wLVcE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-503-upkpHJYSPAuB8vE-z3KGiw-1; Tue, 06 Jul 2021 08:59:09 -0400
X-MC-Unique: upkpHJYSPAuB8vE-z3KGiw-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 40F7D10C1ADC;
        Tue,  6 Jul 2021 12:59:08 +0000 (UTC)
Received: from localhost (ovpn-113-13.ams2.redhat.com [10.36.113.13])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 876CE5C3E0;
        Tue,  6 Jul 2021 12:59:04 +0000 (UTC)
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        david@redhat.com, thuth@redhat.com
Subject: Re: [kvm-unit-tests PATCH v2 3/5] lib: s390x: uv: Add offset
 comments to uv_query and extend it
In-Reply-To: <20210706121757.24070-4-frankja@linux.ibm.com>
Organization: Red Hat GmbH
References: <20210706121757.24070-1-frankja@linux.ibm.com>
 <20210706121757.24070-4-frankja@linux.ibm.com>
User-Agent: Notmuch/0.32.1 (https://notmuchmail.org)
Date:   Tue, 06 Jul 2021 14:59:02 +0200
Message-ID: <87bl7fha3t.fsf@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, Jul 06 2021, Janosch Frank <frankja@linux.ibm.com> wrote:

> The struct is getting longer, let's add offset comments so we know
> where we change things when we add struct members.
>
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  lib/s390x/asm/uv.h | 33 +++++++++++++++++----------------
>  1 file changed, 17 insertions(+), 16 deletions(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

