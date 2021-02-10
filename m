Return-Path: <linux-s390-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_CR_TRAILER,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DD2C5C433E0
	for <linux-s390@archiver.kernel.org>; Wed, 10 Feb 2021 11:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 90AC164E25
	for <linux-s390@archiver.kernel.org>; Wed, 10 Feb 2021 11:08:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229547AbhBJLIf (ORCPT <rfc822;linux-s390@archiver.kernel.org>);
        Wed, 10 Feb 2021 06:08:35 -0500
Received: from us-smtp-delivery-124.mimecast.com ([216.205.24.124]:37613 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231602AbhBJLGm (ORCPT
        <rfc822;linux-s390@vger.kernel.org>);
        Wed, 10 Feb 2021 06:06:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1612955113;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=z3pAfZk6r3KZwOINV4f5Aj8wihUC0MavkIHBBzDY0Q0=;
        b=eKIBvYiE/BUF2EQYbUBe70FsZlDpthaxAexQhwAIC/ChAlXVQuHIqsu/KASmhGj5AYLsGv
        siIgsMdnDK87om4tavZw0jjsbRFwDIBFsk4Ba9ylrUTYh7jV2Gwy1f+f5NewGgoKCRZDnh
        +0BHNRW9Bb26S7LTDDJzPmMBTQdwS+A=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-187-e5DvYtAqNzy5917UfTfg5w-1; Wed, 10 Feb 2021 06:05:11 -0500
X-MC-Unique: e5DvYtAqNzy5917UfTfg5w-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7D045803F47;
        Wed, 10 Feb 2021 11:05:10 +0000 (UTC)
Received: from gondolin (ovpn-113-113.ams2.redhat.com [10.36.113.113])
        by smtp.corp.redhat.com (Postfix) with ESMTP id B234210074FC;
        Wed, 10 Feb 2021 11:05:03 +0000 (UTC)
Date:   Wed, 10 Feb 2021 12:05:01 +0100
From:   Cornelia Huck <cohuck@redhat.com>
To:     Thomas Huth <thuth@redhat.com>
Cc:     kvm@vger.kernel.org, Janosch Frank <frankja@linux.ibm.com>,
        linux-s390@vger.kernel.org, David Hildenbrand <david@redhat.com>
Subject: Re: [kvm-unit-tests PATCH] Fix the length in the stsi check for the
 VM name
Message-ID: <20210210120501.0e492991.cohuck@redhat.com>
In-Reply-To: <20210209155705.67601-1-thuth@redhat.com>
References: <20210209155705.67601-1-thuth@redhat.com>
Organization: Red Hat GmbH
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Precedence: bulk
List-ID: <linux-s390.vger.kernel.org>
X-Mailing-List: linux-s390@vger.kernel.org

On Tue,  9 Feb 2021 16:57:05 +0100
Thomas Huth <thuth@redhat.com> wrote:

> sizeof(somepointer) results in the size of the pointer, i.e. 8 on a
> 64-bit system, so the
> 
>  memcmp(data->ext_names[0], vm_name_ext, sizeof(vm_name_ext))
> 
> only compared the first 8 characters of the VM name here. Switch
> to a proper array to get the sizeof() right.
> 
> Signed-off-by: Thomas Huth <thuth@redhat.com>
> ---
>  s390x/stsi.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Reviewed-by: Cornelia Huck <cohuck@redhat.com>

