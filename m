Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C110C433E0
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 12:25:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DF5364F11
	for <linux-s390@archiver.kernel.org>; Thu,  4 Mar 2021 12:25:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240521AbhCDMZV (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Thu, 4 Mar 2021 07:25:21 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:26646 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S240511AbhCDMYx (ORCPT
        <rfc822;linux-s390@vger.kernel.org>); Thu, 4 Mar 2021 07:24:53 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1614860607;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YXQ6T/kCoY/xq83HGnHtE5TYINF0iV5k/bZaLfBv74w=;
        b=exUwkIIwxF9P0fzGdoEH2cRsm0eGVfKRP1W9rvyxH7I5yBWQiDNSczfi09N/SxG8JVga6F
        kG35fhOHn/t9e0gJz1TkAlUimJLu2mwGjI0BsBkdG/PsXR3x+tHCZ2nv6ZggeX/RIiPL6N
        WAu8AeiDKaqdM/NkkmKbxYOjkYV6i8U=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-433-MeHIx61FOoGoVHZOcyDghg-1; Thu, 04 Mar 2021 07:23:24 -0500
X-MC-Unique: MeHIx61FOoGoVHZOcyDghg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 9BE051940923;
        Thu,  4 Mar 2021 12:23:22 +0000 (UTC)
Received: from thuth.remote.csb (ovpn-112-31.ams2.redhat.com [10.36.112.31])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 2E836608BA;
        Thu,  4 Mar 2021 12:23:15 +0000 (UTC)
Subject: Re: [kvm-unit-tests PATCH v3 4/7] s390x: Provide preliminary
 backtrace support
To:     Janosch Frank <frankja@linux.ibm.com>, kvm@vger.kernel.org
Cc:     linux-s390@vger.kernel.org, imbrenda@linux.ibm.com,
        pmorel@linux.ibm.com, david@redhat.com
References: <20210222085756.14396-1-frankja@linux.ibm.com>
 <20210222085756.14396-5-frankja@linux.ibm.com>
From:   Thomas Huth <thuth@redhat.com>
Message-ID: <9ee0038e-8b74-381e-8ccb-6975397805e2@redhat.com>
Date:   Thu, 4 Mar 2021 13:23:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.7.0
MIME-Version: 1.0
In-Reply-To: <20210222085756.14396-5-frankja@linux.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On 22/02/2021 09.57, Janosch Frank wrote:
> After the stack changes we can finally use -mbackchain and have a
> working backtrace.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>   lib/s390x/stack.c | 20 ++++++++++++++------
>   s390x/Makefile    |  1 +
>   s390x/macros.S    |  5 +++++
>   3 files changed, 20 insertions(+), 6 deletions(-)

Reviewed-by: Thomas Huth <thuth@redhat.com>

