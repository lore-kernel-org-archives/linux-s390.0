Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 24FDAC433B4
	for <linux-s390@archiver.kernel.org>; Wed, 21 Apr 2021 11:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DBFB3613FA
	for <linux-s390@archiver.kernel.org>; Wed, 21 Apr 2021 11:04:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234854AbhDULFP (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 21 Apr 2021 07:05:15 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41439 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234093AbhDULFO (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 21 Apr 2021 07:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1619003081;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=sOUNSf+wa2FIFGr/K8EYF8uxujvMd69wZUrFVxUqldk=;
        b=GDyZ4FylJqrmCnbztvOcqo+KGTuaEX5GTa+SsX01bR31bCjqSY7nsgTgtgunQ7Vn/wMvdV
        H6FwQwtf2ix8kc/hSb5zq/3nzXc/Lc0ZE1WUb13UrsymGHKf2wo+bHiPoMn302+c7syoKw
        zzbCbr305w52CqgzJvJAQLTI55v1DII=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-140-XMmGIxOzNz6zf6pLGpOxCg-1; Wed, 21 Apr 2021 07:04:39 -0400
X-MC-Unique: XMmGIxOzNz6zf6pLGpOxCg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 3E9DF343A4;
        Wed, 21 Apr 2021 11:04:38 +0000 (UTC)
Received: from gondolin.fritz.box (ovpn-112-160.ams2.redhat.com [10.36.112.160])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 83BA860CFB;
        Wed, 21 Apr 2021 11:04:33 +0000 (UTC)
Date:   Wed, 21 Apr 2021 13:04:30 +0200
From:   Cornelia Huck <cohuck@redhat.com>
To:     Janosch Frank <frankja@linux.ibm.com>
Cc:     kvm@vger.kernel.org, linux-s390@vger.kernel.org, thuth@redhat.com,
        david@redhat.com, imbrenda@linux.ibm.com
Subject: Re: [kvm-unit-tests PATCH 1/6] s390x: uv-guest: Add invalid share
 location test
Message-ID: <20210421130430.6d3f9614.cohuck@redhat.com>
In-Reply-To: <20210316091654.1646-2-frankja@linux.ibm.com>
References: <20210316091654.1646-1-frankja@linux.ibm.com>
        <20210316091654.1646-2-frankja@linux.ibm.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue, 16 Mar 2021 09:16:49 +0000
Janosch Frank <frankja@linux.ibm.com> wrote:

> Let's also test sharing unavailable memory.
> 
> Signed-off-by: Janosch Frank <frankja@linux.ibm.com>
> ---
>  s390x/uv-guest.c | 5 +++++
>  1 file changed, 5 insertions(+)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

